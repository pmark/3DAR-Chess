//
//  SphereView.m
//
//

#import <OpenGLES/ES1/gl.h>
#import "SphereView.h"

@implementation SphereView

- (UIColor *) randomColor 
{
    red = (CGFloat)random()/(CGFloat)RAND_MAX;
    green = (CGFloat)random()/(CGFloat)RAND_MAX;
    blue = (CGFloat)random()/(CGFloat)RAND_MAX;    
    colorAlpha = 0.32;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:colorAlpha];
}

- (void) buildView 
{
    self.color = [self randomColor];
    self.hidden = NO;    
    self.zrot = 0.0;    
    self.sizeScalar = 68.0;
	self.frame = CGRectZero;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sphere" ofType:@"obj"];
    self.geometry = [[Geometry newOBJFromResource:path] autorelease];
    self.geometry.cullFace = NO;
}

- (void) displayGeometry 
{
    if (texture == nil && [textureName length] > 0) 
    {
        NSLog(@"Loading texture named %@", textureName);
        NSString *textureExtension = [[textureName componentsSeparatedByString:@"."] objectAtIndex:1];
        NSString *textureBaseName = [textureName stringByDeletingPathExtension];
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:textureBaseName ofType:textureExtension];
        NSData *imageData = [[NSData alloc] initWithContentsOfFile:imagePath]; 
        UIImage *textureImage =  [[UIImage alloc] initWithData:imageData];
        CGImageRef cgi = textureImage.CGImage;
        self.texture = [[Texture newTextureFromImage:cgi] autorelease];           
        [imageData release];
        [textureImage release];
    }

    glScalef(-sizeScalar, sizeScalar, 1.3*sizeScalar);
    glTranslatef(0, 0, -10);
    
    if (texture)
    {
        [Geometry displaySphereWithTexture:self.texture];
    }
	else
    {
        [self.geometry displayShaded:self.color];
    }
}

- (void) didReceiveFocus
{
    self.color = [UIColor colorWithRed:red green:green blue:blue alpha:(colorAlpha*2.5)];
}

- (void) didLoseFocus
{
    self.color = [UIColor colorWithRed:red green:green blue:blue alpha:colorAlpha];
}


@end
