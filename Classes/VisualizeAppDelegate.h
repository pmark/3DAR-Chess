//
//  VisualizeAppDelegate.h
//  Visualize
//
//  Created by P. Mark Anderson on 11/29/10.
//  Copyright 2010 Bordertown Labs, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "URLFetchOperation.h"
#import "Scene.h"

@class VisualizeViewController;

@interface VisualizeAppDelegate : NSObject <UIApplicationDelegate, URLFetchDelegate> {
    UIWindow *window;
    VisualizeViewController *viewController;
    Scene *scene;
    
    NSOperationQueue *operationQueue;
    CGFloat gearSpeed;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet VisualizeViewController *viewController;
@property (nonatomic, retain) Scene *scene;
@property (nonatomic, assign) CGFloat gearSpeed;

- (void) fetchPage:(NSString*)url;

@end

#define APP_DELEGATE ((VisualizeAppDelegate*)[UIApplication sharedApplication].delegate)