B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.3
@EndOfDesignText@

#Event: Moved(Index As Int, Value As Int)
#Event: Released(Index As Int, Value As Int)

#IgnoreWarnings: 9,11,12

'Class module
Private Sub Class_Globals
	Private rectClear As Rect
	Private rectBorder As Rect
	Private rectFill As Rect
	
	Dim TagLabel As Label
	Dim ValueLabel As Label
	
	Private ValueLabelTextSize As Int
	Private TagLabelTextSize As Int
	
	Private cv As Canvas
	Private pnl As Panel
	
	Private mShowTag As Boolean
	Private mShowVal As Boolean

	Private CurrentValue, OldValue As Int
	Private MaxVal As Int = 100
	
	Private mModule As Object
	Private mEventName As String

	Private mStrokeWidth As Float
	Private mColorClear As Int
	Private mColorFill As Int
	Private mColorBorder As Int
	Private mTouchControl As Boolean
	Private mUserChanged As Boolean = False

	Private mViewPager As AHViewPager
	Private mUseViewPager As Boolean = False
	
	Private mWidth As Int
	Private mHeight As Int
'	Private mLeft As Int
'	Private mTop As Int	
	Private mTag As String
	Private mIndex As Int
	
	Private mHorizontal As Boolean = False
	Private mTouchOffset As Int = 0
	
	Private mFireEventTouchMove As Boolean = True
	Private mFireEventTouchUp As Boolean = True
	
	Private A,R,G,B As Int
	
	''''''''' ANIMATION ''''''''''
	Private Fade As AnimationPlus
	Private Rotate As AnimationPlus
	Private RotateCenter As AnimationPlus
	Private Scale As AnimationPlus
	Private ScaleCenter As AnimationPlus
	Private Translate As AnimationPlus
	
	Private ASet As AnimationSet

	Private ANI As AnimationPlus
	'The rate of change is constant.
	Public Const INTERPOLATOR_LINEAR As Int = ANI.INTERPOLATOR_LINEAR
	'The change bounces at the end.
	Public Const INTERPOLATOR_BOUNCE As Int = ANI.INTERPOLATOR_BOUNCE
	'The rate of change Plays a out slowly, then accelerates.
	Public Const INTERPOLATOR_ACCELERATE As Int = ANI.INTERPOLATOR_ACCELERATE
	'The rate of change Plays a and ends slowly but accelerates through the middle.
	Public Const INTERPOLATOR_ACCELERATE_DECELERATE As Int = ANI.INTERPOLATOR_ACCELERATE_DECELERATE
	'The change Plays a backward then flings forward.
	Public Const INTERPOLATOR_ANTICIPATE As Int = ANI.INTERPOLATOR_ANTICIPATE
	'The change Plays a backward, flings forward and overshoots the target value, then settles at the final
	Public Const INTERPOLATOR_ANTICIPATE_OVERSHOOT As Int = ANI.INTERPOLATOR_ANTICIPATE_OVERSHOOT
	'Repeats the animation for a specified number of cycles. The rate of change follows a sinusoidal pattern.
	Public Const INTERPOLATOR_CYCLE As Int = ANI.INTERPOLATOR_CYCLE
	'The rate of change Plays a out quickly, then decelerates.
	Public Const INTERPOLATOR_DECELERATE As Int = ANI.INTERPOLATOR_DECELERATE
	'The change flings forward and overshoots the last value, then comes back.
	Public Const INTERPOLATOR_OVERSHOOT As Int = ANI.INTERPOLATOR_OVERSHOOT
	
	Public Const  COUNT_INFINITE As Int = ANI.REPEAT_INFINITE
	Public Const  REPEAT_RESTART As Int = ANI.REPEAT_RESTART
	Public Const  REPEAT_REVERSE As Int = ANI.REPEAT_REVERSE
	
	''''''''''''''''''''''''''''''
	Private Const ACTION_DOWN As Int = 0
	Private Const ACTION_UP As Int = 1
	Private Const ACTION_MOVE As Int = 2
	Private Const ACTION_POINTER_DOWN As Int = 5
	Private Const ACTION_POINTER_UP As Int = 6
	
End Sub

'Initialize a CustomMinimalSlider object.
Public Sub Initialize
End Sub
'
''Initialize a CustomMinimalSlider object on top of ViewPager.
''This avoid touch event conflicts.
'Public Sub Initialize2(ViewPager As AHViewPager)
'	mUseViewPager = True
'	mViewPager = ViewPager
'End Sub


'Set CustomMinimalSlider object to be used on top of ViewPager.
'This avoid touch event conflicts.
Public Sub UseViewPager(ViewPager As AHViewPager)
	If ViewPager.IsInitialized Then
		mUseViewPager = True
		mViewPager = ViewPager
	Else
		mUseViewPager = False
'		mViewPager = Null
		Log("CustomMinimalSlider: ViewPager is not initialized, to this method is not applicable.")
	End If
End Sub

'
'Create a CustomMinimalSlider object.
'
'After Initialize, this is a first step to create a CustomMinimalSlider. Other methods can be used after this method.
'
'NOTE: Slider have automatic orientation, if With > Height, it is placed horizontally, otherwise vertically.
'
'Parent:              the parent in witch to initialize the CustomMinimalSlider control, can be Activity or Panel or View
'Module:             the module that receive events
'EventName:        the name of Sub that receive events
'Left:                 the Left property of the slider
'Top:                 the Top property of the slider 
'Width:               the Width of the slider 
'Height:              the Height of the slider
'ColorClear:           the internal background color of the control
'ColorFill:               the bar color
'ColorBorder:        the border color
'StrokeWidth:       the border width 
'ShowValue:         set label Value visibility
'TouchControl:      if True can be used a MultiTouch control to set the slider value and event _Moved is raised
'Visible:                set the initial visible state
'
'Example:
'<code>
'Dim CMS1 As CustomMinimalSlider
'CMS1.Initialize
'CMS1.Create(Panel1, Me, "CMS1", 10,50,500,300, Colors.Black, Colors.Green, Colors.White, 1, True, True, True)
'</code>
Sub Create(Parent As Panel, Module As Object, EventName As String, Left As Int, Top As Int, Width As Int, Height As Int, _
	        ColorClear As Int, ColorFill As Int, ColorBorder As Int, StrokeWidth As Float, ShowTag As Boolean, ShowValue As Boolean, TouchControl As Boolean, Visible As Boolean)
			  
	InternalCreate(Parent, Module, EventName, 0, Left, Top, Width, Height, ColorClear, ColorFill, ColorBorder, StrokeWidth, ShowTag, ShowValue, TouchControl, Visible)
End Sub

Private Sub InternalCreate(Parent As Panel, Module As Object, EventName As String, Index As Int, Left As Int, Top As Int, Width As Int, Height As Int, _
	ColorClear As Int, ColorFill As Int, ColorBorder As Int, StrokeWidth As Float, ShowTag As Boolean, ShowValue As Boolean, TouchControl As Boolean, Visible As Boolean)
	
