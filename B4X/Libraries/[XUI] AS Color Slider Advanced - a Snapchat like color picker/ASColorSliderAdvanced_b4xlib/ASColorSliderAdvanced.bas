B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
'Auhtor: Alexander Stolte
'Version: 1.01

#If Documentation
Versions:
V1.00
	-Release
V1.01
	-add BaseView property
	-better handling if you swipe fast
	-touch area is now as wide as the circle	
V1.02
	-BugFixes
#End If
#DesignerProperty: Key: BarWidth, DisplayName: Bar Width Percent, FieldType: Int, DefaultValue: 20, MinRange: 0
#DesignerProperty: Key: AnimationDuration, DisplayName: Animation Duration, FieldType: Int, DefaultValue: 250, MinRange: 0

#DesignerProperty: Key: BorderWidth, DisplayName: Border Width, FieldType: Int, DefaultValue: 2, MinRange: 0
#DesignerProperty: Key: BorderColor, DisplayName: Border Color, FieldType: Color, DefaultValue: 0xFFFFFFFF

#DesignerProperty: Key: CircleBorderWidth, DisplayName: Circle Border Width, FieldType: Int, DefaultValue: 2, MinRange: 0
#DesignerProperty: Key: CirlceBorderColor, DisplayName: Circle Border Color, FieldType: Color, DefaultValue: 0xFFFFFFFF

#Event: ColorChanged(color as int)

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	Private xiv_hue As B4XView
	Private xpnl_background As B4XView
	Private xpnl_colorcircle As B4XView
	
	Dim bc As BitmapCreator
	'Properties
	Private g_BarWidth As Int
	Private g_AnimationDuration As Int
	
	Private g_BorderWidth As Int
	Private g_BorderColor As Int
	
	Private g_CircleBorderWidth As Int
	Private g_CircleBorderColor As Int
	
	Private g_padding As Float = 30dip
	
	
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	ini_props(Props)
	xiv_hue = CreateImageview("")
	xpnl_background = xui.CreatePanel("xpnl_background")
	xpnl_colorcircle = xui.CreatePanel("")
	mBase.AddView(xpnl_background,0,0,0,0)
	mBase.AddView(xiv_hue,0,0,0,0)
	mBase.AddView(xpnl_colorcircle,0,0,0,0)
	
	bc.Initialize(mBase.Width*g_BarWidth/100/ xui.Scale,(mBase.Height - (mBase.Width - mBase.Width*g_BarWidth/100 - g_padding))/ xui.Scale)
	
	#if B4A
	Base_Resize(mBase.Width,mBase.Height)
	Private r As Reflector
	r.Target = xpnl_background
	r.SetOnTouchListener("xpnl_background_Touch2")
	#Else if B4J
	Dim jo As JavaObject = xiv_hue
	jo.RunMethod("setMouseTransparent", Array(True))
	Dim jo As JavaObject = xpnl_colorcircle
	jo.RunMethod("setMouseTransparent", Array(True))
	#Else If B4I
	Dim tmp_pnl As Panel = xpnl_colorcircle
	tmp_pnl.UserInteractionEnabled = False
	#End If
End Sub

Private Sub ini_props(props As Map)
	g_BarWidth = props.Get("BarWidth")
	g_AnimationDuration = props.Get("AnimationDuration")
	
	g_BorderWidth = props.Get("BorderWidth")
	g_BorderColor = xui.PaintOrColorToColor(props.Get("BorderColor"))
	
	g_CircleBorderWidth = props.Get("CircleBorderWidth")
	g_CircleBorderColor = xui.PaintOrColorToColor(props.Get("CirlceBorderColor"))
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	
	Dim tmp_huewidth As Float = Width*g_BarWidth/100
	
	xiv_hue.SetLayoutAnimated(0,Width - tmp_huewidth - 10dip/2,(Width - tmp_huewidth - g_padding)/2,tmp_huewidth,Height - (Width - tmp_huewidth - g_padding))
	xpnl_background.SetLayoutAnimated(0,xiv_hue.left - 10dip/2,xiv_hue.top,xiv_hue.Width + 10dip,xiv_hue.Height)
	
	xpnl_colorcircle.SetLayoutAnimated(0,xiv_hue.Left - 5dip,xiv_hue.top - (xiv_hue.Width + 10dip)/2, xiv_hue.Width + 10dip,xiv_hue.Width + 10dip)
	
	xpnl_colorcircle.SetColorAndBorder(xui.Color_Black,g_CircleBorderWidth,g_CircleBorderColor,xpnl_colorcircle.Width/2)
	xpnl_background.Color = xui.Color_Transparent
'	#If B4A
	'xiv_hue.SetColorAndBorder(xui.Color_Transparent,g_BorderWidth,g_BorderColor,xiv_hue.Width/2)
'	#End If
	DrawHueBar	
End Sub

