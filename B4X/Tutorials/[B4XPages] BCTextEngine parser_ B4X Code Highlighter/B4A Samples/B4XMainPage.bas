B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.9
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private BBCodeView1 As BBCodeView
	Private TextEngine As BCTextEngine
	Private Highlighter As B4XSimpleCodeHighlighter
	Private B4XPlusMinus1 As B4XPlusMinus
End Sub

'You can add more parameters here.
Public Sub Initialize As Object
	Return Me
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	Root.LoadLayout("1")
	TextEngine.Initialize(Root)
	Highlighter.Initialize(TextEngine)
	B4XPlusMinus1.SetStringItems(Array("Light Theme", "Dark Theme"))
	SetTheme("Dark Theme")
End Sub

Private Sub SetTheme(Theme As String)
	B4XPlusMinus1.SelectedValue = Theme
	Dim BackgroundColor As Int
	If Theme = "Light Theme" Then
		Highlighter.TokenColors = CreateMap(Highlighter.TOKEN_COMMENT: 0xFF0A9100, Highlighter.TOKEN_STRING: 0xFFC00000, Highlighter.TOKEN_NUMBER: 0xFF7B00FF, _
			Highlighter.TOKEN_KEYWORD: 0xFF1300FF, Highlighter.TOKEN_LINENUMBER: 0xFF00B6FF, Highlighter.TOKEN_TYPE: 0xFF00AEFF, Highlighter.TOKEN_ATTRIBUTE: 0xFFFF4100, _
			Highlighter.TOKEN_DEFAULT: xui.Color_Black, Highlighter.TOKEN_IDENTIFIER: xui.Color_Black, Highlighter.TOKEN_SUBNAME: xui.Color_Black)
		BackgroundColor = xui.Color_White
	Else If Theme = "Dark Theme" Then
		Highlighter.TokenColors = CreateMap(Highlighter.TOKEN_COMMENT: 0xFF0A9100, Highlighter.TOKEN_STRING: 0xFFF45E77, Highlighter.TOKEN_NUMBER: 0xFF7B00FF, _
			Highlighter.TOKEN_KEYWORD: 0xFF5E7CF4, Highlighter.TOKEN_LINENUMBER: 0xFF00B6FF, Highlighter.TOKEN_TYPE: 0xFF00AEFF, Highlighter.TOKEN_ATTRIBUTE: 0xFFFF4100, _
			Highlighter.TOKEN_DEFAULT: xui.Color_White, Highlighter.TOKEN_IDENTIFIER: xui.Color_White, Highlighter.TOKEN_SUBNAME: xui.Color_White)
		BackgroundColor = xui.Color_Black
	End If
	BBCodeView1.mBase.Color = BackgroundColor
	BBCodeView1.sv.Color = BackgroundColor
	BBCodeView1.sv.ScrollViewInnerPanel.Color = BackgroundColor
	B4XPlusMinus1.mBase.Parent.Color = BackgroundColor
	BBCodeView1.ExternalRuns = Highlighter.Parse(File.ReadString(File.DirAssets, "Code.txt"))
	BBCodeView1.ParseAndDraw
End Sub


Sub B4XPlusMinus1_ValueChanged (Value As Object)
	SetTheme(Value)
End Sub