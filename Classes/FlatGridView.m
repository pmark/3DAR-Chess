//
//  Created by P. Mark Anderson on 2/13/11.
//  Copyright 2011 Spot Metrix, Inc. All rights reserved.
//

#import "FlatGridView.h"
#import <OpenGLES/ES1/gl.h>
#import "Constants.h"


@implementation FlatGridView

- (void) buildView 
{
    // x

    for (int i=0; i < FLAT_GRID_LINE_COUNT; i++)
	{
        CGFloat column = i * FLAT_GRID_SCALE;
        
        xverts[i][0][0] = 0.0;
        xverts[i][0][1] = column;
        xverts[i][0][2] = 0.0;

        xverts[i][1][0] = (FLAT_GRID_LINE_COUNT-1) * FLAT_GRID_SCALE;
        xverts[i][1][1] = column;
        xverts[i][1][2] = 0.0;
        		
		indexes[i][0] = 2*i;
		indexes[i][1] = 2*i+1;
	}
	
    
    // y
    for (int i=0; i < FLAT_GRID_LINE_COUNT; i++)
	{
        CGFloat row = i * FLAT_GRID_SCALE;
        
        yverts[i][0][0] = row;
        yverts[i][0][1] = 0.0;
        yverts[i][0][2] = 0.0;

        yverts[i][1][0] = row;
        yverts[i][1][1] = (FLAT_GRID_LINE_COUNT-1) * FLAT_GRID_SCALE;
        yverts[i][1][2] = 0.0;
	}	
    
}

- (void) addFog
{
    GLfloat fogColor[4] = {.3, .0, .0, 0.2};
    glFogfv(GL_FOG_COLOR, fogColor);
    
    glFogf(GL_FOG_MODE, GL_LINEAR);
    glFogf(GL_FOG_DENSITY, 0.6);
    
    glFogf(GL_FOG_START, 0.0);
    
    CGFloat fogEnd = FLAT_GRID_LINE_COUNT * FLAT_GRID_SCALE / 2.0;
    glFogf(GL_FOG_END, fogEnd);
    
    glHint(GL_FOG_HINT, GL_NICEST);
    
    glEnable(GL_FOG);    
}

- (void) drawInGLContext 
{
    glDisable(GL_LIGHTING);
    glDisable(GL_TEXTURE_2D);
    glDepthMask(false);
    glEnable(GL_DEPTH_TEST);
    
	glEnableClientState(GL_VERTEX_ARRAY);
	glDisableClientState(GL_NORMAL_ARRAY);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
    
    NSInteger half = FLAT_GRID_LINE_COUNT / 2 * FLAT_GRID_SCALE;
    glTranslatef(-half, -half, GROUNDPLANE_ALTITUDE_METERS);
    
//    glScalef(FLAT_GRID_SCALE, FLAT_GRID_SCALE, FLAT_GRID_SCALE);    

    glLineWidth(1);

    glColor4f(.3,.3,.3, 0.05);
	glVertexPointer(3, GL_FLOAT, 0, xverts);
	glDrawElements(GL_LINES, 2*FLAT_GRID_LINE_COUNT, GL_UNSIGNED_SHORT, indexes);
	
    glColor4f(.1, .1, .1, 0.05);
	glVertexPointer(3, GL_FLOAT, 0, yverts);
	glDrawElements(GL_LINES, 2*FLAT_GRID_LINE_COUNT, GL_UNSIGNED_SHORT, indexes);
    
    
    //[self addFog];

    glDepthMask(true);
}

@end
