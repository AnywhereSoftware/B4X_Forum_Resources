### Subsampling Scale Image View Library by Pendrush
### 04/04/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/115852/)

Original library link: <https://github.com/davemorrissey/subsampling-scale-image-view>  
Original description:  
A custom image view for Android, designed for photo galleries and displaying huge images (e.g. maps and building plans) without OutOfMemoryErrors. Includes pinch to zoom, panning, rotation and animation support, and allows easy extension so you can add your own overlays and touch event detection.  
The view optionally uses subsampling and tiles to support very large images - a low resolution base layer is loaded and as you zoom in, it is overlaid with smaller high resolution tiles for the visible area. This avoids holding too much data in memory. It's ideal for displaying large images while allowing you to zoom in to the high resolution details. You can disable tiling for smaller images and when displaying a bitmap object. There are some advantages and disadvantages to disabling tiling so to decide which is best, see the wiki.  
  
![](https://raw.githubusercontent.com/davemorrissey/subsampling-scale-image-view/master/docs/images/demo.gif)  
  
Example project: <https://www.dropbox.com/s/jyri8y18g0hwgjt/SubsamplingScaleImageViewExample.zip?dl=0>  
  
I haven't searched the forum before wrapping, completed version:  
<https://www.b4x.com/android/forum/threads/scaleimageview-pan-and-zoom-large-images.102190/#content>