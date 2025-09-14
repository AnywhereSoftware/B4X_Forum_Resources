B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.8
@EndOfDesignText@
'Author: Biswajit
'Version: 1.51

#DesignerProperty: Key: TabCount, DisplayName: No. of Tabs, FieldType: String, DefaultValue: 5, List: 5|3, Description: Number of Tabs
#DesignerProperty: Key: ActiveTab, DisplayName: Active Tab, FieldType: String, DefaultValue: 3, List: 1|2|3|4|5, Description: Active tab when app starts. If No. of Tabs is less than active tab then the center tab will be active when the app starts.
#DesignerProperty: Key: BackgroundColor, DisplayName: Background Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: BackGround color
#DesignerProperty: Key: ShadowColor, DisplayName: Shadow Color, FieldType: String, DefaultValue: Dark, List: Dark|Light, Description: Shadow Color
#DesignerProperty: Key: IconColor, DisplayName: Icon Color, FieldType: Color, DefaultValue: 0xFFBBBBBB, Description: Icon color (alpha channel is not supported for image icon) 
#DesignerProperty: Key: IconSize, DisplayName: Icon Size, FieldType: Int, DefaultValue: 18, Description: Icon size
#DesignerProperty: Key: TextColor, DisplayName: Text Color, FieldType: Color, DefaultValue: 0xFF000000, Description: Text color
#DesignerProperty: Key: TextSize, DisplayName: Text Size, FieldType: Int, DefaultValue: 14, Description: Text size
#DesignerProperty: Key: SelectedIconColor, DisplayName: Selected Icon Color, FieldType: Color, DefaultValue: 0xFF000000, Description: Selected Icon color
#DesignerProperty: Key: IconAppear, DisplayName: Icon Appear Style, FieldType: String, DefaultValue: FROM EDGE, List: FROM EDGE|FROM CENTER|FADE IN|NO ANIMATION
#DesignerProperty: Key: AnimationType, DisplayName: Animation Type, FieldType: String, DefaultValue: ELASTIC OUT, List: ELASTIC OUT|ELASTIC IN|EASE OUT|EASE IN|NONE
#DesignerProperty: Key: AnimationDuration, DisplayName: Animation Duration, FieldType: Int, DefaultValue: 500, Description: Wobble animation time in milliseconds

#Event: Tab1Click
#Event: Tab2Click
#Event: Tab3Click
#Event: Tab4Click
#Event: Tab5Click

Private Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView
	Private xui As XUI
	
	Private BackgroundColor,IconColor,IconSize,TextColor,TextSize,SelectedIconColor,circleRadius,animDuration As Int
	Private TabContainer,TabCurve,TabCircle,Tab1,Tab2,Tab3,Tab4,Tab5 As B4XView
	Private Tabs,IconList As List
	Private MenuHeight, AbsoluteWidth, TabCount, ActiveTab As Int
	Private CurrentTab As Int
	
	Public const ANIMATION_TYPE_ELASTIC_OUT As Int = 0
	Public const ANIMATION_TYPE_ELASTIC_IN As Int = 1
	Public const ANIMATION_TYPE_EASE_OUT As Int = 2
	Public const ANIMATION_TYPE_EASE_IN As Int = 3
	Public const ANIMATION_TYPE_NONE As Int = 4
	Private AnimationType As Int
	
	Public const ICON_APPEAR_FROM_CENTER As Int = 0
	Public const ICON_APPEAR_FROM_EDGE As Int = 1
	Public const ICON_APPEAR_FADE_IN As Int = 2
	Public const ICON_APPEAR_NO_ANIMATION As Int = 3
	Private IconAppearStyle As Int
	Private ShadowColor As String
	Private badge,enabled As List
	
	#IF B4J
	Private fx As JFX
	#End If
	
	#IF B4A
	Type IconType(Text As String, Icon As String, iFont As Typeface, IconImg As Bitmap, tinted As Boolean)
	#ELSE IF B4I
	Type IconType(Text As String, Icon As String, iFont As Font, IconImg As Bitmap, tinted As Boolean)
	#ELSE IF B4J
	Type IconType(Text As String, Icon As String, iFont As Font, IconImg As Image, tinted As Boolean)
	#End If
	
	Private designerLbl As B4XView
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	IconList.Initialize
	Tabs.Initialize
	badge.Initialize
	enabled.Initialize2(Array As Boolean(True,True,True,True,True))
End Sub

