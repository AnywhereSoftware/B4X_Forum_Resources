### Example CubeExample ( GPUImage ) by naifnas
### 10/17/2020
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/123569/)

hi  
this full Example CubeExample ( GPUImage gruop)  
THIS example showing the video is a 3D square  
I collected the codes and put them inside the code main b4i  
the wrapper class inside main ..  
files \*.h inside folder <Files->Special>  
These are open files source, not library, so you can develop files  
  
\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  
They are reserved for their respective owners,  
\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  
![](https://www.b4x.com/android/forum/attachments/101639) ![](https://www.b4x.com/android/forum/attachments/101640) ![](https://www.b4x.com/android/forum/attachments/101641)  
 ![](https://www.b4x.com/android/forum/attachments/101642)  
[MEDIA=youtube]cn3mhkWM\_m0[/MEDIA]  
  
  
  
  
important note  
The codes are reserved for their owners.  
  
 This is Jeff LaMarche's GLProgram OpenGL shader wrapper class from his OpenGL ES 2.0 book.  
   
  
[GPUImage files]  
Copyright © 2012, Brad Larson, Ben Cochran, Hugues Lismonde, Keitaroh Kobayashi, Alaric Cole, Matthew Clark, Jacob Gundersen, Chris Williams.  
All rights reserved.  
  
thia some code  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: B4i Example  
    #Version: 1.0.0  
    'Orientation possible values: Portrait, LandscapeLeft, LandscapeRight and PortraitUpsideDown  
    #iPhoneOrientations: Portrait, LandscapeLeft, LandscapeRight  
    #iPadOrientations: Portrait, LandscapeLeft, LandscapeRight, PortraitUpsideDown  
    #Target: iPhone, iPad  
    #ATSEnabled: True  
    #MinVersion: 8  
        #PlistExtra:<key>NSFaceIDUsageDescription</key><string>Uses n</string>  
  
  
'    #PlistExtra: <key>UIBackgroundModes</key><array><string>fetch</string></array>  
    #PlistExtra: <key>UIFileSharingEnabled</key><true/>  
    #PlistExtra: <key>UIViewControllerBasedStatusBarAppearance</key><false/>  
    #PlistExtra: <key>NSCameraUsageDescription</key><string>App d via chat</string>  
  
#End Region  
  
Sub Process_Globals  
    Public App As Application  
    Public NavControl As NavigationController  
    Private Page1 As Page  
    Private Panel1 As Panel  
    Private Button1 As Button  
    Private ImageView1 As ImageView  
End Sub  
  
Private Sub Application_Start (Nav As NavigationController)  
    NavControl = Nav  
    Page1.Initialize("Page1")  
    Page1.RootPanel.LoadLayout("Page1")  
    NavControl.ShowPage(Page1)  
  
  
End Sub  
  
Sub Button1_Click  
    Dim no As NativeObject =Me  
    Dim p1 As Page  
    Dim o As Object  
        no.RunMethod("StartApp:", Array  (Panel1))  
'    Panel1.AddView(o,0,0,500,500)  
  
End Sub  
  
  
#If OBJC  
  
  
  
#import "DisplayViewController.h"  
#import "ES2Renderer.h"  
#import "ESRenderer.h"  
  
//———File view————  
  
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\  
  
// ————- بداية العرض———-  
//  Failed to load vertex shader  
//Failed to load vertex shader  
//Failed to compile vertex shader  
  
//#import "ResultsTableViewController.h"  
  
-(UIViewController * )StartApp :(UIViewController*)tarjets   // :(UIApplication *)application  
{  
  
     DisplayViewController *tarjet1 = [[DisplayViewController alloc]init];  
//     [tarjet1 viewDidLoad ];  
  
  
//     UIViewController *tarjetx = [[UIViewController alloc]init];  
//    tarjetx = [tarjet1 viewDidLoadf:tarjets];  
  
    //   tarjet2 = [tarjet1  viewChange ];  
  
        return [tarjet1 viewDidLoadf:tarjets];  
//     [self viewDidLoad];  
  
}  
  
// exampele  
    // SMKDetectionCamera *sampleClass1 = [[SMKDetectionCamera alloc]init];  
    // [sampleClass1 stopAllDetection];  
  
#end if  
#if objc  
//———————————ملف الاستقبال  
  
  
//——————————  
//————————ملف الادوات  
#import "DisplayViewController.h"  
  
@end  
  
@interface DisplayViewController ()  
  
@end  
  
@implementation DisplayViewController  
  
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil  
{  
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];  
    if (self) {  
        // Custom initialization  
    }  
  
  
    return self;  
}  
  
- (void)dealloc  
{  
//   [renderer release];  
  
//   [super dealloc];  
}  
- (UIViewController*)viewDidLoadf :(UIViewController*)tarjet2  
{  
    self.view =  tarjet2 ;  
    CGRect mainScreenFrame = [[UIScreen mainScreen] applicationFrame];  
    GPUImageView *primaryView = [[GPUImageView alloc] initWithFrame:mainScreenFrame];  
    self.view = primaryView;  
  
    renderer = [[ES2Renderer alloc] initWithSize:[primaryView sizeInPixels]];  
  
    textureInput = [[GPUImageTextureInput alloc] initWithTexture:renderer.outputTexture size:[primaryView sizeInPixels]];  
    filter = [[GPUImagePixellateFilter alloc] init];  
    [(GPUImagePixellateFilter *)filter setFractionalWidthOfAPixel:0.01];  
  
//    filter = [[GPUImageGaussianBlurFilter alloc] init];  
//    [(GPUImageGaussianBlurFilter *)filter setBlurSize:3.0];  
  
    [textureInput addTarget:filter];  
    [filter addTarget:primaryView];  
  
    [renderer setNewFrameAvailableBlock:^{  
        float currentTimeInMilliseconds = [[NSDate date] timeIntervalSinceDate:startTime] * 1000.0;  
  
        [textureInput processTextureWithFrameTime:CMTimeMake((int)currentTimeInMilliseconds, 1000)];  
    }];  
  
    [renderer startCameraCapture];  
    return   self  ;  
}  
- (void)loadView  
{  
    CGRect mainScreenFrame = [[UIScreen mainScreen] applicationFrame];  
    GPUImageView *primaryView = [[GPUImageView alloc] initWithFrame:mainScreenFrame];  
    self.view = primaryView;  
  
    renderer = [[ES2Renderer alloc] initWithSize:[primaryView sizeInPixels]];  
  
    textureInput = [[GPUImageTextureInput alloc] initWithTexture:renderer.outputTexture size:[primaryView sizeInPixels]];  
    filter = [[GPUImagePixellateFilter alloc] init];  
    [(GPUImagePixellateFilter *)filter setFractionalWidthOfAPixel:0.01];  
  
//    filter = [[GPUImageGaussianBlurFilter alloc] init];  
//    [(GPUImageGaussianBlurFilter *)filter setBlurSize:3.0];  
  
    [textureInput addTarget:filter];  
    [filter addTarget:primaryView];  
  
    [renderer setNewFrameAvailableBlock:^{  
        float currentTimeInMilliseconds = [[NSDate date] timeIntervalSinceDate:startTime] * 1000.0;  
    
        [textureInput processTextureWithFrameTime:CMTimeMake((int)currentTimeInMilliseconds, 1000)];  
    }];  
  
    [renderer startCameraCapture];  
}  
  
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation  
{  
    return (interfaceOrientation == UIInterfaceOrientationPortrait);  
}  
  
- (void)drawView:(id)sender  
{  
    [renderer renderByRotatingAroundX:0 rotatingAroundY:0];  
}  
  
#pragma mark -  
#pragma mark Touch-handling methods  
  
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event  
{  
    NSMutableSet *currentTouches = [[event touchesForView:self.view] mutableCopy];  
    [currentTouches minusSet:touches];  
  
    // New touches are not yet included in the current touches for the view  
    lastMovementPosition = [[touches anyObject] locationInView:self.view];  
}  
  
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;  
{  
    CGPoint currentMovementPosition = [[touches anyObject] locationInView:self.view];  
    [renderer renderByRotatingAroundX:(currentMovementPosition.x - lastMovementPosition.x) rotatingAroundY:(lastMovementPosition.y - currentMovementPosition.y)];  
    lastMovementPosition = currentMovementPosition;  
}  
  
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event  
{  
    NSMutableSet *remainingTouches = [[event touchesForView:self.view] mutableCopy];  
    [remainingTouches minusSet:touches];  
  
    lastMovementPosition = [[remainingTouches anyObject] locationInView:self.view];  
}  
  
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event  
{  
    // Handle touches canceled the same as as a touches ended event  
    [self touchesEnded:touches withEvent:event];  
}  
  
  
//——————————–  
//—————–ملف العرض  
  
#import "ES2Renderer.h"  
//ES2Renderer.h  
  
// uniform index  
enum {  
    UNIFORM_MODELVIEWMATRIX,  
    UNIFORM_TEXTURE,  
    NUM_UNIFORMS  
};  
GLint uniforms[NUM_UNIFORMS];  
  
// attribute index  
enum {  
    ATTRIB_VERTEX,  
    ATTRIB_TEXTUREPOSITION,  
    NUM_ATTRIBUTES  
};  
@end  
  
@interface ES2Renderer (PrivateMethods)  
- (BOOL)loadShaders;  
- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file;  
- (BOOL)linkProgram:(GLuint)prog;  
- (BOOL)validateProgram:(GLuint)prog;  
@end  
  
@implementation ES2Renderer  
  
@synthesize outputTexture;  
@synthesize newFrameAvailableBlock;  
  
- (id)initWithSize:(CGSize)newSize;  
{  
    if ((self = [super init]))  
    {  
        // Need to use a share group based on the GPUImage context to share textures with the 3-D scene  
        context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2 sharegroup:[[[GPUImageContext sharedImageProcessingContext] context] sharegroup]];  
  
        if (!context || ![EAGLContext setCurrentContext:context] || ![self loadShaders])  
        {  
//           [self release];  
            return nil;  
        }  
    
        backingWidth = (int)newSize.width;  
        backingHeight = (int)newSize.height;  
    
        currentCalculatedMatrix = CATransform3DIdentity;  
        currentCalculatedMatrix = CATransform3DScale(currentCalculatedMatrix, 0.5, 0.5 * (320.0/480.0), 0.5);  
    
        glActiveTexture(GL_TEXTURE0);  
        glGenTextures(1, &outputTexture);  
        glBindTexture(GL_TEXTURE_2D, outputTexture);  
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);  
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);  
        // This is necessary for non-power-of-two textures  
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);  
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);  
        glBindTexture(GL_TEXTURE_2D, 0);  
  
        glActiveTexture(GL_TEXTURE1);  
        glGenFramebuffers(1, &defaultFramebuffer);  
        glBindFramebuffer(GL_FRAMEBUFFER, defaultFramebuffer);  
    
        glBindTexture(GL_TEXTURE_2D, outputTexture);  
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, backingWidth, backingHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, 0);  
        glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, outputTexture, 0);  
    
