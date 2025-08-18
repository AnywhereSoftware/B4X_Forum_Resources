###  BitmapCreator Effects by Erel
### 04/29/2021
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/93608/)

BitmapCreatorEffects class includes all kinds of very simple to use image effects.  
The class is cross platform and compatible with B4J (v6.3+), B4A (v8.3+) and B4i (v5.0+).  
Example:  

```B4X
'Greyscale an image:  
Dim GreyImage As B4XBitmap = effects.GreyScale(ExistingBmp)  
'Blur an image:  
Dim BlurImage As B4XBitmap = effects.Blur(ExistingBmp)
```

  
  
[MEDIA=vimeo]272558725[/MEDIA]  
  
The attached examples demonstrate the various methods.  
  
  
**Updates**  
  
v1.40 - Adds support for B4XImageViews (XUI Views).  
- New ScaleDownImages flag. True by default. The updated example demonstrates the usage. Note that if not using B4XImageView then you should set the image when ScaleDown = False, with XUIViewsUtils.SetBitmapAndFill.  
v1.31 -New FadeBorders effect. See post #9: <https://www.b4x.com/android/forum/threads/b4x-bitmapcreator-effects.93608/#post-672188>  
v1.21 - New ReplaceColor method.  
v1.20 - Added PieceSize to ImplodeAnimated and added FlipVertical and FlipHorizontal methods.  
v1.10 - Adds TransitionAnimated method to transition between two bitmaps.