#Region Design
'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	designerLbl=Lbl
	mBase = Base
	mBase.Color = xui.Color_Transparent
	AbsoluteWidth= Min(mBase.Parent.Width,mBase.Parent.Height)
	MenuHeight = (AbsoluteWidth/7) + ((AbsoluteWidth/7)/4)
	mBase.Height = MenuHeight
	mBase.Top = mBase.Parent.Height - mBase.Height
	circleRadius = AbsoluteWidth/7
	
	BackgroundColor = xui.PaintOrColorToColor(Props.Get("BackgroundColor"))
	IconColor = xui.PaintOrColorToColor(Props.Get("IconColor"))
	IconSize = xui.PaintOrColorToColor(Props.Get("IconSize"))
	TextSize = xui.PaintOrColorToColor(Props.Get("TextSize"))
	TextColor = xui.PaintOrColorToColor(Props.Get("TextColor"))
	SelectedIconColor = xui.PaintOrColorToColor(Props.Get("SelectedIconColor"))
	animDuration = Props.Get("AnimationDuration")
	TabCount = Props.Get("TabCount")
	ActiveTab = Props.Get("ActiveTab")
	ShadowColor = Props.Get("ShadowColor")
	If TabCount = 5 Then
		CurrentTab = ActiveTab
	Else
		If ActiveTab > TabCount Then
			CurrentTab = 2
		Else
			CurrentTab = ActiveTab
		End If
	End If
	
	Select Props.Get("IconAppear")
		Case "FROM EDGE": IconAppearStyle = ICON_APPEAR_FROM_EDGE
		Case "FROM CENTER": IconAppearStyle = ICON_APPEAR_FROM_CENTER
		Case "FADE IN": IconAppearStyle = ICON_APPEAR_FADE_IN
		Case "NO ANIMATION": IconAppearStyle = ICON_APPEAR_NO_ANIMATION
	End Select
	
	Select Props.Get("AnimationType")
		Case "ELASTIC OUT": AnimationType = ANIMATION_TYPE_ELASTIC_OUT
		Case "ELASTIC IN": AnimationType = ANIMATION_TYPE_ELASTIC_IN
		Case "EASE OUT": AnimationType = ANIMATION_TYPE_EASE_OUT
		Case "EASE IN": AnimationType = ANIMATION_TYPE_EASE_IN
		Case "NONE": AnimationType = ANIMATION_TYPE_NONE
	End Select
	
	DrawView
	
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	mBase.Width = Width
	AbsoluteWidth= Min(mBase.Parent.Width,mBase.Parent.Height)
	MenuHeight = (AbsoluteWidth/7) + ((AbsoluteWidth/7)/4)
	mBase.Height = MenuHeight
	mBase.Top = mBase.Parent.Height - mBase.Height
	circleRadius = AbsoluteWidth/7
	
	DrawView
End Sub

Private Sub DrawView
	mBase.RemoveAllViews
	Tabs.Clear
	If TabCircle.IsInitialized Then TabCircle.RemoveAllViews
	
	TabContainer = xui.CreatePanel("")
	mBase.AddView(TabContainer,0,mBase.Height/4 ,mBase.Width,mBase.Height - (mBase.Height/4))
	TabCurve = xui.CreatePanel("")
	TabContainer.AddView(TabCurve,((TabContainer.Width/TabCount)*(CurrentTab-1))+((TabContainer.Width/TabCount)/2)-((TabContainer.Width*2)/2),0,TabContainer.Width*2,TabContainer.Height)
	DrawCurve
	
	TabCircle = xui.CreatePanel("")
	mBase.AddView(TabCircle,((TabContainer.Width/TabCount)*(CurrentTab-1))+((TabContainer.Width/TabCount)/2) - (circleRadius/2),1dip,circleRadius,circleRadius)
	DrawCircle
	
	Dim icon As Label
	icon.Initialize("")
	
	#IF B4I
	icon.TextColor = SelectedIconColor
	icon.Font = Font.CreateFontAwesome(20)
	icon.TextAlignment = icon.ALIGNMENT_CENTER
	#ELSE IF B4A
	icon.TextColor = SelectedIconColor
	icon.Typeface = Typeface.FONTAWESOME
	icon.TextSize = 20
	icon.Gravity = Gravity.CENTER_HORIZONTAL + Gravity.CENTER_VERTICAL
	#ELSE IF B4J
	icon.TextColor = fx.Colors.From32Bit(SelectedIconColor)
	icon.Font = fx.CreateFontAwesome(20)
	icon.Alignment = "CENTER"
	#End If
	
	TabCircle.AddView(icon,0,0,TabCircle.Width,TabCircle.Height)
	
	Dim iconImg As ImageView
	iconImg.Initialize("")
	TabCircle.AddView(iconImg,(TabCircle.Width/2)-((TabCircle.Width/2)/2),(TabCircle.Height/2)-((TabCircle.Height/2)/2),TabCircle.Width/2,TabCircle.Height/2)
	
	Dim lw,rw,cw As B4XView
	lw = xui.CreatePanel("")
	rw = xui.CreatePanel("")
	cw = xui.CreatePanel("")
	lw.Color = BackgroundColor
	rw.Color = BackgroundColor
	cw.Color = BackgroundColor
	TabCircle.AddView(lw,(TabCircle.Height/5),(TabCircle.Height/2)-((TabCircle.Height/2)/2),1dip,TabCircle.Height/2)
	TabCircle.AddView(rw,TabCircle.Width-(TabCircle.Height/5) - 1dip,(TabCircle.Height/2)-((TabCircle.Height/2)/2),1dip,TabCircle.Height/2)
	TabCircle.AddView(cw,TabCircle.Width/2,(TabCircle.Height/2)-((TabCircle.Height/2)/2),0,TabCircle.Height/2)
	
	Tab1 = xui.CreatePanel("IconTab")
	Tabs.Add(Tab1)
	Tab2 = xui.CreatePanel("IconTab")
	Tabs.Add(Tab2)
	Tab3 = xui.CreatePanel("IconTab")
	Tabs.Add(Tab3)
	Tab4 = xui.CreatePanel("IconTab")
	Tabs.Add(Tab4)
	Tab5 = xui.CreatePanel("IconTab")
	Tabs.Add(Tab5)
	
	CreateTab
	SetCircleIcon