//        GLenum status = glCheckFramebufferStatus(GL_FRAMEBUFFER);  
//   
//        NSAssert(status == GL_FRAMEBUFFER_COMPLETE, @"Incomplete filter FBO: %d", status);  
        glBindTexture(GL_TEXTURE_2D, 0);  
    
    
  
        videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack];  
        videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;  
        inputFilter = [[GPUImageSepiaFilter alloc] init];  
        textureOutput = [[GPUImageTextureOutput alloc] init];  
        textureOutput.delegate = self;  
    
        [videoCamera addTarget:inputFilter];  
        [inputFilter addTarget:textureOutput];  
    }  
  
    return self;  
}  
  
- (void)renderByRotatingAroundX:(float)xRotation rotatingAroundY:(float)yRotation;  
{  
    if (!newFrameAvailableBlock)  
    {  
        return;  
    }  
  
    static const GLfloat cubeVertices[] = {  
        -1.0, -1.0, -1.0, // 0  
        1.0,  1.0, -1.0, // 2  
        1.0, -1.0, -1.0, // 1  
  
        -1.0, -1.0, -1.0, // 0  
        -1.0,  1.0, -1.0, // 3  
        1.0,  1.0, -1.0, // 2  
  
        1.0, -1.0, -1.0, // 1  
        1.0,  1.0, -1.0, // 2  
        1.0,  1.0,  1.0, // 6  
  
        1.0,  1.0,  1.0, // 6  
        1.0, -1.0,  1.0, // 5  
        1.0, -1.0, -1.0, // 1  
  
        -1.0, -1.0,  1.0, // 4  
        1.0, -1.0,  1.0, // 5  
        1.0,  1.0,  1.0, // 6  
  
        1.0,  1.0,  1.0, // 6  
        -1.0,  1.0,  1.0,  // 7  
        -1.0, -1.0,  1.0, // 4  
  
        1.0,  1.0, -1.0, // 2  
        -1.0,  1.0, -1.0, // 3  
        1.0,  1.0,  1.0, // 6  
  
        1.0,  1.0,  1.0, // 6  
        -1.0,  1.0, -1.0, // 3  
        -1.0,  1.0,  1.0,  // 7  
  
        -1.0, -1.0, -1.0, // 0  
        -1.0,  1.0,  1.0,  // 7  
        -1.0,  1.0, -1.0, // 3  
  
        -1.0, -1.0, -1.0, // 0  
        -1.0, -1.0,  1.0, // 4  
        -1.0,  1.0,  1.0,  // 7  
  
        -1.0, -1.0, -1.0, // 0  
        1.0, -1.0, -1.0, // 1  
        1.0, -1.0,  1.0, // 5  
  
        -1.0, -1.0, -1.0, // 0  
        1.0, -1.0,  1.0, // 5  
        -1.0, -1.0,  1.0 // 4  
    };  
  
    const GLfloat cubeTexCoords[] = {  
        0.0, 0.0,  
        1.0, 1.0,  
        1.0, 0.0,  
    
        0.0, 0.0,  
        0.0, 1.0,  
        1.0, 1.0,  
    
        0.0, 0.0,  
        0.0, 1.0,  
        1.0, 1.0,  
    
        1.0, 1.0,  
        1.0, 0.0,  
        0.0, 0.0,  
  
        1.0, 0.0,  
        0.0, 0.0,  
        0.0, 1.0,  
    
        0.0, 1.0,  
        1.0, 1.0,  
        1.0, 0.0,  
    
        0.0, 1.0,  
        1.0, 1.0,  
        0.0, 0.0,  
    
        0.0, 0.0,  
        1.0, 1.0,  
        1.0, 0.0,  
    
        1.0, 0.0,  
        0.0, 1.0,  
        1.0, 1.0,  
    
        1.0, 0.0,  
        0.0, 0.0,  
        0.0, 1.0,  
    
        0.0, 1.0,  
        1.0, 1.0,  
        1.0, 0.0,  
    
        0.0, 1.0,  
        1.0, 0.0,  
        0.0, 0.0  
    
  
    };  
  
    [EAGLContext setCurrentContext:context];  
  
    glBindFramebuffer(GL_FRAMEBUFFER, defaultFramebuffer);  
  
    glEnable(GL_CULL_FACE);  
    glCullFace(GL_BACK);  
  
    glViewport(0, 0, backingWidth, backingHeight);  
  
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);  
    glClear(GL_COLOR_BUFFER_BIT);  
  
    glUseProgram(program);  
    
    // Perform incremental rotation based on current angles in X and Y  
    if ((xRotation != 0.0) || (yRotation != 0.0))  
    {  
        GLfloat totalRotation = sqrt(xRotation*xRotation + yRotation*yRotation);  
    
        CATransform3D temporaryMatrix = CATransform3DRotate(currentCalculatedMatrix, totalRotation * M_PI / 180.0,  
                                                            ((xRotation/totalRotation) * currentCalculatedMatrix.m12 + (yRotation/totalRotation) * currentCalculatedMatrix.m11),  
                                                            ((xRotation/totalRotation) * currentCalculatedMatrix.m22 + (yRotation/totalRotation) * currentCalculatedMatrix.m21),  
                                                            ((xRotation/totalRotation) * currentCalculatedMatrix.m32 + (yRotation/totalRotation) * currentCalculatedMatrix.m31));  
        if ((temporaryMatrix.m11 >= -100.0) && (temporaryMatrix.m11 <= 100.0))  
            currentCalculatedMatrix = temporaryMatrix;  
    }  
    else  
    {  
    }  
  
    GLfloat currentModelViewMatrix[16];  
  
  
    [self convert3DTransform:&currentCalculatedMatrix toMatrix:currentModelViewMatrix];  
  
    glActiveTexture(GL_TEXTURE4);  
    glBindTexture(GL_TEXTURE_2D, textureForCubeFace);  
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);  
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);  
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);  
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);  
  
    // Update uniform value  
    glUniform1i(uniforms[UNIFORM_TEXTURE], 4);  
    glUniformMatrix4fv(uniforms[UNIFORM_MODELVIEWMATRIX], 1, 0, currentModelViewMatrix);  
  
    // Update attribute values  
    glVertexAttribPointer(ATTRIB_VERTEX, 3, GL_FLOAT, 0, 0, cubeVertices);  
    glEnableVertexAttribArray(ATTRIB_VERTEX);  
    glVertexAttribPointer(ATTRIB_TEXTUREPOSITION, 2, GL_FLOAT, 0, 0, cubeTexCoords);  
    glEnableVertexAttribArray(ATTRIB_TEXTUREPOSITION);  
  
    glDrawArrays(GL_TRIANGLES, 0, 36);  
  
    // The flush is required at the end here to make sure the FBO texture is written to before passing it back to GPUImage  
    glFlush();  
  
    newFrameAvailableBlock();  
}  
  
- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file  
{  
    GLint status;  
    const GLchar *source;  
  
    source = (GLchar *)[[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil] UTF8String];  
    if (!source)  
    {  
        NSLog(@"Failed to load vertex shader");  
        return FALSE;  
    }  
  
    *shader = glCreateShader(type);  
    glShaderSource(*shader, 1, &source, NULL);  
    glCompileShader(*shader);  
  
  
    glGetShaderiv(*shader, GL_COMPILE_STATUS, &status);  
    if (status == 0)  
    {  
        glDeleteShader(*shader);  
        return FALSE;  
    }  
  
    return TRUE;  
}  
  
- (BOOL)linkProgram:(GLuint)prog  
{  
    GLint status;  
  
    glLinkProgram(prog);  
  
  
    glGetProgramiv(prog, GL_LINK_STATUS, &status);  
    if (status == 0)  
        return FALSE;  
  
    return TRUE;  
}  
  
- (BOOL)validateProgram:(GLuint)prog  
{  
    GLint logLength, status;  
  
    glValidateProgram(prog);  
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);  
    if (logLength > 0)  
    {  
        GLchar *log = (GLchar *)malloc(logLength);  
        glGetProgramInfoLog(prog, logLength, &logLength, log);  
        NSLog(@"Program validate log:\n%s", log);  
        free(log);  
    }  
  
    glGetProgramiv(prog, GL_VALIDATE_STATUS, &status);  
    if (status == 0)  
        return FALSE;  
  
    return TRUE;  
}  
  
