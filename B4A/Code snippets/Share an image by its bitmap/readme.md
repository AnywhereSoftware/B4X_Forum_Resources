### Share an image by its bitmap by jkhazraji
### 09/29/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/168856/)

This can be modified to any file type by changing the MIME type and using the file path as the Sub argument  

```B4X
Sub ShareImage(bmp As Bitmap)  
    ' Save image   
    Dim filename As String = "image.jpg"  
    Dim outDir As String = File.DirInternal  
    File.Delete(outDir, filename)  
    Dim out As OutputStream = File.OpenOutput(outDir, filename, False)  
    bmp.WriteToStream(out, 100, "JPEG")  
    out.Close  
  
    Dim ctxt As JavaObject  
    ctxt.InitializeContext  
    Dim fileObj As JavaObject  
    fileObj.InitializeNewInstance("java.io.File", Array(outDir, filename))  
    Dim provider As String = Application.PackageName & ".provider"  
    Dim FileProvider As JavaObject  
    FileProvider.InitializeStatic("androidx.core.content.FileProvider")  
    Dim uri As Object = FileProvider.RunMethod("getUriForFile", Array(ctxt, provider, fileObj))  
      
    Dim i As Intent  
    i.Initialize(i.ACTION_SEND, "")  
    i.SetType("image/*")  
    i.PutExtra("android.intent.extra.STREAM", uri)  
    i.Flags = Bit.Or(i.Flags, 1) ' FLAG_GRANT_READ_URI_PERMISSION  
  
    'chooser  
    Dim jo As JavaObject = i  
    Dim chooser As Intent = jo.InitializeStatic("android.content.Intent") _  
        .RunMethod("createChooser", Array(i, "Share Image via…"))  
  
    StartActivity(chooser)  
End Sub
```

  
  

```B4X
AddManifestText(<uses-permission  
   android:name="android.permission.WRITE_EXTERNAL_STORAGE"  
   android:maxSdkVersion="18" />  
)  
  
AddApplicationText(  
  <provider  
  android:name="android.support.v4.content.FileProvider"  
  android:authorities="$PACKAGE$.provider"  
  android:exported="false"  
  android:grantUriPermissions="true">  
  <meta-data  
  android:name="android.support.FILE_PROVIDER_PATHS"  
  android:resource="@xml/provider_paths"/>  
  </provider>  
)  
CreateResource(xml, provider_paths,  
   <files-path name="internal_files" path="." />  
)
```