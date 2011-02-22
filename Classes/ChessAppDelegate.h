//
//  ChessAppDelegate.h
//  Chess
//
//  Created by P. Mark Anderson on 11/29/10.
//  Copyright 2010 Bordertown Labs, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "URLFetchOperation.h"
#import "Scene.h"

@class MainViewController;

@interface ChessAppDelegate : NSObject <UIApplicationDelegate, URLFetchDelegate> {
    UIWindow *window;
    MainViewController *viewController;
    Scene *scene;
    
    NSOperationQueue *operationQueue;
    CGFloat gearSpeed;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MainViewController *viewController;
@property (nonatomic, retain) Scene *scene;
@property (nonatomic, assign) CGFloat gearSpeed;

- (void) fetchPage:(NSString*)url;

@end

#define APP_DELEGATE ((ChessAppDelegate*)[UIApplication sharedApplication].delegate)