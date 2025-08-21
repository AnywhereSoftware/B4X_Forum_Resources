B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.3
@EndOfDesignText@
'Author: Alexander Stolte
'Version: 1.0

'Custom View class 
#DesignerProperty: Key: TypeOfMenu, DisplayName: Menu Type, FieldType: String, DefaultValue: 4 Icon Tabs, List: 4 Icon Tabs|2 Icon Tabs

#DesignerProperty: Key: MiddleButtonVisible, DisplayName: Middle Button Visible, FieldType: Boolean, DefaultValue: True, Description: Hide or Show the middle Button.

#DesignerProperty: Key: SliderColor1, DisplayName: Slider Color 1, FieldType: Color, DefaultValue: 0xFF3498DB, Description: The Color of the Slider 1. The number stands for the page.
#DesignerProperty: Key: SliderColor2, DisplayName: Slider Color 2, FieldType: Color, DefaultValue: 0xFFFF9908, Description: The Color of the Slider 2. The number stands for the page.
#DesignerProperty: Key: SliderColor3, DisplayName: Slider Color 3, FieldType: Color, DefaultValue: 0xFF2ECC71, Description: The Color of the Slider 3. The number stands for the page.
#DesignerProperty: Key: SliderColor4, DisplayName: Slider Color 4, FieldType: Color, DefaultValue: 0xFFFF1493, Description: The Color of the Slider 4. The number stands for the page.

#DesignerProperty: Key: BackgroundColor, DisplayName: Background Color, FieldType: Color, DefaultValue: 0xFF2F343A, Description: The Color of the Background.

#DesignerProperty: Key: PartingLine, DisplayName: Parting Line, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: The Color of the Parting Line on top of the View.

#DesignerProperty: Key: MiddleBackgroundColor, DisplayName: Middle Button Background Color, FieldType: Color, DefaultValue: 0xFF2D8879, Description: The Background Color of the Middle Button.

#DesignerProperty: Key: EnableBadgetColor1, DisplayName: Enable Badget 1, FieldType: Boolean, DefaultValue: False, Description: Enables the Badget.
#DesignerProperty: Key: BadgetColor1, DisplayName: Badget Color 1, FieldType: Color, DefaultValue: 0xFF000000, Description: The Background Color of the 1 Badget. The number stands for the page.
#DesignerProperty: Key: EnableBadgetColor2, DisplayName: Enable Badget 2, FieldType: Boolean, DefaultValue: False, Description: Enables the Badget.
#DesignerProperty: Key: BadgetColor2, DisplayName: Badget Color 2, FieldType: Color, DefaultValue: 0xFF8E44AD, Description: The Background Color of the 2 Badget. The number stands for the page.
#DesignerProperty: Key: EnableBadgetColor3, DisplayName: Enable Badget 3, FieldType: Boolean, DefaultValue: False, Description: Enables the Badget.
#DesignerProperty: Key: BadgetColor3, DisplayName: Badget Color 3, FieldType: Color, DefaultValue: 0xFF4862A3, Description: The Background Color of the 3 Badget. The number stands for the page.
#DesignerProperty: Key: EnableBadgetColor4, DisplayName: Enable Badget 4, FieldType: Boolean, DefaultValue: False, Description: Enables the Badget.
#DesignerProperty: Key: BadgetColor4, DisplayName: Badget Color 4, FieldType: Color, DefaultValue: 0xFF48A34E, Description: The Background Color of the 4 Badget. The number stands for the page.

#DesignerProperty: Key: PageClickColor, DisplayName: Page Click Color, FieldType: Color, DefaultValue: 0xFF7F8C8D, Description: The Color of Halo Effect during Page Click.

#DesignerProperty: Key: EnableSelectedPageColor, DisplayName: Enable Selected Page Color, FieldType: Boolean, DefaultValue: True, Description: If True then the Icon will change the Color on the current Page.
#DesignerProperty: Key: SelectedPageColor, DisplayName: Selected Page Color, FieldType: Color, DefaultValue: 0xFF27AE61, Description: The Color of the Icon of the current Page.


#Event: Page1Click
#Event: Page2Click
#Event: Page3Click
#Event: Page4Click

#Event: MiddleButtonClick
#Event: MiddleButtonLongClick

'noch Hide middle Button Hinzufügen

Sub Class_Globals
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView
	'Private mLbl As B4XView
	Private Const DefaultColorConstant As Int = -984833 'ignore
	
Private currentpage As Int = 1
	
	Private xui As XUI

	Private asbm_page_1,asbm_page_2,asbm_page_3,asbm_page_4 As B4XView
	Private asbm_icon_1,asbm_icon_2,asbm_icon_3,asbm_icon_4 As ImageView
	Private asbm_badget_1,asbm_badget_2,asbm_badget_3,asbm_badget_4 As B4XView
	Private asbm_slider As B4XView
	
	
	
	Private asbm_add_background As B4XView
	
	Private asbm_parting_line As B4XView
	
	Private asbm_page_background As B4XView
	
	Private s_Color1 As Int
	Private s_Color2 As Int
	Private s_Color3 As Int
	Private s_Color4 As Int
	
	Private b_Color As Int	
	
	Private p_Line As Int
	
	Private m_BackgroundColor As Int
	
	Private e_BadgetColor1 As Boolean
	Private e_BadgetColor2 As Boolean
	Private e_BadgetColor3 As Boolean
	Private e_BadgetColor4 As Boolean
	
	Private b_color1 As Int
	Private b_color2 As Int
	Private b_color3 As Int
	Private b_color4 As Int
	
	Private p_ClickColor As Int
	
	Private e_SelectedPageColor As Boolean
	
	Private s_PageColor As Int
	
	Private MiddleButtonVisible As Boolean
	
	Private pnl_asbm_add_icon As ImageView
	
	Private icon1 As B4XBitmap
	Private icon2 As B4XBitmap
	Private icon3 As B4XBitmap
	Private icon4 As B4XBitmap
	
	Private middleicon As B4XBitmap
	
	Private TypeOfMenu As String = "4 Icon Tabs"
	
	Private Mode As Int = 1
	
End Sub

Private Sub IconTabs4(Props As Map)
	

	
	#If B4A or B4I
	Dim pnl_asbm_page_background As Panel
Dim pnl_asbm_parting_line As Panel
	Dim pnl_asbm_add_background As Panel
	#Else If B4J
	Dim pnl_asbm_page_background As Pane
	Dim pnl_asbm_parting_line As Pane
	Dim pnl_asbm_add_background As Pane
	
	#End If
	
	
	
	pnl_asbm_page_background.Initialize("asbm_page_background")
	asbm_page_background = pnl_asbm_page_background
	
	
	
	pnl_asbm_parting_line.Initialize("asbm_parting_line")
	asbm_parting_line = pnl_asbm_parting_line
	
	
	pnl_asbm_add_background.Initialize("asbm_add_background")
	asbm_add_background = pnl_asbm_add_background
	
	
	asbm_add_background.Height = mBase.Height/1.2
	asbm_add_background.Width = mBase.Height/1.2
	
	
	pnl_asbm_add_icon.Initialize("asbm_icon_4")
	
	
	
	#if B4A
		
	pnl_asbm_add_icon.Gravity = Gravity.FILL
	
	#Else If B4I
	
	pnl_asbm_add_icon.ContentMode = pnl_asbm_add_icon.MODE_FILL
	
	
	
	
	#End If
	

	#If B4A or B4I
	
