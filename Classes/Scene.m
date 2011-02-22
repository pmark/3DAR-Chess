//
//  Scene.m
//  Chess
//
//  Created by P. Mark Anderson on 11/30/10.
//  Copyright 2010 Bordertown Labs, LLC. All rights reserved.
//

#import "Scene.h"
#import "NSDictionary+BSJSONAdditions.h"
#import <CoreLocation/CoreLocation.h>
#import "SphereBackgroundView.h"
#import "GroundPlaneView.h"
#import "SphereView.h"

@implementation Scene

@synthesize properties;
@synthesize sphereBackground;
@synthesize groundPlane;

- (void) dealloc 
{
    RELEASE(properties);
    RELEASE(sphereBackground);
    RELEASE(groundPlane);
    
    [super dealloc];
}

- (id) initWithJSON:(NSString *)json
{
    if (self = [super init])
    {
        [self loadJSON:json];
    }
    
    return self;
}

- (void) loadJSON:(NSString *)json
{
    self.properties = [NSDictionary dictionaryWithJSONString:json];
}

- (void) load3darPoints
{
    [SM3DAR removeAllPointsOfInterest];
    [self addBackground];
    [self addGroundPlane];
    
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
                                                  markerViewClass:[SphereView class]
                                                       properties:nil];
                
        
        [tmpPoints addObject:p];
        [p release];
    }

    [SM3DAR.map addAnnotations:tmpPoints];
    [SM3DAR addPointsOfInterest:tmpPoints];
    
    [SM3DAR zoomMapToFitPointsIncludingUserLocation:NO];
}

- (SM3DAR_Fixture*) addFixtureWithView:(SM3DAR_PointView*)pointView
{
    // create point
    SM3DAR_Fixture *point = [[SM3DAR_Fixture alloc] init];
    
    // give point a view
    point.view = pointView;  
    
    // add point to 3DAR scene
    [SM3DAR addPointOfInterest:point];
    return [point autorelease];
}

- (void) addBackground
{
    SphereBackgroundView *sphereView = [[SphereBackgroundView alloc] initWithTextureNamed:@"sky2.png"];
    self.sphereBackground = [self addFixtureWithView:sphereView];
    [sphereView release];
}

- (void) addGroundPlane
{
    GroundPlaneView *gpView = [[GroundPlaneView alloc] initWithTextureNamed:@"ground1_1024.jpg"];
    self.groundPlane = [self addFixtureWithView:gpView];
    [gpView release];
}

@end