End Sub

Private Sub CreateTab
	For j=0 To TabCount-1
		
		Dim tabView As B4XView = Tabs.Get(j)
		tabView.Enabled = enabled.Get(j)
		Dim tab_width As Int = TabContainer.Width/TabCount
		tabView.Color = xui.Color_Transparent
		TabContainer.AddView(tabView,tab_width*j,0,tab_width,TabContainer.Height)
		
		Dim i As IconType:i.Initialize
		If IconList.Size > j Then
			i = IconList.Get(j)
		Else
			i.tinted = False
			i.IconImg = Null
			i.icon = Chr(0xF10C)
			#IF B4I
			i.ifont = Font.CreateFontAwesome(IconSize)
			#ELSE IF B4J
			i.ifont = fx.CreateFontAwesome(IconSize)
			#ELSE IF B4A
			i.ifont = Typeface.FONTAWESOME
			#End If
		End If
		
		Dim icon As Label
		icon.Initialize("")
		Dim b4xlbl As B4XView = icon
		b4xlbl.TextColor = IconColor
		b4xlbl.SetTextAlignment("CENTER","CENTER")
		b4xlbl.TextSize = IconSize
		
		#IF B4I OR B4j
		If i.ifont.IsInitialized Then icon.Font = i.iFont
		#ELSE IF B4A
		icon.Typeface = i.iFont
		#End If
		
		icon.Text = i.icon
		tabView.AddView(icon,0,0,tabView.Width,tabView.Height)
		
		Dim iconImg As ImageView
		iconImg.Initialize("")
		tabView.AddView(iconImg,0,((tabView.Height/3)-(tabView.Height/4))/2,tabView.Width,tabView.Height)
		
		Dim iconText As Label
		iconText.Initialize("")
		b4xlbl=iconText
		b4xlbl.TextColor = TextColor
		b4xlbl.Font=designerLbl.Font
		b4xlbl.TextSize=TextSize
		b4xlbl.SetTextAlignment("CENTER","CENTER")
		b4xlbl.text=i.text
		
		tabView.AddView(iconText,0,tabView.Height/2,tabView.Width,tabView.Height/2)
		
		If i.Text = "" Then
			#if b4j
			icon.PrefHeight = tabView.Height
			iconImg.PrefHeight = icon.Height
			#else
			icon.Height=tabView.Height
			iconImg.Height = icon.Height
			#End If
		Else
			#if b4j
			icon.PrefHeight = (tabView.Height/3)*2
			iconImg.PrefHeight = (tabView.Height/2)
			#else
			icon.Height=(tabView.Height/3)*2
			iconImg.Height = (tabView.Height/2)
			#End If
		End If
		
		If i.IconImg.IsInitialized Then
			#IF B4A
			Dim jo As JavaObject=iconImg
			jo.RunMethod("setImageBitmap",Array(i.IconImg))
			jo.RunMethod("setScaleType",Array("CENTER_INSIDE"))
			jo.RunMethod("setColorFilter",Array(Colors.Transparent))
			If i.tinted Then jo.RunMethod("setColorFilter",Array(Colors.rgb(GetARGB(IconColor)(1),GetARGB(IconColor)(2),GetARGB(IconColor)(3))))
			#ELSE IF B4i
			Dim no As NativeObject=iconImg
			no.SetField("contentMode",1)
			iconImg.Bitmap = i.IconImg
			If i.tinted Then TintBmp(iconImg,Colors.rgb(GetARGB(IconColor)(1),GetARGB(IconColor)(2),GetARGB(IconColor)(3)))
			#ELSE IF B4j
			iconImg.PreserveRatio = True
			iconImg.SetImage(i.IconImg)
			iconImg.PrefWidth = (i.IconImg.Width/i.IconImg.Height)*iconImg.PrefHeight
			iconImg.Left = (iconImg.Parent.PrefWidth/2)-(iconImg.PrefWidth/2)
			TintBmp(iconImg,0)
			If i.tinted Then TintBmp(iconImg,IconColor)
			#End If
		End If
		
		If badge.Size > j Then
			If badge.Get(j) <> "" Then
				Dim data As Map = badge.Get(j)
				SetBadge(j+1,data.Get("count"),data.Get("backcolor"),data.Get("textcolor"))
			End If
		Else
			badge.Add("")
		End If
		
		If IconList.Size < TabCount Then IconList.add(i)
		If j=CurrentTab-1 Then
			icon.Visible = False
			iconImg.Visible = False
			iconText.Visible = False
		End If
	Next