Dim pnl_asbm_page_1 As Panel
	Dim pnl_asbm_page_2 As Panel
	Dim pnl_asbm_page_3 As Panel
		Dim pnl_asbm_page_4 As Panel
	
	#Else If B4J
	Dim pnl_asbm_page_1 As Pane
	Dim pnl_asbm_page_2 As Pane
	Dim pnl_asbm_page_3 As Pane
	Dim pnl_asbm_page_4 As Pane
	
	#End If
	
	
	pnl_asbm_page_1.Initialize("asbm_page_1")
	asbm_page_1 = pnl_asbm_page_1
	
	pnl_asbm_page_2.Initialize("asbm_page_2")
	asbm_page_2 = pnl_asbm_page_2
	
	pnl_asbm_page_3.Initialize("asbm_page_3")
	asbm_page_3 = pnl_asbm_page_3

	pnl_asbm_page_4.Initialize("asbm_page_4")
	asbm_page_4 = pnl_asbm_page_4

	asbm_icon_1.Initialize("asbm_icon_1")
	
	
	
	#if B4A
		
	asbm_icon_1.Gravity = Gravity.FILL
	
	#Else If B4I
	
	asbm_icon_1.ContentMode = asbm_icon_1.MODE_FILL
	
	#End If
	
	
	asbm_icon_2.Initialize("asbm_icon_2")

		#if B4A
		
	asbm_icon_2.Gravity = Gravity.FILL
	
	#Else If B4I
	
	asbm_icon_2.ContentMode = asbm_icon_2.MODE_FILL
	
	#End If
	
	asbm_icon_3.Initialize("asbm_icon_3")
	
		#if B4A
		
	asbm_icon_3.Gravity = Gravity.FILL
	
	#Else If B4I
	
	asbm_icon_3.ContentMode = asbm_icon_3.MODE_FILL
	
	#End If
	
	
	Dim pnl_asbm_icon_4 As ImageView
	pnl_asbm_icon_4.Initialize("asbm_icon_4")
	
	
	#if B4A
		
	pnl_asbm_icon_4.Gravity = Gravity.FILL
	
	#Else If B4I
	
	pnl_asbm_icon_4.ContentMode = pnl_asbm_icon_4.MODE_FILL
	
	#End If
	
	asbm_icon_4 = pnl_asbm_icon_4



#If B4A or B4I

	Dim pnl_asbm_slider As Panel
	

#Else If B4J
	Dim pnl_asbm_slider As Pane
#End If


	pnl_asbm_slider.Initialize("asbm_slider")
	asbm_slider = pnl_asbm_slider


	Dim pnl_asbm_badget_1 As Label
	pnl_asbm_badget_1.Initialize("asbm_badget_1")
	asbm_badget_1 = pnl_asbm_badget_1
	asbm_badget_1.Font = xui.CreateDefaultBoldFont(10)
	asbm_badget_1.TextColor = xui.Color_White
	asbm_badget_1.SetTextAlignment("CENTER","CENTER")
	
	
	Dim pnl_asbm_badget_2 As Label
	pnl_asbm_badget_2.Initialize("asbm_badget_2")
	asbm_badget_2 = pnl_asbm_badget_2
	asbm_badget_2.Font = xui.CreateDefaultBoldFont(10)
	asbm_badget_2.TextColor = xui.Color_White
	asbm_badget_2.SetTextAlignment("CENTER","CENTER")
	
	Dim pnl_asbm_badget_3 As Label
	pnl_asbm_badget_3.Initialize("asbm_badget_3")
	asbm_badget_3 = pnl_asbm_badget_3
	asbm_badget_3.Font = xui.CreateDefaultBoldFont(10)
	asbm_badget_3.TextColor = xui.Color_White
	asbm_badget_3.SetTextAlignment("CENTER","CENTER")
	
	Dim pnl_asbm_badget_4 As Label
	pnl_asbm_badget_4.Initialize("asbm_badget_4")
	asbm_badget_4 = pnl_asbm_badget_4
	asbm_badget_4.Font = xui.CreateDefaultBoldFont(10)
	asbm_badget_4.TextColor = xui.Color_White
	asbm_badget_4.SetTextAlignment("CENTER","CENTER")
	

	s_Color1 = xui.PaintOrColorToColor(Props.Get("SliderColor1"))
	s_Color2 = xui.PaintOrColorToColor(Props.Get("SliderColor2"))
	s_Color3 = xui.PaintOrColorToColor(Props.Get("SliderColor3"))
	s_Color4 = xui.PaintOrColorToColor(Props.Get("SliderColor4"))
	
	b_Color = xui.PaintOrColorToColor(Props.Get("BackgroundColor"))
	
	p_Line = xui.PaintOrColorToColor(Props.Get("PartingLine"))
	
	m_BackgroundColor = xui.PaintOrColorToColor(Props.Get("MiddleBackgroundColor"))
	
	e_BadgetColor1 = Props.Get("EnableBadgetColor1")
	e_BadgetColor2 = Props.Get("EnableBadgetColor2")
	e_BadgetColor3 = Props.Get("EnableBadgetColor3")
	e_BadgetColor4 = Props.Get("EnableBadgetColor4")
	
	b_color1 = xui.PaintOrColorToColor(Props.Get("BadgetColor1"))
	b_color2 = xui.PaintOrColorToColor(Props.Get("BadgetColor2"))
	b_color3 = xui.PaintOrColorToColor(Props.Get("BadgetColor3"))
	b_color4 = xui.PaintOrColorToColor(Props.Get("BadgetColor4"))
	
	p_ClickColor = xui.PaintOrColorToColor(Props.Get("PageClickColor"))
	
	e_SelectedPageColor = Props.Get("EnableSelectedPageColor")
	
	s_PageColor = xui.PaintOrColorToColor(Props.Get("SelectedPageColor"))
	
	MiddleButtonVisible = Props.Get("MiddleButtonVisible")
	
	
	'Pages
	asbm_page_1.Color = b_Color
	asbm_page_2.Color = b_Color
	asbm_page_3.Color = b_Color
	asbm_page_4.Color = b_Color

	'Slider
	asbm_slider.Height = 2dip
	asbm_slider.Width = 40dip
	asbm_slider.SetColorAndBorder(s_Color1,0,xui.Color_Transparent,asbm_slider.Height/2)

	'Parting Line
	asbm_parting_line.Height = 3dip
	asbm_parting_line.Color = p_Line
	
	'Badget
	asbm_badget_1.Width = 18dip
	asbm_badget_1.Height = 18dip
	asbm_badget_1.SetColorAndBorder(b_color1,0dip,xui.Color_White,asbm_badget_1.Height/2)
	asbm_badget_1.Text = 0
	
	
	asbm_badget_2.Width = 18dip
	asbm_badget_2.Height = 18dip
	asbm_badget_2.SetColorAndBorder(b_color2,0dip,xui.Color_White,asbm_badget_2.Height/2)
	asbm_badget_2.Text = 0
	
	asbm_badget_3.Width = 18dip
	asbm_badget_3.Height = 18dip
	asbm_badget_3.SetColorAndBorder(b_color3,0dip,xui.Color_White,asbm_badget_3.Height/2)
	asbm_badget_3.Text = 0
	
	asbm_badget_4.Width = 18dip
	asbm_badget_4.Height = 18dip
	asbm_badget_4.SetColorAndBorder(b_color4,0dip,xui.Color_White,asbm_badget_4.Height/2)
	asbm_badget_4.Text = 0
	
