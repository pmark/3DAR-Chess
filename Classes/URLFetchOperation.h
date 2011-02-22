//
//  URLFetchOperation.h
//  Chess
//
//  Created by P. Mark Anderson on 11/30/10.
//  Copyright 2010 Bordertown Labs, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol URLFetchDelegate
- (void) didFinishFetchingImage:(UIImage *)image fromURL:(NSString *)url;
- (void) didFinishFetchingText:(NSString *)text fromURL:(NSString *)url;
- (void) didFinishFetchingData:(NSData *)data fromURL:(NSString *)url;
@end

typedef enum
{
    URLFetchTypeData,
    URLFetchTypePage,
    URLFetchTypeImage
} URLFetchType;

@interface URLFetchOperation : NSOperation 
{
    URLFetchType contentType;
    NSURL *URL;
    NSObject<URLFetchDelegate> *delegate;
}

@property (nonatomic, retain) NSURL *URL;
@property (nonatomic, assign) URLFetchType contentType;
@property (nonatomic, retain) NSObject<URLFetchDelegate> *delegate;

- (id) initWithURL:(NSURL *)URL delegate:(NSObject<URLFetchDelegate> *)delegate;

@end
