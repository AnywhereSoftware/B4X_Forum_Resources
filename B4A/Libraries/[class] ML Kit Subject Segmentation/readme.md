### [class] ML Kit Subject Segmentation by Erel
### 04/30/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/160814/)

![](https://www.b4x.com/android/forum/attachments/153169)  
  
<https://developers.google.com/ml-kit/vision/subject-segmentation>  
  
Input: image  
Output: image with main subject  
  
See attached project.  
Don't miss the #AdditionalJars in the main module and the manifest editor snippets.  
  
Usage:  

```B4X
Private Sub Button1_Click  
    Dim cc As ContentChooser  
    cc.Initialize("cc")  
    cc.Show("image/*", "choose image")  
    Wait For cc_Result (Success As Boolean, Dir As String, FileName As String)  
    If Success Then  
        'I'm resizing the image here. It might be better to leave the image with the original resolution.  
        Dim bmp As B4XBitmap = xui.LoadBitmapResize(Dir, FileName, B4XImageView1.mBase.Width, B4XImageView1.mBase.Height, True)  
        B4XImageView1.Bitmap = bmp  
        B4XImageView2.Clear  
        Wait For (segmenter.Process(bmp)) Complete (Result As SegmentationResult)  
        If Result.Success Then  
            B4XImageView2.Bitmap = Result.ForegroundBitmap  
        End If  
    End If  
End Sub
```

  
  
B4A Sdk Manager: search for mlkit and install all items. Search for odml and install as well. Don't install anything else.