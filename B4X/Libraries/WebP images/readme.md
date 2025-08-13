###  WebP images by Erel
### 02/12/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/119990/)

Cross platform library that loads the new WebP format images.  
  
Android natively supports this format so the regular LoadBitmap methods will also work.  
  
**B4i** - If you are using a local builder then download the frameworks and add them to the builder: <https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-1.1.0-ios-framework.tar.gz>  
Implementation is based on [USER=112919]@Brandsum[/USER] code: <https://www.b4x.com/android/forum/threads/who-can-help-me-to-create-b4i-library.110896/#post-694480>  
  
**B4J** - Based on: <https://github.com/zakgof/webp4j> (Apache 2.0 license)  
Download the additional jars.  
Note that it is a Windows only library.  
It will show a warning message in the logs when the first image is loaded. Ignore it.  
(SLF4J: Failed to load class "org.slf4j.impl.StaticLoggerBinder")  
If you are using the built-in packager then add this line:  

```B4X
#CustomBuildAction: After Packager, %WINDIR%\System32\robocopy.exe, ..\Objects\b4xlibs\Files temp\build\bin\ webp.dll
```

  
  
Usage instructions:  
  

```B4X
Dim WebP1 As WebP  
WebP1.Initialize  
ImageView1.SetBitmap(WebP1.LoadWebP(File.ReadBytes(File.DirAssets, "1.webp")))
```

  
  
Updates:  
1.01 - Fixes an issue with B4J and the standalone packager.