'	Log("Parent W: " & Parent.Width)
'	Log("Parent H: " & Parent.Height)
'	
'	If Width < 1 Or Width > Parent.Width Then
'		Log("CustomMinimalSlider Error: Slider index " & Index & " not created because wrong Width size: " & Width)
'		Return
'	End If
'	
'	If Height < 1 Or Height > Parent.Height Then
'		Log("CustomMinimalSlider Error: Slider index " & Index & " not created because wrong Height size: " & Height)
'		Return
'	End If
	
	If Width > Height Then mHorizontal = True Else mHorizontal = False
	
	'Store the calling object
	mModule = Module
	mEventName = EventName
	mStrokeWidth = StrokeWidth
	If mStrokeWidth < 1 Then mStrokeWidth = 1
	mColorClear = ColorClear
	mColorFill = ColorFill
	mColorBorder = ColorBorder
	mTouchControl = TouchControl
'	mParent = Parent
	
	mWidth = Width
	mHeight = Height
'	mLeft = Left
'	mTop = Top

	mShowTag = ShowTag
	mShowVal = ShowValue
		
	pnl.Initialize("pnl")
	Parent.AddView(pnl,Left,Top,mWidth,mHeight)
	pnl.Color = Colors.Red
	pnl.Invalidate
	
	cv.Initialize(pnl)
	
	rectClear.Initialize(mStrokeWidth, mStrokeWidth, mWidth-mStrokeWidth, mHeight-mStrokeWidth)
	cv.DrawRect(rectClear,ColorClear,True,StrokeWidth)
	pnl.Invalidate
	
	rectBorder.Initialize(mStrokeWidth/2, mStrokeWidth/2, mWidth-mStrokeWidth/2,mHeight-mStrokeWidth/2)
	cv.DrawRect(rectBorder,mColorBorder,False,mStrokeWidth)
	pnl.Invalidate

	mTag = Index
	mIndex = Index
	
	If mShowVal Then
'		ValueLabelTextSize = Min(1dip * (Width/4.5),16)
		ValueLabelTextSize = Min(1dip * (Width / 4.5), 6dip)
		ValueLabel.Initialize("ValueLabel")
		
		If mHorizontal Then
			Parent.AddView(ValueLabel, Left + Width + 5dip + 1, Top, 40dip, Height)
		Else
			Parent.AddView(ValueLabel, Left, Top - 20dip - 5dip, Width + mStrokeWidth, 20dip)
		End If
		
		ValueLabel.Color = Colors.DarkGray  ' DEBUG DA ELIMINARE
			
		ValueLabel.TextColor = Colors.White
		ValueLabel.Text = 0
		ValueLabel.Gravity = Gravity.CENTER
		ValueLabel.TextSize = ValueLabelTextSize
		ValueLabel.Visible = Visible
'		ValueLabel.Tag = Index   
		ValueLabel.Invalidate
	End If
	
	If mShowTag Then
		TagLabelTextSize = Min(1dip * (Width / 3.5), 6dip)
		TagLabel.Initialize("TagLabel")
	
		If mHorizontal Then
			Parent.AddView(TagLabel,Left - 40dip - 5dip - 1,Top,40dip,Height)
		Else
			Parent.AddView(TagLabel,Left,Top + Height + 5dip - 1,Width,20dip)
		End If
	
		TagLabel.Color = Colors.DarkGray
	  
		TagLabel.TextColor = Colors.Red
		TagLabel.Text = mTag
		TagLabel.Gravity = Gravity.CENTER
		TagLabel.Typeface = Typeface.DEFAULT_BOLD
		TagLabel.TextSize = TagLabelTextSize
		TagLabel.Visible = Visible
 
		TagLabel.Invalidate
	End If
	
	pnl.Visible = Visible
	pnl.Invalidate
	
'	Log("TextSizeVal: " & ValueLabelTextSize)
'	Log("TextSizeNum: " &TagLabelTextSize)
End Sub

'
'Create a block of CustomMinimalSliders.
'
'NOTE: Sliders have automatic orientation, if each slider With > Height, it is placed horizontally, otherwise vertically.
'
'IMPORTANT:    If this method is used, no need to initialize a Class for each CustomMinimalSlider, just Initialize first element
'                      in the block and Class is automatically initialized for all CMSs in the block.
'                      After Initialize first element in the block, this is a first step to create a CustomMinimalSlider block. Other methods can be used after this method.
'
'Parent:              the parent in witch to initialize the CustomMinimalSlider controls, can be Activity or Panel or View
'Module:             the module that receive events
'EventName:       the name of Sub that receive events
'SliderArray():      the slider array
'Left:                 the Left property of the slider
'Top:                the Top property of the slider 
'Width:              the Width of the slider
'Height:             the Height of the slider
'ColorClear:         the internal background color of the control
'ColorFill:             the bar color
'ColorBorder:      the border color
'StrokeWidth:     the border width
'ShowValue:       set label Value visibility
'TouchControl:    if True can be used a MultiTouch control to set the slider value and event Moved is returned
'Visible:              set the initial visible state
'
'Example:
'<code>
'Dim CMS(10) As CustomMinimalSlider
'CMS(0).Initialize
'CMS(0).CreateBlock(Panel1, Me, "CMS", CMS, 10,50,500,300, Colors.Black, Colors.Green, Colors.White, 1, True, True, True)
'</code>
Sub CreateBlock(Parent As Panel,Module As Object, EventName As String, SliderArray() As CustomMinimalSlider, Left As Int, Top As Int, Width As Int, Height As Int, _
	ColorClear As Int, ColorFill As Int, ColorBorder As Int, StrokeWidth As Float, ShowTag As Boolean, ShowValue As Boolean, TouchControl As Boolean, Visible As Boolean)	
	
	Width = Width / SliderArray.Length    'aggiunto per divisione
	
	For i = 0 To SliderArray.Length-1
		SliderArray(i).Initialize
		SliderArray(i).InternalCreate(Parent, Module, EventName, i, Left+(Width*i), Top, Width, Height, ColorClear, ColorFill, ColorBorder, StrokeWidth, ShowTag, ShowValue, TouchControl, Visible)    'aggiunto per divisione
	Next
End Sub

Private Sub NewPoint(val As Int)
	
'	If val < 0 Or val > MaxVal Then Return
	
	CurrentValue = val
	
'	If CurrentValue <> OldValue Then
	cv.DrawRect(rectClear,mColorClear,True,mStrokeWidth)   'CLEAR
	
	If Not(mHorizontal) Then
		rectFill.Initialize(mStrokeWidth, mHeight-Map_Int(CurrentValue,0,MaxVal,mStrokeWidth,mHeight-mStrokeWidth), mWidth-mStrokeWidth, mHeight-mStrokeWidth)
	Else
		rectFill.Initialize(mStrokeWidth, mStrokeWidth, Map_Int(CurrentValue,0,MaxVal,mStrokeWidth,mWidth-mStrokeWidth), mHeight-mStrokeWidth)
	End If
		
	cv.DrawRect(rectFill,mColorFill,True,mStrokeWidth)
	pnl.Invalidate
		
	If mShowVal Then
		ValueLabel.Text = CurrentValue
'		ValueLabel.Invalidate
	End If
			
	'***********************************************************************************
	'Pass the value back to the calling module
	If mTouchControl And mFireEventTouchMove Then
'		If Not(FireEventTouchUP) Then
'		If mFireEventTouchMove Then
		If SubExists(mModule,mEventName & "_Moved") Then
'			Dim arg As Int
'			If (IsNumber(mTag) And (mTag <= mIndex)) Then arg = mTag Else arg = mIndex
'			arg = mIndex
			CallSub3(mModule, mEventName & "_Moved", mIndex, CurrentValue)
		End If     'per passare + argomenti, passare un Type
