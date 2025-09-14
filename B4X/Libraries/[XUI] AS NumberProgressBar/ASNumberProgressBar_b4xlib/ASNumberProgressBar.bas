B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.1
@EndOfDesignText@
#If Documentation
Updates
V1.00
	-Release
V1.01
	-BugFixes
#End If

#DesignerProperty: Key: Prefix, DisplayName: Prefix, FieldType: String, DefaultValue: %
#DesignerProperty: Key: Suffix, DisplayName: Suffix, FieldType: String, DefaultValue: 

#DesignerProperty: Key: BarMax, DisplayName: Max Progress, FieldType: Int, DefaultValue: 100
#DesignerProperty: Key: BarCurrent, DisplayName: Current Progress, FieldType: Int, DefaultValue: 0

#DesignerProperty: Key: TextOffset, DisplayName: Text Offset, FieldType: Int, DefaultValue: 0
#DesignerProperty: Key: TextColor, DisplayName: Text Color, FieldType: Color, DefaultValue: 0xFF2D8879
#DesignerProperty: Key: TextColorBackground, DisplayName: Text Background Color, FieldType: Color, DefaultValue: 0xFFFFFFFF

#DesignerProperty: Key: ReachedColor, DisplayName: Reached Color, FieldType: Color, DefaultValue: 0xFF2D8879
#DesignerProperty: Key: ReachedHeight, DisplayName: Reached Height, FieldType: Int, DefaultValue: 5

#DesignerProperty: Key: UnreachedColor, DisplayName: Unreached Color, FieldType: Color, DefaultValue: 0xFF777C7C
#DesignerProperty: Key: UnreachedHeight, DisplayName: Unreached Height, FieldType: Int, DefaultValue: 2

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	
	Private xcv_lines,xcv_text As B4XCanvas
	
	Private xpnl_percent_background As B4XView
	
	Private g_text_font As B4XFont
	
	Private g_prefix As String 
	Private g_suffix As String
	
	Private g_bar_max As Int 
	Private g_bar_current As Int
	
	Private g_text_offset As Float
	Private g_text_color As Int
	Private g_text_background_color As Int
	
	Private reached_color As Int
	Private reached_height As Float
	
	Private unreached_color As Int
	Private unreached_height As Float
	
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	ini_props(Props)
	xpnl_percent_background = xui.CreatePanel("")
	mBase.AddView(xpnl_percent_background,0,0,mBase.Width,mBase.Height)
	
	xcv_lines.Initialize(mBase)
	xcv_text.Initialize(xpnl_percent_background)
	
	xpnl_percent_background.Color = xui.Color_Transparent
	
	#If B4A
	Base_Resize(mBase.Width,mBase.Height)
	#End If
	
End Sub

Private Sub ini_props(props As Map)
	g_prefix = props.Get("Prefix")
	g_suffix = props.Get("Suffix")
	
	g_bar_max = props.Get("BarMax")
	g_bar_current = props.Get("BarCurrent")
	
	g_text_offset = props.Get("TextOffset")
	g_text_color = xui.PaintOrColorToColor(props.Get("TextColor"))
	g_text_background_color = xui.PaintOrColorToColor(props.Get("TextColorBackground"))
	
	reached_color = xui.PaintOrColorToColor(props.Get("ReachedColor"))
	reached_height = props.Get("ReachedHeight")
	
	unreached_color = xui.PaintOrColorToColor(props.Get("UnreachedColor"))
	unreached_height = props.Get("UnreachedHeight")
	
	
	g_text_font = xui.CreateDefaultBoldFont(10)
	
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	xpnl_percent_background.SetLayoutAnimated(0,0,0,Width,Height)
	
	xcv_lines.Resize(Width,Height)
	xcv_text.Resize(Width,Height)
	
	Progress(g_bar_current)
	
End Sub

#Region Properties

Public Sub setTextFont(fnt As B4XFont)
	g_text_font = fnt
	Progress(g_bar_current)
End Sub

Public Sub getTextFont As B4XFont
	Return g_text_font
End Sub

Public Sub setUnreachedHeight(height As Float)
	unreached_height = height
	Progress(g_bar_current)
End Sub

Public Sub getUnreachedHeight As Float
	Return unreached_height
End Sub

Public Sub setUnreachedColor(color As Int)
	unreached_color = color
	Progress(g_bar_current)
End Sub

Public Sub getUnreachedColor As Int
	Return unreached_color
End Sub

