### To get bitmaps of thumbnails of your videos or images on device with MediaStore by GeoT
### 02/27/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/159542/)

It depends on what MediaStore has indexed  
  
You can further refine the search by modifying the query  
  
You can also check the images by asking "android.provider.MediaStore.Images$Media" and "android.provider.MediaStore.Images.Thumbnails", modifying with "mime\_type LIKE 'image/%'"  
  

```B4X
Sub GetBitmapsOfVideoThumbnails  
  
    Dim MediaStore As JavaObject  
    Dim uri As Object  
    Dim MediaStore_Video_Thumbnails As JavaObject  
  
    MediaStore.InitializeStatic("android.provider.MediaStore.Video$Media")  
    uri = MediaStore.GetField("EXTERNAL_CONTENT_URI")        'content://media/external/images/media for images, content://media/external/video/media fo videos  
    MediaStore_Video_Thumbnails.InitializeStatic("android.provider.MediaStore.Video.Thumbnails")  
  
  
    Dim cr As ContentResolver        'ContentResolver library  
    cr.Initialize("cr")  
  
   
    Dim thumbCursor As Cursor    'SQL lib  
    thumbCursor = cr.Query(uri, Null, "mime_type LIKE 'video/%'", Null, Null)            'LIMIT not work on android 11+  
    Log("thumbCursor.RowCount = " & thumbCursor.RowCount)  
  
  
    If thumbCursor <> Null And thumbCursor.RowCount > 0 Then  
    
        For i = 0 To thumbCursor.RowCount - 1  
            thumbCursor.Position = i  
        
            Private videoId As Long = thumbCursor.GetString("_id")  
            Log(videoId)  
            LogColor(uri & "/" & videoId, Colors.Blue)  
            Log(thumbCursor.GetString("_data"))  
  
  
            'Option with MediaStore.Video.Thumbnails.getThumbnail(…):  
            Dim r As Reflector  
            Dim cres As Object  
            r.Target = r.GetContext  
            cres = r.RunMethod("getContentResolver")  
  
            Private bm As Bitmap = MediaStore_Video_Thumbnails.RunMethod("getThumbnail", Array As Object(cres, videoId, 3, Null))    '3 = MICRO_KIND     1 = MINI_KIND  
            Log(bm.Width & " x " & bm.Height)  
  
  
  
            'Option with ContentResolver.loadThumbnail(…):  
            Dim SizeObj As JavaObject  
            Dim size As JavaObject = SizeObj.InitializeNewInstance("android.util.Size", Array As Object(96, 96))  
            Log(size)  
  
            Dim uri2 As JavaObject  
            Dim u As JavaObject = uri2.InitializeStatic("android.net.Uri").RunMethod("parse", Array As String(uri & "/" & videoId))  
            LogColor(u, Colors.Magenta)  
        
            Dim csign As JavaObject  
            Dim cs As JavaObject = csign.InitializeNewInstance("android.os.CancellationSignal", Null)  
            Log(cs)  
  
            Dim ctxt As JavaObject  
            Dim ContentResolver As JavaObject = ctxt.InitializeContext.RunMethodJO("getContentResolver", Null)    'https://www.b4x.com/android/forum/threads/saveas-let-the-user-select-a-target-folder-list-of-other-related-methods.129897/#content  
  
            Dim Thumbnail As Bitmap  
            Thumbnail = ContentResolver.RunMethod("loadThumbnail", Array(u, size, csign))  
            Log(Thumbnail.Width & " xx " & Thumbnail.Height)  
  
        Next  
    End If  
   
    thumbCursor.Close  
End Sub
```