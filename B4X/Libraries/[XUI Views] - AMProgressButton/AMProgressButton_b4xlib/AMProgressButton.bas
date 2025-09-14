B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.7
@EndOfDesignText@

'Click to build b4xlib: ide://run?file=%JAVABIN%\jar.exe&WorkingDirectory=..&Args=-cMf&Args=LibraryNameHere.b4xlib&&Args=..&Args=*.bas&Args=manifest.txt

#DesignerProperty: Key: ProgressText, DisplayName: Progress Text, FieldType: String, DefaultValue: Downloading..., Description: Apears when the button is in progress
#DesignerProperty: Key: ProgressTextColor, DisplayName: Progress TextColor, FieldType: Color, DefaultValue: 0xFF006400

#DesignerProperty: Key: OnCompleteText, DisplayName: OnComplete Text, FieldType: String, DefaultValue: Downloaded, Description: Apears when the progress completed
#DesignerProperty: Key: OnCompleteTextColor, DisplayName: OnComplete TextColor, FieldType: Color, DefaultValue: 0xFFFFFFFF

#DesignerProperty: Key: ProgressColor, DisplayName: Progress Color, FieldType: Color, DefaultValue: 0xFF00D254
#DesignerProperty: Key: AnimationDuration, DisplayName: Animation Duration, FieldType: Int, DefaultValue: 150, Description: Duration of textsize and progress animations

#DesignerProperty: Key: Color, DisplayName: Color, FieldType: Color, DefaultValue: 0xFFF5F5F5, Description: Color of the button
#DesignerProperty: Key: CornerRadius, DisplayName: CornerRadius, FieldType: int, DefaultValue: 60, Description: CornerRadius of the button
#DesignerProperty: Key: BorderWidth, DisplayName: Border Width, FieldType: int, DefaultValue: 1, Description: Border Width of the button
#DesignerProperty: Key: BorderColor, DisplayName: Border Color, FieldType: Color, DefaultValue: 0xFFD3D3D3, Description: Border Color of the button

#Event: Click
#Event: OnComplete

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	
	Public mBase As B4XView
	Public mLbl As B4XView
	Private lprogress As Label
	Private mProgress As B4XView
	Public mPnlUpper As B4XView
	
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Public Color As Int
	Public CornerRadius As Int
	Public BorderWidth As Int
	Public BorderColor As Int
	
	Public OnCompleteText As String
	Public OnCompleteTextColor As Int
	
	Public NormalText As String
	Public NormalTextColor As Int
	Private NormalTextSize As Float
	
	Public ProgressText As String
	Public ProgressTextColor As Int
	
	Public AnimationDuration As Int
	Public ProgressColor As Int
	
	Public Enabled As Boolean = True
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, lbl As Label, Props As Map)
	mBase = Base
	mLbl = lbl
	lprogress.Initialize("lprogress")
	mProgress = lprogress
	mPnlUpper = xui.CreatePanel("mPnlUpper")
	
	Tag = mBase.Tag
	mBase.Tag = Me
	
	mPnlUpper.Color = 0x00FFFFFF
	mProgress.Text = ""
	
	AnimationDuration = Props.Get("AnimationDuration")
	
	ProgressColor = xui.PaintOrColorToColor(Props.Get("ProgressColor"))
	ProgressText = Props.Get("ProgressText")
	ProgressTextColor = xui.PaintOrColorToColor(Props.Get("ProgressTextColor"))
	
	NormalText = mLbl.Text
	NormalTextColor = mLbl.TextColor
	NormalTextSize = mLbl.TextSize
	
	OnCompleteText = Props.Get("OnCompleteText")
	OnCompleteTextColor = xui.PaintOrColorToColor(Props.Get("OnCompleteTextColor"))
	
	mProgress.color = ProgressColor
	
	Color = xui.PaintOrColorToColor(Props.Get("Color"))
	CornerRadius = xui.PaintOrColorToColor(Props.Get("CornerRadius"))
	BorderWidth = xui.PaintOrColorToColor(Props.Get("BorderWidth"))
	BorderColor = xui.PaintOrColorToColor(Props.Get("BorderColor"))
	
	SetColor(Color)
	SetCornerRadius(CornerRadius)
	SetBorder(BorderWidth,BorderColor)

	mBase.AddView(mProgress,0,0,0,mBase.Height)
	mBase.AddView(mLbl,0,0,mBase.Width,mBase.Height)
	mBase.AddView(mPnlUpper,0,0,mBase.Width,mBase.Height)
	
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
End Sub

#Region Touch