- (BOOL)loadShaders  
{  
    GLuint vertShader, fragShader;  
    NSString *vertShaderPathname, *fragShaderPathname;  
  
    // Create shader program  
    program = glCreateProgram();  
  
    // Create and compile vertex shader  
    vertShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"vsh"];  
    if (![self compileShader:&vertShader type:GL_VERTEX_SHADER file:vertShaderPathname])  
    {  
        NSLog(@"Failed to compile vertex shader");  
        return FALSE;  
    }  
  
    // Create and compile fragment shader  
    fragShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"fsh"];  
    if (![self compileShader:&fragShader type:GL_FRAGMENT_SHADER file:fragShaderPathname])  
    {  
        NSLog(@"Failed to compile fragment shader");  
        return FALSE;  
    }  
  
    // Attach vertex shader to program  
    glAttachShader(program, vertShader);  
  
    // Attach fragment shader to program  
    glAttachShader(program, fragShader);  
  
    // Bind attribute locations  
    // this needs to be done prior to linking  
    glBindAttribLocation(program, ATTRIB_VERTEX, "position");  
    glBindAttribLocation(program, ATTRIB_TEXTUREPOSITION, "inputTextureCoordinate");  
  
    // Link program  
    if (![self linkProgram:program])  
    {  
        NSLog(@"Failed to link program: %d", program);  
  
        if (vertShader)  
        {  
            glDeleteShader(vertShader);  
            vertShader = 0;  
        }  
        if (fragShader)  
        {  
            glDeleteShader(fragShader);  
            fragShader = 0;  
        }  
        if (program)  
        {  
            glDeleteProgram(program);  
            program = 0;  
        }  
    
        return FALSE;  
    }  
  
    // Get uniform locations  
    uniforms[UNIFORM_MODELVIEWMATRIX] = glGetUniformLocation(program, "modelViewProjMatrix");  
    uniforms[UNIFORM_TEXTURE] = glGetUniformLocation(program, "texture");  
  
    // Release vertex and fragment shaders  
    if (vertShader)  
        glDeleteShader(vertShader);  
    if (fragShader)  
        glDeleteShader(fragShader);  
  
    return TRUE;  
}  
  
- (void)dealloc  
{  
    // Tear down GL  
    if (defaultFramebuffer)  
    {  
        glDeleteFramebuffers(1, &defaultFramebuffer);  
        defaultFramebuffer = 0;  
    }  
  
    if (colorRenderbuffer)  
    {  
        glDeleteRenderbuffers(1, &colorRenderbuffer);  
        colorRenderbuffer = 0;  
    }  
  
    if (program)  
    {  
        glDeleteProgram(program);  
        program = 0;  
    }  
  
    // Tear down context  
    if ([EAGLContext currentContext] == context)  
        [EAGLContext setCurrentContext:nil];  
  
//   [context release];  
    context = nil;  
  
  //  [super dealloc];  
}  
  
- (void)convert3DTransform:(CATransform3D *)transform3D toMatrix:(GLfloat *)matrix;  
{  
    //    struct CATransform3D  
    //    {  
    //        CGFloat m11, m12, m13, m14;  
    //        CGFloat m21, m22, m23, m24;  
    //        CGFloat m31, m32, m33, m34;  
    //        CGFloat m41, m42, m43, m44;  
    //    };  
  
    matrix[0] = (GLfloat)transform3D->m11;  
    matrix[1] = (GLfloat)transform3D->m12;  
    matrix[2] = (GLfloat)transform3D->m13;  
    matrix[3] = (GLfloat)transform3D->m14;  
    matrix[4] = (GLfloat)transform3D->m21;  
    matrix[5] = (GLfloat)transform3D->m22;  
    matrix[6] = (GLfloat)transform3D->m23;  
    matrix[7] = (GLfloat)transform3D->m24;  
    matrix[8] = (GLfloat)transform3D->m31;  
    matrix[9] = (GLfloat)transform3D->m32;  
    matrix[10] = (GLfloat)transform3D->m33;  
    matrix[11] = (GLfloat)transform3D->m34;  
    matrix[12] = (GLfloat)transform3D->m41;  
    matrix[13] = (GLfloat)transform3D->m42;  
    matrix[14] = (GLfloat)transform3D->m43;  
    matrix[15] = (GLfloat)transform3D->m44;  
}  
  