End Sub

Private Sub SetCircleIcon
	#IF B4A OR B4I
	Dim id As Int = 0
	#ELSE IF B4J
	Dim id As Int = 1
	#End If
	
	Select IconAppearStyle
		Case 0:
			TabCircle.GetView(id+2).SetLayoutAnimated(0,TabCircle.GetView(id+2).Left,TabCircle.GetView(id+2).Top,TabCircle.Width/2,TabCircle.GetView(id+2).Height)
			TabCircle.GetView(id+3).SetLayoutAnimated(0,TabCircle.Width-(TabCircle.Height/5) - (TabCircle.Width/2),TabCircle.GetView(3).Top,TabCircle.Width/2,TabCircle.GetView(3).Height)
			TabCircle.GetView(id+2).SetVisibleAnimated(0,True)
			TabCircle.GetView(id+3).SetVisibleAnimated(0,True)
		Case 1:
			TabCircle.GetView(id+4).SetLayoutAnimated(0,TabCircle.GetView(id+2).left,TabCircle.GetView(id+2).Top,TabCircle.GetView(id+3).Left-TabCircle.GetView(id+2).Left,TabCircle.GetView(id+2).Height)
			TabCircle.GetView(id+4).SetVisibleAnimated(0,True)
		Case 2:
			TabCircle.GetView(id).SetVisibleAnimated(0,False)
			TabCircle.GetView(id+1).SetVisibleAnimated(0,False)
	End Select
	Sleep(1)
	
	Dim cl As Label = TabCircle.GetView(id)
	Dim mTab As B4XView = Tabs.Get(CurrentTab-1)
	Dim tl As Label = mTab.GetView(0)
	cl.Text = tl.text
	
	Dim cli As ImageView = TabCircle.GetView(id+1)
	Dim i As IconType = IconList.Get(CurrentTab-1)
	#IF B4A
	Dim jo As JavaObject=cli
	If i.IconImg.IsInitialized Then
		jo.RunMethod("setImageBitmap",Array(i.IconImg))
	Else
		jo.RunMethod("setImageBitmap",Array(Null))
	End If
	jo.RunMethod("setScaleType",Array("CENTER_INSIDE"))
	jo.RunMethod("setColorFilter",Array(Colors.Transparent))
	If i.tinted Then jo.RunMethod("setColorFilter",Array(Colors.rgb(GetARGB(SelectedIconColor)(1),GetARGB(SelectedIconColor)(2),GetARGB(SelectedIconColor)(3))))
	#ELSE IF B4i
	Dim no As NativeObject=cli
	no.SetField("contentMode",1)
	If i.IconImg.IsInitialized Then
		cli.Bitmap = i.IconImg
		If i.tinted Then TintBmp(cli,Colors.rgb(GetARGB(SelectedIconColor)(1),GetARGB(SelectedIconColor)(2),GetARGB(SelectedIconColor)(3)))
	Else
		no.SetField("image",Null)
	End If
	#ELSE IF B4j
	cli.PreserveRatio = True
	If i.IconImg.IsInitialized Then
		cli.SetImage(i.IconImg)
		cli.PrefWidth = (i.IconImg.Width/i.IconImg.Height)*cli.PrefHeight
		cli.Left = (cli.Parent.PrefWidth/2)-(cli.PrefWidth/2)
		TintBmp(cli,0)
		If i.tinted Then TintBmp(cli,SelectedIconColor)
	Else
		cli.SetImage(Null)
	End If
	#End If
	
	#IF B4I
	cl.Font = Font.CreateNew2(tl.Font.Name,20)
	#ELSE IF B4J
	cl.Font = fx.CreateFont(tl.Font.FamilyName,20,False,False)
	#ELSE IF B4A
	cl.Typeface = tl.Typeface
	#End If
	
	Select IconAppearStyle
		Case 0:
			TabCircle.GetView(id+2).SetLayoutAnimated(800,TabCircle.GetView(id+2).Left,TabCircle.GetView(id+2).Top,1dip,TabCircle.GetView(id+2).Height)
			TabCircle.GetView(id+3).SetLayoutAnimated(800,TabCircle.Width-(TabCircle.Height/4) - 1dip,TabCircle.GetView(id+3).Top,1dip,TabCircle.GetView(id+3).Height)
		Case 1:
			TabCircle.GetView(id+4).SetLayoutAnimated(800,TabCircle.Width/2,TabCircle.GetView(id+2).Top,1dip,TabCircle.GetView(id+2).Height)
		Case 2:
			TabCircle.GetView(id).SetVisibleAnimated(800,True)
			TabCircle.GetView(id+1).SetVisibleAnimated(800,True)
	End Select
	
	#IF B4A
	Sleep(400)
	#ELSE B4I OR B4J
		Sleep(700)
	#End If
	TabCircle.GetView(id+2).SetVisibleAnimated(100,False)
	TabCircle.GetView(id+3).SetVisibleAnimated(100,False)
	TabCircle.GetView(id+4).SetVisibleAnimated(100,False)
	
