B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.31
@EndOfDesignText@
'Author: Alexander Stolte
'Version: 1.0

#DesignerProperty: Key: orientations, DisplayName: Orientation, FieldType: String, DefaultValue: TL_BR, List: TL_BR|TOP_BOTTOM|TR_BL|LEFT_RIGHT|RIGHT_LEFT|BL_TR|BOTTOM_TOP|BR_TL|RECTANGLE

#DesignerProperty: Key: colorrange, DisplayName: Color Range, FieldType: Int, DefaultValue: 4, MinRange: 2, MaxRange: 4, Description: Min 2 Colors, Max 4 Colors, if you need more, add this view per code...
#DesignerProperty: Key: color1, DisplayName: Color 1, FieldType: Color, DefaultValue: 0xFF2D8879, Description: colors of Gradients
#DesignerProperty: Key: color2, DisplayName: Color 2, FieldType: Color, DefaultValue: 0xFF8E44AD, Description: colors of Gradients
#DesignerProperty: Key: color3, DisplayName: Color 3, FieldType: Color, DefaultValue: 0xFF4862A3, Description: colors of Gradients
#DesignerProperty: Key: color4, DisplayName: Color 4, FieldType: Color, DefaultValue: 0xFFC0392B, Description: colors of Gradients

#DesignerProperty: Key: cornerradius, DisplayName: Corner Radius, FieldType: Int, DefaultValue: 0, MinRange: 0, MaxRange: 100, Description: set the corner radius

#Event: Click

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	
	Private crl() As Int 
	Private orientations As String
	Private colorrange As Int
	Private cornerradius As Double
	Private xiv As B4XView
	
	Private ispercode As Boolean = False
End Sub

#Region IniClass

Private Sub ini_properties(Props As Map)
	
	orientations = Props.Get("orientations")
	colorrange = Props.Get("colorrange")
	cornerradius = Props.Get("cornerradius")
	
	If colorrange = 2 Then
		crl = Array As Int(xui.PaintOrColorToColor(Props.Get("color1")),xui.PaintOrColorToColor(Props.Get("color2")))
		Else If colorrange = 3 Then
		crl = Array As Int(xui.PaintOrColorToColor(Props.Get("color1")),xui.PaintOrColorToColor(Props.Get("color2")),xui.PaintOrColorToColor(Props.Get("color3")))
			Else
		crl = Array As Int(xui.PaintOrColorToColor(Props.Get("color1")),xui.PaintOrColorToColor(Props.Get("color2")),xui.PaintOrColorToColor(Props.Get("color3")),xui.PaintOrColorToColor(Props.Get("color4")))
	End If
	
End Sub

Private Sub ini_view
	
	xiv = xui.CreatePanel("xiv")
	mBase.AddView(xiv,0,0,mBase.Width,mBase.Height)
	
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
  	
	If ispercode = False Then ini_properties(Props)
	ini_view
	
	BuildGradients
	
	#If B4A
	Base_Resize(mBase.Width,mBase.Height)
	#End If
End Sub

#End Region

Private Sub Base_Resize (Width As Double, Height As Double)
  
	mBase.SetLayoutAnimated(0,mBase.Left,mBase.top,Width,Height)
	xiv.SetLayoutAnimated(0,0,0,Width,Height)
	BuildGradients
  
End Sub

'Adds the view per code, note the Base_Resize event is not fired on this method, you have to resize the view on your own
Public Sub AddViewPerCode(Base As B4XView,pcolors() As Int,pOrientation As String)

	ispercode = True
	
	crl = pcolors
	orientations =	pOrientation
	
	Dim tmp_map As Map
	tmp_map.Initialize
	DesignerCreateView(Base,CreateLabel(""),tmp_map)
	
End Sub

Public Sub GetBase As B4XView
	
	Return mBase
	
End Sub

Public Sub GetBaseGradient As B4XView
	
	Return xiv
	
End Sub

