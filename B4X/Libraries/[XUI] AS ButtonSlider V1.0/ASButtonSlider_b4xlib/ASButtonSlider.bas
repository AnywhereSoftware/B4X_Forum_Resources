B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7
@EndOfDesignText@
'Author: Alexander Stolte
'Version: 1.01

#If Dociumentation
Updates:
V1.0
	-Release
V1.01
	-Over Dragging from the slider is now impossible

#End If

#DesignerProperty: Key: ButtonOrientation, DisplayName: Button Orientation, FieldType: String, DefaultValue: Horizontal, List: Vertical|Horizontal
#DesignerProperty: Key: LeftTopColor, DisplayName: LeftTop Color, FieldType: Color, DefaultValue: 0xFF4962A4, Description: Placeholder
#DesignerProperty: Key: RightBottomColor, DisplayName: RightBottom Color, FieldType: Color, DefaultValue: 0xFF8D44AD, Description: Placeholder
#DesignerProperty: Key: SliderButtonColor, DisplayName: Slider Button Color, FieldType: Color, DefaultValue: 0xFF2A3137, Description: Placeholder

#Event: DropSlider (LeftTop As Boolean)
#Event: ReachedLeftTop
#Event: ReachedRightBottom
#Event: LeftTopClick
#Event: RightBottomClick

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	
	Private xpnl_leftside,xpnl_rightside,xpnl_slidebutton As B4XView
	Private tmp_xpnl_leftside,tmp_xpnl_rightside As B4XView
	
	Private donwx,downy As Int
	
	Private bReachedLeftTop,bReachedRightBottom As Boolean = False
	
	'Properties
	Private xButtonOrientation As String
	Private xLeftTopColor,xRightBottomColor,xSliderButtonColor As Int
	
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
  	
	ini_props(Props)
	
	#If B4A
	
	Base_Resize(mBase.Width,mBase.Height)
	
	#End If
	
End Sub

#Region UserProperties

Public Sub getButtonOrientation As String
	
	Return xButtonOrientation
	
End Sub

Public Sub setButtonOrientation(Orientation As String)
	
	If Orientation = "Horizontal" Or Orientation = "Vertical" Then
		
		xButtonOrientation = Orientation
		
		Else
			
		xButtonOrientation = "Horizontal"
		
	End If
	
End Sub

Public Sub getBUTTONORIENTATION_HORIZONTAL As String
	
	Return "Horizontal"
	
End Sub

Public Sub getBUTTONORIENTATION_VERTICAL As String
	
	Return "Vertical"
	
End Sub

Public Sub getLeftTopColor As Int
	
	Return xLeftTopColor
	
End Sub

Public Sub setLeftTopColor(Color As Int)
	
	xLeftTopColor = Color
	Base_Resize(mBase.Width,mBase.Height)
	
End Sub

Public Sub getRightBottomColor As Int
	
	Return xRightBottomColor
	
End Sub

Public Sub setRightBottomColor(Color As Int)
	
	xRightBottomColor = Color
	Base_Resize(mBase.Width,mBase.Height)
	
End Sub

Public Sub getSliderButtonColor As Int
	
	Return xSliderButtonColor
	
End Sub

Public Sub setSliderButtonColor(Color As Int)
	
	xSliderButtonColor = Color
	Base_Resize(mBase.Width,mBase.Height)
	
End Sub

'Gets the LeftTop Panel to add a label for Text
Public Sub getLeftTopPnl As B4XView
	
	Return xpnl_leftside
	
End Sub

'Gets the RightBottom Panel to add a label for Text
Public Sub getRightBottomPnl As B4XView
	
	Return xpnl_rightside
	
End Sub

'Gets the SliderButton Panel to add a label for Text
Public Sub getSliderButtonPnl As B4XView
	
	Return xpnl_slidebutton
	
End Sub

#End Region

