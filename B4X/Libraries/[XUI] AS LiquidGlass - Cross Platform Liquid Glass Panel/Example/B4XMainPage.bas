B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private Background As B4XView
	Private Glass As AS_LiquidGlass
	Private ClearGlass As AS_LiquidGlass
	Private Title As B4XView
	Private Caption As B4XView
	Private Hint As B4XView
	Private dark As Boolean
End Sub

Public Sub Initialize
End Sub

Private Sub B4XPage_Created(Root1 As B4XView)
	Root = Root1
	B4XPages.SetTitle(Me, "AS LiquidGlass")
	Background = xui.CreatePanel("")
	Root.AddView(Background, 0, 0, Root.Width, Root.Height)
	Glass.Initialize(Me, "Glass")
	Glass.CreateViewPerCode(Root, 20dip, 150dip, 280dip, 100dip)
	Glass.CornerRadius = 32dip
	ClearGlass.Initialize(Me, "ClearGlass")
	ClearGlass.CreateViewPerCode(Root, 20dip, 275dip, 280dip, 70dip)
	ClearGlass.CornerRadius = 35dip
	ClearGlass.BlurRadius = 1dip
	ClearGlass.GlassTint = 0x10FFFFFF
	ClearGlass.RefractionHeight = 18dip
	Title = NewLabel("Liquid Glass", 25, xui.Color_White)
	Glass.ContentPanel.AddView(Title, 0, 14dip, 280dip, 42dip)
	Caption = NewLabel("Tap to change the backdrop", 13, xui.Color_White)
	Glass.ContentPanel.AddView(Caption, 0, 55dip, 280dip, 30dip)
	Hint = NewLabel("Clear material", 18, xui.Color_White)
	ClearGlass.ContentPanel.AddView(Hint, 0, 0, 280dip, 70dip)
	'Labels must not steal clicks from the content panel.
	For Each v As B4XView In Array(Title, Caption, Hint)
		#If B4J
		v.As(JavaObject).RunMethod("setMouseTransparent", Array(True))
		#Else If B4i
		v.As(Label).UserInteractionEnabled = False
		#End If
	Next
	B4XPage_Resize(Root.Width, Root.Height)
End Sub

Private Sub NewLabel(Text As String, Size As Float, Color As Int) As B4XView
	Dim lbl As Label
	lbl.Initialize("")
	Dim result As B4XView = lbl
	result.Text = Text
	result.Font = xui.CreateDefaultBoldFont(Size)
	result.TextColor = Color
	result.SetTextAlignment("CENTER", "CENTER")
	Return result
End Sub

Private Sub B4XPage_Resize(Width As Int, Height As Int)
	If Background.IsInitialized = False Or Width <= 0 Or Height <= 0 Then Return
	Background.SetLayoutAnimated(0, 0, 0, Width, Height)
	DrawBackground
	Dim w As Float = Min(360dip, Max(1dip, Width - 40dip))
	Dim h As Float = Min(100dip, Height * 0.24)
	Dim top As Float = Max(0, (Height - h - 90dip) / 2)
	Glass.mBase.SetLayoutAnimated(0, (Width - w) / 2, top, w, h)
	ClearGlass.mBase.SetLayoutAnimated(0, (Width - w) / 2, top + h + 20dip, w, Min(70dip, Height * 0.2))
	Title.SetLayoutAnimated(0, 0, 8dip, w, h * 0.5)
	Caption.SetLayoutAnimated(0, 0, h * 0.5, w, h * 0.4)
	Hint.SetLayoutAnimated(0, 0, 0, w, ClearGlass.mBase.Height)
	Glass.Resize(w, h)
	ClearGlass.Resize(w, ClearGlass.mBase.Height)
	Glass.SetBackdropView(Background, Glass.mBase.Left, Glass.mBase.Top)
	ClearGlass.SetBackdropView(Background, ClearGlass.mBase.Left, ClearGlass.mBase.Top)
End Sub

Private Sub DrawBackground
	Dim cvs As B4XCanvas
	cvs.Initialize(Background)
	cvs.DrawRect(cvs.TargetRect, IIf(dark, 0xFF15213F, 0xFF385F92), True, 0)
	Dim palette() As Int = Array As Int(0xFFEE866B, 0xFF54C7BA, 0xFF8B80DC, 0xFFE5B758)
	For y = 0 To Ceil(Background.Height / 58dip)
		For x = 0 To Ceil(Background.Width / 58dip)
			cvs.DrawCircle(x * 58dip + 12dip, y * 58dip + 14dip, 22dip, palette((x + y) Mod palette.Length), True, 0)
		Next
	Next
	cvs.Invalidate
	cvs.Release
End Sub

Private Sub Glass_Click
	dark = Not(dark)
	DrawBackground
	Glass.Refresh
	ClearGlass.Refresh
End Sub

Private Sub ClearGlass_Click
	Glass_Click
End Sub

Private Sub B4XPage_Disappear
	Glass.StopAutoRefresh
	ClearGlass.StopAutoRefresh
End Sub

