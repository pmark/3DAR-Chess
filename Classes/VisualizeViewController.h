//
//  VisualizeViewController.h
//  Visualize
//
//  Created by P. Mark Anderson on 11/29/10.
//  Copyright 2010 Bordertown Labs, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SM3DAR.h"

@interface VisualizeViewController : UIViewController <SM3DAR_Delegate> 
{
    BOOL ready;
}

@end

