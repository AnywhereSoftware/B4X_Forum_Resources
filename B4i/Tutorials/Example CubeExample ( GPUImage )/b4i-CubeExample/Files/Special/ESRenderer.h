#import <QuartzCore/QuartzCore.h>

#import <OpenGLES/EAGL.h>
#import <OpenGLES/EAGLDrawable.h>

@class b4i_main;
@protocol ESRenderer <NSObject>

- (void)renderByRotatingAroundX:(float)xRotation rotatingAroundY:(float)yRotation;

@end
