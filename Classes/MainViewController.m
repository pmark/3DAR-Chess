//
//  ChessViewController.m
//  Chess
//
//  Created by P. Mark Anderson on 11/29/10.
//  Copyright 2010 Bordertown Labs, LLC. All rights reserved.
//

#import "MainViewController.h"
#import "ChessAppDelegate.h"
#import "SM3DAR.h"
#import "TexturedGeometryView.h"
#import "CGPointUtil.h"
#import "FlatGridView.h"
#import "OrbitingFixture.h"
#import "SphereBackgroundView.h"

@interface MainViewController (PrivateMethods)
- (void) addJoystick;
- (void) addFlatGrid;
@end

@implementation MainViewController


- (void)loadView 
{
    self.view = [[[UIView alloc] initWithFrame:SM3DAR.view.frame] autorelease];
    
    SM3DAR.view.backgroundColor = [UIColor darkGrayColor]; // [UIColor viewFlipsideBackgroundColor];
    [self.view addSubview:SM3DAR.view];    
    SM3DAR.view.multipleTouchEnabled = YES;
    
//    SM3DAR.hudView = [[[UIView alloc] initWithFrame:self.view.frame] autorelease];
//    [SM3DAR.view addSubview:SM3DAR.hudView];
    
    
    [self loadPointsOfInterest];

    joystickView = [[UIView alloc] initWithFrame:self.view.frame];
    joystickView.multipleTouchEnabled = YES;
    [SM3DAR.view addSubview:joystickView];
    
    Coord3D c = { 0, 0, 300 };
    cameraOffset = c;
    [SM3DAR setCameraOffset:cameraOffset];

    [self addJoystick];
}


- (void)viewDidLoad 
{
    [super viewDidLoad];
    
    [SM3DAR zoomMapToFitPointsIncludingUserLocation:YES];
}

- (void) addFlatGrid
{
    SM3DAR_Fixture *fixture = [[SM3DAR_Fixture alloc] init];
    
    FlatGridView *grid = [[FlatGridView alloc] init];
    grid.multipleTouchEnabled = YES;
    
    grid.point = fixture;
    fixture.view = grid;
    
    Coord3D coord;
    coord.x = 0;
    coord.y = 0;
    coord.z = 0;
    
    fixture.worldPoint = coord;
    
    [SM3DAR addPoint:fixture];
    
    [grid release];
    [fixture release];
}

- (OrbitingFixture*) addOBJ:(NSString*)fileName atCoordinate:(Coord3D)coord sizeScalar:(CGFloat)sizeScalar
{
    OrbitingFixture *point = [OrbitingFixture new];

    TexturedGeometryView *pv = [[TexturedGeometryView alloc] initWithOBJ:fileName];
    pv.multipleTouchEnabled = YES;
    pv.sizeScalar = sizeScalar;
    
    point.view = pv;
    [pv release];
    
    point.worldPoint = coord;
    
    [SM3DAR addPoint:point];    
    [point release];
    
    return point;
}

- (void) addOBJRing:(NSString*)fileName atCoordinate:(Coord3D)coord sizeScalar:(CGFloat)sizeScalar count:(NSInteger)count radius:(NSInteger)radius delay:(NSInteger)delay
{
    static NSInteger direction = 1;
    
    for (int i=0; i < count; i++)
    {
//        coord.x = cos(2 * M_PI / count * i) * radius;
//        coord.y = sin(2 * M_PI / count * i) * radius;
        coord.x = 0;
        coord.y = 0;


        OrbitingFixture *f = [self addOBJ:fileName atCoordinate:coord sizeScalar:sizeScalar];
        
        f.order = i;
        f.delay = delay;
        f.direction = direction;
        f.radius = 4 * delay + 4;
    }    
    
    direction *= -1;
}

- (void) addBackground
{
    SphereBackgroundView *sphereView = [[SphereBackgroundView alloc] initWithTextureNamed:@"sky3.png"];

    SM3DAR_Fixture *point = [[SM3DAR_Fixture alloc] init];
    
    point.view = sphereView;  
    
    [SM3DAR addPoint:point];
    
    [point release];
    
    [sphereView release];
}

//
// Most of these OBJ files came from:
// http://people.sc.fsu.edu/~jburkardt/data/obj/
//
- (void) loadOBJOrbiters
{   
    [self addFlatGrid];
    
    Coord3D coord = { 0, 0, 0 };    

    coord.z = 0;
    [self addOBJRing:@"sphere.obj" atCoordinate:coord sizeScalar:12 count:6 radius:100 delay:0];

    coord.z = 200;
    [self addOBJRing:@"tetrahedron.obj" atCoordinate:coord sizeScalar:110 count:6 radius:200 delay:1];
    
    coord.z = 400;
    [self addOBJRing:@"dodecahedron.obj" atCoordinate:coord sizeScalar:80 count:6 radius:400 delay:2];
    
    coord.z = 800;
    [self addOBJRing:@"octahedron.obj" atCoordinate:coord sizeScalar:80 count:6 radius:800 delay:3];
    
    
    [self addBackground];
    
    [SM3DAR.view bringSubviewToFront:joystickView];

}