End Sub

Private Sub DrawCurve
	Dim backARGB() As Int = GetARGB(BackgroundColor)
	Dim curve As B4XCanvas
	curve.Initialize(TabCurve)
	Dim rect As B4XRect
	Dim BezierView As BitmapCreator
	Dim BezierPath As BCPath
	Dim sWidth As Double = 1000
	Dim sHeight As Double = 500
	#IF B4A
	Dim curveHeight As Double = sHeight- sHeight/5 - 3dip
	#ELSE IF B4I OR B4J
	Dim curveHeight As Double = (sHeight- sHeight/5) + 10dip
	#End If
	
	
	BezierPath.Initialize(0, 0)
	CurveTo(BezierPath, sWidth/9, 0, sWidth/7, (sHeight/3))
	CurveTo(BezierPath, sWidth/5 + 5dip, curveHeight - 8dip  , sWidth/2, curveHeight )
	CurveTo(BezierPath, (sWidth-sWidth/5) - 5dip, curveHeight - 8dip , sWidth-(sWidth/7), (sHeight/3))
	CurveTo(BezierPath, (sWidth-sWidth/9)-2dip, 0, sWidth, 0)
	BezierPath.LineTo(sWidth,sHeight)
	BezierPath.LineTo(0,sHeight)
	BezierPath.LineTo(0,0)
	
	Dim shadow As Int
	If ShadowColor="Dark" Then
		shadow = xui.Color_ARGB(backARGB(0),Max(0,backARGB(1)-20),Max(0,backARGB(2)-20),Max(0,backARGB(3)-20))
	Else If ShadowColor="Light" Then
		shadow = xui.Color_ARGB(backARGB(0),Min(255,backARGB(1)+20),Min(255,backARGB(2)+20),Min(255,backARGB(3)+20))
	End If
	
	BezierView.Initialize(sWidth,sHeight)
	BezierView.DrawPath(BezierPath,BackgroundColor,True,0)
	#IF B4A 
	BezierView.DrawPath(BezierPath,shadow,False,10)
	#ELSE IF B4I OR B4J
	BezierView.DrawPath(BezierPath,shadow,False,20)
	#End If
	
	rect.Initialize(TabContainer.Width - (AbsoluteWidth/5)/2 -4,0,TabContainer.Width + (AbsoluteWidth/5)/2+4,TabContainer.Height)
	curve.DrawBitmap(BezierView.Bitmap,rect)

	rect.Initialize(0,0,TabContainer.Width -(AbsoluteWidth/5)/2,TabContainer.Height)
	curve.DrawRect(rect,BackgroundColor,True,0)
	rect.Initialize(TabContainer.Width +(AbsoluteWidth/5)/2  ,0,TabCurve.Width,TabContainer.Height)
	curve.DrawRect(rect,BackgroundColor,True,0)
	curve.DrawLine(0,0,TabContainer.Width -(AbsoluteWidth/5)/2,0,shadow,4)
	curve.DrawLine(TabContainer.Width +(AbsoluteWidth/5)/2,0,TabContainer.Width*2,0,shadow,4)
	curve.DrawLine(0,TabContainer.Height,TabContainer.Width*2,TabContainer.Height,BackgroundColor,4)
	
	curve.Invalidate
End Sub

Private Sub DrawCircle
	Dim circle As B4XCanvas
	circle.Initialize(TabCircle)
	Dim innerRadius As Int = Min(mBase.Parent.Width,mBase.Parent.Height)/8
	For i=1 To 10
		If ShadowColor="Dark" Then
			circle.DrawCircle(circleRadius/2,(circleRadius/2)+2,(innerRadius/2)+i,xui.Color_ARGB(3,0,0,0),True,0)
		Else If ShadowColor="Light" Then
			circle.DrawCircle(circleRadius/2,(circleRadius/2)+2,(innerRadius/2)+i,xui.Color_ARGB(3,255,255,255),True,0)
		End If
		
	Next
	circle.DrawCircle(circleRadius/2,circleRadius/2,innerRadius/2,BackgroundColor,True,0)
	circle.Invalidate
End Sub

#End Region

