### MediaChooser - Only Capture Photo by asales
### 05/18/2025
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/167048/)

The [example from Erel](https://www.b4x.com/android/forum/threads/b4x-mediachooser-cross-platform-videos-and-images-chooser.161093/) is complete, but I need only to capture a photo and show it in a imageview (or b4ximageview). No Exoplayer, SMM, etc.   
This is the code.  
- libs: MediaChooser, FileProvider  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
      
    Private mc As MediaChooser  
    Private ImageView1 As ImageView  
End Sub  
  
Public Sub Initialize  
    B4XPages.GetManager.LogEvents = True  
End Sub  
  
'This event will be called once, before the page becomes visible.  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
      
    mc.Initialize(Me, "mc")  
End Sub  
  
'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.  
  
Private Sub Button1_Click  
    Wait For (mc.CaptureImage) Complete (Result As MediaChooserResult)  
    ShowMedia(Result)  
End Sub  
  
Private Sub mc_Error (Key As String, Message As String)  
    Log("error: " & Message)  
End Sub  
  
Private Sub ShowMedia (Result As MediaChooserResult)  
    If Result.Success Then  
        ImageView1.Bitmap = xui.LoadBitmap(Result.MediaDir, Result.MediaFile)  
    End If  
End Sub
```