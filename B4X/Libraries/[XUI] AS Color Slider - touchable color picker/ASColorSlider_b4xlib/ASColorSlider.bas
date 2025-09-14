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
	-DesignerProperty BugFix
V1.02
	-BugFix
#End If

#DesignerProperty: Key: BorderWidth, DisplayName: Border Width, FieldType: Int, DefaultValue: 2, MinRange: 0
#DesignerProperty: Key: BorderColor, DisplayName: Border Color, FieldType: Color, DefaultValue: 0xFFFFFFFF

#Event: ColorChanged(color as int)

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	Private xiv_hue As B4XView
	Private xpnl_background As B4XView
	Dim bc As BitmapCreator
	'Properties
	Private g_BorderWidth As Int
	Private g_BorderColor As Int
	
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
	mBase.AddView(xpnl_background,0,0,0,0)
	mBase.AddView(xiv_hue,0,0,0,0)
	bc.Initialize(mBase.Width/ xui.Scale,mBase.Height/ xui.Scale)
	
	#if B4A
	Base_Resize(mBase.Width,mBase.Height)
	Private r As Reflector
	r.Target = xpnl_background
	r.SetOnTouchListener("xpnl_background_Touch2")
	#Else if B4J
	Dim jo As JavaObject = xiv_hue
	jo.RunMethod("setMouseTransparent", Array(True))
	#End If
End Sub

Private Sub ini_props(props As Map)
	g_BorderWidth = props.Get("BorderWidth")
	g_BorderColor = xui.PaintOrColorToColor(props.Get("BorderColor"))
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	xiv_hue.SetLayoutAnimated(0,0,0,Width,Height)
	xpnl_background.SetLayoutAnimated(0,0,0,Width,Height)
	xpnl_background.Color = xui.Color_Transparent
	#If B4A
	xiv_hue.SetColorAndBorder(xui.Color_Transparent,0,0,Height/2)
	#End If
	DrawHueBar	
End Sub

#IF B4A
Private Sub xpnl_background_Touch2 (o As Object, ACTION As Int, x As Float, y As Float, motion As Object) As Boolean
#ELSE
Private Sub xpnl_background_Touch(Action As Int, X As Float, Y As Float) As Boolean
#END IF
#If B4J
	If Action = mBase.TOUCH_ACTION_DOWN Or Action = mBase.TOUCH_ACTION_MOVE Or Action = mBase.TOUCH_ACTION_UP Then
	GetColor(y)
	End If
#Else
GetColor(y)
#End If
	Return True
End Sub

Private Sub GetColor(y As Float)
	
	Dim crl As Int = 0

	Dim tt As ImageView = xiv_hue
	#If B4J
	Dim bmp As Image = tt.GetImage
	#Else
	Dim bmp As Bitmap = tt.Bitmap
	#End If

	If y < bmp.Height And y >= 0 Then
		#If B4A
		crl = bmp.GetPixel(mBase.Width/2,y)
		#Else  B4I
		crl = bc.GetColor(mBase.Width/2,y)
		#End If
	Else If y < 0 Then
		crl = xui.Color_White
	Else
		crl = xui.Color_Black
	End If
	
	CallSub2(mCallBack, mEventName & "_ColorChanged",crl)
	
End Sub


#Region Properties

Public Sub setColorPaletteBitmap(palette As B4XBitmap)
	xiv_hue.SetBitmap(CreateRoundRectBitmap(palette,mBase.Width/2))
End Sub

#End Region

#Region Functions

Private Sub DrawHueBar
	For y = 0 To bc.mHeight - 1
		For x = 0 To bc.mWidth - 1
			bc.SetHSV(x, y, 255, 360 / bc.mHeight * y, 1, 1)
		Next
	Next
	xiv_hue.SetBitmap(CreateRoundRectBitmap(bc.Bitmap,mBase.Width/2))
End Sub

Private Sub CreateImageview(EventName As String) As B4XView
	Dim tmp_iv As ImageView
	tmp_iv.Initialize(EventName)
	Return tmp_iv
End Sub

Private Sub CreateRoundRectBitmap (Input As B4XBitmap, Radius As Float) As B4XBitmap
	Dim c As B4XCanvas
	Dim xview As B4XView = xui.CreatePanel("")
	xview.SetLayoutAnimated(0, 0, 0, mBase.Width, mBase.Height)
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
