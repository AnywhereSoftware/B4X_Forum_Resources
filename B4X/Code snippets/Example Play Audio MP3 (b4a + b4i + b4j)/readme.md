###  Example Play Audio MP3 (b4a + b4i + b4j) by Lucas Siqueira
### 03/12/2025
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/166102/)

[HEADING=2]![](https://www.b4x.com/android/forum/attachments/162499)[/HEADING]  
[HEADING=2][/HEADING]  
[HEADING=2]**Explanation of the Solution**[/HEADING]  

1. **Audio Session Configuration on iOS:**

- On iOS, audio playback depends on the correct configuration of the audio session (AVAudioSession). By default, iOS may block or mute sounds if the audio session is not explicitly configured.
- The AVAudioSessionCategoryPlayback category allows audio to play even when the device is in silent mode (mute).

2. **Adding Code to Application\_Start:**

- The setAudioSession method is called at the start of the application to configure the audio session. This ensures that the app is ready to play MP3 sounds as soon as needed.

3. **Using Native Code (Objective-C):**

- Since B4i does not have a direct API to configure the audio session, you used native Objective-C code to access the AVAudioSession class and set the audio category.
- The Objective-C snippet (#If OBJC) configures the audio session and handles potential errors, logging them to the console for debugging.

4. **Integration with MediaPlayer:**

- After setting up the audio session, the MediaPlayer can be used normally to play MP3 sound files.

  

---

  
**[SIZE=5]👉 Source for [/SIZE]**[**[SIZE=5]download free[/SIZE]**](https://payhip.com/b/sKyHF)  
**[SIZE=5]because of the audio file, I can't attach the source code here, I published the source code with the audio on the website for free download[/SIZE]**  
[HEADING=2][/HEADING]  
[HEADING=2][/HEADING]  
[HEADING=2][/HEADING]  
[HEADING=2]**Complete Code for Sound Playback in B4i**[/HEADING]  
Here’s the complete code with the necessary changes to play sounds on iOS:  
  
  
  
[HEADING=3]**Main.b4i**[/HEADING]  

```B4X
Private Sub Application_Start (Nav As NavigationController)  
    NavControl = Nav  
    
    ' Audio session setup  
    Dim jo As NativeObject = Me  
    jo.RunMethod("setAudioSession", Null)  
    
    ' Initialize the pages manager  
    Dim PagesManager As B4XPagesManager  
    PagesManager.Initialize(NavControl)  
End Sub  
  
' Native code to configure the audio session  
#If OBJC  
#import <AVFoundation/AVFoundation.h>  
- (void) setAudioSession {  
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];  
    BOOL ok;  
    NSError *setCategoryError = nil;  
    ok = [audioSession setCategory:AVAudioSessionCategoryPlayback error:&setCategoryError];  
    if (!ok) {  
        NSLog(@"%s setCategoryError=%@", __PRETTY_FUNCTION__, setCategoryError);  
    }  
}  
#End If
```

  
  
[HEADING=3]**B4XMainPage.b4i**[/HEADING]  

```B4X
#Region Shared Files  
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"  
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True  
#End Region  
  
'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=B4X_ExampleAudio.zip  
  
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Private B4XImageView1 As B4XImageView  
    Private B4XImageView2 As B4XImageView  
    Private Button1 As B4XView  
    
    Private playingMusic As Boolean  
    
    Private mp As MediaPlayer  
End Sub  
  
Public Sub Initialize  
'    B4XPages.GetManager.LogEvents = True  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
    B4XImageView1.Load(File.DirAssets, "disco.png")  
    B4XImageView2.Load(File.DirAssets, "background.jpg")  
    playingMusic = False  
    
    
    Button1.Text = "Play " & Chr(0xF04B)  
    Button1.Font = xui.CreateFontAwesome(22)  
    Button1.TextColor = xui.Color_White  
    Button1.SetColorAndBorder(0xFF55230C, 0, 0, 10dip)  
    
    #if b4a  
    mp.Initialize2("mp")  
    mp.Load(File.DirAssets, "audio.mp3")  
    mp.Looping = True  
    #else if b4i  
    mp.Initialize(File.DirAssets, "audio.mp3", "mp")  
    mp.Volume = 1  
    mp.Looping = True  
    #End If  
End Sub  
  
Private Sub Button1_Click  
    play  
End Sub  
  
Sub play  
    If playingMusic Then  
        playingMusic = False  
        Button1.Text = "Play " & Chr(0xF04B)  
        Return  
    End If  
    
    playingMusic = True  
    Button1.Text = "Stop " & Chr(0xF04D)  
    mp.Play  
    
    Do While playingMusic        
        For i = 1 To 90  
            B4XImageView1.mBase.Rotation = (i*4)  
            Sleep(50)  
            If playingMusic = False Then  
                mp.Pause  
                Exit  
            End If  
        Next  
    Loop  
End Sub  
  
Private Sub mp_Complete  
    Log("mp_Complete")  
End Sub  
Private Sub mp_EndInterruption  
    Log("mp_EndInterruption")  
End Sub
```

  
  
  
  
**[SIZE=5]👉 Source for [/SIZE]**[**[SIZE=5]download free[/SIZE]**](https://payhip.com/b/sKyHF)  
**[SIZE=5]because of the audio file, I can't attach the source code here, I published the source code with the audio on the website for free download[/SIZE]**