End Sub


Private Sub IconTabs2(Props As Map)
	
	
	#If B4A or B4I
	Dim pnl_asbm_page_background As Panel
	Dim pnl_asbm_parting_line As Panel
		Dim pnl_asbm_add_background As Panel
	#Else If B4J
	Dim pnl_asbm_page_background As Pane
	Dim pnl_asbm_parting_line As Pane
	Dim pnl_asbm_add_background As Pane
	
	
	#End If
	
	
	pnl_asbm_page_background.Initialize("asbm_page_background")
	asbm_page_background = pnl_asbm_page_background
	

	pnl_asbm_parting_line.Initialize("asbm_parting_line")
	asbm_parting_line = pnl_asbm_parting_line

	pnl_asbm_add_background.Initialize("asbm_add_background")
	asbm_add_background = pnl_asbm_add_background
	asbm_add_background.Height = mBase.Height/1.2
	asbm_add_background.Width = mBase.Height/1.2
	
	Dim pnl_asbm_add_icon As ImageView
	pnl_asbm_add_icon.Initialize("asbm_icon_4")
	
	
	#if B4A
		
	pnl_asbm_add_icon.Gravity = Gravity.FILL
	
	#Else If B4I
	
	pnl_asbm_add_icon.ContentMode = pnl_asbm_add_icon.MODE_FILL
	
	#End If
	

	#If B4J
	
	Dim pnl_asbm_page_1 As Pane
	Dim pnl_asbm_page_2 As Pane
	#Else
	
	Dim pnl_asbm_page_1 As Panel
	Dim pnl_asbm_page_2 As Panel
	#End If
	
	
	pnl_asbm_page_1.Initialize("asbm_page_1")
	asbm_page_1 = pnl_asbm_page_1	
	
	pnl_asbm_page_2.Initialize("asbm_page_2")
	asbm_page_2 = pnl_asbm_page_2

	asbm_icon_1.Initialize("asbm_icon_1")
	
		#if B4A
		
	asbm_icon_1.Gravity = Gravity.FILL
	
	#Else If B4I
	
	asbm_icon_1.ContentMode = asbm_icon_1.MODE_FILL
	
	#End If

	asbm_icon_2.Initialize("asbm_icon_2")
	
	#if B4A
	
	asbm_icon_2.Gravity = Gravity.FILL
	
	#Else If B4I
	
	asbm_icon_2.ContentMode = asbm_icon_2.MODE_FILL
	
	#End If

#If B4J
	Dim pnl_asbm_slider As Pane

#Else

Dim pnl_asbm_slider As Panel

#End If

	
	pnl_asbm_slider.Initialize("asbm_slider")
	asbm_slider = pnl_asbm_slider

	Dim pnl_asbm_badget_1 As Label
	pnl_asbm_badget_1.Initialize("asbm_badget_1")
	asbm_badget_1 = pnl_asbm_badget_1
	asbm_badget_1.Font = xui.CreateDefaultBoldFont(10)
	asbm_badget_1.TextColor = xui.Color_White
	asbm_badget_1.SetTextAlignment("CENTER","CENTER")
	

	Dim pnl_asbm_badget_2 As Label
	pnl_asbm_badget_2.Initialize("asbm_badget_2")
	asbm_badget_2 = pnl_asbm_badget_2
	asbm_badget_2.Font = xui.CreateDefaultBoldFont(10)
	asbm_badget_2.TextColor = xui.Color_White
	asbm_badget_2.SetTextAlignment("CENTER","CENTER")

	s_Color1 = xui.PaintOrColorToColor(Props.Get("SliderColor1"))
	s_Color2 = xui.PaintOrColorToColor(Props.Get("SliderColor2"))

	
	b_Color = xui.PaintOrColorToColor(Props.Get("BackgroundColor"))
	
	p_Line = xui.PaintOrColorToColor(Props.Get("PartingLine"))
	
	m_BackgroundColor = xui.PaintOrColorToColor(Props.Get("MiddleBackgroundColor"))
	
	e_BadgetColor1 = Props.Get("EnableBadgetColor1")
	e_BadgetColor2 = Props.Get("EnableBadgetColor2")
	
	
	b_color1 = xui.PaintOrColorToColor(Props.Get("BadgetColor1"))
	b_color2 = xui.PaintOrColorToColor(Props.Get("BadgetColor2"))
	
	
	p_ClickColor = xui.PaintOrColorToColor(Props.Get("PageClickColor"))
	
	e_SelectedPageColor = Props.Get("EnableSelectedPageColor")
	
	s_PageColor = xui.PaintOrColorToColor(Props.Get("SelectedPageColor"))
	
	MiddleButtonVisible = Props.Get("MiddleButtonVisible")
	
	'Pages
	asbm_page_1.Color = b_Color
	asbm_page_2.Color = b_Color
		


	'Slider
	asbm_slider.Height = 2dip
	asbm_slider.Width = 40dip
	asbm_slider.SetColorAndBorder(s_Color1,0,xui.Color_Transparent,asbm_slider.Height/2)
	
	
	
	'Parting Line
	asbm_parting_line.Height = 3dip
	asbm_parting_line.Color = p_Line
	

	'Badget
	asbm_badget_1.Width = 18dip
	asbm_badget_1.Height = 18dip
	asbm_badget_1.SetColorAndBorder(b_color1,0dip,xui.Color_White,asbm_badget_1.Height/2)
	asbm_badget_1.Text = 0
	
	
	asbm_badget_2.Width = 18dip
	asbm_badget_2.Height = 18dip
	asbm_badget_2.SetColorAndBorder(b_color2,0dip,xui.Color_White,asbm_badget_2.Height/2)
	asbm_badget_2.Text = 0
	
End Sub


Public Sub Initialize (CallBack As Object, EventName As String)
	mEventName = EventName
	mCallBack = CallBack
