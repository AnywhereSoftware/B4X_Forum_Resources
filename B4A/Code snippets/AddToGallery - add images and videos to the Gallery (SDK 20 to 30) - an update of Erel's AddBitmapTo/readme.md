### AddToGallery - add images and videos to the Gallery (SDK 20 to 30) - an update of Erel's AddBitmapToGallery by JackKirk
### 06/06/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/131374/)

In this code snippet:  
  
<https://www.b4x.com/android/forum/threads/add-image-to-gallery-android-5-10.121992/>  
  
Erel shows how to add an image to an Android gallery for all SDKs 20? to 30.  
  
Only shortcomings are that it is image/jpeg specific (i.e. doesn't handle video/mp4) at SDK >= 29 and it doesn't handle user specified album names - both being functionality I need.  
  
After a lot of mucking around and googling I have managed to upgrade it to do these:  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: B4A Example  
    #VersionCode: 1  
    #VersionName:  
    'SupportedOrientations possible values: unspecified, landscape or portrait.  
    #SupportedOrientations: unspecified  
    #CanInstallToExternalStorage: False  
#End Region  
  
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: True  
#End Region  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
'    Private xui As XUI  
End Sub  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
  
    AddToGallery(File.OpenInput(File.DirAssets, "junk.jpg"), "XYZalbum", "junk.jpg", "image/jpeg")  
    Wait For AddToGallery_Complete_jpeg  
    AddToGallery(File.OpenInput(File.DirAssets, "junk.mp4"), "XYZalbum", "junk.mp4", "video/mp4")  
    Wait For AddToGallery_Complete_mp4  
End Sub  
  
Sub AddToGallery (In As InputStream, AlbumName As String, TargetName As String, MimeType As String)  
    Dim p As Phone  
    Log(p.SdkVersion)  
    Dim ctxt As JavaObject  
    ctxt.InitializeContext  
    If p.SdkVersion >= 29 Then  
        Dim cr As ContentResolver  
        cr.Initialize("cr")  
        Dim values As ContentValues  
        values.Initialize  
        values.PutString("relative_path", "Pictures/" & AlbumName)  
        values.PutString("_display_name", TargetName)  
        values.PutString("mime_type", MimeType)  
        Dim MediaStore As JavaObject  
        If MimeType = "image/jpeg" Then  
            MediaStore.InitializeStatic("android.provider.MediaStore.Images$Media")  
        Else  
            MediaStore.InitializeStatic("android.provider.MediaStore.Video$Media")  
        End If  
        Dim EXTERNAL_CONTENT_URI As Uri = MediaStore.GetField("EXTERNAL_CONTENT_URI")  
        cr.Delete(EXTERNAL_CONTENT_URI, "_display_name = ?", Array As String(TargetName))  
        Dim imageuri As JavaObject = cr.Insert(EXTERNAL_CONTENT_URI, values)  
        Dim out As OutputStream = ctxt.RunMethodJO("getContentResolver", Null).RunMethod("openOutputStream", Array(imageuri))  
        File.Copy2(In, out)  
        out.Close  
        Log("finito SDK >=29")  
    Else  
        Dim rp As RuntimePermissions  
        rp.CheckAndRequest(rp.PERMISSION_WRITE_EXTERNAL_STORAGE)  
        Wait For Activity_PermissionResult (Permission As String, Result As Boolean) 'change to Activity if not using B4XPages  
        If Result Then  
            File.MakeDir(File.DirRootExternal, AlbumName)  
            Dim out As OutputStream = File.OpenOutput(File.DirRootExternal, AlbumName & "/" & TargetName, False)  
            File.Copy2(In, out)  
            out.Close  
            Dim FilePath As String = File.Combine(File.DirRootExternal, AlbumName & "/" & TargetName)  
            Dim MediaScannerConnection As JavaObject  
            MediaScannerConnection.InitializeStatic("android.media.MediaScannerConnection")  
            Dim interface As Object = MediaScannerConnection.CreateEventFromUI("android.media.MediaScannerConnection.OnScanCompletedListener", "ScanCompleted", _  
                   Null)  
            MediaScannerConnection.RunMethod("scanFile", Array(ctxt, Array As String(FilePath), Array As String(MimeType), interface))  
            Wait For ScanCompleted_Event (MethodName As String, Args() As Object)  
            Log(Args(0))  
            Log(Args(1))  
            Log("finito SDK < 29")  
        End If  
    End If  
    If MimeType = "image/jpeg" Then  
        CallSubDelayed(Me, "AddToGallery_Complete_jpeg")  
    Else  
        CallSubDelayed(Me, "AddToGallery_Complete_mp4")  
    End If  
End Sub
```

  
  
Attached is the project as a zip - because of the size limitations imposed on uploaded zips you need to add a video called junk.mp4 to the Files folder and Add it in the Files tab.  
  
I have tested it on a Samsung S5 (SDK 23) and a Pixel 3 (SDK 30)  
  
**I would really appreciate it if forum members with devices other than SDK 23 or 30 would test it and report back - thanks in anticipation.**  
  
Happy coding…