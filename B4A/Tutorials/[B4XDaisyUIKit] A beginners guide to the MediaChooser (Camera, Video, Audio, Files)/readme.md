### [B4XDaisyUIKit] A beginners guide to the MediaChooser (Camera, Video, Audio, Files) by Mashiane
### 07/31/2026
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/171694/)

Hi Fam!  
  
So I tried the MediaChooser component developed by Erel on the B4XDaisyUIKit. The Kit demo now includes an example just to 1. Take Photo, 2. Record Video, 3, Record Audio.  
  
The usual script…  
  
Are you looking to add photo and video capture capabilities to your apps but feeling overwhelmed by intents, permissions, and temporary file management? Look no further!   
  
The **MediaChooser** component created by Erel is your one-stop solution for cross-platform media handling across B4A, B4i, and B4J.  
  
MediaChooser abstracts all the complex lifecycle management and file handling, allowing you to focus on what matters most—your app's core features. It natively supports capturing images, recording videos, and browsing for existing files using just a few lines of code. It even automatically handles cleaning up temporary files upon initialization!  
To help new developers get up and running instantly, I’ve put together a beginner-friendly guide on how to initialize this component, trigger a camera capture, and trap its built-in events.  
  
![](https://www.b4x.com/android/forum/attachments/172696) ![](https://www.b4x.com/android/forum/attachments/172697) ![](https://www.b4x.com/android/forum/attachments/172698)  
  
  
  
🛠️ Simple Usage Example  
Here is a clean, straightforward implementation snippet demonstrating how to capture an image and handle the Progress and Error events:  
  

```B4X
#Region Variables  
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    ' 1. Declare the MediaChooser component  
    Private chooser As MediaChooser   
    Private imgPreview As B4XView ' Assuming you have an ImageView in your layout  
End Sub  
#End Region  
  
#Region Initialization  
Private Sub B4XPage_Created(Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage") ' Load your layout  
      
    ' 2. Initialize the MediaChooser with the callback object (Me) and the Event Name ("Chooser")  
    chooser.Initialize(Me, "Chooser")  
End Sub  
#End Region  
  
#Region Button Action Handlers  
' 3. Trigger this sub when your user clicks a "Take Photo" button  
Private Sub btnCamera_Click(Tag As Object)  
    ' Always check and request permissions first!  
    Dim rp As RuntimePermissions  
    rp.CheckAndRequest(rp.PERMISSION_CAMERA)  
    Wait For B4XPage_PermissionResult (Permission As String, Done As Boolean)  
      
    If Done Then  
        ' 4. Call the CaptureImage method and wait for the result  
        Wait For (chooser.CaptureImage) Complete (Result As MediaChooserResult)  
          
        ' 5. Process the Result  
        If Result.Success Then  
            If File.Exists(Result.MediaDir, Result.MediaFile) Then  
                ' Load the image into your B4XView  
                Dim bmp As B4XBitmap = LoadBitmapSample(Result.MediaDir, Result.MediaFile, 1920, 1920)  
                imgPreview.SetBitmap(bmp)  
            End If  
            B4XPages.MainPage.ShowToastSuccess("Photo captured successfully!", False)  
        Else  
            B4XPages.MainPage.ShowToastError("Photo capture cancelled or failed", False)  
        End If  
    Else  
        B4XPages.MainPage.ShowToastError("Camera permission denied", False)  
    End If  
End Sub  
#End Region  
  
#Region MediaChooser Events  
' 6. Trap component events for progress updates (useful for large files/video)  
Private Sub Chooser_Progress (Value As Int)  
    ' This fires during file operations, handle progress UI here  
    Log("Processing Media: " & Value & "%")  
End Sub  
  
' 7. Trap error events thrown by the component  
Private Sub Chooser_Error (Key As String, Message As String)  
    ' Display the error securely to the user  
    B4XPages.MainPage.ShowToastError(Message, False)  
End Sub  
#End Region
```

  
  
**Key Takeaways:**  

- **MediaChooserResult:** This custom type returns Success, the MediaDir (directory), the MediaFile (filename), and the Mime type (like "image/jpeg" or "video/\*") seamlessly.
- **Permissions:** Always use RuntimePermissions before attempting to access the camera.
- **Background Services:** For Android (B4A), MediaChooser inherently relies on a KeepRunningService to ensure your app doesn't get aggressively killed in the background while the native camera app is open.

Try this out in your next project, and watch how quickly you can integrate rich media features into your applications! Happy coding! 🚀  
  
#SharingTheGoodness  
  
[MEDIA=youtube]TZ0bYbzHob4[/MEDIA]  
  
  
  
PS: Check the B4XDaisyUIKit 0.85+ Demo