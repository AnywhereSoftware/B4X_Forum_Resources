B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=14.2
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private Themes As ThemeManager
	Private EditText1 As B4XView
End Sub

'You can add more parameters here.
Public Sub Initialize As Object
	Return Me
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Themes = B4XPages.MainPage.Themes 'just to avoid writing full the length path
	Themes.RegisterPage(Me)
End Sub

Public Sub ResetLayout
	Dim text As String = IIf(Initialized(EditText1), EditText1.Text, "")
	Root.RemoveAllViews	
	If False Then Root.LoadLayout("Page2")
	Root.LoadLayout(Themes.LayoutName("Page2"))
	Themes.SetTitle(Me, "onPrimary", "Page 2")
	#if B4A
	Themes.SetBackgroundTintList(EditText1, "primary", "border") 'EditText line color isn't set by the designer.
	#else if B4J 
	CSSUtils.SetStyleProperty(EditText1, "-fx-text-fill", Themes.CSSColorFromMap("text"))
	#end if
	EditText1.Text = text
End Sub

