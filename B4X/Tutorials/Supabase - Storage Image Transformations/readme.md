###  Supabase - Storage Image Transformations by Alexander Stolte
### 09/13/2023
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/151321/)

<https://www.b4x.com/android/forum/threads/b4x-supabase-the-open-source-firebase-alternative.149855/>  
  
Supabase Storage offers the functionality to transform and resize images dynamically. Any image stored in your buckets can be transformed and optimized for fast delivery.  
![](https://www.b4x.com/android/forum/attachments/145812)  
<https://supabase.com/docs/guides/storage/image-transformations>  
  
**Download**  
Every Transform parameter is optional  

```B4X
    Dim DownloadFile As Supabase_StorageFile = xSupabase.Storage.DownloadFile("Avatar","test.png")  
    DownloadFile.DownloadOptions_TransformQuality(30)  
    DownloadFile.DownloadOptions_TransformFormat("origin")  
    DownloadFile.DownloadOptions_TransformResize("cover")  
    DownloadFile.DownloadOptions_TransformHeight(100)  
    DownloadFile.DownloadOptions_TransformWidth(100)  
    Wait For (DownloadFile.Execute) Complete (StorageFile As SupabaseStorageFile)  
    If StorageFile.Error.Success Then  
        Log($"File ${"test.jpg"} successfully downloaded "$)  
        ImageView1.SetBitmap(xSupabase.Storage.BytesToImage(StorageFile.FileBody))  
    Else  
        Log("Error: " & StorageFile.Error.ErrorMessage)  
    End If
```

  
  
**Modes**  
You can use different resizing modes to fit your needs, each of them uses a different approach to resize the image:  
  
Use the resize parameter with one of the following values:  

- cover : resizes the image while keeping the aspect ratio to fill a given size and crops projecting parts. (default)
- contain : resizes the image while keeping the aspect ratio to fit a given size.
- fill : resizes the image without keeping the aspect ratio.

Example:  

```B4X
    Dim DownloadFile As Supabase_StorageFile = xSupabase.Storage.DownloadFile("Avatar","test.png")  
    DownloadFile.DownloadOptions_TransformResize("cover")  
    Wait For (DownloadFile.Execute) Complete (StorageFile As SupabaseStorageFile)
```

  
  
**Limits**  

- Width and height must be an integer value between 1-2500.
- The image size cannot exceed 25MB.
- The image resolution cannot exceed 50MP.

**Supported Image Formats**  
[TABLE]  
[TR]  
[TH]Format[/TH]  
[TH]Extension[/TH]  
[TH]Source[/TH]  
[TH]Result[/TH]  
[/TR]  
[TR]  
[TD]PNG[/TD]  
[TD]png[/TD]  
[TD]☑️[/TD]  
[TD]☑️[/TD]  
[/TR]  
[TR]  
[TD]JPEG[/TD]  
[TD]jpg[/TD]  
[TD]☑️[/TD]  
[TD]☑️[/TD]  
[/TR]  
[TR]  
[TD]WebP[/TD]  
[TD]webp[/TD]  
[TD]☑️[/TD]  
[TD]☑️[/TD]  
[/TR]  
[TR]  
[TD]AVIF[/TD]  
[TD]avif[/TD]  
[TD]☑️[/TD]  
[TD]☑️[/TD]  
[/TR]  
[TR]  
[TD]GIF[/TD]  
[TD]gif[/TD]  
[TD]☑️[/TD]  
[TD]☑️[/TD]  
[/TR]  
[TR]  
[TD]ICO[/TD]  
[TD]ico[/TD]  
[TD]☑️[/TD]  
[TD]☑️[/TD]  
[/TR]  
[TR]  
[TD]SVG[/TD]  
[TD]svg[/TD]  
[TD]☑️[/TD]  
[TD]☑️[/TD]  
[/TR]  
[TR]  
[TD]HEIC[/TD]  
[TD]heic[/TD]  
[TD]☑️[/TD]  
[TD]❌[/TD]  
[/TR]  
[TR]  
[TD]BMP[/TD]  
[TD]bmp[/TD]  
[TD]☑️[/TD]  
[TD]☑️[/TD]  
[/TR]  
[TR]  
[TD]TIFF[/TD]  
[TD]tiff[/TD]  
[TD]☑️[/TD]  
[TD]☑️[/TD]  
[/TR]  
[/TABLE]  
  
[MEDIA=youtube]dLqSmxX3r7I[/MEDIA]