End Sub

Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	'mLbl = Lbl

		mBase.SetLayoutAnimated(0, mBase.Left, mBase.Top,  mBase.Width,  mBase.Height)
	
	
	mBase.Color = xui.Color_Transparent
	
	

	TypeOfMenu =  Props.Get("TypeOfMenu")
	
	If TypeOfMenu = "4 Icon Tabs" Then
		
		Mode = 1
		
		IconTabs4(Props)
	
	
		asbm_page_background.Color = b_Color
	
		mBase.AddView(asbm_page_background,0,mBase.Height/2.5,mBase.Width,mBase.Height)
	
		asbm_page_background.Top = mBase.Height/2.5 'mBase.Height/2.3
		asbm_page_background.Height = mBase.Height - asbm_page_background.Top
	
		mBase.AddView(asbm_parting_line,0,mBase.Height/2.5,mBase.Width,asbm_parting_line.Height)
	
		mBase.AddView(asbm_add_background,mBase.Width / 2 - asbm_add_background.Width /2,0,mBase.Height/1.2,mBase.Height/1.2)
	
	
		asbm_add_background.SetColorAndBorder(m_BackgroundColor,3dip,xui.Color_White,asbm_add_background.Height/2)
	
	
	
		asbm_add_background.AddView(pnl_asbm_add_icon,10dip,10dip,asbm_add_background.Width /2.5,asbm_add_background.Height /2.5)

		pnl_asbm_add_icon.Left = asbm_add_background.Width / 2 - pnl_asbm_add_icon.Width /2
		pnl_asbm_add_icon.Top = asbm_add_background.Height / 2 - pnl_asbm_add_icon.Height / 2

	
		If MiddleButtonVisible = True Then
			
			asbm_page_background.AddView(asbm_page_1,0,3dip,asbm_add_background.left/2,asbm_page_background.Height)
			
			Else
				
			asbm_page_background.AddView(asbm_page_1,0,3dip,asbm_page_background.Width/4,asbm_page_background.Height)
				
		End If
	
		
		If MiddleButtonVisible = True Then
		asbm_page_background.AddView(asbm_page_2,asbm_page_1.Width,3dip,asbm_add_background.left/2,asbm_page_background.Height)
	Else
			asbm_page_background.AddView(asbm_page_2,asbm_page_1.Width,3dip,asbm_page_background.Width/4,asbm_page_background.Height)
		
		End If
	
		asbm_page_4.Width = asbm_page_background.Height + 5dip
	
		
	
		asbm_page_3.Width = asbm_page_background.Height + 5dip
	
		If MiddleButtonVisible = True Then
		asbm_page_background.AddView(asbm_page_3,asbm_add_background.left + asbm_add_background.Width,3dip,asbm_add_background.left/2,asbm_page_background.Height)
		Else
			asbm_page_background.AddView(asbm_page_3,asbm_page_2.left + asbm_page_2.Width,3dip,asbm_page_background.Width/4,asbm_page_background.Height)
			
			End If
		
		If MiddleButtonVisible = True Then
		asbm_page_background.AddView(asbm_page_4,asbm_page_3.Left + asbm_page_3.Width,3dip,asbm_add_background.left/2,asbm_page_background.Height)
		Else
			asbm_page_background.AddView(asbm_page_4,asbm_page_3.Left + asbm_page_3.Width,3dip,asbm_page_background.Width/4,asbm_page_background.Height)
			
			End If
	
		asbm_icon_1.Height = asbm_page_background.Height/2.5
		asbm_icon_1.Width = asbm_page_background.Height/2.5
		
	
		asbm_icon_2.Height = asbm_page_background.Height/2.5
		asbm_icon_2.Width = asbm_page_background.Height/2.5'asbm_icon_2.Height
		
	
		asbm_icon_3.Height = asbm_page_background.Height/2.5
		asbm_icon_3.Width = asbm_page_background.Height/2.5
	
		asbm_icon_4.Height = asbm_page_background.Height/2.5
		asbm_icon_4.Width = asbm_page_background.Height/2.5
	
	
		Dim cx,cy As Int
		cx = asbm_page_1.Left + asbm_page_1.Width/2
		cy = asbm_page_1.Top + asbm_page_1.Height/2.5
	
		asbm_page_1.AddView(asbm_icon_1,5dip,asbm_page_1.Height / 2 - asbm_icon_1.Height / 2,asbm_icon_1.Height,asbm_icon_1.Height)
	
		asbm_icon_1.Left = cx - asbm_icon_1.Width/2
		asbm_icon_1.Top = cy - asbm_icon_1.Height/2
	
	
		asbm_page_2.AddView(asbm_icon_2,5dip,asbm_page_2.Height / 2 - asbm_icon_2.Height / 2,asbm_icon_2.Height,asbm_icon_2.Height)

		asbm_icon_2.Left = cx - asbm_icon_2.Width/2
		asbm_icon_2.Top = cy - asbm_icon_2.Height/2
	
	
		asbm_page_3.AddView(asbm_icon_3,5dip,asbm_page_3.Height / 2 - asbm_icon_3.Height / 2,asbm_icon_3.Height,asbm_icon_3.Height)
	
		asbm_icon_3.Left = cx - asbm_icon_3.Width/2
		asbm_icon_3.Top = cy - asbm_icon_3.Height/2
	
	
		asbm_page_4.AddView(asbm_icon_4,5dip,asbm_page_4.Height / 2 - asbm_icon_4.Height / 2,asbm_icon_4.Height,asbm_icon_4.Height)
	
		asbm_icon_4.Left = cx - asbm_icon_4.Width/2
		asbm_icon_4.Top = cy - asbm_icon_4.Height/2

	
		asbm_page_background.AddView(asbm_slider,asbm_page_1.Width / 2 - asbm_slider.Width /2,asbm_page_background.Height - 12dip,asbm_slider.Width,asbm_slider.Height)
	
		asbm_page_1.AddView(asbm_badget_1,asbm_icon_1.Left + asbm_icon_1.Width +1dip,asbm_icon_1.Top - asbm_badget_1.Height/2,asbm_badget_1.Width,asbm_badget_1.Height)
	
		asbm_page_2.AddView(asbm_badget_2,asbm_icon_1.Left + asbm_icon_1.Width +1dip,asbm_icon_2.Top - asbm_badget_2.Height/2,asbm_badget_2.Width,asbm_badget_2.Height)
	
		asbm_page_3.AddView(asbm_badget_3,asbm_icon_1.Left + asbm_icon_1.Width +1dip,asbm_icon_3.Top - asbm_badget_3.Height/2,asbm_badget_3.Width,asbm_badget_3.Height)
	
		asbm_page_4.AddView(asbm_badget_4,asbm_icon_1.Left + asbm_icon_1.Width +1dip,asbm_icon_4.Top - asbm_badget_4.Height/2,asbm_badget_4.Width,asbm_badget_4.Height)
	
	
	
		asbm_badget_1.Visible = e_BadgetColor1
		asbm_badget_2.Visible = e_BadgetColor2
		asbm_badget_3.Visible = e_BadgetColor3
		asbm_badget_4.Visible = e_BadgetColor4
	
	
	If MiddleButtonVisible = True Then
			asbm_add_background.Visible = True
			asbm_add_background.Enabled = True
		
		Else
			asbm_add_background.Visible = False
			asbm_add_background.Enabled = False
		End If
	
	else If TypeOfMenu = "2 Icon Tabs" Then
		
		Mode = 2
		
		IconTabs2(Props)
	
	
		asbm_page_background.Color = b_Color
	
		mBase.AddView(asbm_page_background,0,mBase.Height/2.5,mBase.Width,mBase.Height)
	
		asbm_page_background.Top = mBase.Height/2.5 'mBase.Height/2.3
		asbm_page_background.Height = mBase.Height - asbm_page_background.Top
	
		mBase.AddView(asbm_parting_line,0,mBase.Height/2.5,mBase.Width,asbm_parting_line.Height)
	
		mBase.AddView(asbm_add_background,mBase.Width / 2 - asbm_add_background.Width /2,0,mBase.Height/1.2,mBase.Height/1.2)
	
	
		asbm_add_background.SetColorAndBorder(m_BackgroundColor,3dip,xui.Color_White,asbm_add_background.Height/2)
	
	
	
		asbm_add_background.AddView(pnl_asbm_add_icon,10dip,10dip,asbm_add_background.Width /2.5,asbm_add_background.Height /2.5)

		pnl_asbm_add_icon.Left = asbm_add_background.Width / 2 - pnl_asbm_add_icon.Width /2
		pnl_asbm_add_icon.Top = asbm_add_background.Height / 2 - pnl_asbm_add_icon.Height / 2

		If MiddleButtonVisible = True Then
		asbm_page_background.AddView(asbm_page_1,0,3dip,asbm_add_background.left,asbm_page_background.Height)
		Else
			
			asbm_page_background.AddView(asbm_page_1,0,3dip,asbm_page_background.Width/2,asbm_page_background.Height)
		
		End If
		
		If MiddleButtonVisible = True Then
		asbm_page_background.AddView(asbm_page_2,asbm_add_background.left + asbm_add_background.Width,3dip,asbm_add_background.left,asbm_page_background.Height)
	Else
		
			asbm_page_background.AddView(asbm_page_2,asbm_page_1.left + asbm_page_1.Width,3dip,asbm_add_background.Width/2,asbm_page_background.Height)
		End If
	
		asbm_icon_1.Height = asbm_page_background.Height/2.2
		asbm_icon_1.Width = asbm_icon_1.Height
	
		asbm_icon_2.Height = asbm_page_background.Height/2.2
		asbm_icon_2.Width = asbm_icon_2.Height
	

		Dim cx,cy As Int
		cx = asbm_page_1.Left + asbm_page_1.Width/2
		cy = asbm_page_1.Top + asbm_page_1.Height/2.3
	
		asbm_page_1.AddView(asbm_icon_1,5dip,asbm_page_1.Height / 2 - asbm_icon_1.Height / 2,asbm_icon_1.Height,asbm_icon_1.Height)
	
		asbm_icon_1.Left = cx - asbm_icon_1.Width/2
		asbm_icon_1.Top = cy - asbm_icon_1.Height/2
	
	
		asbm_page_2.AddView(asbm_icon_2,5dip,asbm_page_2.Height / 2 - asbm_icon_2.Height / 2,asbm_icon_2.Height,asbm_icon_2.Height)

		asbm_icon_2.Left = cx - asbm_icon_2.Width/2
		asbm_icon_2.Top = cy - asbm_icon_2.Height/2
	
	
		
		asbm_page_background.AddView(asbm_slider,asbm_page_1.Width / 2 - asbm_slider.Width /2,asbm_page_background.Height - 12dip,asbm_slider.Width,asbm_slider.Height)
	
		asbm_page_1.AddView(asbm_badget_1,asbm_icon_1.Left + asbm_icon_1.Width +1dip,asbm_icon_1.Top - asbm_badget_1.Height/2,asbm_badget_1.Width,asbm_badget_1.Height)
	
		asbm_page_2.AddView(asbm_badget_2,asbm_icon_1.Left + asbm_icon_1.Width +1dip,asbm_icon_2.Top - asbm_badget_2.Height/2,asbm_badget_2.Width,asbm_badget_2.Height)
	
	
		asbm_badget_1.Visible = e_BadgetColor1
		asbm_badget_2.Visible = e_BadgetColor2
		
	
		If MiddleButtonVisible = True Then
			asbm_add_background.Visible = True
			asbm_add_background.Enabled = True
		
		Else
			asbm_add_background.Visible = False
			asbm_add_background.Enabled = False
		End If
	
	End If

