B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.5
@EndOfDesignText@
#DesignerProperty: Key: ShowBorder, 			DisplayName: Show Border, 				FieldType: Boolean, DefaultValue: True, 									Description: Show button border
#DesignerProperty: Key: BorderColor, 			DisplayName: Border Color, 				FieldType: Color, 	DefaultValue: 0xFFFFFFFF, 								Description: Button border color
#DesignerProperty: Key: BorderWidth, 			DisplayName: Border Width, 				FieldType: Int, 	DefaultValue: 3, 										Description: Button border width
#DesignerProperty: Key: RoundedRadius, 			DisplayName: Rounded Radius, 			FieldType: Int, 	DefaultValue: 20, 										Description: Set button rounded corner radius

#DesignerProperty: Key: Appearance, 			DisplayName: Appearance,				FieldType: String, 	DefaultValue: Solid, List:Solid|Gradient2Color|Gradient3Color, 				Description: Show button color appearance
#DesignerProperty: Key: FirstColor, 			DisplayName: First Color, 				FieldType: Color, 	DefaultValue: 0xFFFFFFFF, 								Description: Button First gradient color
#DesignerProperty: Key: SecondColor, 			DisplayName: Second Color, 				FieldType: Color, 	DefaultValue: 0xFFFFFFFF, 								Description: Button Second gradient color
#DesignerProperty: Key: ThirdColor, 			DisplayName: Third Color, 				FieldType: Color, 	DefaultValue: 0xFFFFFFFF, 								Description: Button Third gradient color
#DesignerProperty: Key: OrientationColor, 		DisplayName: Orientation Color,			FieldType: String, 	DefaultValue: TopBottom, List:TopBottom|LeftRight|TopLeft_BottomRight|TopRight_BottomLeft, 				Description: Show button color orientation

#DesignerProperty: Key: IconAppearance, 		DisplayName: Icon Appearance,			FieldType: String, 	DefaultValue: None, List:None|Left|Right|Both, 			Description: Show icon appearance
#DesignerProperty: Key: IconTypeFace, 			DisplayName: Icon TypeFace, 			FieldType: String, 	DefaultValue: Material, List:Material|FontAwewome, 		Description: Icon TypeFace
#DesignerProperty: Key: IconLeft, 				DisplayName: Icon Left, 				FieldType: String, 	DefaultValue: Chr(0xE859), 								Description: Ripple effect width
#DesignerProperty: Key: IconLeftColor, 			DisplayName: Icon Left Color, 			FieldType: Color, 	DefaultValue: 0xFFFFFFFF, 								Description: Set left icon color
#DesignerProperty: Key: IconLeftSize, 			DisplayName: Icon Left Size, 			FieldType: Int, 	DefaultValue: 26, 										Description: Set left icon size
#DesignerProperty: Key: IconRight, 				DisplayName: Icon Right, 				FieldType: String, 	DefaultValue: Chr(0xE859), 								Description: Ripple effect width
#DesignerProperty: Key: IconRightColor, 		DisplayName: Icon Right Color, 			FieldType: Color, 	DefaultValue: 0xFFFFFFFF, 								Description: Set right icon color
#DesignerProperty: Key: IconRightSize, 			DisplayName: Icon Right Size, 			FieldType: Int, 	DefaultValue: 26, 										Description: Set right icon size
#DesignerProperty: Key: ShowDivider, 			DisplayName: Show Divider, 				FieldType: Boolean, DefaultValue: False, 									Description: Show button divider

#DesignerProperty: Key: TextSize, 				DisplayName: Text Size, 				FieldType: Int, 	DefaultValue: 14, 										Description: Text size
#DesignerProperty: Key: TextColor, 				DisplayName: Text Color, 				FieldType: Color, 	DefaultValue: 0xFFFFFFFF, 								Description: Text color
#DesignerProperty: Key: TextPadding, 			DisplayName: Text Padding, 				FieldType: Int, 	DefaultValue: 5, 										Description: Text padding
#DesignerProperty: Key: HorizontalAlignment,	DisplayName: Horizontal Alignment,		FieldType: String, 	DefaultValue: Center, List:Left|Center|Right, 			Description: Text horizontal alignment
#DesignerProperty: Key: VerticalAlignment, 		DisplayName: Vertical Alignment,		FieldType: String, 	DefaultValue: Center, List:Top|Center|Bottom, 			Description: Text vertical alignment