'		End If
'		Else
		''		If mFireEventTouchUp Then
		''			If SubExists(mModule,mEventName & "_Released") Then
		''				CallSub3(mModule, mEventName & "_Released", mIndex, CurrentValue)
		''			End If     'per passare + argomenti, passare un Type
		''		End If
	End If
	'***********************************************************************************
'	End If
	
	mUserChanged = False
	OldValue = CurrentValue
End Sub

Private Sub JustDrawNewPoint(val As Int) ' Just draw without call of callbacks
	
'	If val < 0 Or val > MaxVal Then Return
	
	CurrentValue = val
	
'	If CurrentValue <> OldValue Then
	cv.DrawRect(rectClear,mColorClear,True,mStrokeWidth)   'CLEAR
	
	If Not(mHorizontal) Then
		rectFill.Initialize(mStrokeWidth, mHeight-Map_Int(CurrentValue,0,MaxVal,mStrokeWidth,mHeight-mStrokeWidth), mWidth-mStrokeWidth, mHeight-mStrokeWidth)
	Else
		rectFill.Initialize(mStrokeWidth, mStrokeWidth, Map_Int(CurrentValue,0,MaxVal,mStrokeWidth,mWidth-mStrokeWidth), mHeight-mStrokeWidth)
	End If
		
	cv.DrawRect(rectFill,mColorFill,True,mStrokeWidth)
	pnl.Invalidate
		
	If mShowVal Then
		ValueLabel.Text = CurrentValue
'		ValueLabel.Invalidate
	End If
			
'	mUserChanged = False
	OldValue = CurrentValue
End Sub


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

'Returns a RGB color from an integer
Private Sub GetARGB(Color As Int) 'As Int()
	A = Bit.UnsignedShiftRight(Bit.And(Color, 0xff000000), 24)    'A  (transparency)
	R = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)      'R
	G = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)         'G
	B = Bit.And(Color, 0xff)                                      'B
End Sub

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

'Gets or Sets the control touch property.
Sub getTouchControl As Boolean
	Return mTouchControl
End Sub
Sub setTouchControl(val As Boolean)
	mTouchControl = val
End Sub

'Gets the control Left.
Sub getLeft As Int
	If mStrokeWidth Mod 2 = 0 Then
		Return pnl.Left + (mStrokeWidth/2)
	Else
		Return pnl.Left + (mStrokeWidth+1)/2
	End If
End Sub

'Gets the control Top.
Sub getTop As Int
	Return pnl.Top
End Sub

'Gets the control Right.
Sub getRight As Int
	If mStrokeWidth Mod 2 = 0 Then
		Return pnl.Left + pnl.Width-(mStrokeWidth/2)
	Else
		Return pnl.Left + pnl.Width-(mStrokeWidth/2)+1
	End If
End Sub

'Gets the control Bottom.
Sub getBottom As Int
	Return pnl.Top + pnl.Height
End Sub

'Gets the control Width.
Sub getWidth As Int
	Return pnl.Width-mStrokeWidth
End Sub

'Gets the control Height.
Sub getHeight As Int
	Return pnl.Height
End Sub

'Gets if Moved Action depends from user action, changed with touch (true) or changed at runtime code (false).
Sub getUserChanged As Boolean
	Return mUserChanged
End Sub

'Gets or Sets the control alpha:  0 is tranparent, 1 (default) is fully.
Sub setAlpha(Alpha As Double)
	'    pnl.Alpha = Alpha
	GetARGB(cv.Bitmap.GetPixel(1,1))	 '<<<<<<<<<<<<<<<<<<  DA TESTARE
	pnl.Color = Colors.ARGB(Alpha,R,G,B)
End Sub
Sub getAlpha As Double
	'    Return pnl.Alpha
	GetARGB(cv.Bitmap.GetPixel(1,1))	 '<<<<<<<<<<<<<<<<<<  DA TESTARE
	Return A
End Sub

'Gets or Sets whether the control is visible.
Sub setVisible(Visible As Boolean)
	pnl.Visible = Visible
	If mShowVal Then ValueLabel.Visible = Visible
	If mShowTag Then TagLabel.Visible = Visible
End Sub
Sub getVisible As Boolean
	Return pnl.Visible
End Sub

'Gets or Sets whether the control is enabled.
Sub setEnabled(Enabled As Boolean)
	pnl.Enabled = Enabled
	If mShowVal Then ValueLabel.Enabled = Enabled
	If mShowTag Then TagLabel.Enabled = Enabled
End Sub
Sub getEnabled As Boolean
	Return pnl.Enabled
End Sub

'Gets or Sets the touch offset  
'
'For example:
'by set it to 0.5 when the touch is 50% MaxValue will be reached
'by set it to 0.25 when the touch is 25% MaxValue will be reached
'by set it to 2.0 when the touch is 100% the 50% will be reached
Sub setTouchOffset(Offset As Int)
	mTouchOffset = Offset
End Sub
Sub getTouchOffset As Int
	Return mTouchOffset
End Sub

'Get or Set the Slider MaxValue.
'Default MaxValue if no chanded is 100
Sub getMaxValue As Int
	Return MaxVal
End Sub
Sub setMaxValue (MaxValue As Int)
	MaxVal = MaxValue
End Sub

'Get or Set the Slider Tag.
Sub getTag As String
	Return mTag
End Sub
Sub setTag (Tag As String)
	mTag = Tag
	If mShowTag Then
		TagLabel.Tag = mTag
		TagLabel.Text = mTag
	End If
End Sub

'Get or Set the Slider value.
'Call this after Initialize or CreateBlock
'Default range if MaxValue no chanded is (0-100)
Sub getValue As Int
	Return CurrentValue
End Sub
Sub setValue (Value As Int)
	mUserChanged = False
	If Value >= 0 And Value <= MaxVal Then NewPoint(Value)
End Sub

'Get the Slider Panel.
Sub getPanel As Panel
	Return pnl
End Sub

'Get the Slider Canvas.
Sub getCanvas As Canvas
	Return cv
End Sub

'Remove this control and free ram from it's resource.
Sub Remove
'	Log("Remove")
	pnl.RemoveView
	If mShowVal Then ValueLabel.RemoveView
	If mShowTag Then TagLabel.RemoveView
End Sub

''Captures the control appearance and returns the rendered image.
'Sub getSnapshot As Bitmap
'   Return cv.Bitmap
'End Sub


''''''''''''''''''''''''  A N I M A T I O N S ''''''''''''''''''''''''''

''''''''''''''''''''''''  S I M P L E ''''''''''''''''''''''''''

''Animates the control visible level.
''Note that the animation will only be applied when running on Android 3+ devices.
''
''Duration:   animation duration measured in milliseconds
''Visible:       visible level transition, False = transparent  True = fully
'Sub AnimateVisible(Duration As Int, Visible As Boolean)
'   pnl.SetVisibleAnimated(Duration, Visible)
'	 
'	ValueLabel.SetVisibleAnimated(Duration,Visible)
'	TagLabel.SetVisibleAnimated(Duration,Visible)
'End Sub

'Changes the control Left and Top properties with an animation effect.
'
'Duration:   animation duration in milliseconds
'Left:           new left position after animation
'Top:           new top position after animation
Sub AnimatePosition(Duration As Int, Left As Double, Top As Double)
	pnl.SetLayoutAnimated(Duration,Left,Top,pnl.Width,pnl.Height)
