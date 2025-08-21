### GifView (FLAnimatedImage) by Semen Matusovskiy
### 02/22/2020
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/114173/)

Based on <https://github.com/Flipboard/FLAnimatedImage>  
Not so powerful as Lottie, but more simple.  
  
Installation: Library.zip.  
Source code (for whom is interesting) - XCode.zip.  
  
How to use …  
Declare an object **Private gif As GifView** and intialize it, for example, **gif.Initialize (File.DirAssets, "MyGif.Gif", Page1.RootPanel, 100, 100, 500, 300, True)**  
If you want to replace a picture, initialize again with another parameters. If you want to free resources only, use **Release** method.  
  
Simple Demo –  
  
[MEDIA=googledrive]1a48ofNoPGl\_FtUgm4ZEMiziSOS6mSVTw[/MEDIA]  
To change a picture, rotate a phone.