#Region UserFunctions
'Set tab text and icon
#IF B4I OR B4J
Public Sub SetTabTextIcon(TabID As Int,Text As String,Icon As String, IconFont As Font)
#ELSE IF B4A
Public Sub SetTabTextIcon(TabID As Int,Text As String, Icon As String, IconFont As Typeface)
#End If
	If TabID >= 1 And TabID <= TabCount Then
		Dim i As IconType:i.Initialize
		i.icon = Icon
		i.Text = Text
		i.ifont = IconFont
		i.tinted = False
		IconList.set(TabID-1,i)
		
		Dim mTab As B4XView = Tabs.Get(TabID-1)
		Dim iv As ImageView = mTab.GetView(1)
		
		#IF B4A
		Dim jo As JavaObject=iv
		jo.RunMethod("setImageBitmap",Array(Null))
		jo.RunMethod("setScaleType",Array("CENTER_INSIDE"))
		#ELSE IF B4i
		Dim no As NativeObject=iv
		no.SetField("contentMode",1)
		no.SetField("image",Null)
		#ELSE IF B4j
		iv.PreserveRatio = True
		iv.SetImage(Null)
		#End If
		
		Dim l As Label = mTab.GetView(0)
		l.Text = Icon
		#IF B4I
		i.ifont = Font.CreateNew2(IconFont.Name,IconSize)
		l.Font = i.iFont
		#ELSE IF B4J
		i.ifont = fx.CreateFont(IconFont.FamilyName,IconSize,False,False)
		l.Font = i.ifont
		#ELSE IF B4A
		l.Typeface = IconFont
		#End If
		
		If Text = "" Then
			#if b4j
			l.PrefHeight = mTab.Height
			#else
			l.Height=mTab.Height
			#End If
		Else
			#if b4j
			l.PrefHeight = (mTab.Height/3)*2
			#else
			l.Height=(mTab.Height/3)*2
			#End If
		End If
		
		Dim lbl As Label = mTab.GetView(2)
		lbl.Text = Text
		
		SetCircleIcon
	Else
		Log("Invalid Tab ID")
	End If
End Sub

'Set tab text and icon bitmap
#IF B4J
Public Sub SetTabTextIcon2(TabID As Int,Text As String, Icon As Image, tinted As Boolean)
#Else
Public Sub SetTabTextIcon2(TabID As Int,Text As String, Icon As bitmap, tinted As Boolean)
#END IF
	If TabID >= 1 And TabID <= TabCount Then
		Dim i As IconType:i.Initialize
		i.iconImg = Icon
		i.Text = Text
		i.tinted = tinted
		IconList.set(TabID-1,i)
		
		Dim mTab As B4XView = Tabs.Get(TabID-1)
		Dim l As Label = mTab.GetView(0)
		l.Text = i.Icon
		Dim iv As ImageView = mTab.GetView(1)
		
		If Text = "" Then
			#if b4j
			iv.PrefHeight = mTab.Height
			#else
			iv.Height=mTab.Height
			#End If
		Else
			#if b4j
			iv.PrefHeight = (mTab.Height/2)
			#else
			iv.Height=(mTab.Height/2)
			#End If
		End If
		
		#IF B4A
		Dim jo As JavaObject=iv
		jo.RunMethod("setImageBitmap",Array(i.IconImg))
		jo.RunMethod("setScaleType",Array("CENTER_INSIDE"))
		jo.RunMethod("setColorFilter",Array(Colors.Transparent))
		If i.tinted Then jo.RunMethod("setColorFilter",Array(Colors.rgb(GetARGB(IconColor)(1),GetARGB(IconColor)(2),GetARGB(IconColor)(3))))
		#ELSE IF B4i
		Dim no As NativeObject=iv
		no.SetField("contentMode",1)
		iv.Bitmap = i.IconImg
		If i.tinted Then TintBmp(iv,Colors.rgb(GetARGB(IconColor)(1),GetARGB(IconColor)(2),GetARGB(IconColor)(3)))
		#ELSE IF B4j
		iv.PreserveRatio = True
		iv.SetImage(i.IconImg)
		iv.PrefWidth = (i.IconImg.Width/i.IconImg.Height)*iv.PrefHeight
		iv.Left = (iv.Parent.PrefWidth/2)-(iv.PrefWidth/2)
		TintBmp(iv,0)
		If i.tinted Then TintBmp(iv,IconColor)
		#End If
		
		
		Dim lbl As Label = mTab.GetView(2)
		lbl.Text = Text
		
		SetCircleIcon
	Else
		Log("Invalid Tab ID")
	End If
End Sub

'Get the current tab index
Public Sub GetCurrentTab As Int
	Return CurrentTab
End Sub

'Same as SetCurrentTab. If you set triggerEvent = false then it will not trigger the tab click event.
Public Sub SetCurrentTab2(TabID As Int, triggerEvent As Boolean)
	If TabID >= 1 And TabID <= TabCount Then
		TriggerTabClickEvent(Tabs.Get(TabID-1),triggerEvent)
	Else
		Log("Invalid Tab ID")
	End If
End Sub

'Set current tab index
Public Sub SetCurrentTab(TabID As Int)
	SetCurrentTab2(TabID,True)
End Sub

