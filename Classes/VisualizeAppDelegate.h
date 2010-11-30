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
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet VisualizeViewController *viewController;
@property (nonatomic, retain) Scene *scene;

@end