#IF B4A
Private Sub xpnl_background_Touch2 (o As Object, ACTION As Int, x As Float, y As Float, motion As Object) As Boolean
#ELSE
Private Sub xpnl_background_Touch(Action As Int, X As Float, Y As Float) As Boolean
#END IF

	If Action = mBase.TOUCH_ACTION_DOWN Then
		Dim WidthHeight As Float = mBase.Width - xiv_hue.Width - g_padding
		
		xpnl_colorcircle.SetLayoutAnimated(g_AnimationDuration,0,xiv_hue.Top + y - (mBase.Width - xiv_hue.Width - g_padding)/2,WidthHeight,WidthHeight)
		xpnl_colorcircle.SetColorAndBorder(xpnl_colorcircle.Color,g_CircleBorderWidth,g_CircleBorderColor,WidthHeight/2)
	Else If  Action = mBase.TOUCH_ACTION_MOVE Then
		If y < xiv_hue.Height Then
			xpnl_colorcircle.Top =  Max(0,xiv_hue.Top + y - (mBase.Width - xiv_hue.Width - g_padding)/2)
			Else
			xpnl_colorcircle.Top =  Min(xiv_hue.Height ,xiv_hue.Top + y - (mBase.Width - xiv_hue.Width - g_padding)/2)
		End If
	Else If  Action = mBase.TOUCH_ACTION_UP Then
		xpnl_colorcircle.SetColorAndBorder(xpnl_colorcircle.Color,g_CircleBorderWidth,g_CircleBorderColor,(xiv_hue.Width + 10dip)/2)
		If y >= 0 And y <= xiv_hue.Height Then
			xpnl_colorcircle.SetLayoutAnimated(g_AnimationDuration,xiv_hue.Left - 5dip,xiv_hue.Top + y - (xiv_hue.Width + 10dip)/2,xiv_hue.Width + 10dip,xiv_hue.Width + 10dip)
		Else If y < 0 Then
			xpnl_colorcircle.SetLayoutAnimated(g_AnimationDuration,xiv_hue.Left - 5dip,xiv_hue.top - (xiv_hue.Width + 10dip)/2,xiv_hue.Width + 10dip,xiv_hue.Width + 10dip)
		Else
			xpnl_colorcircle.SetLayoutAnimated(g_AnimationDuration,xiv_hue.Left - 5dip,xiv_hue.top + xiv_hue.Height - (xiv_hue.Width + 10dip)/2,xiv_hue.Width + 10dip,xiv_hue.Width + 10dip)
		End If
		
	End If
	#If B4J
	If Action = mBase.TOUCH_ACTION_DOWN Or Action = mBase.TOUCH_ACTION_MOVE Or Action = mBase.TOUCH_ACTION_UP Then
		xpnl_colorcircle.Color = GetColor(y)
	End If
	#Else
	xpnl_colorcircle.Color = GetColor(y)
	#End If
	Return True
End Sub

Private Sub GetColor(y As Float) As Int
	
	Dim crl As Int = 0

	Dim tt As ImageView = xiv_hue
	#If B4J
	Dim bmp As Image = tt.GetImage
	#Else
	Dim bmp As Bitmap = tt.Bitmap
	#End If

	If y < bmp.Height And y >= 0 Then
		#If B4A
		crl = bmp.GetPixel(xiv_hue.Width/2,y)
		#Else  B4I
		crl = bc.GetColor(xiv_hue.Width/2,y)
		#End If
	Else If y < 0 Then
		crl = xui.Color_White
	Else
		crl = xui.Color_Black
	End If
	
	ColorChanged(crl)
	Return crl
End Sub


#Region Properties

Public Sub getBaseView As B4XView
	Return mBase
End Sub

Public Sub setAnimationDuration(duration As Int)
	g_AnimationDuration = duration
End Sub

Public Sub getAnimationDuration As Int
	Return g_AnimationDuration
End Sub

Public Sub setColorPaletteBitmap(palette As B4XBitmap)
	xiv_hue.SetBitmap(CreateRoundRectBitmap(palette,xiv_hue.Width/2))
End Sub

#End Region

#Region Events

Private Sub ColorChanged(Color As Int)
	If xui.SubExists(mCallBack, mEventName & "_ColorChanged",1) Then
		CallSub2(mCallBack, mEventName & "_ColorChanged",Color)
	End If
End Sub

#End Region

#Region Functions

Private Sub DrawHueBar
	For y = 0 To bc.mHeight - 1
		For x = 0 To bc.mWidth - 1
			bc.SetHSV(x, y, 255, 360 / bc.mHeight * y, 1, 1)
		Next
	Next
	xiv_hue.SetBitmap(CreateRoundRectBitmap(bc.Bitmap,xiv_hue.Width/2))
End Sub

Private Sub CreateImageview(EventName As String) As B4XView
	Dim tmp_iv As ImageView
	tmp_iv.Initialize(EventName)
	Return tmp_iv
End Sub

Private Sub CreateRoundRectBitmap (Input As B4XBitmap, Radius As Float) As B4XBitmap
	Dim c As B4XCanvas
	Dim xview As B4XView = xui.CreatePanel("")
	xview.SetLayoutAnimated(0, 0,0, xiv_hue.Width, xiv_hue.Height)
	c.Initialize(xview)
	Dim path As B4XPath
	path.InitializeRoundedRect(c.TargetRect, Radius)
	c.ClipPath(path)
	c.DrawRect(c.TargetRect, g_BorderColor, True, g_BorderWidth) 'border
	c.RemoveClip
	Dim r As B4XRect
	r.Initialize(g_BorderWidth, g_BorderWidth, c.TargetRect.Width - g_BorderWidth, c.TargetRect.Height - g_BorderWidth)
	path.InitializeRoundedRect(r, Radius - 0.7 * g_BorderWidth)
	c.ClipPath(path)
	c.DrawBitmap(Input, r)
	c.RemoveClip
	c.Invalidate
	Dim res As B4XBitmap = c.CreateBitmap
	c.Release
	Return res
End Sub

#End Region
