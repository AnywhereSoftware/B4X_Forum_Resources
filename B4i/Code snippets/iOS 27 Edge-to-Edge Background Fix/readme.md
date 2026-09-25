### iOS 27 Edge-to-Edge Background Fix by Segga
### 09/22/2026
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/172122/)

Just a heads-up for anyone running edge-to-edge in B4i.  
  
On iOS 27, when the app is sent to the background, the status bar becomes visible again, which can mess up the UI and functionality, especially if you have controls near the bottom of the screen.  
An easy fix is to update the Application\_Background sub in the Main module using Erel's [Full Screen apps](https://www.b4x.com/android/forum/threads/full-screen-apps.47866/#content) code snippet as follows:  
  

```B4X
Private Sub Application_Background  
    Dim no As NativeObject = App  
    no.RunMethod("setStatusBarHidden:animated:", Array(True, False))  
    B4XPages.Delegate.Activity_Pause  
End Sub
```