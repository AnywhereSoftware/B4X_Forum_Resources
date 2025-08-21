### Background playback by Erel
### 05/17/2020
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/49337/)

This tutorial explains how you can play local audio files or stream audio while your app is in the background.  
Standard applications are killed when moved to the background. However you can add the following attribute to your project to mark it as an application that plays audio in the background:  

```B4X
#Region  Project Attributes  
   #ApplicationLabel: B4i Example  
   #Version: 1.0.0  
   'Orientation possible values: Portrait, LandscapeLeft, LandscapeRight and PortraitUpsideDown  
   #iPhoneOrientations: Portrait, LandscapeLeft, LandscapeRight  
   #iPadOrientations: Portrait, LandscapeLeft, LandscapeRight, PortraitUpsideDown  
   #Target: iPhone, iPad  
   #MinVersion: 8  
#End Region  
#PlistExtra: <key>UIBackgroundModes</key><array><string>audio</string></array>  
  
Sub Process_Globals  
    Public App As Application  
    Public NavControl As NavigationController  
    Private Page1 As Page  
    Private NativeMe As NativeObject  
    Private VideoPlayer1 As VideoPlayer  
End Sub  
  
Private Sub Application_Start (Nav As NavigationController)  
    NativeMe = Me  
    NavControl = Nav  
    Page1.Initialize("Page1")  
    Page1.RootPanel.LoadLayout("1")  
    NavControl.ShowPage(Page1)  
    NativeMe.RunMethod("setAudioSession", Null)  
    VideoPlayer1.LoadVideoUrl("https://stream-dc1.radioparadise.com/mp3-32")  
    VideoPlayer1.Play  
     
    NativeMe.RunMethod("register", Null)  
End Sub  
  
Public Sub ControlEvent (Command As String)  
    Select Command  
        Case "play"  
            VideoPlayer1.Play  
        Case "pause"  
            VideoPlayer1.Pause  
    End Select  
End Sub  
  
  
  
#If OBJC  
@import MediaPlayer;  
#import <AVFoundation/AVFoundation.h>  
#import <AudioToolbox/AudioToolbox.h>  
- (void)setAudioSession {  
  AVAudioSession *audioSession = [AVAudioSession sharedInstance];  
  NSError *err = nil;  
  BOOL success = [audioSession setCategory:AVAudioSessionCategoryPlayback error:&err];  
  if (success) {  
     success = [audioSession setActive:YES error:&err];  
   success = [audioSession setPreferredSampleRate:4096 error:nil];  
   [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];  
  }  
  if (!success)  
  [NSException raise:@"" format:@"Error setting audio session: %@", err];  
}  
- (void)register {  
   MPRemoteCommandCenter* center = [MPRemoteCommandCenter sharedCommandCenter];  
   center.playCommand.enabled = true;  
   center.pauseCommand.enabled = true;  
   [center.playCommand addTarget:self action:@selector(play)];  
   [center.pauseCommand addTarget:self action:@selector(pause)];  
}  
- (MPRemoteCommandHandlerStatus) play {  
   NSLog(@"test");  
   [self.bi raiseEvent:nil event:@"controlevent:"  params:@[@"play"]];  
   return MPRemoteCommandHandlerStatusSuccess;  
  
}  
- (MPRemoteCommandHandlerStatus) pause {  
   [self.bi raiseEvent:nil event:@"controlevent:"  params:@[@"pause"]];  
   return MPRemoteCommandHandlerStatusSuccess;  
}  
  
#end if
```

  
  
The above code will play the radio stream. You can leave your app and the streaming will continue.  
  
With this code the user can play and pause the playback from the draggable control center.