- (void)startCameraCapture;  
{  
    [videoCamera startCameraCapture];  
}  
  
#pragma mark -  
#pragma mark GPUImageTextureOutputDelegate delegate method  
  
- (void)newFrameReadyFromTextureOutput:(GPUImageTextureOutput *)callbackTextureOutput;  
{  
    // Rotation in response to touch events is handled on the main thread, so to be safe we dispatch this on the main queue as well  
    // Nominally, I should create a dispatch queue just for the rendering within this application, but not today  
    dispatch_async(dispatch_get_main_queue(), ^{  
        textureForCubeFace = callbackTextureOutput.texture;  
    
        [self renderByRotatingAroundX:0.0 rotatingAroundY:0.0];  
        [callbackTextureOutput doneWithTexture];  
    });  
}  
  
//—————–  
@end  
#import "GPUImageSepiaFilter.h"  
  
@implementation GPUImageSepiaFilter  
  
- (id)init;  
{  
    if (!(self = [super init]))  
    {  
        return nil;  
    }  
  
    self.intensity = 1.0;  
    self.colorMatrix = (GPUMatrix4x4){  
        {0.3588, 0.7044, 0.1368, 0.0},  
        {0.2990, 0.5870, 0.1140, 0.0},  
        {0.2392, 0.4696, 0.0912 ,0.0},  
        {0,0,0,1.0},  
    };  
  
    return self;  
}  
  
  
@end  
  
#import "GPUImageTextureInput.h"  
  
@implementation GPUImageTextureInput  
  
#pragma mark -  
#pragma mark Initialization and teardown  
  
- (id)initWithTexture:(GLuint)newInputTexture size:(CGSize)newTextureSize;  
{  
    if (!(self = [super init]))  
    {  
        return nil;  
    }  
  
    runSynchronouslyOnVideoProcessingQueue(^{  
        [GPUImageContext useImageProcessingContext];  
    });  
  
    textureSize = newTextureSize;  
  
    runSynchronouslyOnVideoProcessingQueue(^{  
        outputFramebuffer = [[GPUImageFramebuffer alloc] initWithSize:newTextureSize overriddenTexture:newInputTexture];  
    });  
  
    return self;  
}  
  
#pragma mark -  
#pragma mark Image rendering  
  
- (void)processTextureWithFrameTime:(CMTime)frameTime;  
{  
    runAsynchronouslyOnVideoProcessingQueue(^{  
        for (id<GPUImageInput> currentTarget in targets)  
        {  
            NSInteger indexOfObject = [targets indexOfObject:currentTarget];  
            NSInteger targetTextureIndex = [[targetTextureIndices objectAtIndex:indexOfObject] integerValue];  
        
            [currentTarget setInputSize:textureSize atIndex:targetTextureIndex];  
            [currentTarget setInputFramebuffer:outputFramebuffer atIndex:targetTextureIndex];  
            [currentTarget newFrameReadyAtTime:frameTime atIndex:targetTextureIndex];  
        }  
    });  
}  
  
//————————–  
#import "GPUImageTextureOutput.h"  
@end  
  
@implementation GPUImageTextureOutput  
  
@synthesize delegate = _delegate;  
@synthesize texture = _texture;  
@synthesize enabled;  
  
#pragma mark -  
#pragma mark Initialization and teardown  
  
- (id)init;  
{  
    if (!(self = [super init]))  
    {  
        return nil;  
    }  
  
    self.enabled = YES;  
  
    return self;  
}  
  
- (void)doneWithTexture;  
{  
    [firstInputFramebuffer unlock];  
}  
  
#pragma mark -  
#pragma mark GPUImageInput protocol  
  
- (void)newFrameReadyAtTime:(CMTime)frameTime atIndex:(NSInteger)textureIndex;  
{  
    [_delegate newFrameReadyFromTextureOutput:self];  
}  
  
- (NSInteger)nextAvailableTextureIndex;  
{  
    return 0;  
}  
  
// TODO: Deal with the fact that the texture changes regularly as a result of the caching  
- (void)setInputFramebuffer:(GPUImageFramebuffer *)newInputFramebuffer atIndex:(NSInteger)textureIndex;  
{  
    firstInputFramebuffer = newInputFramebuffer;  
    [firstInputFramebuffer lock];  
  
    _texture = [firstInputFramebuffer texture];  
}  
  
- (void)setInputRotation:(GPUImageRotationMode)newInputRotation atIndex:(NSInteger)textureIndex;  
{  
}  
  
- (void)setInputSize:(CGSize)newSize atIndex:(NSInteger)textureIndex;  
{  
}  
  
- (CGSize)maximumOutputSize;  
{  
    return CGSizeZero;  
}  
  
- (void)endProcessing  
{  
}  
  
- (BOOL)shouldIgnoreUpdatesToThisTarget;  
{  
    return NO;  
}  
  
- (BOOL)wantsMonochromeInput;  
{  
    return NO;  
}  
  
- (void)setCurrentlyReceivingMonochromeInput:(BOOL)newValue;  
{  
  
}  
//——————————————————  
  
#import "GPUImageVideoCamera.h"  
#import "GPUImageMovieWriter.h"  
#import "GPUImageFilter.h"  
  
void setColorConversion601( GLfloat conversionMatrix[9] )  
{  
    kColorConversion601 = conversionMatrix;  
}  
  
void setColorConversion601FullRange( GLfloat conversionMatrix[9] )  
{  
    kColorConversion601FullRange = conversionMatrix;  
}  
  
void setColorConversion709( GLfloat conversionMatrix[9] )  
{  
    kColorConversion709 = conversionMatrix;  
}  
  
#pragma mark -  
#pragma mark Private methods and instance variables  
@end  
  
