###  APNG - animated PNG by Erel
### 12/24/2023
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/121311/)

![](https://apng.onevcat.com/assets/elephant.png)  
(image source: <https://apng.onevcat.com/demo/>)  
  
APNG is a format that extends PNG with support for animations, similar to animated gifs.  
This class, which is implemented in B4X, extracts the frames from the APNG file and creates the animation.  
  
It doesn't support all possible formats. If you encounter a file that is not supported then post it  
  
Under the hood it uses RandomAccessFile + BytesBuilder + BitmapCreator + native CRC32 implementation to extract the frames, build temporary images that are loaded as regular bitmaps and then animate them.  
  
Tip: You can use this tool to create APNG images: <http://apngasm.sourceforge.net/>  
  
Versions history  
  
- V1.10 - Adds support for images with inter-frame optimizations: <http://littlesvr.ca/apng/inter-frame.html>