B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
'''#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region


'Ctrl + click To export As zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private VideoPlayer1 As VideoPlayer
	Private btnStop As B4XView
	
	Private pip As NativeObject
	Private playerViewController As NativeObject
	Private playerLayerHelper As NativeObject
	'''Private playerContainer As Panel
	Private playerContainer As Panel
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	playerViewController = CreatePlayerViewController("https://bestvpn.org/html5demos/assets/dizzy.mp4")
'''	VideoPlayer1 = playerViewController.GetField("view")
	playerLayerHelper = CreatePlayerLayer(playerViewController)
	AddPlayerViewToContainer(playerViewController, playerContainer)
	pip = CreatePIPController(playerLayerHelper)
	
	
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	'''xui.MsgboxAsync("Hello world!", "B4X")
'''	Log(VideoPlayer1.As(NativeObject))
'''	Dim no As NativeObject = VideoPlayer1
'''	'''VideoPlayer1.LoadVideoUrl("https://bestvpn.org/html5demos/assets/dizzy.mp4")
'''	Dim no2 As NativeObject = Me
'''	Dim no3 As NativeObject = Main.App
'''	no2.RunMethod("setAVController:delegate:", Array("https://bestvpn.org/html5demos/assets/dizzy.mp4", no3.GetField("delegate")))

	'''pip = 
'''	Sleep(500)
	'''pip.RunMethod("startPIP", Null)
	StartPlayingVideo(playerViewController)
'''	StartPIP
End Sub

Sub StartPlayingVideo(playerViewController2 As NativeObject)
	Dim player As NativeObject = playerViewController2.GetField("player")
	player.RunMethod("play", Null)
End Sub

'''Private Sub VideoPlayer1_Ready (Success As Boolean)
'''	If Success Then
'''		VideoPlayer1.Play
'''	End If
'''End Sub
'''
'''Private Sub VideoPlayer1_Complete
'''	
'''End Sub

Private Sub btnStop_Click
'''	VideoPlayer1.Pause
	pip.RunMethod("stopPIP", Null)
End Sub

Private Sub StartPIP
	pip.RunMethod("startPIP", Null)
End Sub

private Sub StopPIP
	pip.RunMethod("stopPIP", Null)
End Sub
Sub CreatePlayerViewController(videoURL As String) As NativeObject
	Dim playerViewController2 As NativeObject
	playerViewController2 = playerViewController2.Initialize("AVPlayerViewController").RunMethod("new", Null)
    
	Dim player As NativeObject
	player = player.Initialize("AVPlayer").RunMethod("playerWithURL:", Array(CreateURL(videoURL)))
	'''vp.LoadVideoUrl(videoURL)
    
	playerViewController2.RunMethod("setPlayer:", Array(player))
	
	Dim audioSessionHelper As NativeObject
	audioSessionHelper.Initialize("AudioSessionHelper").RunMethod("configureAudioSession", Null)
    
	Return playerViewController2
End Sub

Sub CreateURL(url As String) As NativeObject
	Dim nsurl As NativeObject
	nsurl = nsurl.Initialize("NSURL").RunMethod("URLWithString:", Array(url))
'''	nsurl.Initialize("NSURL").RunMethod("initWithString:", Array(url))
	Dim description As String = nsurl.RunMethod("absoluteString", Null).AsString
	Log("nsurl: " & description)
	Return nsurl
End Sub

Sub CreatePIPController(playerLayer2 As NativeObject) As NativeObject
	Dim pip As NativeObject = Me
	pip = pip.Initialize("PIPController").RunMethod("alloc", Null).RunMethod("initWithPlayerLayer:", Array(playerLayer2))
	Return pip
End Sub

Sub CreatePlayerLayer(playerViewController2 As NativeObject) As NativeObject
	Dim playerHelper2 As NativeObject
	playerHelper2 =	playerHelper2.Initialize("PlayerLayerHelper").RunMethod("new", Null)
	playerHelper2.RunMethod("createPlayerLayer:", Array(playerViewController2))
	
'''	Dim no As NativeObject
'''	no.Initialize("NSObject").RunMethod("createPlayerLayer:", Array(playerViewController2))
	Return playerHelper2.GetField("playerLayer")
End Sub

Sub AddPlayerViewToContainer(playerViewController2 As NativeObject, container As Panel)
	Dim playerView As NativeObject = playerViewController2.GetField("view")
	'''container.RunMethod("addSubview:", Array(playerView))
	container.AddView(playerView.As(View), 0, 0, container.Width/2, container.Height/2)
	'''container.As(NativeObject).RunMethod("addSubview:", Array(playerView))
	Log("playerLayer is initialized: " & playerLayerHelper.IsInitialized)
	'''playerLayerHelper.SetField("setFrameForView:x:y:width:height:", Array(playerView, 0.0, 0.0, container.Width, container.Height))
	'''playerLayerHelper.RunMethod("setFrameForView:x:y:width:height:", Array(playerView, 0.0, 0.0, container.Width, container.Height))
	'''playerLayerHelper.RunMethod("setFrameForView:", Array(Null))
