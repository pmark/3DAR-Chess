//
//  VisualizeViewController.h
//  Visualize
//
//  Created by P. Mark Anderson on 11/29/10.
//  Copyright 2010 Bordertown Labs, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SM3DAR.h"
#import "Joystick.h"

@interface VisualizeViewController : UIViewController <SM3DAR_Delegate> 
{
    BOOL ready;
    Joystick *joystick;
    Joystick *joystickZ;
    Coord3D cameraOffset;
    UIView *joystickView;
    NSInteger touchCount;
}

@end

