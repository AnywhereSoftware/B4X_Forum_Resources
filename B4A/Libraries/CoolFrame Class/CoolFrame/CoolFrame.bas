B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
#DesignerProperty: Key: ShowBorder, 			DisplayName: Show Border, 				FieldType: Boolean, DefaultValue: True, 									Description: Show frame border
#DesignerProperty: Key: BorderAppearance, 		DisplayName: Border Appearance,			FieldType: String, 	DefaultValue: Left, List:Left|Top|Right|Bottom, 	Description: Show border appearance
#DesignerProperty: Key: BorderColor, 			DisplayName: Border Color, 				FieldType: Color, 	DefaultValue: 0xFFFFFFFF, 								Description: Frame border color
#DesignerProperty: Key: BorderWidth, 			DisplayName: Border Width, 				FieldType: Int, 	DefaultValue: 5, 										Description: Frame border width

#DesignerProperty: Key: PanelTheme, 			DisplayName: Panel Theme,				FieldType: String, 	DefaultValue: Primary, List:Primary|Secondary|Success|Danger|Warning|Info|Custom, 	Description: Show frame theme
#DesignerProperty: Key: FirstColor, 			DisplayName: First Color, 				FieldType: Color, 	DefaultValue: 0xFFFFFFFF, 								Description: Frame First gradient color
#DesignerProperty: Key: SecondColor, 			DisplayName: Second Color, 				FieldType: Color, 	DefaultValue: 0xFFFFFFFF, 								Description: Frame Second gradient color
#DesignerProperty: Key: Orientation, 			DisplayName: Color Orientation,			FieldType: String, 	DefaultValue: TopBottom, List:TopBottom|LeftRight|TopLeft_BottomRight|TopRight_BottomLeft, 	Description: Show border appearance
#DesignerProperty: Key: PanelRadius, 			DisplayName: Panel Radius, 				FieldType: Int, 	DefaultValue: 5, 										Description: Set frame corner radius

#DesignerProperty: Key: Outline, 				DisplayName: Show Outline, 				FieldType: Boolean, DefaultValue: False, 									Description: Show frame outline
#DesignerProperty: Key: OutlineColor, 			DisplayName: Outline Color, 			FieldType: Color, 	DefaultValue: 0xFFFFFFFF, 								Description: Frame outline color
#DesignerProperty: Key: OutlineWidth, 			DisplayName: Outline Width, 			FieldType: Int, 	DefaultValue: 1, 										Description: Frame outline width

'-- Author: rraswisak
'-- Version: 0.1 (20200817)
'	+ initial release

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object

	Private cpShowBorder As Boolean
	Private cpBorderAppearance As String
	Private cpBorderColor As Int
	Private cpBorderWidth As Int

	Private cpPanelTheme As String
	Private cpFirstColor As Int
	Private cpSecondColor As Int
	Private cpPanelRadius As Int
	Private cpOrientation As String
	
	Private cpOutline As Boolean
	Private cpOutlineColor As Int
	Private cpOutlineWidth As Int
	
	Private cvs As B4XCanvas
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

	cpShowBorder 		= Props.Get("ShowBorder")
	cpBorderAppearance= Props.Get("BorderAppearance")
	cpBorderColor		= xui.PaintOrColorToColor(Props.Get("BorderColor"))
	cpBorderWidth		= DipToCurrent(Props.Get("BorderWidth"))
	cpPanelTheme 		= Props.Get("PanelTheme")
	cpFirstColor 		= xui.PaintOrColorToColor(Props.Get("FirstColor"))
	cpSecondColor 		= xui.PaintOrColorToColor(Props.Get("SecondColor"))
	cpPanelRadius 		= DipToCurrent(Props.Get("PanelRadius"))
	cpOrientation		= Props.Get("Orientation")
	cpOutline			= Props.Get("Outline")
	cpOutlineColor		= xui.PaintOrColorToColor(Props.Get("OutlineColor"))
	cpOutlineWidth 		= DipToCurrent(Props.Get("OutlineWidth"))
	cvs.Initialize(mBase)
	Draw
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	cvs.Resize(Width,Height)
	Draw
End Sub