'''	playerView.RunMethod("setFrame:", Array(0, 0, container.Width, container.Height))
	Dim flexibleWidth As NativeObject
	Dim flexibleHeight As NativeObject
	flexibleWidth.Initialize("NSNumber").RunMethod("numberWithInt:", Array(2))
	flexibleHeight.Initialize("NSNumber").RunMethod("numberWithInt:", Array(16))
	playerView.RunMethod("setAutoresizingMask:", Array(flexibleWidth Or flexibleHeight))
End Sub

'''Sub CreatePlayerLayer(mplayerViewController As NativeObject) As NativeObject
'''	Dim no As NativeObject
'''	no = no.Initialize("NSObject")
'''	no.RunMethod("
'''End Sub

Sub getDelegate As NativeObject
	Dim no As NativeObject = Main.App
	no = no.GetField("delegate")
	Return no
End Sub

#If OBJC
#import <Foundation/Foundation.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
@end
@interface PlayerLayerHelper : NSObject
@property (nonatomic, strong) AVPlayerLayer *playerLayer;

- (void)createPlayerLayer:(AVPlayerViewController *)playerViewController;
- (void)setFrameForView:(UIView *)view x:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height;
@end

@implementation PlayerLayerHelper

- (void)createPlayerLayer:(AVPlayerViewController *)playerViewController {
	NSLog(@"creating PlayerLayer");
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:playerViewController.player];
    [playerViewController.view.layer addSublayer:self.playerLayer];
    self.playerLayer.frame = playerViewController.view.bounds;
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
}

- (void)setFrameForView:(UIView *)view x:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height {
	NSLog(@"found setFrameForView method");
    view.frame = CGRectMake(x, y, width, height);
}


@end
@interface PIPController: NSObject <AVPictureInPictureControllerDelegate>

@property (nonatomic, strong) AVPictureInPictureController *pipController;
@property (nonatomic, strong) AVPlayerViewController *playerViewController;

- (instancetype)initWithPlayerViewController:(AVPlayerViewController *)playerViewController;
- (void)startPIP;
- (void)stopPIP;
@end

@implementation PIPController

- (instancetype)initWithPlayerLayer:(AVPlayerLayer *)playerLayer {
    self = [super init];
    if (self) {
        if ([AVPictureInPictureController isPictureInPictureSupported]) {
            self.pipController = [[AVPictureInPictureController alloc] initWithPlayerLayer:playerLayer];
            self.pipController.delegate = self;
        }
    }
    return self;
}

- (void)startPIP {
    if (self.pipController) {
		NSLog(@"starting playing from PIPController");
        [self.pipController startPictureInPicture];
    }
}

- (void)stopPIP {
    if (self.pipController) {
        [self.pipController stopPictureInPicture];
    }
}

@end
@interface AudioSessionHelper : NSObject
+ (void)configureAudioSession;
@end

@implementation AudioSessionHelper

+ (void)configureAudioSession {
    NSError *error = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback
                                     withOptions:AVAudioSessionCategoryOptionMixWithOthers
                                           error:&error];
    if (error) {
        NSLog(@"Error setting audio session category: %@", error);
    } else {
        [[AVAudioSession sharedInstance] setActive:YES error:&error];
        if (error) {
            NSLog(@"Error activating audio session: %@", error);
        }
    }
}
#End If

Sub B4XPage_Background
	Log("application placed in background")
	StartPIP
End Sub

