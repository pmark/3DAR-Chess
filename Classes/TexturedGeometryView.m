//
//  TexturedGeometryView.m
//
//

#import <OpenGLES/ES1/gl.h>
#import "TexturedGeometryView.h"
#import "Constants.h"

@implementation TexturedGeometryView

@synthesize zrot, color, geometry, texture, textureName, textureURL, sizeScalar;

- (id) initWithPointOfInterest:(SM3DAR_PointOfInterest*)poi {
    if (self = [self initWithTextureNamed:nil]) {    
        self.point = poi;
    }
    return self;
}

- (id) initWithTextureNamed:(NSString*)name {
    if (self = [super initWithFrame:CGRectZero]) {    
        self.textureName = name;
    }
    return self;
}

- (id) initWithTextureURL:(NSURL*)url {
    self.textureURL = url;
    if (self = [super initWithFrame:CGRectZero]) {    
    }
    return self;
}

- (id) initWithOBJ:(NSString*)fileName {
    
    if (self = [super initWithFrame:CGRectZero]) {
        self.color = [self randomColor];
        self.hidden = NO;    
        NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
        self.geometry = [[Geometry newOBJFromResource:path] autorelease];
        self.geometry.cullFace = NO;
    }
    
    return self;
}

- (void) dealloc {
    NSLog(@"\n\n[TexturedGeometryView] dealloc\n\n");
    RELEASE(color);
    RELEASE(geometry);
    RELEASE(texture);
    RELEASE(textureName);
    RELEASE(textureURL);
    [super dealloc];
}


#pragma mark -
/*
 // Subclasses should implement didReceiveFocus
 - (void) didReceiveFocus {
 }
 */

#pragma mark -
- (void) updateTexture:(UIImage*)textureImage {
    if (textureImage) {
        NSLog(@"[TexturedGeometryView] updating texture with %@", textureImage);
        [texture replaceTextureWithImage:textureImage.CGImage];
    }
}

- (void) updateImage:(UIImage*)img {
    NSLog(@"[TexturedGeometryView] resizing image from original: %f, %f", img.size.width, img.size.height);
    img = [self resizeImage:img];
    //NSLog(@"[TexturedGeometryView] DONE: %f, %f", img.size.width, img.size.height);
    [self updateTexture:img];
}

- (UIImage*) resizeImage:(UIImage*)originalImage {
	//CGPoint topCorner = CGPointMake(0, 0);
	CGSize targetSize = CGSizeMake(512, 256);	
	
	UIGraphicsBeginImageContext(targetSize);	
	[originalImage drawInRect:CGRectMake(0, 0, 512, 256)];	
	UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();	
	
	return result;	
}

// Subclasses should implement displayGeometry
- (void) displayGeometry {

    glScalef(-sizeScalar, sizeScalar, sizeScalar);
    glRotatef(zrot, 0, 0, 1.0);
    
    [self.geometry displayShaded:self.color];
    
//    [self.geometry displayWireframe];
}

- (void) drawInGLContext {
    [self displayGeometry];
}

- (UIColor *) randomColor 
{
    CGFloat red = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)random()/(CGFloat)RAND_MAX;    
    CGFloat colorAlpha = 1.00;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:colorAlpha];
}


@end
