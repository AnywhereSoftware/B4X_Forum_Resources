### BANanoCSSUtils - Utility Helpers & Animations on any BANanoElement by Mashiane
### 08/24/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/149805/)

Hi there  
  
[Demo on Vercel](https://ba-nano-css-utils.vercel.app/)  
  
This b4xlib does similar functions as the CSSUtils in terms of enabling one to change BANanoElement styling. Added to that we have added some animation classes so that you can animate your BANano WebApps without any extra dependencies except anime.js.  
  
For a demo about the animation visit.  
  
<https://www.b4x.com/android/forum/threads/banano-setlayoutanimated-other-animations.149793/#post-949335>  
  
Play around.  
  

```B4X
SetBorder(mElement As BANanoElement, width As String, color As String, radius As String)  
SetRotate(mElement As BANanoElement, deg As String)  
SetColorAndBorder (mElement As BANanoElement, BackGroundColor As String, BorderWidth As String, BorderColor As String, BorderCornerRadius As String)  
SetLayout(mElement As BANanoElement, left As String, top As String, width As String, height As String)  
SetLayoutRadius(mElement As BANanoElement, left As String, top As String, width As String, height As String, radius As String)  
SetRadius(mElement As BANanoElement, radius As String)  
SetScale(mElement As BANanoElement, scale As Double)  
SetTextSize(mElement As BANanoElement, size As String)  
SetVisible(mElement As BANanoElement, b As Boolean)  
SetBackgroundColor(mElement As BANanoElement, color As String)  
SetAlpha(mElement As BANanoElement, v As Double)  
SetStyleProperty(mElement As BANanoElement, key As String, value As String)  
SetBackgroundImage(mElement As BANanoElement, fileName As String)  
GetStyleProperty(mElement As BANanoElement, key As String) As Object  
SetPadding(mElement As BANanoElement, LeftM As Int, TopM As Int, RightM As Int, BottomM As Int)  
SetMargin(mElement As BANanoElement, LeftM As Int, TopM As Int, RightM As Int, BottomM As Int)  
GetPaddingLeft(mElement As BANanoElement) As String  
GetPaddingTop(mElement As BANanoElement) As String  
GetPaddingBottom(mElement As BANanoElement) As String  
GetPaddingRight(mElement As BANanoElement) As String  
GetMarginLeft(mElement As BANanoElement) As String  
GetMarginTop(mElement As BANanoElement) As String  
GetMarginBottom(mElement As BANanoElement) As String  
GetMarginRight(mElement As BANanoElement) As String  
SetTop(mElement As BANanoElement, s As String)  
SetLeft(mElement As BANanoElement, s As String)  
SetWidth(mElement As BANanoElement, s As String)  
SetHeight(mElement As BANanoElement, s As String)  
SetColorAnimated(mElement As BANanoElement,duration As Int, FromColor As String, ToColor As String) As BANanoAnimeJS  
SetScaleAnimated(mElement As BANanoElement,duration As Int, FromScale As Double, ToScale As Double) As BANanoAnimeJS  
SetVisibleAnimated(mElement As BANanoElement,duration As Int, b As Boolean) As BANanoAnimeJS  
SetAlphaAnimated(mElement As BANanoElement,duration As Int, alpha As Double) As BANanoAnimeJS  
SetLayoutAnimated(mElement As BANanoElement,duration As Int, left As String, top As String, width As String, height As String) As BANanoAnimeJS  
SetLayoutAnimatedRadius(mElement As BANanoElement,duration As Int, left As String, top As String, width As String, height As String, radius As String) As BANanoAnimeJS  
SetWidthAnimated(mElement As BANanoElement,duration As Int, width As String) As BANanoAnimeJS  
SetHeightAnimated(mElement As BANanoElement,duration As Int, height As String) As BANanoAnimeJS  
SetRadiusAnimated(mElement As BANanoElement,duration As Int, radius As String) As BANanoAnimeJS  
SetTextSizeAnimated(mElement As BANanoElement,duration As Int, textSize As String) As BANanoAnimeJS  
SetLeftAnimated(mElement As BANanoElement,duration As Int, left As String) As BANanoAnimeJS  
SetTopAnimated(mElement As BANanoElement,duration As Int, top As String) As BANanoAnimeJS  
SetRotationAnimated(mElement As BANanoElement,duration As Int, degrees As Int) As BANanoAnimeJS
```

  
  
  
<https://github.com/Mashiane/BANanoCSSUtils>