//
//  VisualizeAppDelegate.m
//  Visualize
//
//  Created by P. Mark Anderson on 11/29/10.
//  Copyright 2010 Bordertown Labs, LLC. All rights reserved.
//

#import "VisualizeAppDelegate.h"
#import "VisualizeViewController.h"
#import "SM3DAR.h"

@implementation VisualizeAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize scene;

- (void)dealloc {
    RELEASE(viewController);
    RELEASE(window);
    RELEASE(scene);
    RELEASE(operationQueue);

    [super dealloc];
}



#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    [application setStatusBarHidden:YES];
    
    operationQueue = [[NSOperationQueue alloc] init];

    // Init 3DAR
    SM3DAR.delegate = viewController; 

    [self.window addSubview:viewController.view];
    [self.window makeKeyAndVisible];

    self.scene = [[[Scene alloc] init] autorelease];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}



- (NSDictionary *) parseLoadParams:(NSString *)query
{
    NSArray *paramParts = [query componentsSeparatedByString:@"&"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:[paramParts count]];
    
    for (NSString *part in paramParts)
    {
        NSArray *pieces = [part componentsSeparatedByString:@"="];
        [params setObject:[pieces objectAtIndex:1] forKey:[pieces objectAtIndex:0]];
    }
    
    NSLog(@"params: %@", params);    
    
    return params;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if (!url) 
    { 
        return NO;
    }
    
    NSString *URLString = [url absoluteString];
    NSLog(@"Opened app with URL: %@", URLString);
    
    NSString *base = [url host];
    NSLog(@"Base: %@", base);
    
    NSDictionary *params = [self parseLoadParams:[url query]];
    
    NSString *sceneURL = [params objectForKey:@"url"];

    if ([sceneURL length] > 0)
    {
        // Load the scene from the given URL        
        URLFetchOperation *fetch = [[URLFetchOperation alloc] initWithURL:[NSURL URLWithString:sceneURL] 
                                                                 delegate:self];
        fetch.contentType = URLFetchTypePage;
        [operationQueue addOperation:fetch];
        [fetch release];
    }
    
    return YES;
}

- (void) didFinishFetchingImage:(UIImage *)image fromURL:(NSString *)url
{
    
}

- (void) didFinishFetchingText:(NSString *)text fromURL:(NSString *)url
{
    [scene loadJSON:text];    
    [scene load3darPoints];
}

- (void) didFinishFetchingData:(NSData *)data fromURL:(NSString *)url
{
    
}


@end