End Sub


Public Sub GetBase As B4XView
	Return mBase
End Sub

#If B4J

Sub BringToFront(n As Node)
	Dim parent As Pane = n.Parent
	n.RemoveNodeFromParent
	parent.AddNode(n, n.Left, n.Top, n.PrefWidth, n.PrefHeight)
End Sub

#End If

#If B4J

Private Sub asbm_page_1_MouseClicked (EventData As MouseEvent)
	
	asbm_page_1_handler(Sender)
	
End Sub

#Else

Private Sub asbm_page_1_Click
	
	asbm_page_1_handler(Sender)
	
End Sub

#End If

private Sub asbm_page_1_handler(SenderPanel As B4XView)
	
	If xui.SubExists(mCallBack, mEventName & "_Page1Click",0) Then
		CallSub(mCallBack, mEventName & "_Page1Click")
	End If
	currentpage = 1
		
	Dim cx As Int = asbm_page_1.Left + asbm_page_1.Width/2
	
	asbm_slider.SetLayoutAnimated(500,cx - asbm_slider.Width/2 ,asbm_slider.Top,asbm_slider.Width,asbm_slider.Height)
	asbm_slider.SetColorAnimated(0,asbm_slider.Color,s_Color1)

#If B4J
	If e_SelectedPageColor = True Then

		asbm_icon_2.SetImage(ChangeColorBasedOnAlphaLevel(asbm_icon_2.GetImage,xui.Color_White))

		If Mode = 1 Then
	
			asbm_icon_3.SetImage(ChangeColorBasedOnAlphaLevel(asbm_icon_3.GetImage,xui.Color_White))
			asbm_icon_4.SetImage(ChangeColorBasedOnAlphaLevel(asbm_icon_4.GetImage,xui.Color_White))

		End If

		asbm_icon_1.SetImage(ChangeColorBasedOnAlphaLevel(asbm_icon_1.GetImage,s_PageColor))

	End If
	
	CreateHaloEffect(asbm_page_1, asbm_page_1.Width/2, asbm_page_1.Height/2, p_ClickColor)

	BringToFront(asbm_icon_1)

#Else
If e_SelectedPageColor = True Then

	asbm_icon_2.Bitmap = ChangeColorBasedOnAlphaLevel(asbm_icon_2.Bitmap,xui.Color_White)

		If Mode = 1 Then
	
				asbm_icon_3.Bitmap = ChangeColorBasedOnAlphaLevel(asbm_icon_3.Bitmap,xui.Color_White)
			asbm_icon_4.Bitmap = ChangeColorBasedOnAlphaLevel(asbm_icon_4.Bitmap,xui.Color_White)

End If

asbm_icon_1.Bitmap = ChangeColorBasedOnAlphaLevel(asbm_icon_1.Bitmap,s_PageColor)

	End If
	
	CreateHaloEffect(asbm_page_1, asbm_page_1.Width/2, asbm_page_1.Height/2, p_ClickColor)

	asbm_icon_1.BringToFront
#End If


	

	asbm_slider.BringToFront
	
End Sub
	

#If B4J

Private Sub asbm_page_2_MouseClicked (EventData As MouseEvent)
	
	asbm_page_2_handler(Sender)
	
End Sub

#Else

Private Sub asbm_page_2_Click
	
	asbm_page_2_handler(Sender)
	
End Sub

#End If

