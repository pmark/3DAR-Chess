//
//  Scene.h
//  Visualize
//
//  Created by P. Mark Anderson on 11/30/10.
//  Copyright 2010 Bordertown Labs, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Scene : NSObject 
{
    NSDictionary *properties;
}

@property (nonatomic, retain) NSDictionary *properties;

- (id) initWithJSON:(NSString *)json;
- (void) load3darPoints;

@end
