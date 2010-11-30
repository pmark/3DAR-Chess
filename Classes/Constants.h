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

#define GROUNDPLANE_ZPOS -80