Private Sub asbm_page_2_handler(SenderPanel As B4XView)
	
	If xui.SubExists(mCallBack, mEventName & "_Page2Click",0) Then
		CallSub(mCallBack, mEventName & "_Page2Click")
	End If
	currentpage = 2
	Dim cx As Int = asbm_page_2.Left + asbm_page_2.Width/2
	
	asbm_slider.SetLayoutAnimated(500,cx - asbm_slider.Width/2,asbm_slider.Top,asbm_slider.Width,asbm_slider.Height)
	asbm_slider.SetColorAnimated(0,asbm_slider.Color,s_Color2)
	
	
	#If B4J
	
	If e_SelectedPageColor = True Then
	
		asbm_icon_1.SetImage(ChangeColorBasedOnAlphaLevel(asbm_icon_1.GetImage,xui.Color_White))
	
		If Mode = 1 Then
	
			asbm_icon_3.SetImage(ChangeColorBasedOnAlphaLevel(asbm_icon_3.GetImage,xui.Color_White))
			asbm_icon_4.SetImage(ChangeColorBasedOnAlphaLevel(asbm_icon_4.GetImage,xui.Color_White))
	
		End If
	
		asbm_icon_2.SetImage(ChangeColorBasedOnAlphaLevel(asbm_icon_2.GetImage,s_PageColor))
	
	End If
	
	CreateHaloEffect(asbm_page_2, asbm_page_2.Width/2, asbm_page_2.Height/2, p_ClickColor)
	BringToFront(asbm_icon_2)
	#Else
		If e_SelectedPageColor = True Then
	
	asbm_icon_1.Bitmap = ChangeColorBasedOnAlphaLevel(asbm_icon_1.Bitmap,Colors.White)
	
		If Mode = 1 Then
	
	asbm_icon_3.Bitmap = ChangeColorBasedOnAlphaLevel(asbm_icon_3.Bitmap,Colors.White)
	asbm_icon_4.Bitmap = ChangeColorBasedOnAlphaLevel(asbm_icon_4.Bitmap,Colors.White)
	
	End If
	
	asbm_icon_2.Bitmap = ChangeColorBasedOnAlphaLevel(asbm_icon_2.Bitmap,s_PageColor)
	
	End If
	
	CreateHaloEffect(asbm_page_2, asbm_page_2.Width/2, asbm_page_2.Height/2, p_ClickColor)
	asbm_icon_2.BringToFront
	
	#End If
	

	asbm_slider.BringToFront
	
	
	
End Sub



#If B4J

Private Sub asbm_page_3_MouseClicked (EventData As MouseEvent)
	
	asbm_page_3_handler(Sender)
	
End Sub

#Else

Private Sub asbm_page_3_Click
	
	If Mode = 1 Then
	
	asbm_page_3_handler(Sender)
	
	End If
	
End Sub

#End If

Private Sub asbm_page_3_handler(SenderPanel As B4XView)
	
	If xui.SubExists(mCallBack, mEventName & "_Page3Click",0) Then
		CallSub(mCallBack, mEventName & "_Page3Click")
	End If
	currentpage = 3
	
	Dim cx As Int = asbm_page_3.Left + asbm_page_3.Width/2
	
	asbm_slider.SetLayoutAnimated(500,cx - asbm_slider.Width/2,asbm_slider.Top,asbm_slider.Width,asbm_slider.Height)
	asbm_slider.SetColorAnimated(0,asbm_slider.Color,s_Color3)
	
	#If B4J
	
	If e_SelectedPageColor = True Then
	
		asbm_icon_1.SetImage(ChangeColorBasedOnAlphaLevel(asbm_icon_1.GetImage,xui.Color_White))
		asbm_icon_2.SetImage(ChangeColorBasedOnAlphaLevel(asbm_icon_2.GetImage,xui.Color_White))
		asbm_icon_4.SetImage(ChangeColorBasedOnAlphaLevel(asbm_icon_4.GetImage,xui.Color_White))
	
		asbm_icon_3.SetImage(ChangeColorBasedOnAlphaLevel(asbm_icon_3.GetImage,s_PageColor))
	
	End If
	
	CreateHaloEffect(asbm_page_3, asbm_page_3.Width/2, asbm_page_3.Height/2, p_ClickColor)
	BringToFront(asbm_icon_3)
	#Else
	
		If e_SelectedPageColor = True Then
	
	asbm_icon_1.Bitmap = ChangeColorBasedOnAlphaLevel(asbm_icon_1.Bitmap,Colors.White)
	asbm_icon_2.Bitmap = ChangeColorBasedOnAlphaLevel(asbm_icon_2.Bitmap,Colors.White)
	asbm_icon_4.Bitmap = ChangeColorBasedOnAlphaLevel(asbm_icon_4.Bitmap,Colors.White)
	
	asbm_icon_3.Bitmap = ChangeColorBasedOnAlphaLevel(asbm_icon_3.Bitmap,s_PageColor)
	
	End If
	
	CreateHaloEffect(asbm_page_3, asbm_page_3.Width/2, asbm_page_3.Height/2, p_ClickColor)
	asbm_icon_3.BringToFront
	
	#End If
	
	

	asbm_slider.BringToFront
	

End Sub



#If B4J

Private Sub asbm_page_4_MouseClicked (EventData As MouseEvent)
	
	asbm_page_4_handler(Sender)
	
End Sub

#Else

Private Sub asbm_page_4_Click
	
	If Mode = 1 Then
	
	asbm_page_4_handler(Sender)
	
	End If
	
End Sub

#End If


Private Sub asbm_page_4_handler(SenderPanel As B4XView)
	
	If xui.SubExists(mCallBack, mEventName & "_Page4Click",0) Then
		CallSub(mCallBack, mEventName & "_Page4Click")
	End If
	currentpage = 4

	Dim cx As Int = asbm_page_4.Left + asbm_page_4.Width/2
	
	asbm_slider.SetLayoutAnimated(500,cx - asbm_slider.Width/2,asbm_slider.Top,asbm_slider.Width,asbm_slider.Height)
	asbm_slider.SetColorAnimated(0,asbm_slider.Color,s_Color4)
	
	#If B4J
	
	If e_SelectedPageColor = True Then
	
		asbm_icon_1.SetImage(ChangeColorBasedOnAlphaLevel(asbm_icon_1.GetImage,xui.Color_White))
		asbm_icon_2.SetImage(ChangeColorBasedOnAlphaLevel(asbm_icon_2.GetImage,xui.Color_White))
		asbm_icon_3.SetImage(ChangeColorBasedOnAlphaLevel(asbm_icon_3.GetImage,xui.Color_White))
	
	
		asbm_icon_4.SetImage(ChangeColorBasedOnAlphaLevel(asbm_icon_4.GetImage,s_PageColor))
	
	End If
	
	CreateHaloEffect(asbm_page_4, asbm_page_4.Width/2, asbm_page_4.Height/2, p_ClickColor)

	BringToFront(asbm_icon_4)
	#Else
	
	If e_SelectedPageColor = True Then
	
	asbm_icon_1.Bitmap = ChangeColorBasedOnAlphaLevel(asbm_icon_1.Bitmap,Colors.White)
	asbm_icon_2.Bitmap = ChangeColorBasedOnAlphaLevel(asbm_icon_2.Bitmap,Colors.White)
	asbm_icon_3.Bitmap = ChangeColorBasedOnAlphaLevel(asbm_icon_3.Bitmap,Colors.White)
	
	
	asbm_icon_4.Bitmap = ChangeColorBasedOnAlphaLevel(asbm_icon_4.Bitmap,s_PageColor)
	
	End If
	
	CreateHaloEffect(asbm_page_4, asbm_page_4.Width/2, asbm_page_4.Height/2, p_ClickColor)

	asbm_icon_4.BringToFront
	
	#End If
	
	
	
	asbm_slider.BringToFront

End Sub


Private Sub asbm_add_background_Click

	asbm_add_background_handler(Sender)

End Sub

Private Sub asbm_add_background_LongClick
	
	asbm_add_background_handler_long(Sender)
	