#DesignerProperty: Key: RippleColor, 			DisplayName: Ripple Color, 				FieldType: Color, 	DefaultValue: 0xAF000000, 								Description: Set Ripple color effect when bitton clicked or mouse up
#DesignerProperty: Key: RippleWidth, 			DisplayName: Ripple Width, 				FieldType: String, 	DefaultValue: Medium, List:Wide|Medium|Short,			Description: Ripple effect width
#DesignerProperty: Key: WaterEffect, 			DisplayName: Water Effect, 				FieldType: Boolean, DefaultValue: True, 									Description: Show water effect when button swiped
#DesignerProperty: Key: WaterEffectColor, 		DisplayName: Water Effect Color, 		FieldType: Color, 	DefaultValue: 0xFFFFFFFF, 								Description: Set Ripple water effect color when button swiped

#DesignerProperty: Key: PressEffect, 			DisplayName: Press Effect, 				FieldType: Boolean, DefaultValue: True, 									Description: Show button press effect when clicked

#Event: Click

'-- Author: rraswisak
'-- Version: 0.1 (20200726)
 

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private rbShowBorder, rbShowDivider, rbWaterEffect, rbPressEffect As Boolean
	Private rbBorderColor, rbFirstColor, rbSecondColor, rbThirdColor, rbIconLeftColor, rbIconRightColor, rbTextColor, rbRippleColor, rbWaterEffectColor As Int
	Private rbBorderWidth, rbTextPadding, rbRoundedRadius, rbIconLeftSize, rbIconRightSize As Int
	Private rbTextSize As Float
	Private rbAppearance, rbOrientationColor, rbIconAppearance, rbIconTypeFace, rbIconLeft, rbIconRight, rbHorizontalAlignment, rbVerticalAlignment, rbRippleWidth As String

	Private cvs As B4XCanvas
	Private LabelText, LabelIconLeft, LabelIconRight As B4XView
	Private icoWidth As Int

	Private FrameBtn As B4XView
	Private FrameView As B4XView
	Private FrameBmp As B4XBitmap
	Private FrameImg As ImageView 'Required for B4J Only
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me

	rbShowBorder 			= Props.Get("ShowBorder")
	rbShowDivider			= Props.Get("ShowDivider")
	rbWaterEffect			= Props.Get("WaterEffect")
	rbPressEffect			= Props.Get("PressEffect")
	rbBorderColor			= xui.PaintOrColorToColor(Props.Get("BorderColor"))
	rbFirstColor			= xui.PaintOrColorToColor(Props.Get("FirstColor"))
	rbSecondColor			= xui.PaintOrColorToColor(Props.Get("SecondColor"))
	rbThirdColor			= xui.PaintOrColorToColor(Props.Get("ThirdColor"))
	rbIconLeftColor			= xui.PaintOrColorToColor(Props.Get("IconLeftColor"))
	rbIconRightColor		= xui.PaintOrColorToColor(Props.Get("IconRightColor"))
	rbTextColor				= xui.PaintOrColorToColor(Props.Get("TextColor"))
	rbRippleColor			= xui.PaintOrColorToColor(Props.Get("RippleColor"))
	rbWaterEffectColor		= xui.PaintOrColorToColor(Props.Get("WaterEffectColor"))
	rbBorderWidth			= DipToCurrent(Props.Get("BorderWidth"))
	rbTextSize				= Props.Get("TextSize")
	rbTextPadding			= DipToCurrent(Props.Get("TextPadding"))
	rbRoundedRadius			= DipToCurrent(Props.Get("RoundedRadius"))
	rbAppearance			= Props.Get("Appearance")
	rbOrientationColor		= Props.Get("OrientationColor")
	rbIconAppearance		= Props.Get("IconAppearance")
	rbIconTypeFace			= Props.Get("IconTypeFace")
	rbIconLeft				= Props.Get("IconLeft")
	rbIconLeftSize			= Props.Get("IconLeftSize")
	rbIconRight				= Props.Get("IconRight")
	rbIconRightSize			= Props.Get("IconRightSize")
	rbHorizontalAlignment	= Props.Get("HorizontalAlignment")
	rbVerticalAlignment		= Props.Get("VerticalAlignment")
	rbRippleWidth			= Props.Get("RippleWidth")
	
	If mBase.Height > 60 Then icoWidth = 60dip Else icoWidth = mBase.Height
	LabelText = Lbl
	
	Dim lblIconLeft, lblIconRight As Label
	lblIconLeft.Initialize("")
	lblIconRight.Initialize("")
	
	LabelIconLeft=lblIconLeft
	If rbIconTypeFace = "Material" Then
		LabelIconLeft.Font = xui.CreateMaterialIcons(rbTextSize)
	Else
		LabelIconLeft.Font = xui.CreateFontAwesome(rbTextSize)
	End If
	
	Dim f As Int
	f = Bit.ParseInt(rbIconLeft.Replace("Chr(0x","").Replace(")",""),16)
	LabelIconLeft.Text = Chr(f)
	LabelIconLeft.TextColor = rbIconLeftColor
	mBase.AddView(LabelIconLeft,0,0,icoWidth,mBase.Height)
	
	LabelIconRight=lblIconRight
	If rbIconTypeFace = "Material" Then
		LabelIconRight.Font = xui.CreateMaterialIcons(rbTextSize)
	Else
		LabelIconRight.Font = xui.CreateFontAwesome(rbTextSize)
	End If
	f = Bit.ParseInt(rbIconRight.Replace("Chr(0x","").Replace(")",""),16)
	LabelIconRight.Text = Chr(f)
	LabelIconRight.TextColor = rbIconRightColor
	mBase.AddView(LabelIconRight,mBase.Width-icoWidth,0,icoWidth,mBase.Height)
	
	Select rbIconAppearance
		Case "None"
			LabelIconLeft.Visible=False
			LabelIconRight.Visible=False
			mBase.AddView(LabelText,rbTextPadding,0,mBase.Width-rbTextPadding*2, mBase.Height)
		Case "Left"
			LabelIconRight.Visible=False
			mBase.AddView(LabelText,LabelIconLeft.Width+rbTextPadding,0,mBase.Width-LabelIconLeft.Width-rbTextPadding*2, mBase.Height)
		Case "Right"
			LabelIconLeft.Visible=False
			mBase.AddView(LabelText,rbTextPadding,0,mBase.Width-LabelIconRight.width- rbTextPadding*2, mBase.Height)
		Case "Both"
			'default are visible
			mBase.AddView(LabelText,LabelIconLeft.Width+rbTextPadding,0,mBase.Width-LabelIconRight.width * 2- rbTextPadding*2, mBase.Height)
	End Select

	
	LabelText.TextColor = rbTextColor
	LabelText.Text = Lbl.Text
	#If B4A
	LabelText.TextSize = rbTextSize
	LabelText.SetTextAlignment(rbVerticalAlignment.ToUpperCase,rbHorizontalAlignment.ToUpperCase)
	#Else If B4J
		Dim s As B4XView = LabelText
		s.TextSize = rbTextSize
		s.SetTextAlignment(rbVerticalAlignment.ToUpperCase,rbHorizontalAlignment.ToUpperCase)
	#End If
	LabelIconLeft.TextSize = rbIconLeftSize
	LabelIconRight.TextSize = rbIconRightSize
	
	
	LabelIconLeft.SetTextAlignment("CENTER","CENTER")
	LabelIconRight.SetTextAlignment("CENTER","CENTER")
	
	FrameBtn = xui.CreatePanel("FrameBtn")
	FrameBtn.Color = xui.Color_Transparent
	mBase.AddView(FrameBtn,0,0,mBase.Width,mBase.Height)
	
	FrameImg.Initialize("")
	
	cvs.Initialize(mBase)
	Draw
	CreateFrame
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	cvs.Resize(Width,Height)
	FrameBtn.SetLayoutAnimated(0,0,0,Width,Height)

	LabelIconLeft.SetLayoutAnimated(0,0,0,icoWidth,Height)
	LabelIconRight.SetLayoutAnimated(0,Width-icoWidth,0,icoWidth,Height)
	Select rbIconAppearance
		Case "None"
			LabelText.SetLayoutAnimated(0,rbTextPadding,0,Width-rbTextPadding*2, Height)
		Case "Left"
			LabelText.SetLayoutAnimated(0,LabelIconLeft.Width+rbTextPadding,0,Width-LabelIconLeft.Width-rbTextPadding*2, Height)
		Case "Right"
			LabelText.SetLayoutAnimated(0,rbTextPadding,0,Width-LabelIconRight.width- rbTextPadding*2, Height)
		Case "Both"
			LabelText.SetLayoutAnimated(0,LabelIconLeft.Width+rbTextPadding,0,Width-LabelIconRight.width * 2- rbTextPadding*2, Height)
	End Select

	Draw
	CreateFrame
