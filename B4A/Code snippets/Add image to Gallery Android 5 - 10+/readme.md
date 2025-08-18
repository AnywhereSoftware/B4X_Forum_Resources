### Add image to Gallery Android 5 - 10+ by Erel
### 09/06/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/121992/)

Depends on: Phone, JavaObject and ContentResolver libraries  
  

```B4X
Sub AddBitmapToGallery (In As InputStream, TargetName As String, MimeType As String)  
    Dim p As Phone  
    Dim ctxt As JavaObject  
    ctxt.InitializeContext  
    If p.SdkVersion >= 29 Then  
        Dim cr As ContentResolver  
        cr.Initialize("cr")  
        Dim values As ContentValues  
        values.Initialize  
        values.PutString("_display_name", TargetName)  
        values.PutString("mime_type", MimeType)  
        Dim MediaStoreImagesMedia As JavaObject  
        MediaStoreImagesMedia.InitializeStatic("android.provider.MediaStore.Images$Media")  
        Dim EXTERNAL_CONTENT_URI As Uri = MediaStoreImagesMedia.GetField("EXTERNAL_CONTENT_URI")  
        cr.Delete(EXTERNAL_CONTENT_URI, "_display_name = ?", Array As String(TargetName))  
        Dim imageuri As JavaObject = cr.Insert(EXTERNAL_CONTENT_URI, values)  
        Dim out As OutputStream = ctxt.RunMethodJO("getContentResolver", Null).RunMethod("openOutputStream", Array(imageuri))  
        File.Copy2(In, out)  
        out.Close  
    Else  
        Dim rp As RuntimePermissions  
        rp.CheckAndRequest(rp.PERMISSION_WRITE_EXTERNAL_STORAGE)  
        Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean) 'change to Activity if not using B4XPages  
        If Result Then  
            Dim out As OutputStream = File.OpenOutput(File.DirRootExternal, "Pictures/" & TargetName, False)  
            File.Copy2(In, out)  
            out.Close  
            Dim FilePath As String = File.Combine(File.DirRootExternal, "Pictures/" & TargetName)  
            Dim MediaScannerConnection As JavaObject  
            MediaScannerConnection.InitializeStatic("android.media.MediaScannerConnection")  
            Dim interface As Object = MediaScannerConnection.CreateEventFromUI("android.media.MediaScannerConnection.OnScanCompletedListener", "ScanCompleted", _  
                   Null)  
            MediaScannerConnection.RunMethod("scanFile", Array(ctxt, Array As String(FilePath), Array As String(MimeType), interface))  
            Wait For ScanCompleted_Event (MethodName As String, Args() As Object)  
            Log(Args(0))  
            Log(Args(1))  
        End If  
    End If  
End Sub
```

  
  
Usage example:  

```B4X
AddBitmapToGallery(File.OpenInput(File.DirAssets, "logo.png"), "logo.png", "image/png")
```

  
  
No permission is required in Android 10+.