End Sub

Private Sub asbm_add_background_handler(SenderPanel As B4XView)
	
	If xui.SubExists(mCallBack, mEventName & "_MiddleButtonClick",0) Then
		CallSub(mCallBack, mEventName & "_MiddleButtonClick")
	End If
	
	
End Sub

Private Sub asbm_add_background_handler_long(SenderPanel As B4XView)
	
	If xui.SubExists(mCallBack, mEventName & "_MiddleButtonLongClick",0) Then
		CallSub(mCallBack, mEventName & "_MiddleButtonLongClick")
	End If
	
	
End Sub

'Public Subs

'If True, the Badget is Visible, if not, the Badget is hidden.
Public Sub EnableBadget1(Enable As Boolean)
	
	e_BadgetColor1 = Enable
	asbm_badget_1.Visible = e_BadgetColor1
End Sub

'If True, the Badget is Visible, if not, the Badget is hidden.
Public Sub EnableBadget2(Enable As Boolean)
	
	e_BadgetColor2 = Enable
	asbm_badget_2.Visible = e_BadgetColor2
End Sub

'If True, the Badget is Visible, if not, the Badget is hidden.
Public Sub EnableBadget3(Enable As Boolean)
	
	If Mode = 1 Then
	
	e_BadgetColor3 = Enable
	asbm_badget_3.Visible = e_BadgetColor3
	
	End If
	
End Sub

'If True, the Badget is Visible, if not, the Badget is hidden.
Public Sub EnableBadget4(Enable As Boolean)
	
	If Mode = 1 Then
		
	
	e_BadgetColor4 = Enable
	asbm_badget_4.Visible = e_BadgetColor4
	
	End If
	
End Sub

'Set the Background Color of the 1. Badget
Public Sub SetBadgetColor1(color As Int)
	
	b_color1 = color
	asbm_badget_1.Color = b_color1
End Sub

'Set the Background Color of the 2. Badget
Public Sub SetBadgetColor2(color As Int)
	
	b_color2 = color
	asbm_badget_2.Color = b_color2
End Sub

'Set the Background Color of the 3. Badget
Public Sub SetBadgetColor3(color As Int)
	
	If Mode = 1 Then
		
	b_color3 = color
	asbm_badget_3.Color = b_color3
	
	End If
	
End Sub

'Set the Background Color of the 4. Badget
Public Sub SetBadgetColor4(color As Int)
	
	If Mode = 1 Then
	
	b_color4 = color
	asbm_badget_4.Color = b_color4
	
	End If
	
End Sub

'Set the Background color behind the Buttons.
Public Sub SetMenuBackgroundColor(color As Int)
	
	b_Color = color
	asbm_page_background.Color = b_Color
End Sub

'If True then the Icon will change the Color on the current Page.
Public Sub EnableSelectedPageColor(enable As Boolean)
	
	e_SelectedPageColor = enable
	
End Sub

'Set the color of the icon which is selected
Public Sub SetSelectedPageColor(color As Int)
		
	s_PageColor = color
	
End Sub

'The Color of Halo Effect during Page Click.
Public Sub SetPageClickColor(color As Int)
	
	p_ClickColor = color
	
End Sub

'Set the Middle Button Background Color
Public Sub SetMiddleButtonBackgroundColor(color As Int)
	
	
	m_BackgroundColor = color
	asbm_add_background.Color = m_BackgroundColor
	
End Sub

'Set the Color of the Line over the Buttons.
Public Sub SetPartingLineColor(color As Int)
	
	p_Line = color
	asbm_parting_line.Color = p_Line
	
End Sub

'Set the slider Color, if the slider slides to the 1. button.
Public Sub SetSlider1Color(color As Int)
	
	s_Color1 = color
	
End Sub

'Set the slider Color, if the slider slides to the 2. button.
Public Sub SetSlider2Color(color As Int)
	
	s_Color2 = color
	
End Sub

'Set the slider Color, if the slider slides to the 3. button.
Public Sub SetSlider3Color(color As Int)
	
	If Mode = 1 Then
	
	s_Color3 = color
	
	End If
	
End Sub

'Set the slider Color, if the slider slides to the 4. button.
Public Sub SetSlider4Color(color As Int)
	
	If Mode = 1 Then
	
	s_Color4 = color
	
	End If
	
End Sub

'Set on the 1. Badge the Value. Bigger then 9, a "9+" is Displayed
Public Sub SetBadgetValue1(value As Int)
	
	If value > 9 Then
		
		asbm_badget_1.Text = "+" & 9
		
		Else if value < 0 Then
			
		asbm_badget_1.Text = 0
			
			Else
				
				
		asbm_badget_1.Text = value
		
	End If
	
End Sub

'Set on the 2. Badge the Value. Bigger then 9, a "9+" is Displayed
Public Sub SetBadgetValue2(value As Int)
	
	If value > 9 Then
		
		asbm_badget_2.Text = "+" & 9
		
	Else if value < 0 Then
			
		asbm_badget_2.Text = 0
			
	Else
				
				
		asbm_badget_2.Text = value
		
	End If
	
End Sub

'Set on the 3. Badge the Value. Bigger then 9, a "9+" is Displayed
Public Sub SetBadgetValue3(value As Int)
	
	If Mode = 1 Then
	
	If value > 9 Then
		
		asbm_badget_3.Text = "+" & 9
		
	Else if value < 0 Then
			
		asbm_badget_3.Text = 0
			
	Else
				
				
		asbm_badget_3.Text = value
		
	End If
	
	End If
	
End Sub

'Set on the 4. Badge the Value. Bigger then 9, a "9+" is Displayed
Public Sub SetBadgetValue4(value As Int)
	
	If Mode = 1 Then
	
	If value > 9 Then
		
		asbm_badget_4.Text = "+" & 9
		
	Else if value < 0 Then
			
		asbm_badget_4.Text = 0
			
	Else
				
				
		asbm_badget_4.Text = value
		
	End If
	
	End If
	
End Sub

Public Sub SetIcon1(icon As B4XBitmap)
	
	icon1 = icon
	
	#If B4J
	asbm_icon_1.SetImage(icon1)
	
	If currentpage = 1 Then
		
		asbm_icon_1.SetImage(ChangeColorBasedOnAlphaLevel(asbm_icon_1.GetImage,s_PageColor))
		
	End If
	#Else
	asbm_icon_1.Bitmap = icon1
	
	If currentpage = 1 Then
		
		asbm_icon_1.Bitmap = ChangeColorBasedOnAlphaLevel(asbm_icon_1.Bitmap,s_PageColor)
		
	End If
	
	#End If

End Sub

Public Sub SetIcon2(icon As B4XBitmap)
	
	icon2 = icon
	
	#If B4J
	asbm_icon_2.SetImage(icon2)
	
	If currentpage = 2 Then
		
		asbm_icon_2.SetImage(ChangeColorBasedOnAlphaLevel(asbm_icon_2.GetImage,s_PageColor))
		
	End If
	#Else
	
	asbm_icon_2.Bitmap = icon2
	
	If currentpage = 2 Then
		
		asbm_icon_2.Bitmap = ChangeColorBasedOnAlphaLevel(asbm_icon_2.Bitmap,s_PageColor)
		
	End If
	
	#End If
	
	
	
	
End Sub