Private Sub ini_props(Props As Map)
	
	xButtonOrientation = Props.Get("ButtonOrientation")
	xLeftTopColor = xui.PaintOrColorToColor(Props.Get("LeftTopColor"))
	xRightBottomColor = xui.PaintOrColorToColor( Props.Get("RightBottomColor"))
	xSliderButtonColor = xui.PaintOrColorToColor( Props.Get("SliderButtonColor"))
	
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
	If xpnl_leftside.IsInitialized = False Then
		
		ini_views
		
	End If
  
	If xButtonOrientation = "Horizontal" Then xpnl_leftside.SetLayoutAnimated(0,0,0,Width/2,Height) Else xpnl_leftside.SetLayoutAnimated(0,0,0,Width,Height/2)
	If xButtonOrientation = "Horizontal" Then xpnl_rightside.SetLayoutAnimated(0,Width/2,0,Width/2,Height) Else xpnl_rightside.SetLayoutAnimated(0,0,Height/2,Width,Height/2)
  	If xButtonOrientation = "Horizontal" Then xpnl_slidebutton.SetLayoutAnimated(0,Width/2 - Height/2,0,Height,Height) Else xpnl_slidebutton.SetLayoutAnimated(0,0,Height/2 - Width/2,Width,Width)
  	'trick17
	If xButtonOrientation = "Horizontal" Then tmp_xpnl_leftside.SetLayoutAnimated(0,Width/2 - (Width/3)/2,0,Width/3,Height) Else tmp_xpnl_leftside.SetLayoutAnimated(0,0,Height/2 - (Height/3)/2,Width,Height/3)
	If xButtonOrientation = "Horizontal" Then tmp_xpnl_rightside.SetLayoutAnimated(0,Width/2,0,Width/3,Height) Else tmp_xpnl_rightside.SetLayoutAnimated(0,0,Height/2,Width,Height/3)
	
	xpnl_leftside.SetColorAndBorder(xLeftTopColor,0,xui.Color_Transparent,mBase.Height/2)
	xpnl_rightside.SetColorAndBorder(xRightBottomColor,0,xui.Color_Transparent,mBase.Height/2)
	xpnl_slidebutton.SetColorAndBorder(xSliderButtonColor,0,xui.Color_Transparent,mBase.Height/2)
  	tmp_xpnl_leftside.Color = xLeftTopColor
	tmp_xpnl_rightside.Color = xRightBottomColor
  
End Sub

Private Sub ini_views
	
	xpnl_leftside = xui.CreatePanel("xpnl_leftside")
	xpnl_rightside = xui.CreatePanel("xpnl_rightside")
	xpnl_slidebutton = xui.CreatePanel("xpnl_slidebutton")
	
	tmp_xpnl_leftside = xui.CreatePanel("")
	tmp_xpnl_rightside = xui.CreatePanel("")
	
		#If B4A

	Private r As Reflector
	r.Target = xpnl_slidebutton
	r.SetOnTouchListener("xpnl_slidebutton_Touch2")
#End If
	
	mBase.AddView(tmp_xpnl_leftside,0,0,0,0)
	mBase.AddView(tmp_xpnl_rightside,0,0,0,0)
	
	mBase.AddView(xpnl_leftside,0,0,0,0)
	mBase.AddView(xpnl_rightside,0,0,0,0)
	mBase.AddView(xpnl_slidebutton,0,0,0,0)
	
End Sub

#If B4J

Private Sub xpnl_leftside_MouseClicked (EventData As MouseEvent)
	
	LeftTopClick
	
End Sub

Private Sub xpnl_rightside_MouseClicked (EventData As MouseEvent)
	
	RightBottomClick
	
End Sub

#Else

Private Sub xpnl_leftside_Click
	LeftTopClick
End Sub

Private Sub xpnl_rightside_Click
	RightBottomClick
End Sub


#End if

