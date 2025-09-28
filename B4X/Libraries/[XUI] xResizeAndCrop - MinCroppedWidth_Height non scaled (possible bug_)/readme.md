###  [XUI] xResizeAndCrop - MinCroppedWidth/Height non scaled (possible bug?) by GianniGntl
### 09/26/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/168802/)

Good morning,  
  
[USER=904]@klaus[/USER], congratulations on this control. I'm considering using it in a small project.  
  
I noticed a small problem: setting the MinCroppedWidth property (and implicitly MinCroppedHeight based on the set ratio) doesn't consider the pixels of the original image, but those of the screen.  
  
As a workaround, if I need a minimum resolution, I set the value by dividing it by PixelScale (computed in DrawImage), so the minimum cropping has the correct dimensions.  
  
N.B.: Since PixelScale is private, there's no getter; I access the value using Reflection.  
  
Cheers.