@interface GPUImageVideoCamera ()  
{  
    AVCaptureDeviceInput *audioInput;  
    AVCaptureAudioDataOutput *audioOutput;  
    NSDate *startingCaptureTime;  
  
    dispatch_queue_t cameraProcessingQueue, audioProcessingQueue;  
  
    GLProgram *yuvConversionProgram;  
    GLint yuvConversionPositionAttribute, yuvConversionTextureCoordinateAttribute;  
    GLint yuvConversionLuminanceTextureUniform, yuvConversionChrominanceTextureUniform;  
    GLint yuvConversionMatrixUniform;  
    const GLfloat *_preferredConversion;  
  
    BOOL isFullYUVRange;  
  
    int imageBufferWidth, imageBufferHeight;  
  
    BOOL addedAudioInputsDueToEncodingTarget;  
}  
  
- (void)updateOrientationSendToTargets;  
- (void)convertYUVToRGBOutput;  
  
@end  
  
@implementation GPUImageVideoCamera  
  
@synthesize captureSessionPreset = _captureSessionPreset;  
@synthesize captureSession = _captureSession;  
@synthesize inputCamera = _inputCamera;  
@synthesize runBenchmark = _runBenchmark;  
@synthesize outputImageOrientation = _outputImageOrientation;  
@synthesize delegate = _delegate;  
@synthesize horizontallyMirrorFrontFacingCamera = _horizontallyMirrorFrontFacingCamera, horizontallyMirrorRearFacingCamera = _horizontallyMirrorRearFacingCamera;  
@synthesize frameRate = _frameRate;  
  
#pragma mark -  
#pragma mark Initialization and teardown  
  
- (id)init;  
{  
    if (!(self = [self initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack]))  
    {  
        return nil;  
    }  
  
    return self;  
}  
  
- (id)initWithSessionPreset:(NSString *)sessionPreset cameraPosition:(AVCaptureDevicePosition)cameraPosition;  
{  
    if (!(self = [super init]))  
    {  
        return nil;  
    }  
  
    cameraProcessingQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0);  
    audioProcessingQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW,0);  
  
    frameRenderingSemaphore = dispatch_semaphore_create(1);  
  
    _frameRate = 0; // This will not set frame rate unless this value gets set to 1 or above  
    _runBenchmark = NO;  
    capturePaused = NO;  
    outputRotation = kGPUImageNoRotation;  
    internalRotation = kGPUImageNoRotation;  
    captureAsYUV = YES;  
    _preferredConversion = kColorConversion709;  
  
    // Grab the back-facing or front-facing camera  
    _inputCamera = nil;  
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];  
    for (AVCaptureDevice *device in devices)  
    {  
        if ([device position] == cameraPosition)  
        {  
            _inputCamera = device;  
        }  
    }  
  
    if (!_inputCamera) {  
        return nil;  
    }  
  
    // Create the capture session  
    _captureSession = [[AVCaptureSession alloc] init];  
  
    [_captureSession beginConfiguration];  
  
    // Add the video input  
    NSError *error = nil;  
    videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:_inputCamera error:&error];  
    if ([_captureSession canAddInput:videoInput])  
    {  
        [_captureSession addInput:videoInput];  
    }  
  
    // Add the video frame output  
    videoOutput = [[AVCaptureVideoDataOutput alloc] init];  
    [videoOutput setAlwaysDiscardsLateVideoFrames:NO];  
  
//    if (captureAsYUV && [GPUImageContext deviceSupportsRedTextures])  
    if (captureAsYUV && [GPUImageContext supportsFastTextureUpload])  
    {  
        BOOL supportsFullYUVRange = NO;  
        NSArray *supportedPixelFormats = videoOutput.availableVideoCVPixelFormatTypes;  
        for (NSNumber *currentPixelFormat in supportedPixelFormats)  
        {  
            if ([currentPixelFormat intValue] == kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)  
            {  
                supportsFullYUVRange = YES;  
            }  
        }  
    
        if (supportsFullYUVRange)  
        {  
            [videoOutput setVideoSettings:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_420YpCbCr8BiPlanarFullRange] forKey:(id)kCVPixelBufferPixelFormatTypeKey]];  
            isFullYUVRange = YES;  
        }  
        else  
        {  
            [videoOutput setVideoSettings:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange] forKey:(id)kCVPixelBufferPixelFormatTypeKey]];  
            isFullYUVRange = NO;  
        }  
    }  
    else  
    {  
        [videoOutput setVideoSettings:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA] forKey:(id)kCVPixelBufferPixelFormatTypeKey]];  
    }  
  
    runSynchronouslyOnVideoProcessingQueue(^{  
    
        if (captureAsYUV)  
        {  
            [GPUImageContext useImageProcessingContext];  
            //            if ([GPUImageContext deviceSupportsRedTextures])  
            //            {  
            //                yuvConversionProgram = [[GPUImageContext sharedImageProcessingContext] programForVertexShaderString:kGPUImageVertexShaderString fragmentShaderString:kGPUImageYUVVideoRangeConversionForRGFragmentShaderString];  
            //            }  
            //            else  
            //            {  
            if (isFullYUVRange)  
            {  
                yuvConversionProgram = [[GPUImageContext sharedImageProcessingContext] programForVertexShaderString:kGPUImageVertexShaderString fragmentShaderString:kGPUImageYUVFullRangeConversionForLAFragmentShaderString];  
            }  
            else  
            {  
                yuvConversionProgram = [[GPUImageContext sharedImageProcessingContext] programForVertexShaderString:kGPUImageVertexShaderString fragmentShaderString:kGPUImageYUVVideoRangeConversionForLAFragmentShaderString];  
            }  
  
            //            }  
        
            if (!yuvConversionProgram.initialized)  
            {  
                [yuvConversionProgram addAttribute:@"position"];  
                [yuvConversionProgram addAttribute:@"inputTextureCoordinate"];  
            
                if (![yuvConversionProgram link])  
                {  
                    NSString *progLog = [yuvConversionProgram programLog];  
                    NSLog(@"Program link log: %@", progLog);  
                    NSString *fragLog = [yuvConversionProgram fragmentShaderLog];  
                    NSLog(@"Fragment shader compile log: %@", fragLog);  
                    NSString *vertLog = [yuvConversionProgram vertexShaderLog];  
                    NSLog(@"Vertex shader compile log: %@", vertLog);  
                    yuvConversionProgram = nil;  
                    NSAssert(NO, @"Filter shader link failed");  
                }  
            }  
        
            yuvConversionPositionAttribute = [yuvConversionProgram attributeIndex:@"position"];  
            yuvConversionTextureCoordinateAttribute = [yuvConversionProgram attributeIndex:@"inputTextureCoordinate"];  
            yuvConversionLuminanceTextureUniform = [yuvConversionProgram uniformIndex:@"luminanceTexture"];  
            yuvConversionChrominanceTextureUniform = [yuvConversionProgram uniformIndex:@"chrominanceTexture"];  
            yuvConversionMatrixUniform = [yuvConversionProgram uniformIndex:@"colorConversionMatrix"];  
        
            [GPUImageContext setActiveShaderProgram:yuvConversionProgram];  
        
            glEnableVertexAttribArray(yuvConversionPositionAttribute);  
            glEnableVertexAttribArray(yuvConversionTextureCoordinateAttribute);  
        }  
    });  
  
    [videoOutput setSampleBufferDelegate:self queue:cameraProcessingQueue];  
    if ([_captureSession canAddOutput:videoOutput])  
    {  
        [_captureSession addOutput:videoOutput];  
    }  
    else  
    {  
        NSLog(@"Couldn't add video output");  
        return nil;  
    }  
  
    _captureSessionPreset = sessionPreset;  
    [_captureSession setSessionPreset:_captureSessionPreset];  
  