Private Sub mPnlUpper_Touch (Action As Int, X As Float, Y As Float)
	Dim Inside As Boolean = x > 0 And x < mBase.Width And y > 0 And y < mBase.Height
	If Enabled = False Then Return
	
	Select Action
		Case 0 'Down
			
			mLbl.SetTextSizeAnimated(AnimationDuration,mLbl.TextSize - 2)
			
		Case 1 'Up
			
			mLbl.SetTextSizeAnimated(AnimationDuration,NormalTextSize)
			
			If Inside Then
				If xui.SubExists(mCallBack, mEventName & "_Click",1) Then
					CallSubDelayed(mCallBack, mEventName & "_Click")
				End If
			End If
			
	End Select
End Sub

#End Region

#region Settings

Public Sub SetProgress(progress As Float)
	
	Dim percent As Double
	percent = mBase.Width / 100
	
	If progress <= 0 Then

		SetNormalText(NormalText)
		SetNormalTextColor(NormalTextColor)
		
		mProgress.SetLayoutAnimated(AnimationDuration,percent*(-1),0,percent,mBase.Height)
		
	End If
	
	If progress < 100 And progress > 0 Then
		
		SetProgressText(ProgressText)
		SetProgressTextColor(ProgressTextColor)
		
		mProgress.SetLayoutAnimated(AnimationDuration,0,0,percent*progress,mBase.Height)
		
	End If
	
	If progress >= 100 Then
		
		SetOnCompleteText(OnCompleteText)
		SetOnCompleteTextColor(OnCompleteTextColor)
		
		mProgress.SetLayoutAnimated(AnimationDuration,0,0,(percent*100)+percent,mBase.Height)
		
		If xui.SubExists(mCallBack, mEventName & "_OnComplete",1) Then
			CallSubDelayed(mCallBack, mEventName & "_OnComplete")
		End If
		
	End If

End Sub


Public Sub SetColor(clr As Int)
	Color  = clr
	mBase.Color = Color
End Sub

Public Sub SetCornerRadius(cr As Int)
	CornerRadius = cr
	
	SetCircleClip(mBase,CornerRadius)
	
	SetBorder(BorderWidth,BorderColor)
End Sub

Public Sub SetBorder(BWidth As Int, BColor As Int)
	BorderWidth = BWidth
	BorderColor = BColor
	
	mBase.SetColorAndBorder(mBase.Color,BWidth,BColor,CornerRadius)
End Sub

Public Sub SetNormalText(Text As String)
	NormalText = Text
	mLbl.Text = NormalText
End Sub

Public Sub SetNormalTextColor(clr As Int)
	NormalTextColor = clr
	mLbl.TextColor = NormalTextColor
End Sub


Public Sub SetProgressColor(clr As Int)
	ProgressColor = clr
	mProgress.Color = Color
End Sub

Public Sub SetProgressText(Text As String)
	ProgressText = Text
	mLbl.Text = ProgressText
End Sub

Public Sub SetProgressTextColor(clr As Int)
	ProgressTextColor = clr
	mLbl.TextColor = ProgressTextColor
End Sub


Public Sub SetOnCompleteText(Text As String)
	OnCompleteText = Text
	mLbl.Text = OnCompleteText
End Sub

Public Sub SetOnCompleteTextColor(clr As Int)
	OnCompleteTextColor = clr
	mLbl.TextColor = OnCompleteTextColor
End Sub

#End Region

#Region Others

Private Sub SetCircleClip (pnl As B4XView,radius As Int)
#if B4J
	Dim jo As JavaObject = pnl
	Dim shape As JavaObject
	Dim cx As Double = pnl.Width
	Dim cy As Double = pnl.Height
	shape.InitializeNewInstance("javafx.scene.shape.Rectangle", Array(cx, cy))
	If radius > 0 Then
		Dim d As Double = radius
		shape.RunMethod("setArcHeight", Array(d))
		shape.RunMethod("setArcWidth", Array(d))
	End If
	jo.RunMethod("setClip", Array(shape))
#else if B4A
	Dim jo As JavaObject = pnl
	jo.RunMethod("setClipToOutline", Array(True))
	pnl.SetColorAndBorder(pnl.Color,0,0,radius)
	#Else If B4I
	Dim NaObj As NativeObject = pnl
	Dim BorderWidth As Float = NaObj.GetField("layer").GetField("borderWidth").AsNumber
	' *** Get border color ***
	Dim noMe As NativeObject = Me
	Dim BorderUIColor As Int = noMe.UIColorToColor (noMe.RunMethod ("borderColor:", Array (pnl)))
	pnl.SetColorAndBorder(pnl.Color,BorderWidth,BorderUIColor,radius)
#end if
End Sub

#End Region