'Build the Gradient new based on the mBase width and height
Public Sub RefreshGradient
	
	BuildGradients
	
End Sub

'Triggers the Base_Resize event
Public Sub RefreshView
	
	Base_Resize(mBase.Width,mBase.Height)
	
End Sub

Private Sub BuildGradients
	Dim cvs As B4XCanvas
	xiv.RemoveAllViews
	mBase.Color = xui.Color_Transparent
	cvs.Initialize(xiv)
	
	Dim p As B4XPath
	Dim r As B4XRect
	r.Initialize(0, 0,mBase.Width,mBase.Height)

	p.InitializeRoundedRect(r, cornerradius)
	cvs.ClipPath(p)
	Dim bc As BitmapCreator
	bc.Initialize(mBase.Width / xui.Scale, mBase.Height / xui.Scale)
	bc.FillGradient(crl, bc.TargetRect, orientations)
	cvs.DrawBitmap(bc.Bitmap, cvs.TargetRect)

	cvs.RemoveClip
	'r.Initialize(mBase.Left + mBase.Width, mBase.Top + mBase.Height,mBase.Left , mBase.Top)
	'r.Initialize(0, 0,mBase.Width , mBase.Height)
	p.InitializeRoundedRect(r, cornerradius)
	cvs.ClipPath(p)
	cvs.RemoveClip
	cvs.Invalidate
	cvs.Release
End Sub


#Region Properties

Public Sub getColors As Int()
	
	Return crl
	
End Sub

Public Sub setColors(pcolors() As Int)
	
	crl = pcolors
	
End Sub

Public Sub getOrientations As String
	
	Return orientations
	
End Sub

Public Sub setOrientations(pOrientation As String)
	
	orientations = pOrientation
End Sub

Public Sub getCornerRadius As Double
	
	Return cornerradius
	
End Sub

Public Sub setCornerRadius(pCornerRadius As Double)
	
	cornerradius = pCornerRadius
	
End Sub

#End Region

#Region Orientations

'Top Left - Bottom Right
Public Sub getTL_BR As String
	
	Return "TL_BR"
	
End Sub

Public Sub getTOP_BOTTOM As String
	
	Return "TOP_BOTTOM"
	
End Sub

'Top Right - Bottom Left
Public Sub getTR_BL As String
	
	Return "TR_BL"
	
End Sub

Public Sub getLEFT_RIGHT As String
	
	Return "LEFT_RIGHT"
	
End Sub

Public Sub getRIGHT_LEFT As String
	
	Return "RIGHT_LEFT"
	
End Sub

'Bottom Left - Top Right
Public Sub getBL_TR As String
	
	Return "BL_TR"
	
End Sub

Public Sub getBOTTOM_TOP As String
	
	Return "BOTTOM_TOP"
	
End Sub

'Bottom Right - Top Left
Public Sub getBR_TL As String
	
	Return "BR_TL"
	
End Sub

Public Sub getRECTANGLE As String
	
	Return "RECTANGLE"
	
End Sub

#End Region

#Region Events

#If B4J

Private Sub xiv_MouseClicked (EventData As MouseEvent)
	
	If xui.SubExists(mCallBack, mEventName & "_Click", 2) Then
		CallSub(mCallBack, mEventName & "_Click")
	End If
	
End Sub

#Else

Private Sub xiv_Click
	
	If xui.SubExists(mCallBack, mEventName & "_Click", 2) Then
		CallSub(mCallBack, mEventName & "_Click")
	End If
	
End Sub

#End if

#End Region

#Region Functions

Private Sub CreateLabel(EventName As String)As B4XView
	
	Dim lbl As Label
	lbl.Initialize(EventName)
	Return lbl
	
End Sub

Public Sub generate_rnd_clr As Int
	
	Return xui.Color_ARGB(255,Rnd(1,254),Rnd(1,254),Rnd(1,254))
	
End Sub

#End Region