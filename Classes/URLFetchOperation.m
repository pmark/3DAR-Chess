//
//  URLFetchOperation.m
//  Visualize
//
//  Created by P. Mark Anderson on 11/30/10.
//  Copyright 2010 Bordertown Labs, LLC. All rights reserved.
//

#import "URLFetchOperation.h"


@implementation URLFetchOperation

@synthesize URL;
@synthesize contentType;
@synthesize delegate;

- (void) dealloc
{
    RELEASE(URL);
    RELEASE(delegate);
    [super dealloc];
}

- (id) initWithURL:(NSURL *)_URL delegate:(NSObject<URLFetchDelegate> *)_delegate
{
    if (self = [super init])
    {
        self.contentType = URLFetchTypeData;
        self.URL = _URL;
        self.delegate = _delegate;
    }
    
    return self;
}

- (void) main
{
    NSURLRequest *request = [NSURLRequest requestWithURL:URL
                                             cachePolicy:NSURLRequestReloadRevalidatingCacheData 
                                         timeoutInterval:60.0];
    
    NSURLResponse *response;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response 
                                                     error:&error];

    if (error != nil)
    {
        NSLog(@"ERROR in URLFetchOperation: %@", [error localizedDescription]);
    }
    
    if (!delegate)
        return;
    
    NSString *urlString = [URL absoluteString];
    NSString *text;
    UIImage *image;
    
    switch (contentType) 
    {
        case URLFetchTypePage:
            text = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
            [delegate didFinishFetchingText:text fromURL:urlString];
            break;

        case URLFetchTypeImage:
            image = [UIImage imageWithData:data];
            [delegate didFinishFetchingImage:image fromURL:urlString];
            break;

        default:
            [delegate didFinishFetchingData:data fromURL:urlString];
            break;
    }
}


@end
