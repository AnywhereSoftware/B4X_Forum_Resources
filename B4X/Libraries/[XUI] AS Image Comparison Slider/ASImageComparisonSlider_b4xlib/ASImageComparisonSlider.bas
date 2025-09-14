B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
'Author: Alexander Stolte
'V1.0

#If Documentation
Changelog:
V1.00
	-Release
V1.01
	-New Designer Property ButtonColor
		-Default: White
	-New Designer Property ButtonTextColor
		-Default: Black
	-New SliderPositionChanged Event
	-New get and set SliderPosition
#End If

#DesignerProperty: Key: ButtonColor, DisplayName: ButtonColor, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: ButtonTextColor, DisplayName: ButtonTextColor, FieldType: Color, DefaultValue: 0xFF000000

#DesignerProperty: Key: ShowDescription, DisplayName: Show Description, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: DescriptionLeft, DisplayName: Description Left, FieldType: String, DefaultValue: Modified
#DesignerProperty: Key: DescriptionRight, DisplayName: Description Right, FieldType: String, DefaultValue: Original
#DesignerProperty: Key: SliderStayOnLastPosition, DisplayName: Slider Stay On Last Position, FieldType: Boolean, DefaultValue: True

#Event: SliderPositionChanged(x As Int)

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	
	'Views
	Private xlbl_Description1,xlbl_Description2 As B4XView
	Private xpnl_Sliderbackground,xlbl_Slider As B4XView
	
	Private downx As Float
			
	Private xbmp_1,xbmp_2 As B4XBitmap
	Dim xcv_Main As B4XCanvas
	
	'Properties
	Private m_ShowDescription As Boolean
	Private m_DescriptionLeft,m_DescriptionRight As String
	Private m_SliderStayOnLastPosition As Boolean
	
	Private m_ButtonColor As Int
	Private m_ButtonTextColor As Int
	Private m_LastSliderPosition As Int = 0
	
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base

		ini_props(Props)
		ini_views

#if B4A
	Base_Resize(mBase.Width,mBase.Height)
	
	Private r As Reflector
	r.Target = xpnl_sliderbackground
	r.SetOnTouchListener("xpnl_sliderbackground_Touch2")
	
#End If

End Sub

Private Sub ini_props(props As Map)
	m_ShowDescription = props.Get("ShowDescription")
	m_DescriptionLeft = props.Get("DescriptionLeft")
	m_DescriptionRight = props.Get("DescriptionRight")
	m_SliderStayOnLastPosition = props.Get("SliderStayOnLastPosition")
	
	m_ButtonColor = xui.PaintOrColorToColor(props.GetDefault("ButtonColor",xui.Color_White))
	m_ButtonTextColor = xui.PaintOrColorToColor(props.GetDefault("ButtonTextColor",xui.Color_Black))
	
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
	xcv_Main.Resize(Width,Height)
	
	xpnl_Sliderbackground.SetLayoutAnimated(0,Width/2 - 40dip/2,Height/2 - 40dip/2,40dip,40dip)
	xlbl_Slider.SetLayoutAnimated(0,0,0,xpnl_Sliderbackground.Width,xpnl_Sliderbackground.Height)
	If xbmp_1.IsInitialized = True And xbmp_2.IsInitialized = True Then SlideImages(xpnl_Sliderbackground.Left + xpnl_Sliderbackground.Width/2)
	
	xlbl_Description1.Visible = m_ShowDescription
	xlbl_Description2.Visible = m_ShowDescription
	
	xlbl_Description1.SetLayoutAnimated(0,0,Height - 16dip,Width/2,16dip)
	xlbl_Description2.SetLayoutAnimated(0,Width/2,Height - 16dip,Width/2,16dip)

End Sub

Private Sub ini_views
	
	xlbl_Description1 = CreateLabel("")
	xlbl_Description2 = CreateLabel("")
	
	xpnl_Sliderbackground = xui.CreatePanel("xpnl_sliderbackground")
	xlbl_Slider = CreateLabel("")
	
	mBase.AddView(xlbl_Description1,0,0,0,0)
	mBase.AddView(xlbl_Description2,0,0,0,0)
	
	mBase.AddView(xpnl_Sliderbackground,0,0,0,0)
	xpnl_Sliderbackground.AddView(xlbl_Slider,0,0,40dip,40dip)
	
	xcv_Main.Initialize(mBase)
	
	
	xlbl_Description1.Text = m_DescriptionLeft
	xlbl_Description2.Text = m_DescriptionRight
	
	xlbl_Description1.Font = xui.CreateDefaultBoldFont(12)
	xlbl_Description2.Font = xui.CreateDefaultBoldFont(12)
	
	xlbl_Description1.TextColor = xui.Color_White
	xlbl_Description2.TextColor = xui.Color_White
  
	xlbl_Description1.SetTextAlignment("CENTER","LEFT")
	xlbl_Description2.SetTextAlignment("CENTER","RIGHT")
	
	xlbl_Slider.SetColorAndBorder(m_ButtonColor,0,0,xlbl_Slider.Height/2)
	xlbl_Slider.Font = xui.CreateMaterialIcons(20)
	xlbl_Slider.SetTextAlignment("CENTER","CENTER")
	xlbl_Slider.TextColor = m_ButtonTextColor
	xlbl_Slider.Text = Chr(0xE86F)
	