Private Sub Draw
	cvs.ClearRect(cvs.TargetRect)
	
	Dim rect As B4XRect
	Dim path As B4XPath

	
	If cpOutline = True Then
		'create outline
		path.InitializeRoundedRect(cvs.TargetRect,cpPanelRadius)
		cvs.ClipPath(path)
		cvs.DrawRect(cvs.TargetRect,cpOutlineColor,True,cpOutlineWidth)
		cvs.RemoveClip

		rect.Initialize(cpOutlineWidth,cpOutlineWidth,cvs.TargetRect.Width-cpOutlineWidth,cvs.TargetRect.Height-cpOutlineWidth)
		path.InitializeRoundedRect(rect,cpPanelRadius)
	Else
		path.InitializeRoundedRect(cvs.TargetRect,cpPanelRadius)
	End If
	cvs.ClipPath(path)
	cvs.DrawRect(cvs.TargetRect,xui.Color_White,True,0)
	
	'create frame backcolor
	Dim grad As BitmapCreator
	Dim clr(2) As Int
	
	Select cpPanelTheme
		Case "Primary"
			clr(0) = 0x64FFFFFF
			clr(1) = 0x320066FF
			cpBorderColor = 0xAF0066FF
		Case "Secondary"
			clr(0) = 0x64FFFFFF
			clr(1) = 0x32000000
			cpBorderColor = 0xAF000000
		Case "Success"
			clr(0) = 0x64FFFFFF
			clr(1) = 0x3242A100
			cpBorderColor = 0xAF42A100
		Case "Danger"
			clr(0) = 0x64FFFFFF
			clr(1) = 0x32FF1300
			cpBorderColor = 0xAFFF1300
		Case "Warning"
			clr(0) = 0x64FFFFFF
			clr(1) = 0x32FFA500
			cpBorderColor = 0xAFFFA500
		Case "Info"
			clr(0) = 0x64FFFFFF
			clr(1) = 0x320060A1
			cpBorderColor = 0xAF0060A1
		Case "Custom"
			clr(0) = cpFirstColor
			clr(1) = cpSecondColor
	End Select
	
	grad.Initialize(mBase.Width, mBase.Height)
	Select cpOrientation
		Case "TopBottom"
			grad.FillGradient(clr,grad.TargetRect,"TOP_BOTTOM")
		Case "LeftRight"
			grad.FillGradient(clr,grad.TargetRect,"LEFT_RIGHT")
		Case "TopLeft_BottomRight"
			grad.FillGradient(clr,grad.TargetRect,"TL_BR")
		Case "TopRight_BottomLeft"
			grad.FillGradient(clr,grad.TargetRect,"TR_BL")
	End Select	

	Dim brush As BCBrush = grad.CreateBrushFromBitmapCreator(grad)
	Dim bc As BitmapCreator
	bc.Initialize(mBase.Width, mBase.Height)
	bc.DrawRectRounded2(bc.TargetRect,brush,True,0,cpPanelRadius)
	rect.Initialize(0,0,mBase.Width,mBase.Height)
	cvs.DrawBitmap(bc.Bitmap, rect)

	'create border
	If cpShowBorder = True Then
		Select cpBorderAppearance
			Case "Left"
				rect.Initialize(0,0,cpBorderWidth,mBase.Height)
			Case "Top"
				rect.Initialize(0,0,mBase.Width,cpBorderWidth)
			Case "Right"
				rect.Initialize(mBase.Width-cpBorderWidth,0,mBase.Width,mBase.Height)
			Case "Bottom"
				rect.Initialize(0,mBase.Height-cpBorderWidth,mBase.Width,mBase.Height)
		End Select
	End If
	
	'if panel radius not set, so no border neither
	If cpPanelRadius = 0 Then cpBorderWidth = 0
	
	
	'clear outer unnecessary region
	path.InitializeRoundedRect(rect,cpBorderWidth)
	cvs.ClipPath(path)
	cvs.DrawRect(cvs.TargetRect,cpBorderColor,True,0)

	rect.Initialize(0,0,cvs.TargetRect.Width,cvs.TargetRect.Height)
	path.InitializeRoundedRect(rect,cpPanelRadius)
	cvs.ClipPath(path)
	
	'update canvas
	cvs.Invalidate
End Sub