'	pnl.Style = "-fx-background-color: black; -fx-border-color: red;"  
	If mShowVal Then ValueLabel.SetLayoutAnimated(Duration,Left,Top-40dip,pnl.Width,ValueLabel.Height)
	If mShowTag Then TagLabel.SetLayoutAnimated(Duration,Left,Top+pnl.Height,pnl.Width,TagLabel.Height)
End Sub

'Changes the control layout with an animation effect.
'
'Duration:    animation duration measured in milliseconds
'Left:            new left position after animation
'Top:            new top position after animation
'Width:         new width size after animation
'Height:        new height size after animation
Sub AnimateLayout(Duration As Int, Left As Double, Top As Double, Width As Double, Height As Double)
	pnl.SetLayoutAnimated(Duration,Left,Top,Width,Height)
	If mShowVal Then ValueLabel.SetLayoutAnimated(Duration,Left,Top-40dip,pnl.Width,ValueLabel.Height)                             '<<<  DA CONTROLLARE
	If mShowTag Then TagLabel.SetLayoutAnimated(Duration,Left,Top+pnl.Height,pnl.Width,TagLabel.Height)          '<<<  DA CONTROLLARE
End Sub

'Changes the background color with a transition animation between the FromColor and the ToColor colors.
'Note that the animation will only be applied when running on Android 3+ devices.
'
'Duration:   animation duration measured in milliseconds
Sub AnimateColor(Duration As Int, FromColor As Int, ToColor As Int)
	pnl.SetColorAnimated(Duration,FromColor,ToColor)
	If mShowVal Then ValueLabel.SetColorAnimated(Duration,FromColor,ToColor)
	If mShowTag Then TagLabel.SetColorAnimated(Duration,FromColor,ToColor)
End Sub

''''''''''''''''''''''''  P L U S ''''''''''''''''''''''''

Sub setAnimFade_StartOffset(StartOffset As Long)
	Fade.StartOffset = StartOffset
End Sub

Sub setAnimRotate_StartOffset(StartOffset As Long)
	Rotate.StartOffset = StartOffset
End Sub

Sub setAnimRotateCenter_StartOffset(StartOffset As Long)
	RotateCenter.StartOffset = StartOffset
End Sub

Sub setAnimScale_StartOffset(StartOffset As Long)
	Scale.StartOffset = StartOffset
End Sub

Sub setAnimScaleCenter_StartOffset(StartOffset As Long)
	ScaleCenter.StartOffset = StartOffset
End Sub

Sub setAnimTranslate_StartOffset(StartOffset As Long)
	Translate.StartOffset = StartOffset
End Sub

'Plays an AnimationSet that contain all previously added animations. 
'
'Duration:                 the animations duration (milliseconds). This overwrite all single animation durations
'StartOffset              sets when the animation should begin after this method was called (milliseconds)
'ShareInterpolator:  pass True if all the animations in this set should use the interpolator associated with this AnimationSet, pass False if each animation should use its own interpolator
'Interpolator:            the AnimationSet Interpolator, pass INTERPOLATOR constants. 
'NOTE: this is relevant only if ShareInterpolator is True and all the animations in this set should use the same interpolator associated with this AnimationSet
'Param :                    Interpolator parameter if needed, Factor, Tension or Cycles
'INTERPOLATOR_LINEAR,  INTERPOLATOR_ACCELERATE_DECELERATE, INTERPOLATOR_BOUNCE have no parameters.
'NOTE: this is relevant only if ShareInterpolator is True, if not or if parameter is not required just pass -1
'
'Parameters:
'
'INTERPOLATOR_ACCELERATE :                          Float Factor                     -      The acceleration rate (default is 1.0)
'INTERPOLATOR_ANTICIPATE:                             Float Tension                  -      The amount of tension to apply (default is 2.0) 
'INTERPOLATOR_ANTICIPATE_OVERSHOOT:      Float Tension                 -       The amount of tension to apply (default is 2.0)                                                                              
'INTERPOLATOR_CYCLE:                                      Integer Cycles                 -      The number of cycles (default is 1)
'INTERPOLATOR_DECELERATE:                           Float Factor                     -       The deceleration rate (default is 1.0)
'INTERPOLATOR_OVERSHOOT:                            Float Tension                  -      The amount of tension to apply (default is 2.0) 
'
'Raise event AnimationSet_Finished
Sub PlayAnimationSet(Duration As Int,  StartOffset As Long,  ShareInterpolator As Boolean, Interpolator As Int, Param As Float)
	ASet.Initialize(ShareInterpolator)
	ASet.StartOffset = StartOffset

	If Fade.IsInitialized Then ASet.AddAnimation(Fade)
	If Rotate.IsInitialized Then ASet.AddAnimation(Rotate)
	If RotateCenter.IsInitialized Then ASet.AddAnimation(RotateCenter)
	If Scale.IsInitialized Then ASet.AddAnimation(Scale)
	If ScaleCenter.IsInitialized Then ASet.AddAnimation(ScaleCenter)
	If Translate.IsInitialized Then ASet.AddAnimation(Translate)
	
	If ShareInterpolator Then
		If Param = -1 Then
			ASet.SetInterpolator(Interpolator)
		Else
			ASet.SetInterpolatorWithParam(Interpolator,Param)
		End If
	End If
		
	ASet.Duration = Duration
	ASet.PersistAfter = True
	ASet.Start(pnl)
	If mShowVal Then ASet.Start(ValueLabel)
	If mShowTag Then ASet.Start(TagLabel)
End Sub

'Creates an alpha animation. This animation affects the view's transparency (fading effect).
'The alpha values are between 0 to 1 where 0 is fully transparent and 1 is fully opaque.
'
'NOTE: this animation is automatically added to AnimationSet and can be started from 
'PlayAlphaTransition for a single animation or PlayAnimationSet for multiple and complex animations.
'
'Duration:                the animation duration in milliseconds.
'FromAlpha:            the first frame value
'ToAlpha                 the last frame value
'RepeatCount:         the number of times the animation will repeat. A value of 0 means that it will play once. Set to -1 or COUNT_INFINITE for a non stopping animation.
'RepeatMode:          the repeat mode. Relevant when RepeatCount is larger than 0 (or -1).
'default is REPEAT_RESTART which means that the animation will restart each time. REPEAT_REVERSE causes the animation to repeat in reverse each time.
'Interpolator:           the acceleration curve for this animation. Defaults to a linear interpolation.  Use one of the INTERPOLATOR constants or number (0-8)                        
'Param :                   Interpolator parameter if needed, Factor, Tension or Cycles. If parameter is not required just pass -1
'INTERPOLATOR_LINEAR,  INTERPOLATOR_ACCELERATE_DECELERATE, INTERPOLATOR_BOUNCE have no parameters.
'
'Parameters:
'
'INTERPOLATOR_ACCELERATE :                          Float Factor                     -      The acceleration rate (default is 1.0)
'INTERPOLATOR_ANTICIPATE:                             Float Tension                  -      The amount of tension to apply (default is 2.0) 
'INTERPOLATOR_ANTICIPATE_OVERSHOOT:      Float Tension                 -       The amount of tension to apply (default is 2.0)                                                                              
'INTERPOLATOR_CYCLE:                                      Integer Cycles                 -      The number of cycles (default is 1)
'INTERPOLATOR_DECELERATE:                           Float Factor                     -       The deceleration rate (default is 1.0)
'INTERPOLATOR_OVERSHOOT:                            Float Tension                  -      The amount of tension to apply (default is 2.0) 
'
'Raise event Alpha_Finished
Sub AddFadeTransition(Duration As Int, FromAlpha As Float, ToAlpha As Float, RepeatCount As Int, RepeatMode As Int, Interpolator As Int, Param As Float)
	Fade.InitializeAlpha("AnimateAlpha",FromAlpha,ToAlpha)
	Fade.Duration = Duration
	Fade.RepeatCount = RepeatCount
	Fade.RepeatMode = RepeatMode
	 
	If Param = -1 Then
		Fade.SetInterpolator(Interpolator)
	Else
		Fade.SetInterpolatorWithParam(Interpolator,Param)
	End If
	 
	Fade.PersistAfter = True
