/*
 *  Constants.h
 *  Visualize
 *
 *  Created by P. Mark Anderson on 11/30/10.
 *  Copyright 2010 Bordertown Labs, LLC. All rights reserved.
 *
 */

#define RELEASE(object) \
{ \
if(object)\
{ \
[object release];\
object=nil; \
} \
}

#define GROUNDPLANE_ALTITUDE_METERS -1000.0
#define BUBBLE_ALTITUDE_METERS -300.0
#define DIRECTION_BILLBOARD_ALTITUDE_METERS 300.0