- (void) loadDefaultScene
{    
    [APP_DELEGATE fetchPage:@"http://bordertownlabs.com/3dar/scene1.json"];    
    [APP_DELEGATE.scene addBackground];
    [APP_DELEGATE.scene addGroundPlane];
}

- (void) loadPointsOfInterest
{   
    [self loadOBJOrbiters];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [joystick release];
    [super dealloc];
}

#pragma mark -
- (void) addJoystick
{
    joystick = [Joystick new];
//    joystick.center = CGPointMake(74, 120);
//    joystick.transform = CGAffineTransformMakeRotation(M_PI/2);
    joystick.center = CGPointMake(80, 406);
    
    [joystickView addSubview:joystick];
    [NSTimer scheduledTimerWithTimeInterval:0.10f target:self selector:@selector(updateJoystick) userInfo:nil repeats:YES];    
    
    
    // Z
    
    joystickZ = [Joystick new];
//    joystickZ.center = CGPointMake(74, 360);
//    joystickZ.transform = CGAffineTransformMakeRotation(M_PI/2);
    joystickZ.center = CGPointMake(240, 406);
    
    [joystickView addSubview:joystickZ];
    [NSTimer scheduledTimerWithTimeInterval:0.10f target:self selector:@selector(updateJoystickZ) userInfo:nil repeats:YES];    
    
}


- (void) updateJoystick 
{
    [joystick updateThumbPosition];
    
    CGFloat s = 6.2; // 4.6052;
    
    CGFloat xspeed =  joystick.velocity.x * exp(fabs(joystick.velocity.x) * s);
    CGFloat yspeed = -joystick.velocity.y * exp(fabs(joystick.velocity.y) * s);
    
    if (abs(xspeed) > 0.0 || abs(yspeed) > 0.0) 
    {        
        Coord3D ray = [SM3DAR ray:CGPointMake(160, 240)];
        
        cameraOffset.x += (ray.x * yspeed);
        cameraOffset.y += (ray.y * yspeed);
//        cameraOffset.z += (ray.z * yspeed);
        
        CGPoint perp = [CGPointUtil perpendicularCounterClockwise:CGPointMake(ray.x, ray.y)];        
        cameraOffset.x += (perp.x * xspeed);
        cameraOffset.y += (perp.y * xspeed);
        
        //NSLog(@"Camera (%.1f, %.1f, %.1f)", offset.x, offset.y, offset.z);
        
        [SM3DAR setCameraOffset:cameraOffset];
    }
}

- (void) updateJoystickZ
{
    [joystickZ updateThumbPosition];
    
    CGFloat s = 6.2; // 4.6052;
    
    //CGFloat xspeed =  joystickZ.velocity.x * exp(fabs(joystickZ.velocity.x));
    CGFloat yspeed = -joystickZ.velocity.y * exp(fabs(joystickZ.velocity.y) * s);    

    /*
    if (abs(xspeed) > 0.0) 
    {   
        APP_DELEGATE.gearSpeed += xspeed;

        if (APP_DELEGATE.gearSpeed < 0.0)
            APP_DELEGATE.gearSpeed = 0.0;

        if (APP_DELEGATE.gearSpeed > 5.0)
            APP_DELEGATE.gearSpeed = 5.0;
        
        NSLog(@"speed: %.1f", APP_DELEGATE.gearSpeed);
    }
    */

    if (abs(yspeed) > 0.0) 
    {        
        cameraOffset.z += yspeed;
        
        [SM3DAR setCameraOffset:cameraOffset];
    }

}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    touchCount++;
    
    UITouch *touch = [[touches allObjects] objectAtIndex:0];    
    CGPoint point = [touch locationInView:SM3DAR.view];    
    
    NSLog(@"touches: %i", touchCount);
    
    if (touchCount == 1)
    {
        joystick.center = point;
        joystick.transform = CGAffineTransformMakeRotation([SM3DAR screenOrientationRadians]);
        joystickZ.hidden = YES;
    }
    else if (touchCount == 2)
    {
        joystickZ.center = point;
        joystickZ.transform = CGAffineTransformMakeRotation([SM3DAR screenOrientationRadians]);
        joystickZ.hidden = NO;
    }
    else
    {
        touchCount = 0;
    }
    
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    touchCount--;
    if (touchCount < 0)
        touchCount = 0;
}

@end
