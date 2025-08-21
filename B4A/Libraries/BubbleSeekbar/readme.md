### BubbleSeekbar by somed3v3loper
### 04/22/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/116690/)

Got something from this <https://github.com/woxingxiao/BubbleSeekBar>  
  
![](https://www.b4x.com/android/forum/attachments/92359)  
  
**BubbleSeekbar**  
  
**Author:** SMM  
**Version:** 1.34  

- **BubbleSeekbar**

- **Events:**

- **getprogressonactionup** (progress As Int, progressfloat As Float)
- **getprogressonfinally** (progress As Int, progressfloat As Float, fromUser As Boolean)
- **onprogresschanged** (progress As Int, progressfloat As Float, fromUser As Boolean)

- **Functions:**

- **BringToFront**
- **Config** (min As Float, max As Float, progress As Int, sectionCount As Int, dotsColor As Int, trackColor As Int, secondTrackColor As Int, thumbColor As Int, showSectionText As Boolean, sectionTextColor As Int, sectionTextSize As Int, showThumbText As Boolean, thumbTextColor As Int, thumbTextSize As Int, bubbleColor As Int, bubbleTextSize As Int, showSectionMark As Boolean, seekBySection As Boolean, autoAdjustSectionMark As Boolean, sectionTextPosition As Int)
- **correctOffsetWhenContainerOnScrolling**
- **DesignerCreateView** (base As Panel, lw As Label, props As Map)
- **getProgressOnActionUp** (bubbleSeekBar As com.xw.repo.BubbleSeekBar, progress As Int, progressFloat As Float)
- **getProgressOnFinally** (bubbleSeekBar As com.xw.repo.BubbleSeekBar, progress As Int, progressFloat As Float, fromUser As Boolean)
- **Initialize** (EventName As String)
- **Invalidate**
- **Invalidate2** (arg0 As android.graphics.Rect)
- **Invalidate3** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int)
- **IsInitialized** As Boolean
- **onProgressChanged** (b As com.xw.repo.BubbleSeekBar, progress As Int, progressFloat As Float, fromUser As Boolean)
- **RemoveView**
- **RequestFocus** As Boolean
- **SendToBack**
- **SetBackgroundImage** (arg0 As android.graphics.Bitmap) As BitmapDrawable
- **SetColorAnimated** (arg0 As Int, arg1 As Int, arg2 As Int)
- **SetLayout** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int)
- **SetLayoutAnimated** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int, arg4 As Int)
- **SetVisibleAnimated** (arg0 As Int, arg1 As Boolean)

- **Properties:**

- **Background** As android.graphics.drawable.Drawable
- **BubbleColor** As Int [write only]
- **Color** As Int [write only]
- **Enabled** As Boolean
- **Height** As Int
- **Left** As Int
- **Max** As Float [read only]
- **Min** As Float [read only]
- **Padding** As Int()
- **Parent** As Object [read only]
- **Progress** As Int
- **ProgressFloat** As Float [read only]
- **SecondTrackColor** As Int [write only]
- **Tag** As Object
- **ThumbColor** As Int [write only]
- **Top** As Int
- **TrackColor** As Int [write only]
- **Visible** As Boolean
- **Width** As Int

  

```B4X
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    'These variables can only be accessed from this module.  
    Dim seek As BubbleSeekBar  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    'Activity.LoadLayout("Layout1")  
    seek.Initialize("seek")  
    seek.Config(0,7,0 ,7,  Colors.Yellow , Colors.RGB(0,255,239)   ,Colors.RGB(255,255,239) ,   Colors.RGB(99,26,0), False  ,   Colors.Transparent,18, False , Colors.White,18,Colors.Black,18, False   ,  True ,  True,0)  
    Activity.AddView(seek,0,300dip,290dip,30dip)  
  
End Sub
```