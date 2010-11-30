//
//  VisualizeViewController.m
//  Visualize
//
//  Created by P. Mark Anderson on 11/29/10.
//  Copyright 2010 Bordertown Labs, LLC. All rights reserved.
//

#import "VisualizeViewController.h"
#import "VisualizeAppDelegate.h"
#import "SM3DAR.h"

@implementation VisualizeViewController



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

- (void)loadView 
{
    self.view = [[[UIView alloc] initWithFrame:SM3DAR.view.frame] autorelease];
    
    [self.view addSubview:SM3DAR.view];    
}


- (void)viewDidLoad 
{
    [super viewDidLoad];
    
    [SM3DAR zoomMapToFitPointsIncludingUserLocation:YES];
}

- (void) loadPointsOfInterest
{
    [APP_DELEGATE fetchPage:@"http://bordertownlabs.com/3dar/scene1.json"];
    
//    [APP_DELEGATE.scene addBackground];
//    [APP_DELEGATE.scene addGroundPlane];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
    [super dealloc];
}

@end