End Sub

Private Sub FrameView_Touch (Action As Int, X As Float, Y As Float)
	FrameBtn_Touch (Action, X, Y)
End Sub

Private Sub FrameBtn_Touch (Action As Int, X As Float, Y As Float)
	Dim Inside As Boolean = x > 0 And x < mBase.Width And y > 0 And y < mBase.Height
	Select Action
		Case mBase.TOUCH_ACTION_DOWN
			If rbPressEffect = True Then
				mBase.Left = mBase.Left + 1dip
				mBase.Top = mBase.Top + 2dip
				FrameView.Left = mBase.Left
				FrameView.Top = mBase.Top
			End If
		Case mBase.TOUCH_ACTION_UP
			If rbPressEffect = True Then
				mBase.Left = mBase.Left - 1dip
				mBase.Top = mBase.Top - 2dip
				FrameView.Left = mBase.Left
				FrameView.Top = mBase.Top
			End If
			If Inside Then
				DoRipple(X,Y,1500,rbRippleColor)
				CallSubDelayed(mCallBack, mEventName & "_Click")
			End If
		Case mBase.TOUCH_ACTION_MOVE
			If Inside And rbWaterEffect = True Then
				Dim cX As Long = X
				If (cX Mod 5 = 0) Then DoRipple(X,Y,2000,rbWaterEffectColor)
			End If
	End Select
