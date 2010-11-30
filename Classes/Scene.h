//
//  Scene.h
//  Visualize
//
//  Created by P. Mark Anderson on 11/30/10.
//  Copyright 2010 Bordertown Labs, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SM3DAR.h"


@interface Scene : NSObject 
{
    NSDictionary *properties;
    SM3DAR_Fixture *sphereBackground;
    SM3DAR_Fixture *groundPlane;
}

@property (nonatomic, retain) NSDictionary *properties;
@property (nonatomic, retain) SM3DAR_Fixture *sphereBackground;
@property (nonatomic, retain) SM3DAR_Fixture *groundPlane;

- (id) initWithJSON:(NSString *)json;
- (void) loadJSON:(NSString *)json;
- (void) load3darPoints;
- (void) addBackground;
- (void) addGroundPlane;

@end