Public Sub SetIcon3(icon As B4XBitmap)
	
	If Mode = 1 Then
	
	icon3 = icon
	
	#If B4J
	asbm_icon_3.SetImage(icon3)
	
	If currentpage = 3 Then
		
		asbm_icon_3.SetImage(ChangeColorBasedOnAlphaLevel(asbm_icon_3.GetImage,s_PageColor))
		
	End If
	
	#Else
	
	asbm_icon_3.Bitmap = icon3
	
	If currentpage = 3 Then
		
		asbm_icon_3.Bitmap = ChangeColorBasedOnAlphaLevel(asbm_icon_3.Bitmap,s_PageColor)
		
	End If
	#End If
	
	End If
	
End Sub


Public Sub SetIcon4(icon As B4XBitmap)
	
	If Mode = 1 Then
	
	icon4 = icon
	
	#If B4J
	asbm_icon_4.SetImage(icon4)
	
	If currentpage = 4 Then
		
		asbm_icon_4.SetImage(ChangeColorBasedOnAlphaLevel(asbm_icon_4.GetImage,s_PageColor))
		
	End If
	#Else
	
	asbm_icon_4.Bitmap = icon4
	
	If currentpage = 4 Then
		
		asbm_icon_4.Bitmap = ChangeColorBasedOnAlphaLevel(asbm_icon_4.Bitmap,s_PageColor)
		
	End If
	#End If
	
	End If
	
End Sub

'Set the Icon of the Middle Button
Public Sub SetMiddleButtonIcon(icon As B4XBitmap)
	
	middleicon = icon
	
	#if B4J
	
	pnl_asbm_add_icon.SetImage(middleicon)
	#ELSE
	
	pnl_asbm_add_icon.Bitmap = middleicon
	#End If
	
	
	
	
End Sub

'Set the current Page 1-4
Public Sub SetCurrentPage(page As Int)
	
	If page = 1 Then
		
		asbm_page_1_handler(asbm_page_1)
		
		Else If page = 2 Then
			
		asbm_page_2_handler(asbm_page_2)
			
	Else If page = 3 Then
		
		If Mode = 1 Then
		
		asbm_page_3_handler(asbm_page_3)
		
		End If
		
	Else If page = 4 Then
			
		If Mode = 1 Then
			
		asbm_page_4_handler(asbm_page_4)
		
		End If
			
			Else
				
				Log("Page number not valid")
		asbm_page_1_handler(asbm_page_1)
		
	End If
	
End Sub

#Region UsedFunctions

'https://www.b4x.com/android/forum/threads/b4x-xui-simple-halo-animation.80267/#content
Private Sub CreateHaloEffect (Parent As B4XView, x As Int, y As Int, clr As Int)
	Dim cvs As B4XCanvas
	Dim p As B4XView = xui.CreatePanel("")
	Dim radius As Int = 150dip
	p.SetLayoutAnimated(0, 0, 0, radius * 2, radius * 2)
	cvs.Initialize(p)
	cvs.DrawCircle(cvs.TargetRect.CenterX, cvs.TargetRect.CenterY, cvs.TargetRect.Width / 2, clr, True, 0)
	Dim bmp As B4XBitmap = cvs.CreateBitmap
	For i = 1 To 1
		CreateHaloEffectHelper(Parent,bmp, x, y, clr, radius)
		Sleep(800)
	Next
End Sub

Private Sub CreateHaloEffectHelper (Parent As B4XView,bmp As B4XBitmap, x As Int, y As Int, clr As Int, radius As Int)
	Dim iv As ImageView
	iv.Initialize("")
	Dim p As B4XView = iv
	p.SetBitmap(bmp)
	Parent.AddView(p, x, y, 0, 0)
	Dim duration As Int = 1000
	p.SetLayoutAnimated(duration, x - radius, y - radius, 2 * radius, 2 * radius)
	p.SetVisibleAnimated(duration, False)
	Sleep(duration)
	p.RemoveViewFromParent
End Sub

'https://www.b4x.com/android/forum/threads/b4x-bitmapcreator-change-color-of-bitmap.95518/#post-603416
Private Sub ChangeColorBasedOnAlphaLevel(bmp As B4XBitmap, NewColor As Int) As B4XBitmap
	Dim bc As BitmapCreator
	bc.Initialize(bmp.Width, bmp.Height)
	bc.CopyPixelsFromBitmap(bmp)
	Dim a1, a2 As ARGBColor
	bc.ColorToARGB(NewColor, a1)
	For y = 0 To bc.mHeight - 1
		For x = 0 To bc.mWidth - 1
			bc.GetARGB(x, y, a2)
			If a2.a > 0 Then
				a2.r = a1.r
				a2.g = a1.g
				a2.b = a1.b
				bc.SetARGB(x, y, a2)
			End If
		Next
	Next
	Return bc.Bitmap
End Sub

#End Region

'Maybe Comming Soon

'Public Sub HideOrShowMiddleButton(show As Boolean)
'	
'	If show = True Then
'		
'		If Mode = 1 Then
'			
'		
'			asbm_page_1.Left = 0
'			asbm_page_1.Width = asbm_add_background.left/2
'			
'			asbm_page_2.Left = asbm_page_1.Width
'			asbm_page_2.Width = asbm_add_background.left/2
'			
'			asbm_page_3.Left = asbm_page_2.left + asbm_page_2.Width
'			asbm_page_3.Width = asbm_page_background.Width/4
'		
'			asbm_page_4.Left = asbm_page_3.Left + asbm_page_3.Width
'			asbm_page_4.Width = asbm_add_background.left/2
'			
'		
'			
'			
'		Else
'				
'			asbm_page_1.Left = 0
'			asbm_page_1.Width = asbm_add_background.left
'			
'			asbm_page_2.Left = asbm_add_background.left + asbm_add_background.Width
'			asbm_page_2.Width = asbm_add_background.left
'				
'			
'			Dim cx,cy As Int
'			cx = asbm_page_1.Left + asbm_page_1.Width/2
'			cy = asbm_page_1.Top + asbm_page_1.Height/2.3
'		
'			
'				
'				
'		End If
'		
'		MiddleButtonVisible = True
'		asbm_add_background.Visible = True
'		asbm_add_background.Enabled = True
'		
'		Else
'			
'		If Mode = 1 Then
'			
'			
'			asbm_page_1.Left = 0
'			asbm_page_1.Width = asbm_page_background.Width/4
'			
'			asbm_page_2.Left = asbm_page_1.Width
'			asbm_page_2.Width = asbm_page_background.Width/4
'			
'			asbm_page_3.Left = asbm_page_2.left + asbm_page_2.Width
'			asbm_page_3.Width = asbm_page_background.Width/4
'			
'			asbm_page_4.Left = asbm_page_3.Left + asbm_page_3.Width
'			asbm_page_4.Width = asbm_page_background.Width/4
'			
'			
'			Else
'			
'			asbm_page_1.Left = 0
'			asbm_page_1.Width = asbm_page_background.Width/2
'			
'			asbm_page_2.Left = asbm_page_1.left + asbm_page_1.Width
'			asbm_page_2.Width = asbm_add_background.Width/2
'			
'		End If
'			
'			
'		MiddleButtonVisible = False
'		asbm_add_background.Visible = False
'		asbm_add_background.Enabled = False
'		
'	End If
'	
'End Sub