End Sub

Private Sub Draw
	#If B4J
	cvs.RemoveClip
	#End If
	cvs.ClearRect(cvs.TargetRect)
	
	Dim rect As B4XRect
	Dim path As B4XPath
	
	If rbShowBorder = True Then
		path.InitializeRoundedRect(cvs.TargetRect,rbRoundedRadius)
		cvs.ClipPath(path)
		cvs.DrawRect(cvs.TargetRect,rbBorderColor,True,rbBorderWidth)
		cvs.RemoveClip
	Else
		rbBorderWidth = 0
	End If
		
	rect.Initialize(rbBorderWidth,rbBorderWidth,cvs.TargetRect.Width-rbBorderWidth, cvs.TargetRect.Height-rbBorderWidth)
	If rbRoundedRadius > 0 Then
		path.InitializeRoundedRect(rect,rbRoundedRadius - .7 * rbBorderWidth)
	Else
		path.InitializeRoundedRect(rect,0)
	End If
	
	cvs.ClipPath(path)
	
	If rbAppearance = "Solid" Then
		cvs.DrawPath(path,rbFirstColor,True,0)
	Else
		Dim grad As BitmapCreator
		Dim clr2(2), clr3(3) As Int
		clr2(0) = rbFirstColor
		clr2(1) = rbSecondColor
		
		clr3(0) = rbFirstColor
		clr3(1) = rbSecondColor
		clr3(2) = rbThirdColor
		
		grad.Initialize(mBase.Width, mBase.Height)
		Select rbOrientationColor
			Case "TopBottom"
				If rbAppearance="Gradient2Color" Then grad.FillGradient(clr2,grad.TargetRect,"TOP_BOTTOM")
				If rbAppearance="Gradient3Color" Then grad.FillGradient(clr3,grad.TargetRect,"TOP_BOTTOM")
			Case "LeftRight"
				If rbAppearance="Gradient2Color" Then grad.FillGradient(clr2,grad.TargetRect,"LEFT_RIGHT")
				If rbAppearance="Gradient3Color" Then grad.FillGradient(clr3,grad.TargetRect,"LEFT_RIGHT")
			Case "TopLeft_BottomRight"
				If rbAppearance="Gradient2Color" Then grad.FillGradient(clr2,grad.TargetRect,"TL_BR")
				If rbAppearance="Gradient3Color" Then grad.FillGradient(clr3,grad.TargetRect,"TL_BR")
			Case "TopRight_BottomLeft"
				If rbAppearance="Gradient2Color" Then grad.FillGradient(clr2,grad.TargetRect,"TR_BL")
				If rbAppearance="Gradient3Color" Then grad.FillGradient(clr3,grad.TargetRect,"TR_BL")
		End Select

		Dim Bruss As BCBrush = grad.CreateBrushFromBitmapCreator(grad)
		Dim bc As BitmapCreator
		bc.Initialize(mBase.Width, mBase.Height)
		bc.DrawRectRounded2(bc.TargetRect,Bruss,True,0,rbRoundedRadius)
		rect.Initialize(0,0,mBase.Width, mBase.Height)
		cvs.DrawBitmap(bc.Bitmap,rect)
	End If
	
	If rbShowDivider = True And rbIconAppearance <> "None" Then
		If rbIconAppearance = "Left" Or rbIconAppearance = "Both" Then
			If rbShowBorder Then
				cvs.DrawLine(icoWidth,0,icoWidth,mBase.Height,rbBorderColor,rbBorderWidth)
			Else
				cvs.DrawLine(icoWidth,0,icoWidth,mBase.Height,xui.Color_LightGray,2dip)
			End If
		End If
		If rbIconAppearance = "Right" Or rbIconAppearance = "Both" Then
			If rbShowBorder Then
				cvs.DrawLine(mBase.Width -icoWidth,0,mBase.Width - icoWidth,mBase.Height,rbBorderColor,rbBorderWidth)
			Else
				cvs.DrawLine(mBase.Width - icoWidth,0,mBase.Width - icoWidth,mBase.Height,xui.Color_LightGray,2dip)
			End If
		End If
	End If
	
	cvs.Invalidate