End Sub

'Plays an Alpha animation previously added with AddFadeTransition method .
'
'StartOffset:     add a delay before animation should begin after this method is called (milliseconds)
'Delay:             delay this animation (milliseconds). This is offset for this single element in the FadeTransition
Sub PlayFadeTransition(StartOffset As Long, Delay As Int)
	Fade.StartOffset = StartOffset
	Fade.Start(pnl)
	If mShowVal Then Fade.Start(ValueLabel)
	If mShowTag Then Fade.Start(TagLabel)
	Sleep(Delay)
End Sub

'Creates a rotation animation. The view will rotate between the given values.
'Rotation pivot is set to the top left corner.
'
'NOTE: this animation is automatically added to AnimationSet and can be started from 
'PlayRotateTransition for a single animation or PlayAnimationSet for multiple and complex animations.
'
'Duration:               the animation duration in milliseconds
'FromDegrees:       the first frame rotation value
'ToDegrees:            the last frame rotation value
'RepeatCount:        the number of times the animation will repeat. A value of 0 means that it will play once. Set to -1 or COUNT_INFINITE for a non stopping animation
'RepeatMode:         the repeat mode. Relevant when RepeatCount is larger than 0 (or -1)
' default is REPEAT_RESTART which means that the animation will restart each time. REPEAT_REVERSE causes the animation to repeat in reverse each time
'Interpolator:          the acceleration curve for this animation. Defaults to a linear interpolation.  Use one of the INTERPOLATOR constants or number (0-8)         
'Param :                   Interpolator parameter if needed, Factor, Tension or Cycles. If parameter is not required just pass -1
'INTERPOLATOR_LINEAR,  INTERPOLATOR_ACCELERATE_DECELERATE, INTERPOLATOR_BOUNCE have no parameters.
'
'Parameters:
'
'INTERPOLATOR_ACCELERATE :                          Float Factor                     -      The acceleration rate (default is 1.0)
'INTERPOLATOR_ANTICIPATE:                             Float Tension                  -      The amount of tension to apply (default is 2.0) 
'INTERPOLATOR_ANTICIPATE_OVERSHOOT:      Float Tension                 -       The amount of tension to apply (default is 2.0)                                                                              
'INTERPOLATOR_CYCLE:                                      Integer Cycles                 -      The number of cycles (default is 1)
'INTERPOLATOR_DECELERATE:                           Float Factor                     -       The deceleration rate (default is 1.0)
'INTERPOLATOR_OVERSHOOT:                            Float Tension                  -      The amount of tension to apply (default is 2.0) 
'
'Raise event Rotate_Finished
Sub AddRotateTransition(Duration As Long, FromDegrees As Float, ToDegrees As Float, RepeatCount As Int, RepeatMode As Int, Interpolator As Int, Param As Float)
	Rotate.InitializeRotate("AnimateRotate",FromDegrees,ToDegrees)
	Rotate.Duration = Duration

	Rotate.RepeatCount = RepeatCount
	Rotate.RepeatMode = RepeatMode
	 
	If Param = -1 Then
		Rotate.SetInterpolator(Interpolator)
	Else
		Rotate.SetInterpolatorWithParam(Interpolator,Param)
	End If
	 
	Rotate.PersistAfter = True
End Sub

'Plays a Rotate animation previously added with AddRotateTransition method.
'NOTE: this method supports only one animation at time . To use more animations simultaneously use the method PlayAnimationSet instead.
'
'StartOffset:     add a delay before animation should begin after this method was called (milliseconds)
'Delay:             delay this animation (milliseconds). This is offset for this single element in the RotateTransition
Sub PlayRotateTransition(StartOffset As Long, Delay As Int)
	Rotate.StartOffset = StartOffset
	Rotate.Start(pnl)
	If mShowVal Then Rotate.Start(ValueLabel)
	If mShowTag Then Rotate.Start(TagLabel)
	Sleep(Delay)
End Sub

'Similar to AddRotateTransition, but with the pivot set to the given view center.
'
'NOTE: this animation is automatically added to AnimationSet and can be started from 
'PlayRotateCenterTransition for a single animation or PlayAnimationSet for multiple and complex animations.
'
'Duration:               the animation duration in milliseconds
'FromDegrees:       the first frame rotation value
'ToDegrees:           the last frame rotation value
'View:                      set pivot to the given view center
'RepeatCount:        the number of times the animation will repeat. A value of 0 means that it will play once. Set to -1 or COUNT_INFINITE for a non stopping animation
'RepeatMode:         the repeat mode. Relevant when RepeatCount is larger than 0 (or -1)
'default is REPEAT_RESTART which means that the animation will restart each time. REPEAT_REVERSE causes the animation to repeat in reverse each time
'Interpolator:          the acceleration curve for this animation. Defaults to a linear interpolation.  Use one of the INTERPOLATOR constants or number (0-8)       
'Param :                   Interpolator parameter if needed, Factor, Tension or Cycles. If parameter is not required just pass -1
'INTERPOLATOR_LINEAR,  INTERPOLATOR_ACCELERATE_DECELERATE, INTERPOLATOR_BOUNCE have no parameters.
'
'Parameters:
'
'INTERPOLATOR_ACCELERATE :                          Float Factor                     -      The acceleration rate (default is 1.0)
'INTERPOLATOR_ANTICIPATE:                             Float Tension                  -      The amount of tension to apply (default is 2.0) 
'INTERPOLATOR_ANTICIPATE_OVERSHOOT:      Float Tension                 -       The amount of tension to apply (default is 2.0)                                                                              
'INTERPOLATOR_CYCLE:                                      Integer Cycles                 -      The number of cycles (default is 1)
'INTERPOLATOR_DECELERATE:                           Float Factor                     -       The deceleration rate (default is 1.0)
'INTERPOLATOR_OVERSHOOT:                            Float Tension                  -      The amount of tension to apply (default is 2.0) 
'
'Raise event RotateCenter_Finished
Sub AddRotateCenterTransition(Duration As Int, FromDegrees As Float, ToDegrees As Float, RepeatCount As Int, RepeatMode As Int, Interpolator As Int, Param As Float)
	RotateCenter.InitializeRotateCenter("AnimateRotateCenter",FromDegrees,ToDegrees,pnl)
	RotateCenter.Duration = Duration
	RotateCenter.RepeatCount = RepeatCount
	RotateCenter.RepeatMode = RepeatMode
	 
	If Param = -1 Then
		RotateCenter.SetInterpolator(Interpolator)
	Else
		RotateCenter.SetInterpolatorWithParam(Interpolator,Param)
	End If
	 
	RotateCenter.PersistAfter = True