#IF B4A
Private Sub xpnl_slidebutton_Touch2 (o As Object, ACTION As Int, x As Float, y As Float, motion As Object) As Boolean
#ELSE 
Private Sub xpnl_slidebutton_Touch(Action As Int, X As Float, Y As Float) As Boolean
#END IF

	If xButtonOrientation = "Horizontal" Then
		
		If ACTION = xpnl_slidebutton.TOUCH_ACTION_DOWN Then
	
			donwx = X 
		
		Else if ACTION = xpnl_slidebutton.TOUCH_ACTION_MOVE Then
	
			If xpnl_slidebutton.Left + x - donwx + xpnl_slidebutton.Width < mBase.Width Then				
				xpnl_slidebutton.Left = Max(0,xpnl_slidebutton.Left + x - donwx)				
			Else		
				xpnl_slidebutton.Left = Min(mBase.Width - xpnl_slidebutton.Width,xpnl_slidebutton.Left + x - donwx + xpnl_slidebutton.Width)
			End If
	
			If xpnl_slidebutton.Left = 0 Then
			
				If bReachedLeftTop = False Then	ReachedLeftTop
				bReachedLeftTop = True
				
			Else if xpnl_slidebutton.Left + xpnl_slidebutton.Width = mBase.Width Then
					
				If bReachedRightBottom = False Then	ReachedRightBottom
				bReachedRightBottom = True
					
			End If
	
		else If xpnl_slidebutton.TOUCH_ACTION_UP = ACTION Then
	
			If xpnl_slidebutton.Left + xpnl_slidebutton.Width/2 < mBase.Width/2 Then DropSlider(True) Else DropSlider(False)
	
			xpnl_slidebutton.SetLayoutAnimated(0,mBase.Width/2 - mBase.Height/2,0,mBase.Height,mBase.Height)
	
			bReachedLeftTop = False
			bReachedRightBottom = False
	
		End If
		
		
	Else
			
		If ACTION = xpnl_slidebutton.TOUCH_ACTION_DOWN Then
	
			downy  = y
		
		Else if ACTION = xpnl_slidebutton.TOUCH_ACTION_MOVE Then
			
				If xpnl_slidebutton.Top + y - downy + xpnl_slidebutton.Height < mBase.Height Then
				xpnl_slidebutton.Top = Max(0,xpnl_slidebutton.Top + y - downy)
			Else			
				xpnl_slidebutton.Top = Min(mBase.Height - xpnl_slidebutton.Height,xpnl_slidebutton.Top + y - downy + xpnl_slidebutton.Height)
			End If
	
			If xpnl_slidebutton.Top = 0 Then
			
				If bReachedLeftTop = False Then	ReachedLeftTop
				bReachedLeftTop = True
				
			Else if xpnl_slidebutton.Top + xpnl_slidebutton.Height = mBase.Height Then
					
				If bReachedRightBottom = False Then	ReachedRightBottom
				bReachedRightBottom = True
					
			End If
	
		else If xpnl_slidebutton.TOUCH_ACTION_UP = ACTION Then
	
			If xpnl_slidebutton.Top + xpnl_slidebutton.Height/2 < mBase.Height/2 Then DropSlider(True) Else DropSlider(False)

			

			xpnl_slidebutton.SetLayoutAnimated(0,0,mBase.Height/2 - mBase.Width/2,mBase.Width,mBase.Width)
	
			bReachedLeftTop = False
			bReachedRightBottom = False
	
		End If
			
	End If

	
	
	Return True
	
End Sub

#Region Events

Private Sub DropSlider(LeftTop As Boolean)
	
	If xui.SubExists(mCallBack, mEventName & "_DropSlider",0) Then
		CallSub2(mCallBack, mEventName & "_DropSlider",LeftTop)
	End If
	
End Sub

Private Sub ReachedLeftTop
	
	If xui.SubExists(mCallBack, mEventName & "_ReachedLeftTop",0) Then
		CallSub(mCallBack, mEventName & "_ReachedLeftTop")
	End If
	
End Sub

Private Sub ReachedRightBottom
	
	If xui.SubExists(mCallBack, mEventName & "_ReachedRightBottom",0) Then
		CallSub(mCallBack, mEventName & "_ReachedRightBottom")
	End If
	
End Sub

Private Sub LeftTopClick
	
	If xui.SubExists(mCallBack, mEventName & "_LeftTopClick",0) Then
		CallSub(mCallBack, mEventName & "_LeftTopClick")
	End If
	
End Sub

Private Sub RightBottomClick
	
	If xui.SubExists(mCallBack, mEventName & "_RightBottomClick",0) Then
		CallSub(mCallBack, mEventName & "_RightBottomClick")
	End If
	
End Sub

#End Region

#Region UsedFunctions

''https://www.b4x.com/android/forum/threads/b4x-xui-simple-halo-animation.80267/
'Private Sub CreateHaloEffect (Parent As B4XView, x As Int, y As Int, clr As Int)
'	Dim cvs As B4XCanvas
'	Dim p As B4XView = xui.CreatePanel("")
'	Dim radius As Int = 150dip
'	p.SetLayoutAnimated(0, 0, 0, radius * 2, radius * 2)
'	cvs.Initialize(p)
'	cvs.DrawCircle(cvs.TargetRect.CenterX, cvs.TargetRect.CenterY, cvs.TargetRect.Width / 2, clr, True, 0)
'	Dim bmp As B4XBitmap = cvs.CreateBitmap
'	For i = 1 To 1
'		CreateHaloEffectHelper(Parent,bmp, x, y, clr, radius)
'		Sleep(800)
'	Next
'End Sub
'
'Private Sub CreateHaloEffectHelper (Parent As B4XView,bmp As B4XBitmap, x As Int, y As Int, clr As Int, radius As Int)
'	Dim iv As ImageView
'	iv.Initialize("")
'	Dim p As B4XView = iv
'	p.SetBitmap(bmp)
'	Parent.AddView(p, x, y, 0, 0)
'	Dim duration As Int = 1000
'	p.SetLayoutAnimated(duration, x - radius, y - radius, 2 * radius, 2 * radius)
'	p.SetVisibleAnimated(duration, False)
'	Sleep(duration)
'	p.RemoveViewFromParent
'End Sub

#End Region

