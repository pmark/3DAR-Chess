//
//  Scene.m
//  Visualize
//
//  Created by P. Mark Anderson on 11/30/10.
//  Copyright 2010 Bordertown Labs, LLC. All rights reserved.
//

#import "Scene.h"
#import "NSDictionary+BSJSONAdditions.h"
#import <CoreLocation/CoreLocation.h>
#import "SM3DAR.h"

@implementation Scene

@synthesize properties;

- (void) dealloc 
{
    RELEASE(properties);
    
    [super dealloc];
}

- (id) initWithJSON:(NSString *)json
{
    if (self = [super init])
    {
        self.properties = [NSDictionary dictionaryWithJSONString:json];
    }
    
    return self;
}

- (void) load3darPoints
{
    [SM3DAR removeAllPointsOfInterest];
    
    if (!properties || [properties count] == 0)
    {
        NSLog(@"Scene is empty");
        return;        
    }
    
    NSArray *points = [[properties objectForKey:@"scene"] objectForKey:@"points"];
    
    NSMutableArray *tmpPoints = [NSMutableArray arrayWithCapacity:[points count]];
    
    for (NSDictionary *onePoint in points)
    {
        CLLocationDegrees lat = [[onePoint objectForKey:@"latitude"] doubleValue];
        CLLocationDegrees lng = [[onePoint objectForKey:@"longitude"] doubleValue];
        NSString *title = [onePoint objectForKey:@"title"];
        NSString *subtitle = [onePoint objectForKey:@"subtitle"];
        
        SM3DAR_Point *p = [SM3DAR initPointOfInterestWithLatitude:lat 
                                                        longitude:lng 
                                                         altitude:0 
                                                            title:title 
                                                         subtitle:subtitle 
                                                  markerViewClass:nil 
                                                       properties:nil];
        
        [tmpPoints addObject:p];
    }

    [SM3DAR.map addAnnotations:tmpPoints];
    [SM3DAR addPointsOfInterest:tmpPoints];
    
    [SM3DAR zoomMapToFitPointsIncludingUserLocation:NO];
}

@end