End Sub

'Plays a RotateCenter animation previously added with AddRotateCenterTransition method.
'NOTE: this method supports only one animation at a time . To use more animations simultaneously use the method PlayAnimationSet instead.
'
'StartOffset:     add a delay before animation should begin after this method was called (milliseconds)
'Delay:             delay this animation (milliseconds). This is offset for this single element in the RotateCenterTransition
Sub PlayRotateCenterTransition(StartOffset As Long, Delay As Int)
	RotateCenter.StartOffset = StartOffset
	RotateCenter.Start(pnl)
	If mShowVal Then RotateCenter.Start(ValueLabel)
	If mShowTag Then RotateCenter.Start(TagLabel)
	Sleep(Delay)
End Sub

'Creates a scale animation. The view will be scaled during the animation.
'The scaling pivot will be set to the top left corner.
'
'NOTE: this animation is automatically added to AnimationSet and can be started from 
'PlayScaleTransition for a single animation or PlayAnimationSet for multiple and complex animations.
'
'Duration:               the animation duration in milliseconds
'FromX:                   the first frame horizontal scale
'ToX:                  		 the last frame horizontal scale
'FromY:              	  the first frame vertical scale
'ToY:                  		 the last frame vertical scale
'RepeatCount:   		the number of times the animation will repeat. A value of 0 means that it will play once. Set to -1 or COUNT_INFINITE for a non stopping animation
'RepeatMode:    		the repeat mode. Relevant when RepeatCount is larger than 0 (or -1)
'default is REPEAT_RESTART which means that the animation will restart each time. REPEAT_REVERSE causes the animation to repeat in reverse each time
'Interpolator:     		the acceleration curve for this animation. Defaults to a linear interpolation.  Use one of the INTERPOLATOR constants or number (0-8)      
'Param :                   Interpolator parameter if needed, Factor, Tension or Cycles. If parameter is not required just pass -1
'INTERPOLATOR_LINEAR,  INTERPOLATOR_ACCELERATE_DECELERATE, INTERPOLATOR_BOUNCE have no parameters.
'
'Parameters:
'
'INTERPOLATOR_ACCELERATE :                          Float Factor                     -      The acceleration rate (default is 1.0)
'INTERPOLATOR_ANTICIPATE:                             Float Tension                  -      The amount of tension to apply (default is 2.0) 
'INTERPOLATOR_ANTICIPATE_OVERSHOOT:      Float Tension                 -       The amount of tension to apply (default is 2.0)                                                                              
'INTERPOLATOR_CYCLE:                                      Integer Cycles                 -      The number of cycles (default is 1)
'INTERPOLATOR_DECELERATE:                           Float Factor                     -       The deceleration rate (default is 1.0)
'INTERPOLATOR_OVERSHOOT:                            Float Tension                  -      The amount of tension to apply (default is 2.0) 
'
'Raise event Scale_Finished
Sub AddScaleTransition(Duration As Int, FromX As Float, ToX As Float, FromY As Float, ToY As Float, RepeatCount As Int, RepeatMode As Int, Interpolator As Int, Param As Float)
	Scale.InitializeScale("AnimateScale",FromX,FromY,ToX,ToY)
	Scale.Duration = Duration

	Scale.RepeatCount = RepeatCount
	Scale.RepeatMode = RepeatMode
	 
	If Param = -1 Then
		Scale.SetInterpolator(Interpolator)
	Else
		Scale.SetInterpolatorWithParam(Interpolator,Param)
	End If
	 
	Scale.PersistAfter = True
End Sub

'Plays a Scale animation previously added  with AddScaleTransition method.
'NOTE: this method supports only one animation at a time . To use more animations simultaneously use the method PlayAnimationSet instead.
'
'StartOffset:     add a delay before animation should begin after this method is called (milliseconds)
'Delay:             delay this animation (milliseconds). This is offset for this single element in the ScaleTransition
Sub PlayScaleTransition(StartOffset As Long, Delay As Int)
	Scale.StartOffset = StartOffset
	Scale.Start(pnl)
	If mShowVal Then Scale.Start(ValueLabel)
	If mShowTag Then Scale.Start(TagLabel)
	Sleep(Delay)
End Sub

'Similar to AddScaleTransition with a pivot set to the given view center.
'
'NOTE: this animation is automatically added to AnimationSet and can be started from 
'PlayScaleCenterTransition for a single animation or PlayAnimationSet for multiple and complex animations.
'
'Duration:        	     the animation duration in milliseconds
'FromX:             		   the first frame horizontal scale
'ToX:                		  the last frame horizontal scale
'FromY:             		   the first frame vertical scale
'ToY:                 		  the last frame vertical scale
'View:                 		  set pivot to the given view center
'RepeatCount:   	    the number of times the animation will repeat. A value of 0 means that it will play once. Set to -1 or COUNT_INFINITE for a non stopping animation
'RepeatMode:          the repeat mode. Relevant when RepeatCount is larger than 0 (or -1)
'                          	  default is REPEAT_RESTART which means that the animation will restart each time. REPEAT_REVERSE causes the animation to repeat in reverse each time
'Interpolator:     		 the acceleration curve for this animation. Defaults to a linear interpolation.  Use one of the INTERPOLATOR constants or number (0-8)       
'Param :                   Interpolator parameter if needed, Factor, Tension or Cycles. If parameter is not required just pass -1
'INTERPOLATOR_LINEAR,  INTERPOLATOR_ACCELERATE_DECELERATE, INTERPOLATOR_BOUNCE have no parameters.
'
'Parameters:
'
'INTERPOLATOR_ACCELERATE :                          Float Factor                     -      The acceleration rate (default is 1.0)
'INTERPOLATOR_ANTICIPATE:                             Float Tension                  -      The amount of tension to apply (default is 2.0) 
'INTERPOLATOR_ANTICIPATE_OVERSHOOT:      Float Tension                 -       The amount of tension to apply (default is 2.0)                                                                              
'INTERPOLATOR_CYCLE:                                      Integer Cycles                 -      The number of cycles (default is 1)
'INTERPOLATOR_DECELERATE:                           Float Factor                     -       The deceleration rate (default is 1.0)
'INTERPOLATOR_OVERSHOOT:                            Float Tension                  -      The amount of tension to apply (default is 2.0) 
'
'Raise event ScaleCenter_Finished
Sub AddScaleCenterTransition(Duration As Int,  FromX As Float, ToX As Float, FromY As Float, ToY As Float, RepeatCount As Int, RepeatMode As Int, Interpolator As Int, Param As Float)
	ScaleCenter.InitializeScaleCenter("AnimateScaleCenter",FromX,FromY,ToX,ToY,pnl)
	ScaleCenter.Duration = Duration
	ScaleCenter.RepeatCount = RepeatCount
	ScaleCenter.RepeatMode = RepeatMode
	 
	If Param = -1 Then
		ScaleCenter.SetInterpolator(Interpolator)
	Else
		ScaleCenter.SetInterpolatorWithParam(Interpolator,Param)
	End If
	 
	ScaleCenter.PersistAfter = True
End Sub

