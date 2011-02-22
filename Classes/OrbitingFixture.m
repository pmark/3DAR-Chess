//
//  Created by P. Mark Anderson on 2/20/2011.
//  Copyright 2010 Spot Metrix, Inc. All rights reserved.
//

#import "OrbitingFixture.h"
#import "Constants.h"
#import "TexturedGeometryView.h"
#import "ChessAppDelegate.h"

extern float degreesToRadians(float degrees);
extern float radiansToDegrees(float radians);

@implementation OrbitingFixture

@synthesize order;
@synthesize direction;
@synthesize delay;
@synthesize radius;

- (CGFloat) gearSpeed 
{
    return 0.5;
}

- (NSInteger) numberOfTeethInGear 
{
    return 360;
}

- (void) gearHasTurned 
{
    Coord3D wp = self.worldPoint;
    
    CGFloat degrees = self.gearPosition + (order * 60) + (delay * 30);
    CGFloat radians = direction * degreesToRadians(degrees);
    CGFloat offset = radius/2.0;
    
    Coord3D wp2 = {
        wp.x + (cos(radians) * offset),
        wp.y + (sin(radians) * offset),
        wp.z
    };
    
    self.worldPoint = wp2;

    
    TexturedGeometryView *tgv = (TexturedGeometryView *)self.view;
    tgv.zrot = degrees * 3.0;
    
}

@end