'Set tab selection animation type. One of the ANIMATION_TYPE constant value.
Public Sub SetAnimationType(Animation_Type As Int)
	AnimationType = Animation_Type
End Sub

'Set tab icon revealing animation type. One of the ICON_APPEAR constant value.
Public Sub SetIconAppearStyle(Icon_Appear_Style As Int)
	IconAppearStyle = Icon_Appear_Style
End Sub

'Count must be either 5 or 3
'Note: You can't change the tab count to 3 if your selected tab id is 4 or 5
Public Sub SetTabCount(count As Int)
	If count = 3 Or count = 5 Then
		If CurrentTab > count Then
			Log("Current Tab ID: "&CurrentTab)
			Log("Cannot change tab count.")
		Else
			TabCount = count
			DrawView
		End If
	Else
		Log("Count must be either 5 or 3.")
	End If
End Sub

'Set tab badge
#if b4j
Public Sub SetBadge(TabID As Int, Count As Int, BackColor As Paint, TxtColor As Paint)
#Else
Public Sub SetBadge(TabID As Int, Count As Int, BackColor As Int, TxtColor As Int)
#End If
	If TabID >= 1 And TabID <= TabCount Then
		RemoveBadge(TabID)
		If Count>0 Then
			Dim t As B4XView = Tabs.Get(TabID-1)
			Dim l As Label
			l.Initialize("")
			Dim b4xlbl As B4XView=l
			b4xlbl.TextSize=10
			b4xlbl.TextColor=xui.PaintOrColorToColor(TxtColor)
			b4xlbl.Text = Count
			If Count>99 Then b4xlbl.Text = "99+"
			b4xlbl.SetTextAlignment("CENTER","CENTER")
			t.AddView(l,(t.Width/3)*2,5dip,t.Height/3,t.Height/3)
			
			b4xlbl.SetColorAndBorder(xui.PaintOrColorToColor(BackColor),0,xui.Color_Transparent,b4xlbl.Height/2)
			
			If TabID = CurrentTab Then b4xlbl.Visible = False
			badge.set(TabID-1,CreateMap("count":Count,"backcolor":BackColor,"textcolor":TxtColor))
		End If
	Else
		Log("Invalid Tab ID")
	End If
End Sub

'Remove tab badge
Public Sub RemoveBadge(TabID As Int)
	If TabID >= 1 And TabID <= TabCount Then
		badge.set(TabID-1,"")
		Dim t As B4XView = Tabs.Get(TabID-1)
		If t.NumberOfViews = 4 Then
			t.GetView(3).RemoveViewFromParent
		End If
	Else
		Log("Invalid Tab ID")
	End If
End Sub

'Get the menu height
Public Sub getHeight As Int
	Return mBase.Height
End Sub

'Enable/Disable a tab
Public Sub SetEnableTab(TabID As Int, enable As Boolean)
	If TabID >= 1 And TabID <= TabCount Then
		Dim t As B4XView = Tabs.Get(TabID-1)
		t.Enabled = enable
		enabled.Set(TabID-1,enable)
	Else
		Log("Invalid Tab ID")
	End If
End Sub

'Check if a tab is enabled or not
Public Sub GetEnableTab(TabID As Int) As Boolean
	If TabID >= 1 And TabID <= TabCount Then
		Return enabled.get(TabID-1)
	Else
		Log("Invalid Tab ID")
		Return False
	End If
End Sub

'Set menu visibility
Public Sub SetVisible(show As Boolean,animate As Boolean)
	If animate Then
		mBase.SetVisibleAnimated(300,show)
	Else
		mBase.Visible = show
	End If
End Sub

#End Region

#Region EventHandling

#If B4J

Private Sub IconTab_MouseClicked (EventData As MouseEvent)
	TriggerTabClickEvent(Sender,True)
End Sub

#Else

Private Sub IconTab_Click
	TriggerTabClickEvent(Sender,True)
End Sub

#End If

Private Sub TriggerTabClickEvent(t As B4XView, trigger As Boolean)
	If CurrentTab <> Tabs.IndexOf(t)+1 Then CurrentTab = Tabs.IndexOf(t)+1
	AnimateTo(TabCurve,t.Left+(t.Width/2)-(TabCurve.Width/2) - 1 )
	AnimateTo(TabCircle,t.Left+(t.Width/2)-(TabCircle.Width/2))
	
	For i=0 To TabCount-1
		Dim tb As B4XView = Tabs.Get(i)
		If tb<>t Then
			tb.GetView(0).Visible = True
			tb.GetView(1).Visible = True
			tb.GetView(2).Visible = True
			If tb.NumberOfViews = 4 Then tb.GetView(3).Visible = True
		Else
			tb.GetView(0).Visible = False
			tb.GetView(1).Visible = False
			tb.GetView(2).Visible = False
			If tb.NumberOfViews = 4 Then tb.GetView(3).Visible = False
		End If
	Next
	SetCircleIcon
	
	If trigger And xui.SubExists(mCallBack, mEventName & "_Tab"&CurrentTab&"Click",0) Then
		CallSub(mCallBack, mEventName & "_Tab"&CurrentTab&"Click")
	End If