'Plays a ScaleCenter animation previously added with AddScaleCenterTransition method.
'NOTE: this method supports only one animation at time . To use more animations simultaneously use the method PlayAnimationSet instead.
'
'StartOffset:     add a delay before animation should begin after this method is called (milliseconds)
'Delay:             delay this animation (milliseconds). This is offset for this single element in the ScaleCenterTransition
Sub PlayScaleCenterTransition(StartOffset As Long, Delay As Int)
	ScaleCenter.StartOffset = StartOffset
	ScaleCenter.Start(pnl)
	If mShowVal Then ScaleCenter.Start(ValueLabel)
	If mShowTag Then ScaleCenter.Start(TagLabel)
	Sleep(Delay)
End Sub

'Creates  a translation animation. The view will move according to the given values.
'
'NOTE: this animation is automatically added to AnimationSet and can be started from 
'PlayTranslateTransition a for single animation or PlayAnimationSet for multiple and complex animations.
'
'Duration:         	    the animation duration in milliseconds
'FromX:             	     the first frame horizontal scale
'ToX:                 	    the last frame horizontal scale
'FromY:             	     the first frame vertical scale
'ToY:                 	    the last frame vertical scale
'RepeatCount:   	   the number of times the animation will repeat. A value of 0 means that it will play once. Set to -1 or COUNT_INFINITE for a non stopping animation
'RepeatMode:    	   the repeat mode. Relevant when RepeatCount is larger than 0 (or -1)
'default is REPEAT_RESTART which means that the animation will restart each time. REPEAT_REVERSE causes the animation to repeat in reverse each time
'Interpolator:    	    the acceleration curve for this animation. Defaults to a linear interpolation.  Use one of the INTERPOLATOR constants or number (0-8)       
'Param :                   Interpolator parameter if needed, Factor, Tension or Cycles. If parameter is not required just pass -1
'INTERPOLATOR_LINEAR,  INTERPOLATOR_ACCELERATE_DECELERATE, INTERPOLATOR_BOUNCE have no parameters.
'
'Parameters:
'
'INTERPOLATOR_ACCELERATE :                          Float Factor                     -      The acceleration rate (default is 1.0)
'INTERPOLATOR_ANTICIPATE:                             Float Tension                  -      The amount of tension to apply (default is 2.0) 
'INTERPOLATOR_ANTICIPATE_OVERSHOOT:      Float Tension                 -       The amount of tension to apply (default is 2.0)                                                                              
'INTERPOLATOR_CYCLE:                                      Integer Cycles                 -      The number of cycles (default is 1)
'INTERPOLATOR_DECELERATE:                           Float Factor                     -       The deceleration rate (default is 1.0)
'INTERPOLATOR_OVERSHOOT:                            Float Tension                  -      The amount of tension to apply (default is 2.0) 
'
'Raise event Translate_Finished
Sub AddTranslateTransition(Duration As Int, FromX As Float, ToX As Float, FromY As Float, ToY As Float, RepeatCount As Int, RepeatMode As Int, Interpolator As Int, Param As Float)
	Translate.InitializeTranslate("AnimateTranslate",FromX,FromY,ToX,ToY)
	Translate.Duration = Duration
	Translate.RepeatCount = RepeatCount
	Translate.RepeatMode = RepeatMode
	 
	If Param = -1 Then
		Translate.SetInterpolator(Interpolator)
	Else
		Translate.SetInterpolatorWithParam(Interpolator,Param)
	End If
	 
	Translate.PersistAfter = True
End Sub

'Plays a TranslateTransition previously added with AddTranslateTransition method.
'NOTE: this method supports only one animation at time . To use more animations simultaneously use the method PlayAnimationSet instead.
'
'StartOffset:     add a delay before animation should begin after this method is called (milliseconds)
'Delay:             delay this animation (milliseconds). This is offset for this single element in the TranslateTransition
Sub PlayTranslateTransition(StartOffset As Long, Delay As Int)
	Translate.StartOffset = StartOffset
	Translate.Start(pnl)
	If mShowVal Then Translate.Start(ValueLabel)
	If mShowTag Then Translate.Start(TagLabel)
	Sleep(Delay)