// This will let you get 60 FPS video from the 720p preset on an iPhone 4S, but only that device and that preset  
//    AVCaptureConnection *conn = [videoOutput connectionWithMediaType:AVMediaTypeVideo];  
//  
//    if (conn.supportsVideoMinFrameDuration)  
//        conn.videoMinFrameDuration = CMTimeMake(1,60);  
//    if (conn.supportsVideoMaxFrameDuration)  
//        conn.videoMaxFrameDuration = CMTimeMake(1,60);  
  
    [_captureSession commitConfiguration];  
  
    return self;  
}  
  
- (GPUImageFramebuffer *)framebufferForOutput;  
{  
    return outputFramebuffer;  
}  
  
- (void)dealloc  
{  
    [self stopCameraCapture];  
    [videoOutput setSampleBufferDelegate:nil queue:dispatch_get_main_queue()];  
    [audioOutput setSampleBufferDelegate:nil queue:dispatch_get_main_queue()];  
  
    [self removeInputsAndOutputs];  
  
// ARC forbids explicit message send of 'release'; since iOS 6 even for dispatch_release() calls: stripping it out in that case is required.  
//#if !OS_OBJECT_USE_OBJC  
//    if (frameRenderingSemaphore != NULL)  
//   {  
//       dispatch_release(frameRenderingSemaphore);  
//    }  
//#endif  
}  
  
- (BOOL)addAudioInputsAndOutputs  
{  
    if (audioOutput)  
        return NO;  
  
    [_captureSession beginConfiguration];  
  
    _microphone = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];  
    audioInput = [AVCaptureDeviceInput deviceInputWithDevice:_microphone error:nil];  
    if ([_captureSession canAddInput:audioInput])  
    {  
        [_captureSession addInput:audioInput];  
    }  
    audioOutput = [[AVCaptureAudioDataOutput alloc] init];  
  
    if ([_captureSession canAddOutput:audioOutput])  
    {  
        [_captureSession addOutput:audioOutput];  
    }  
    else  
    {  
        NSLog(@"Couldn't add audio output");  
    }  
    [audioOutput setSampleBufferDelegate:self queue:audioProcessingQueue];  
  
    [_captureSession commitConfiguration];  
    return YES;  
}  
  
- (BOOL)removeAudioInputsAndOutputs  
{  
    if (!audioOutput)  
        return NO;  
  
    [_captureSession beginConfiguration];  
    [_captureSession removeInput:audioInput];  
    [_captureSession removeOutput:audioOutput];  
    audioInput = nil;  
    audioOutput = nil;  
    _microphone = nil;  
    [_captureSession commitConfiguration];  
    return YES;  
}  
  
- (void)removeInputsAndOutputs;  
{  
    [_captureSession beginConfiguration];  
    if (videoInput) {  
        [_captureSession removeInput:videoInput];  
        [_captureSession removeOutput:videoOutput];  
        videoInput = nil;  
        videoOutput = nil;  
    }  
    if (_microphone != nil)  
    {  
        [_captureSession removeInput:audioInput];  
        [_captureSession removeOutput:audioOutput];  
        audioInput = nil;  
        audioOutput = nil;  
        _microphone = nil;  
    }  
    [_captureSession commitConfiguration];  
}  
  
#pragma mark -  
#pragma mark Managing targets  
  
- (void)addTarget:(id<GPUImageInput>)newTarget atTextureLocation:(NSInteger)textureLocation;  
{  
    [super addTarget:newTarget atTextureLocation:textureLocation];  
  
    [newTarget setInputRotation:outputRotation atIndex:textureLocation];  
}  
  
#pragma mark -  
#pragma mark Manage the camera video stream  
  
- (BOOL)isRunning;  
{  
    return [_captureSession isRunning];  
}  
  
- (void)startCameraCapture;  
{  
    if (![_captureSession isRunning])  
    {  
        startingCaptureTime = [NSDate date];  
        [_captureSession startRunning];  
    };  
}  
  
- (void)stopCameraCapture;  
{  
    if ([_captureSession isRunning])  
    {  
        [_captureSession stopRunning];  
    }  
}  
  
