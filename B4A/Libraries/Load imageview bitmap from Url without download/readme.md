### Load imageview bitmap from Url without download by jkhazraji
### 02/13/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/165600/)

Direct display of any image from its url in an imageview:  
  
Methods:  
***imageLoadFromUrl:*** *bring the bitmap from url  
**urlSetBitmap:**  load the image in an image view with the same original aspect ratio.*  
Attachments: library   
and here is an example:  

```B4X
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
    Private xui As XUI  
End Sub  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    Dim iv As ImageView  
    Dim imgload As imageLoadFromUrl  
    Dim urlInput As EditText  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("Layout")  
    urlInput.Initialize("urlInput")  
    Activity.AddView(urlInput,0,0,100%x, 40dip)  
      
    iv.Initialize("iv")  
    iv.Gravity=Gravity.fill  
    Activity.AddView(iv, 0, 10%x, -1, 75%y)  
      
      
    imgload.Initialize  
      
End Sub  
Private Sub urlInput_EnterPressed  
    Dim bm As Bitmap=imgload.imageLoadFromUrl(urlInput.Text)  
    imgload.urlSetBitmap(iv, bm)  
  
End Sub
```