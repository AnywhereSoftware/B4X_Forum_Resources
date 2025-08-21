### Gif Maker for B4i by ilan
### 06/23/2020
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/119373/)

**il\_GifMaker  
Author:** Ilan Tetruashvili ([EMAIL]info@sagital.net[/EMAIL])  
**Version:** 0.1  
  

- **il\_GifMaker**
Events:

- **Initialize:** ()
*Initializes the object*- **create::** (l As List, FileName As String, Speed As Float)
Create the Gif from a list of images and stores it in File.Dirdocuments
  

```B4X
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
    Public App As Application  
    Public NavControl As NavigationController  
    Private Page1 As Page  
    
    Private myGifmaker As il_GifMaker  
End Sub  
  
Private Sub Application_Start (Nav As NavigationController)  
    'SetDebugAutoFlushLogs(True) 'Uncomment if program crashes before all logs are printed.  
    NavControl = Nav  
    Page1.Initialize("Page1")  
    Page1.Title = "Page 1"  
    Page1.RootPanel.Color = Colors.White  
    NavControl.ShowPage(Page1)  
    
    Dim l As List  
    l.Initialize  
    
    For i = 0 To 3  
        l.Add(LoadBitmap(File.DirAssets,$"f${i}.png"$)) 'add images to list  
    Next  
    
    myGifmaker.Initialize  
    myGifmaker.create(l,"mygif.gif",0.1) 'Gif saved to File.DirDocuments  
    
    Log(File.ListFiles(File.DirDocuments)) 'log all files in File.Dirdocuments  
End Sub
```

  
  
  
  
![](https://www.b4x.com/android/forum/attachments/96084)