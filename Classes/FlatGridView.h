//
//  Created by P. Mark Anderson on 2/13/11.
//  Copyright 2011 Spot Metrix, Inc. All rights reserved.
//

#import "SM3DAR.h"

#define FLAT_GRID_LINE_COUNT 7
#define FLAT_GRID_SCALE 500


@interface FlatGridView : SM3DAR_MarkerView 
{
	float xverts[FLAT_GRID_LINE_COUNT][2][3];
	float yverts[FLAT_GRID_LINE_COUNT][2][3];
	unsigned short indexes[FLAT_GRID_LINE_COUNT][2];    
}

@end