End Sub

#End Region

#Region Functions
Private Sub AnimateTo(Element As B4XView,NewPos As Int)
	Dim n As Long = DateTime.Now
	Dim duration As Int = animDuration
	Dim currentPos As Int = Element.left
	Dim start As Float = currentPos
	currentPos = NewPos
	Dim tempValue As Float
	Do While DateTime.Now < n + duration
		tempValue = TimeWisePosition(DateTime.Now - n, start, NewPos - start, duration)
		Element.left=tempValue
		Sleep(1)
		If NewPos <> currentPos Then Return
	Loop
	Element.Left = currentPos
End Sub

'http://www.timotheegroleau.com/Flash/experiments/easing_function_generator.htms
Private Sub TimeWisePosition(ctime As Float, fromPos As Float, toPos As Float, duration As Int) As Int
	Dim ts,tc As Float
	ctime = ctime/duration
	ts=ctime*ctime
	tc=ts*ctime
	
	Select AnimationType
		Case 0: 'elastic out
			Return fromPos + toPos * (23.645*tc*ts + -73.7325*ts*ts + 86.38*tc + -46.79*ts + 11.4975*ctime)
		Case 1: 'elastic in
			Return fromPos + toPos * (34.445*tc*ts + -69.39*ts*ts + 47.395*tc + -12.4*ts + 0.95*ctime)
		Case 2: 'ease out
			Return fromPos + toPos * (tc*ts + -5*ts*ts + 10*tc + -10*ts + 5*ctime)
		Case 3: 'ease in
			Return fromPos + toPos * (tc*ts)
		Case Else: 'no easing
			Return fromPos + toPos*(ctime)
	End Select
	
End Sub

'Curve function 
Private Sub CurveTo (Path1 As BCPath, ControlPointX As Float, ControlPointY As Float, TargetX As Float, TargetY As Float)
	Dim LastPoint As InternalBCPathPointData = Path1.Points.Get(Path1.Points.Size - 1)
	Dim CurrentX As Float = LastPoint.X
	Dim Currenty As Float = LastPoint.Y
	Dim NumberOfSteps As Int = 100 '<--- change as needed
	Dim dt As Float = 1 / NumberOfSteps
	Dim t As Float = dt
	For i = 1 To NumberOfSteps
		Dim tt1 As Float =  (1 - t) * (1 - t)
		Dim tt2 As Float = 2 * (1 - t) * t
		Dim tt3 As Float = t * t
		Dim x As Float = tt1 * CurrentX + tt2 * ControlPointX + tt3 * TargetX
		Dim y As Float = tt1 * Currenty + tt2 * ControlPointY + tt3 * TargetY
		Path1.LineTo(x, y)
		t = t + dt
	Next
End Sub

'int ot argb
Private Sub GetARGB(Color As Int) As Int()
	Private res(4) As Int
	res(0) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff000000), 24)
	res(1) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)
	res(2) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)
	res(3) = Bit.And(Color, 0xff)
	Return res
End Sub

#if B4i
Private Sub TintBmp(img As ImageView, color As Int)
	Dim NaObj As NativeObject = Me
	NaObj.RunMethod("BmpColor::",Array(img,NaObj.ColorToUIColor(color)))
End Sub
#End If
#If OBJC
- (void)BmpColor: (UIImageView*) theImageView :(UIColor*) Color{
theImageView.image = [theImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
[theImageView setTintColor:Color];
}
#end if

#if B4J
Private Sub TintBmp(img As ImageView, color As Int)
	If color = 0 Then
		Dim jiv As JavaObject = img
		jiv.RunMethod("setClip",Array(Null))
		jiv.RunMethod("setEffect", Array(Null))
		Return
	End If
	color = fx.Colors.To32Bit(fx.Colors.rgb(GetARGB(color)(1),GetARGB(color)(2),GetARGB(color)(3)))
	Dim monochrome,effect,mode,tint As JavaObject
	monochrome.InitializeNewInstance("javafx.scene.effect.ColorAdjust", Null)
	monochrome.RunMethod("setSaturation", Array(-1.0))
	effect.InitializeNewInstance("javafx.scene.effect.Blend",Array(mode.InitializeStatic("javafx.scene.effect.BlendMode").GetField("SCREEN"),monochrome,tint.InitializeNewInstance("javafx.scene.effect.ColorInput",Array(0.0,0.0,img.PrefWidth,img.PrefHeight,fx.Colors.From32Bit(color)))))
	Dim jiv As JavaObject = img
	Dim imgt As ImageView
	imgt.Initialize("")
	imgt.SetImage(img.GetImage)
	imgt.SetSize(img.PrefWidth,img.PrefHeight)
	jiv.RunMethod("setClip",Array(imgt))
	jiv.RunMethod("setEffect", Array(effect))
End Sub
#End If
#End Region