End Sub

Private Sub CreateFrame
	If FrameView.IsInitialized = True Then 
		FrameView.RemoveViewFromParent
		#if B4J
		FrameImg.SetImage(Null)
		#End If
	End If
	FrameView = xui.CreatePanel("FrameView")
	FrameView.AddView(FrameImg,0,0,FrameView.Width,FrameView.Height)
	mBase.Parent.AddView(FrameView,mBase.Left,mBase.Top,mBase.Width,mBase.Height)

	FrameImg.SetLayoutAnimated(0,0,0,FrameView.Width, FrameView.Height)

	FrameBmp = mBase.Parent.Snapshot.Crop(mBase.Left,mBase.Top,mBase.Width,mBase.Height)
	
	#If B4A
	FrameView.SetBitmap(FrameBmp)
	
	Dim c As B4XCanvas
	c.Initialize(FrameView)
				
	Dim rect As B4XRect
	Dim path As B4XPath
				
	rect.Initialize(0,0,c.TargetRect.Width, c.TargetRect.Height)
	path.InitializeRoundedRect(rect,DipToCurrent(rbRoundedRadius))
	c.ClipPath(path)
	c.ClearRect(rect)
	c.Invalidate
	FrameView.SetBitmap(c.CreateBitmap)
	c.Release	
	#Else If B4J
	Dim bc As BitmapCreator
	bc.Initialize(FrameView.Width, FrameView.Height)
	bc.CopyPixelsFromBitmap(FrameBmp)
	bc.DrawRectRounded(bc.TargetRect,xui.Color_ARGB(1,0,0,0),True,0,rbRoundedRadius)
	bc.SetBitmapToImageView(bc.Bitmap,FrameImg)
	#End If
End Sub

Private Sub DoRipple(X As Float, Y As Float, duration As Int,clr As Int)
	Dim radius As Int
	If rbRippleWidth = "Wide" Then radius = mBase.Width
	If rbRippleWidth = "Medium" Then radius = mBase.Width * .75
	If rbRippleWidth = "Short" Then radius = mBase.Width * .50
	
	Dim p As B4XView = xui.CreatePanel("")
	p.SetColorAndBorder(clr,0,0,radius)
	#If B4A
	mBase.AddView(p,X, Y,0,0)
	#Else If B4J
	FrameBtn.AddView(p,x,y,0,0)
	#End If
	p.SetLayoutAnimated(duration,x-radius, y-radius,2 * radius, 2 * radius)
	p.SetVisibleAnimated(duration,False)
	Sleep(duration)
	p.RemoveViewFromParent
End Sub

Public Sub SetText(Text As String)
	LabelText.Text = Text
End Sub