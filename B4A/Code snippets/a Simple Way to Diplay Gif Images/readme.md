### a Simple Way to Diplay Gif Images by khwarizmi
### 09/01/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/133924/)

The basic idea is derived from [Erel code to display an image from dirassets in HTML code](https://www.b4x.com/android/forum/threads/using-webview-files-in-the-assets-directory.69996/post-444559), this image can be a gif image and then displayed by the webview.  
  

```B4X
Sub DisplayGif(FileName As String,lf As Int,tp As Int)  
    Dim img As Bitmap  
    img.Initialize(File.DirAssets,FileName)  
    Dim w,h As Int  
    w=img.Width : h=img.Height  
    Dim wb As WebView  
    wb.Initialize("")  
    Activity.AddView(wb,lf,tp,w,h)  
    Dim imgasset As String  
    Dim jo As JavaObject  
    jo.InitializeStatic("anywheresoftware.b4a.objects.streams.File")  
    If jo.GetField("virtualAssetsFolder") = Null Then  
        imgasset= "file:///android_asset/" & FileName.ToLowerCase  
    Else  
        imgasset= "file://" & File.Combine(jo.GetField("virtualAssetsFolder"), _  
       jo.RunMethod("getUnpackedVirtualAssetFile", Array As Object(FileName)))  
    End If  
    wb.LoadHtml("<html><body background='" & imgasset & "'></body></html>")  
End Sub
```