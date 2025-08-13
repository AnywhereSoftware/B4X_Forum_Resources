### Before-after image slider library by jkhazraji
### 01/25/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/165259/)

This is a Beta version of before-after image comparison slider written completely in b4a.  
Attached are the .jar and .xml files to be placed in additional libraries folder of b4a.  
No extra jar files needed.  
  
***How to use:***  
1- Place a beforeAfterImgSlider in designer, give a name or leave default  
2- Generate as a member with methods ( 'dragged' and 'ImagesSet' if needed)  
2- Initialize two bitmaps ( before and after ) from two images as:  

```B4X
Dim beforeBmp as Bitmap  
beforeBmp.Initialize(File.DirAssets, "beforeImg.jpg")  
Dim afterBmp as Bitmap  
afterBmp.Initialize(File.DirAssets, "afterImg.jpg")
```

  
2- set Images:  
beforeAfterImgSlider1.setImages(beforeBmp, afterBmp)  
3- run  
  
***Methods , properties and events:***  
Methods:  
**-Initialize:** no parameters  
**-SetImages:** 2 parameters (beforeBMP , afterBMP)  
Properties:  
**-ShowThumb:** whether to show the thumb to drag the line between the two images (can be set in designer or at runtime).  
**-ThumbColor:** the color of the thumb (can be set in designer or at runtime).  
Events:  
***BeforeAfterImgSlider\_Dragged (clipPosition as int)***: show how much of the before image is shown.  
***BeforeAfterImgSlider\_ImagesSet***: just to check if the two images are loaded (True or False).  
  
![](https://www.b4x.com/android/forum/attachments/161127)  
Here is a [Demo](https://youtube.com/shorts/B6ybGUsxs2g):  
A demo example is attached.  
A watermark (JK) is overlying the customview at time being.  
Source code will be gladly presented on [donation](https://www.paypal.com/ncp/payment/XLNESHQTU5R3U) of $30. It took a lot of time to develop.  
  
Edit: Example added.