End Sub

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''' 

Private Sub Map_Int(Value As Int, fromLow As Int, fromHigh As Int, toLow As Int, toHigh As Int) As Int
	Return ( (Value - fromLow) * (toHigh - toLow) / (fromHigh - fromLow) + toLow )
End Sub

'EVENTI GESTURE TOUCH
'Sub Gestures_Touch(View As Object, PointerID As Int, Action As Int, x As Float, y As Float) As Boolean
'     If mTouchControl = False Then Return False
'	  
''If Action = mParent.ACTION_DOWN 'AND y < top AND x > 80%x Then Return
''
''	For i = 0 To Gesture.GetPointerCount - 1
''
''        Dim x, y As Float
''        x = Gesture.GetX(i)
''        y = Gesture.GetY(i)
''	 
'''	For  idx = 0 To 7             'FADER IN ORIZZONTALE
''	
'''        If (y-Offs >= (idx*spazio)) AND (y-Offs <= ((idx*spazio)+spazio)) Then
'''          valore=  CMS.DrawSeekBarX(Activity,cvs,idx,127,x,Offs,spazio,spazio,100,700dip,Colors.Transparent,Colors.Blue,Colors.White,True,1dip)
'''		 Log(idx & "  " & valore & CRLF)
'''        End If
'''	Next  
''	
''	For  idx = 0 To numControlli -1             'FADER IN VERTICALE	
''       	 If x >= Offs1+(Offs + larg) *idx AND x <= (Offs1+(Offs + larg) *idx)+larg Then	
''      		Valore(idx)= CMS2.DrawSeekBarV(False,Activity,cvs,idx,MaxVal,y,Offs,Offs1,spazio,larg,top,bottom,Colors.Transparent,ColorFill,Colors.White,True,1dip)	
''			'If valore <> -1 Then Log(idx & "  " & valore & CRLF)
''			If Valore(idx) <> oldValore(idx) Then 
''				MIDI.SendCC(idx+1,Valore(idx),Main.ch)
''				'CMS2.createlblVAL(idx,"CC")
''			'Activity.AddView(CMS2.createtxtVAL(idx,Valore(idx)),Offs + (idx * spazio),10%y-6%y,larg+1dip,6%y)
''				oldValore(idx)=Valore(idx)
''			End If
''        	End If
''	Next  
''	
''    Next
''	
'    Select Action
'        Case Gesture.ACTION_DOWN, Gesture.ACTION_POINTER_DOWN
'            'New Point is assigned to the new touch
''				Log("Touch DOWN")
'				TouchDown = True
'			   NewPoint(Map_Int(y,mHeight-(mStrokeWidth*2)-1,0,0,MaxVal)  )   'relativo al Panel corrente
'            'TouchMap.Put(PointerID, p)
'        Case Gesture.ACTION_POINTER_UP
''			   Log("Touch POINTER_UP")
'				TouchDown = False
''            TouchMap.Remove(PointerID)       
'        Case Gesture.ACTION_UP
''		      Log("Touch UP")
'				TouchDown = False 
''            TouchMap.Clear
'		  Case Gesture.ACTION_MOVE	
'	         NewPoint(Map_Int(y,mHeight-(mStrokeWidth*2)-1,0,0,MaxVal)  )     'relativo al Panel corrente
'
''				If y <= pnl.Top Then NewPoint(MaxVal)                                                        'relativo all'Activity
''				If y >= pnl.Top + pnl.Height-(mStrokeWidth*2)-1 Then NewPoint(0) 
'
'				If y <= 0 Then NewPoint(MaxVal)                                                                  'relativo al Panel corrente
'	         If y >= mHeight-(mStrokeWidth*2)-1 Then NewPoint(0)
'				
''         	Log("Slider: " & pnl.Tag & "   X: " & x & "   Y: " & y) 
'    End Select 
'    
'	 Return True
'End Sub

'Private Sub Activity_Touch (Action As Int, X As Float, Y As Float)
'	Log("Activity_Touch")
'	TouchDown = True
'End Sub

'Set if _Move event will be fired when moved the slider. 
'(By default True)
Public Sub FireEventMove(val As Boolean)
	mFireEventTouchMove = val
End Sub

'Set if Up event will be fired when released the slider.
'(By default True)
Public Sub FireEventRelease(val As Boolean)
	mFireEventTouchUp = val
End Sub

Private Sub pnl_Touch (Action As Int, X As Float, Y As Float) As Boolean

	If mTouchControl = False Then Return False
'	If mEventName = "" Then Return False
		
'	mUserChanged = True
			
	Dim val As Int
			
	Select Action
			
		Case ACTION_DOWN  ', ACTION_POINTER_DOWN
			'New Point is assigned to the new touch
'			Log("Slider ACTION_DOWN on " & mTag & "   X: " & X & "   Y: " & Y)
			
			If mHorizontal = False Then
				val = Min(MaxVal,Map_Int(Y, mHeight-(mStrokeWidth*2)-1, mTouchOffset, 0, MaxVal))
			Else
				If mUseViewPager And mViewPager.PagingEnabled Then DisableViewPager
				val = Min(MaxVal,Map_Int(X, mWidth-(mStrokeWidth*2)-1-mTouchOffset, 0, MaxVal, 0))
			End If
				
'			If val <> OldValue And val >= 0 And val <= MaxVal Then
'				mUserChanged = True
'				NewPoint(val)
'			End If

			If val >= 0 And val <= MaxVal Then
'				If Not(FireEventTouchUP) Then
'				If val >= 0 And val <= MaxVal Then
				mUserChanged = True
				NewPoint(val)
'				End If
'				Else
'					JustDrawNewPoint(val)
'				End If
			End If
		
			'TouchMap.Put(PointerID, p)
		
'		Case ACTION_POINTER_UP  ' Only with more that one finger
'			Log("ACTION_POINTER_UP on " & mTag & "   X: " & X & "   Y: " & Y)
'			TouchMap.Remove(PointerID)
			
		Case ACTION_UP
'			Log("ACTION_UP on " & mTag & "   X: " & X & "   Y: " & Y)
			'          TouchMap.Clear
			
			If mFireEventTouchUp Then
								
				'          Log("Slider ACTION_MOVE: " & mTag & "   X: " & X & "   Y: " & Y)
				If Not(mHorizontal) Then
					val = Min(MaxVal, Map_Int(Y, mHeight-(mStrokeWidth*2)-1, mTouchOffset, 0, MaxVal))
				Else
					val = Min(MaxVal, Map_Int(X, mWidth-(mStrokeWidth*2)-1-mTouchOffset, 0, MaxVal, 0))
				End If
			
'				Log("ACTION_UP on UseOnlyTouchUP " & mTag & "   X: " & X & "   Y: " & Y & "   VAL: " & val)
				
				mUserChanged = True
				
				If val >= 0 And val <= MaxVal Then
'					NewPoint(val)
					JustDrawNewPoint(val)
					If SubExists(mModule,mEventName & "_Released") Then CallSub3(mModule, mEventName & "_Released", mIndex, val)
					If mHorizontal Then
						If mUseViewPager And mViewPager.PagingEnabled = False Then EnableViewPager
					End If
				Else
					If val < 0 Then
'						NewPoint(0)
						JustDrawNewPoint(0)
						If SubExists(mModule,mEventName & "_Released") Then CallSub3(mModule, mEventName & "_Released", mIndex, 0)
						If mHorizontal Then
							If mUseViewPager And mViewPager.PagingEnabled = False Then EnableViewPager
						End If
					End If
					If val > MaxVal Then
'						NewPoint(MaxVal)
						JustDrawNewPoint(MaxVal)
						If SubExists(mModule,mEventName & "_Released") Then CallSub3(mModule, mEventName & "_Released", mIndex, MaxVal)
						If mHorizontal Then
							If mUseViewPager And mViewPager.PagingEnabled = False Then EnableViewPager
						End If
					End If
				End If
				
				mUserChanged = False
			End If
					
		Case ACTION_MOVE
			
			'          Log("Slider ACTION_MOVE: " & mTag & "   X: " & X & "   Y: " & Y)
			
			If mHorizontal = False Then
				val = Min(MaxVal, Map_Int(Y, mHeight-(mStrokeWidth*2)-1, mTouchOffset, 0, MaxVal))
			Else
				If mUseViewPager And mViewPager.PagingEnabled Then DisableViewPager
				val = Min(MaxVal, Map_Int(X, mWidth-(mStrokeWidth*2)-1-mTouchOffset, 0, MaxVal, 0))
			End If

			If val >= 0 And val <= MaxVal And val <> OldValue Then
				If mFireEventTouchMove Then
'					If val <> OldValue Then  'And val >= 0 And val <= MaxVal Then
					mUserChanged = True
					NewPoint(val)
'					End If
				Else
					JustDrawNewPoint(val)
				End If
			End If

	End Select
	
'			  If Y <= pnl.Top Then NewPoint(MaxVal)
'			  If Y >= pnl.Top + pnl.Height-(mStrokeWidth*2)-1 Then NewPoint(0)
	
	If Not(mHorizontal) Then
		If Y <= 0 Then NewPoint(MaxVal)
		If Y >= mHeight-(mStrokeWidth*2)-1 Then NewPoint(0)
	Else
		If X <= 0 Then NewPoint(0)
		If X >= mWidth-(mStrokeWidth*2)-1 Then NewPoint(MaxVal)
	End If
	
	Return True
End Sub

Private Sub EnableViewPager
'	If mUseViewPager = False Or mViewPager.PagingEnabled Then Return
	Sleep(0)
	mViewPager.PagingEnabled = True
End Sub

Private Sub DisableViewPager
'	If mUseViewPager = False Or mViewPager.PagingEnabled = False Then Return
	Sleep(0)
	mViewPager.PagingEnabled = False
End Sub

Private Sub TagLabel_Click
	If Not(mTouchControl) Then Return

	mUserChanged = True
	If mFireEventTouchMove Then NewPoint(0)
	
	If mFireEventTouchUp Then
		mUserChanged = True ' Reset it
		JustDrawNewPoint(0)
		If SubExists(mModule,mEventName & "_Released") Then CallSub3(mModule, mEventName & "_Released", mIndex, 0)
		mUserChanged = False
	End If
End Sub

Private Sub ValueLabel_Click
	If Not(mTouchControl) Then Return
	
	mUserChanged = True
	If mFireEventTouchMove Then NewPoint(MaxVal)

	If mFireEventTouchUp Then
		mUserChanged = True ' Reset it
		JustDrawNewPoint(MaxVal)
		If SubExists(mModule,mEventName & "_Released") Then CallSub3(mModule, mEventName & "_Released", mIndex, MaxVal)
		mUserChanged = False
	End If
End Sub

''''''''''''''''''''''''''''''''''''''' End of class ''''''''''''''''''''''''''''''''''''



