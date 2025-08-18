#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "ESRenderer.h"
#import "ES2Renderer.h"
#import "GPUImage.h"
//#import "b4i_main.h"

//@class b4i_main;

@interface DisplayViewController : UIViewController
{
    CGPoint lastMovementPosition;
@private
    ES2Renderer *renderer;
    GPUImageTextureInput *textureInput;
    GPUImageFilter *filter;
    
    NSDate *startTime;
}

- (void)drawView:(id)sender;
 -(UIViewController *) viewDidLoadf :(UIViewController*)tarjet2 ;
@end
