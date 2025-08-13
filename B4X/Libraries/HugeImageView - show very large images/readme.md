###  HugeImageView - show very large images by Erel
### 03/12/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/132905/)

Q: I want to load a 10,000 x 10,000 image?  
A: That's impossible!!! The memory required is: width \* height \* 4 = 400MB.  
A: You will need to scale down the image.  
A: Sure. Use HugeImageView:  
  
[MEDIA=vimeo]579719086[/MEDIA]  
  
(image source: <https://images4.alphacoders.com/655/655004.jpg>)  
  
How does it work?  
  
It uses two layers - one with a scaled down image and another made of tiles. The visible tiles are loaded in the background using a native API that allows loading specific regions (BitmapRegionDecoder).  
  
I've tested it with a 40,000x20,000 image and it worked (such image requires 3GB of RAM to fully load it).  
  
  
Updates:  
- v1.04 - Fixes an issue with Android 15.  
- v1.03 - Adds support for B4J.  
- v1.02 - Fixes an issue related to image vs. device orientation (<https://www.b4x.com/android/forum/threads/hugeimageview-tile-not-showing-at-bottom.134387/>).  
- v1.01 - Adds support for B4i.