Public Sub setReachedHeight(height As Float)
	reached_height = height
	Progress(g_bar_current)
End Sub

Public Sub getReachedHeight As Float
	Return reached_height
End Sub

Public Sub setReachedColor(color As Int)
	reached_color = color
	Progress(g_bar_current)
End Sub

Public Sub getReachedColor As Int
	Return reached_color
End Sub

Public Sub setTextBackgroundColor(color As Int)
	g_text_background_color = color
	Progress(g_bar_current)
End Sub

Public Sub getTextBackgroundColor As Int
	Return g_text_background_color
End Sub

Public Sub setTextColor(color As Int)
	g_text_color = color
	Progress(g_bar_current)
End Sub

Public Sub getTextColor As Int
	Return g_text_color
End Sub

Public Sub setTextOffset(offset As Int)
	g_text_offset = offset
	Progress(g_bar_current)
End Sub

Public Sub getTextOffset As Int
	Return g_text_offset
End Sub

Public Sub setPrefix(prefix As String)
	g_prefix = prefix
	Progress(g_bar_current)
End Sub

Public Sub getPrefix As String
	Return g_prefix
End Sub

Public Sub setSuffix(suffix As String)
	g_suffix = suffix
	Progress(g_bar_current)
End Sub

Public Sub getSuffix As String
	Return g_suffix
End Sub

Public Sub setBarMax(bar_max As Int)
	g_bar_max = bar_max
	Progress(g_bar_current)
End Sub

Public Sub getBarMax As Int
	Return g_bar_max
End Sub

Public Sub setCurrentProgress(current_progress As Int)
	g_bar_current = current_progress
	xcv_lines.ClearRect(xcv_lines.TargetRect)
	Progress(current_progress)
End Sub

Public Sub getCurrentProgress As Int
	Return g_bar_current
End Sub

Public Sub IncrementProgressBy(by As Int)
	g_bar_current = g_bar_current + by

	Progress(g_bar_current)
End Sub

Public Sub DecrementProgressBy(by As Int)
	g_bar_current = g_bar_current - by
	xcv_lines.ClearRect(xcv_lines.TargetRect)
	Progress(g_bar_current)
End Sub

#End Region

Private Sub Progress(percent As Int)
	
	Dim r As B4XRect = xcv_text.MeasureText(g_suffix & percent & g_prefix, g_text_font)
	Dim BaseLine As Int = mBase.Height/2 - r.Height / 2 - r.Top
	
	xcv_lines.DrawLine(0,mBase.Height/2,mBase.Width,mBase.Height/2,unreached_color,unreached_height)
	
	xcv_lines.DrawLine(0,mBase.Height/2,(percent * mBase.Width)/g_bar_max,mBase.Height/2,reached_color,reached_height)
	xcv_lines.Invalidate
		
	xcv_text.ClearRect(xcv_text.TargetRect)

	If (percent * mBase.Width)/g_bar_max + r.Width/2 < mBase.Width And (percent * mBase.Width)/g_bar_max - r.Width/2 > 0 Then
		xcv_text.DrawLine((percent * mBase.Width)/g_bar_max - r.Width/2 - g_text_offset/2,mBase.Height/2,(percent * mBase.Width)/g_bar_max + r.Width/2 + g_text_offset/2,mBase.Height/2,g_text_background_color,r.Height)
		xcv_text.DrawText(g_suffix & percent & g_prefix,(percent * mBase.Width)/g_bar_max,BaseLine,g_text_font,g_text_color,"CENTER")
	Else if (percent * mBase.Width)/g_bar_max + r.Width/2 >= mBase.Width Then
		xcv_text.DrawLine(mBase.Width - r.Width/2 - r.Width/2 - g_text_offset/2,mBase.Height/2,mBase.Width - r.Width/2 + r.Width/2 + g_text_offset/2,mBase.Height/2,g_text_background_color,r.Height)
		xcv_text.DrawText(g_suffix & percent & g_prefix,mBase.Width - r.Width/2,BaseLine,g_text_font,g_text_color,"CENTER")
	Else
		xcv_text.DrawLine(0 + r.Width/2 - r.Width/2 - g_text_offset/2,mBase.Height/2,0 + r.Width/2 + r.Width/2 + g_text_offset/2,mBase.Height/2,g_text_background_color,r.Height)
		xcv_text.DrawText(g_suffix & percent & g_prefix,0 + r.Width/2,BaseLine,g_text_font,g_text_color,"CENTER")
	End If
	xcv_text.Invalidate
End Sub
