### jWebP WebP Images by Erel
### 07/09/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/118188/)

**Cross platform version of this library: <https://www.b4x.com/android/forum/threads/b4x-webp-images.119990/>**  
  
This library is based on: <https://github.com/zakgof/webp4j> (Apache 2.0 license)  
It allows loading WebP images.  
It is a Windows only library.  
  
Usage example:  

```B4X
#CustomBuildAction: After Packager, %WINDIR%\System32\robocopy.exe, ..\Objects\b4xlibs\Files temp\build\bin\ webp.dll  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private ImageView1 As ImageView  
    Private wp As WebP  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("1") 'Load the layout file.  
    MainForm.Show  
    wp.Initialize  
    ImageView1.SetImage(wp.Decode(File.ReadBytes(File.DirAssets, "1.webp")))  
End Sub
```

  
  
The CustomBuildAction is required for the new integrated packager.  
  
Download link: [www.b4x.com/b4j/files/jWebP.zip](https://www.b4x.com/b4j/files/jWebP.zip)