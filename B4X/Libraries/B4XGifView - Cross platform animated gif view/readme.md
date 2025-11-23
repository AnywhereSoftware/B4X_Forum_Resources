###  B4XGifView - Cross platform animated gif view by Erel
### 11/19/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/118550/)

![](https://www.b4x.com/android/forum/attachments/95135)  
  
I was missing a cross platform, animated gif view, so created one.  
  
Usage is simple:  
Add with the visual designer and call SetGif to set the gif file.  
  
  
The B4i implementation depends on FLAnimatedImage open source project: <https://github.com/Flipboard/FLAnimatedImage>  
The B4A implementation is based on this open source project: <https://github.com/koral--/android-gif-drawable>  
The two dependent aars are attached. Copy them to B4A additional libraries folder.  
  
Updates:  
  
1.20 - Change dependency declaration to be compatible with B4i v10+  
1.15 - Updated the B4A dependencies to fix a compatibility issue with targetSdkVersion 35.  
1.12 - SetGif2 - Allows loading an animated gif from an array of bytes.  
1.11 - GIF image ratio is preserved.  
1.10 - New B4A implementation based on Android GIF Drawable. It provides better performance. Note that the Activity\_Resume method has been removed. Don't miss the B4A-Dependencies zip file.