- (void)pauseCameraCapture;  
{  
    capturePaused = YES;  
}  
  
- (void)resumeCameraCapture;  
{  
    capturePaused = NO;  
}  
  
- (void)rotateCamera  
{  
    if (self.frontFacingCameraPresent == NO)  
        return;  
  
    NSError *error;  
    AVCaptureDeviceInput *newVideoInput;  
    AVCaptureDevicePosition currentCameraPosition = [[videoInput device] position];  
  
    if (currentCameraPosition == AVCaptureDevicePositionBack)  
    {  
        currentCameraPosition = AVCaptureDevicePositionFront;  
    }  
    else  
    {  
        currentCameraPosition = AVCaptureDevicePositionBack;  
    }  
  
    AVCaptureDevice *backFacingCamera = nil;  
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];  
    for (AVCaptureDevice *device in devices)  
    {  
        if ([device position] == currentCameraPosition)  
        {  
            backFacingCamera = device;  
        }  
    }  
    newVideoInput = [[AVCaptureDeviceInput alloc] initWithDevice:backFacingCamera error:&error];  
  
    if (newVideoInput != nil)  
    {  
        [_captureSession beginConfiguration];  
    
        [_captureSession removeInput:videoInput];  
        if ([_captureSession canAddInput:newVideoInput])  
        {  
            [_captureSession addInput:newVideoInput];  
            videoInput = newVideoInput;  
        }  
        else  
        {  
            [_captureSession addInput:videoInput];  
        }  
        //captureSession.sessionPreset = oriPreset;  
        [_captureSession commitConfiguration];  
    }  
  
    _inputCamera = backFacingCamera;  
    [self setOutputImageOrientation:_outputImageOrientation];  
}  
  
- (AVCaptureDevicePosition)cameraPosition  
{  
    return [[videoInput device] position];  
}  
  
+ (BOOL)isBackFacingCameraPresent;  
{  
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];  
  
    for (AVCaptureDevice *device in devices)  
    {  
        if ([device position] == AVCaptureDevicePositionBack)  
            return YES;  
    }  
  
    return NO;  
}  
  
- (BOOL)isBackFacingCameraPresent  
{  
    return [GPUImageVideoCamera isBackFacingCameraPresent];  
}  
  
+ (BOOL)isFrontFacingCameraPresent;  
{  
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];  
  
    for (AVCaptureDevice *device in devices)  
    {  
        if ([device position] == AVCaptureDevicePositionFront)  
            return YES;  
    }  
  
    return NO;  
}  
  
- (BOOL)isFrontFacingCameraPresent  
{  
    return [GPUImageVideoCamera isFrontFacingCameraPresent];  
}  
  
- (void)setCaptureSessionPreset:(NSString *)captureSessionPreset;  
{  
    [_captureSession beginConfiguration];  
  
    _captureSessionPreset = captureSessionPreset;  
    [_captureSession setSessionPreset:_captureSessionPreset];  
  
    [_captureSession commitConfiguration];  
}  
  
- (void)setFrameRate:(int32_t)frameRate;  
{  
    _frameRate = frameRate;  
  
    if (_frameRate > 0)  
    {  
        if ([_inputCamera respondsToSelector:@selector(setActiveVideoMinFrameDuration:)] &&  
            [_inputCamera respondsToSelector:@selector(setActiveVideoMaxFrameDuration:)]) {  
        
            NSError *error;  
            [_inputCamera lockForConfiguration:&error];  
            if (error == nil) {  
//#if defined(__IPHONE_7_0)  
                [_inputCamera setActiveVideoMinFrameDuration:CMTimeMake(1, _frameRate)];  
                [_inputCamera setActiveVideoMaxFrameDuration:CMTimeMake(1, _frameRate)];  
//#endif  
            }  
            [_inputCamera unlockForConfiguration];  
        
        } else {  
        
            for (AVCaptureConnection *connection in videoOutput.connections)  
            {  
#pragma clang diagnostic push  
#pragma clang diagnostic ignored "-Wdeprecated-declarations"  
                if ([connection respondsToSelector:@selector(setVideoMinFrameDuration:)])  
                    connection.videoMinFrameDuration = CMTimeMake(1, _frameRate);  
            
                if ([connection respondsToSelector:@selector(setVideoMaxFrameDuration:)])  
                    connection.videoMaxFrameDuration = CMTimeMake(1, _frameRate);  
#pragma clang diagnostic pop  
            }  
        }  
    
    }  
    else  
    {  
        if ([_inputCamera respondsToSelector:@selector(setActiveVideoMinFrameDuration:)] &&  
            [_inputCamera respondsToSelector:@selector(setActiveVideoMaxFrameDuration:)]) {  
        
            NSError *error;  
            [_inputCamera lockForConfiguration:&error];  
            if (error == nil) {  
//#if defined(__IPHONE_7_0)  
                [_inputCamera setActiveVideoMinFrameDuration:kCMTimeInvalid];  
                [_inputCamera setActiveVideoMaxFrameDuration:kCMTimeInvalid];  
//#endif  
            }  
            [_inputCamera unlockForConfiguration];  
        
        } else {  
        
            for (AVCaptureConnection *connection in videoOutput.connections)  
            {  
#pragma clang diagnostic push  
#pragma clang diagnostic ignored "-Wdeprecated-declarations"  
                if ([connection respondsToSelector:@selector(setVideoMinFrameDuration:)])  
                    connection.videoMinFrameDuration = kCMTimeInvalid; // This sets videoMinFrameDuration back to default  
            
                if ([connection respondsToSelector:@selector(setVideoMaxFrameDuration:)])  
                    connection.videoMaxFrameDuration = kCMTimeInvalid; // This sets videoMaxFrameDuration back to default  
#pragma clang diagnostic pop  
            }  
        }  
    
    }  
}  
  
- (int32_t)frameRate;  
{
```