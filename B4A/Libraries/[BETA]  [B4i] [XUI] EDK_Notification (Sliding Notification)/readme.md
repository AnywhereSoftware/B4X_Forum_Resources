### [BETA]  [B4i] [XUI] EDK_Notification (Sliding Notification) by Ertan
### 04/08/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/130743/)

Hello, this is a library that is still in beta.  
  
I have no expectations. (Except for ![](https://www.b4x.com/android/forum/attachments/113406) :) ) If you want, you can take the codes with winrar and open B4Xlib codes, edit and duplicate them. Because sharing is good.  
  
Report bugs and requests to us in response.  
  
**Please let me know if any errors occur. I am here to help you.  
  
EDK\_Notification  
  
Authors : [USER=118387]@Ertan[/USER]   
Versions :** 1.1  
  
V1.0 = Release.  
V1.1 = Bug Fix.  
  
View;  
![](https://www.b4x.com/android/forum/attachments/113397)![](https://www.b4x.com/android/forum/attachments/113395)  
  
Add at the bottom of the design.  
  
Horizontal Anchor = Right and Left  
Vertical Anchor = Down  
  
set to.  
  
![](https://www.b4x.com/android/forum/attachments/113399)  
  
Notification\_Start(AnimationTime As Int,Text As String)  

```B4X
EDK_Notification1.Notification_Start(500,"Loading…")
```

  
  
Notification\_Finish(Time As Int,AnimationTime As Int,Text As String)  

```B4X
EDK_Notification1.Notification_Finish(1000,500,"Finish…")
```

  
  
  
Example;  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Private EDK_Notification1 As EDK_Notification  
End Sub  
  
Public Sub Initialize  
  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
    Sleep(500) 'optionally The page was put as it started as soon as it opened.  
    EDK_Notification1.Notification_Start(500,"Loading…")  
    Sleep(750)  
    EDK_Notification1.Notification_Finish(1000,500,"Finish…")  
End Sub
```

  
  
**C****olo****r** choices will be added upon request.