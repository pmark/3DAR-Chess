//
//  Created by P. Mark Anderson on 2/20/2011.
//  Copyright 2010 Spot Metrix, Inc. All rights reserved.
//

#import "SM3DAR.h"


@interface OrbitingFixture : SM3DAR_Fixture {
    NSInteger order;
    NSInteger direction;
    NSInteger delay;    
    CGFloat radius;
}

@property (nonatomic, assign) NSInteger order;
@property (nonatomic, assign) NSInteger direction;
@property (nonatomic, assign) NSInteger delay;
@property (nonatomic, assign) CGFloat radius;

@end