End Sub

#Region Properties

Public Sub getImage1 As B4XView
	Return xbmp_1
End Sub

Public Sub getImage2 As B4XView
	Return xbmp_2
End Sub

Public Sub getSliderPanel As B4XView
	Return xpnl_Sliderbackground
End Sub

Public Sub getSliderLabel As B4XView
	Return xlbl_Slider
End Sub

Public Sub getDescriptionLabel_Right As B4XView
	Return xlbl_Description2
End Sub

Public Sub getDescriptionLabel_Left As B4XView
	Return xlbl_Description1
End Sub

Public Sub SetImages(img1 As B4XBitmap,img2 As B4XBitmap)
	xbmp_1 = img1'.Resize(mBase.Width,mBase.Height,True)
	xbmp_2 = img2'.Resize(mBase.Width,mBase.Height,True)

	SlideImages(xpnl_Sliderbackground.Left + xpnl_Sliderbackground.Width/2)
	
End Sub

Public Sub getSliderPosition As Int
	Return m_LastSliderPosition
End Sub

Public Sub setSliderPosition(x As Int)
	SlideImages(x)
End Sub

#End Region

#Region Events

Private Sub SliderPositionChanged(x As Int)
	If m_LastSliderPosition = x Then Return
	m_LastSliderPosition = x
	If xui.SubExists(mCallBack, mEventName & "_SliderPositionChanged",1) Then
		CallSub2(mCallBack, mEventName & "_SliderPositionChanged",x)
	End If
End Sub

#End Region

Private Sub SlideImages(size As Float)
	
	Dim tmp_rect_1 As B4XRect
	tmp_rect_1.Initialize(0,0,mBase.Width,mBase.Height)
	
	Dim tmp_rect_2 As B4XRect
	tmp_rect_2.Initialize(size,0,mBase.Width,mBase.Height)

	xcv_Main.DrawBitmap(xbmp_1.Resize(mBase.Width,mBase.Height,False).Crop(0,0,mBase.Width,mBase.Height),tmp_rect_1)
	xcv_Main.DrawBitmap(xbmp_2.Resize(mBase.Width,mBase.Height,False).Crop(size,0,mBase.Width - size,mBase.Height),tmp_rect_2)
	xcv_Main.Invalidate
	SliderPositionChanged(size)
End Sub

#IF B4A
Private Sub xpnl_sliderbackground_Touch2 (o As Object, ACTION As Int, x As Float, y As Float, motion As Object) As Boolean
#ELSE
Private Sub xpnl_sliderbackground_Touch(Action As Int, X As Float, Y As Float) As Boolean
#END IF
	If Action = xpnl_Sliderbackground.TOUCH_ACTION_DOWN Then

		downx  = x
    
	Else if Action = xpnl_Sliderbackground.TOUCH_ACTION_MOVE Then
    
		If xpnl_Sliderbackground.Left + x - downx + xpnl_Sliderbackground.Width < mBase.Width Then
		xpnl_Sliderbackground.Left = Max(0,xpnl_Sliderbackground.Left + x - downx)
		Else
			xpnl_Sliderbackground.Left = Min(mBase.Width - xpnl_Sliderbackground.Width,xpnl_Sliderbackground.Left + x - downx + xpnl_Sliderbackground.Width)
		End If
		
	Else if Action = xpnl_Sliderbackground.TOUCH_ACTION_UP Then
    
		If m_SliderStayOnLastPosition = False Then	
			xpnl_Sliderbackground.SetLayoutAnimated(250,mBase.Width/2 - xpnl_Sliderbackground.Width/2,mBase.Height/2 - xlbl_Slider.Height/2,xlbl_Slider.Width,xlbl_Slider.Height)
	'	Else
			'xpnl_sliderbackground.Left = xpnl_sliderbackground.Left + x - downx
		End If
      
	End If
	
	SlideImages(xpnl_Sliderbackground.Left + xpnl_Sliderbackground.Width/2)
	
	Return True
    
End Sub

#Region Functions
Private Sub CreateLabel(EventName As String) As B4XView
	Dim tmp_lbl As Label
	tmp_lbl.Initialize(EventName)
	Return tmp_lbl
End Sub
#End Region