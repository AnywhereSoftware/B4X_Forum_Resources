B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Public txtUser As B4XFloatTextField
	Private btnLogin As B4XView
	Public Page2 As B4XPage2
	Public Page3 As B4XPage3
	Type PagePosition (Left As Int, Top As Int, Width As Int, Height As Int, IsIconified As Boolean)
	Private kvs As KeyValueStore
End Sub

'You can add more parameters here.
Public Sub Initialize

End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	xui.SetDataFolder("ThreePagesExample")
	kvs.Initialize(xui.DefaultFolder, "kvs.dat")
	Root.LoadLayout("Login")
	Page2.Initialize
	B4XPages.AddPage("Page 2", Page2)
	Page3.Initialize
	B4XPages.AddPage("Page 3", Page3)
	B4XPages.MainPage.LoadPagePosition(Me)
End Sub

Private Sub B4XPage_Background
	B4XPages.MainPage.SavePagePosition(Me)
End Sub

Public Sub SavePagePosition (Page As Object)
	Dim f As Form = B4XPages.GetNativeParent(Page)
	If f = Null Or f.IsInitialized = False Then Return
	kvs.Put(B4XPages.GetPageId(Page), FormToPP(f))	
End Sub

Public Sub LoadPagePosition (Page As Object)
	Dim f As Form = B4XPages.GetNativeParent(Page)
	Dim pp As PagePosition = kvs.Get(B4XPages.GetPageId(Page))
	If pp = Null Then Return
	SetFormFromMap(pp, f)
End Sub

Private Sub FormToPP (f As Form) As PagePosition
	Return CreatePagePosition(f.WindowLeft, f.WindowTop, f.WindowWidth, f.WindowHeight, f.As(JavaObject).GetFieldJO("stage").RunMethod("isIconified", Null))
End Sub


Private Sub SetFormFromMap(pp As PagePosition, f As Form)
	f.WindowLeft = pp.Left
	f.WindowTop = pp.Top
	f.WindowWidth = pp.Width
	f.WindowHeight = pp.Height
	Dim iconified As Boolean = pp.IsIconified
	If iconified Then
		Dim jo As JavaObject = f
		jo.GetFieldJO("stage").RunMethod("setIconified", Array(iconified))
	End If
	'check that left and top are in screen boundaries
	Dim goodLeft, goodTop As Boolean
	Dim fx As JFX
	For Each screen As Screen In fx.Screens
		If f.WindowLeft >= screen.MinX And f.WindowLeft <= screen.MaxX Then
			goodLeft = True
		End If
		If f.WindowTop >= screen.MinY And f.WindowTop <= screen.MaxY Then
			goodTop = True
		End If
	Next
	If Not(goodLeft) Then f.WindowLeft = 0
	If Not(goodTop) Then f.WindowTop = 0
End Sub

Private Sub CreatePagePosition (Left As Int, Top As Int, Width As Int, Height As Int, IsIconified As Boolean) As PagePosition
	Dim t1 As PagePosition
	t1.Initialize
	t1.Left = Left
	t1.Top = Top
	t1.Width = Width
	t1.Height = Height
	t1.IsIconified = IsIconified
	Return t1
End Sub

Sub btnLogin_Click
	B4XPages.ShowPageAndRemovePreviousPages("Page 2")
End Sub

Sub txtUser_TextChanged (Old As String, New As String)
	btnLogin.Enabled = New.Length > 0
End Sub

Sub txtUser_EnterPressed
	If btnLogin.Enabled Then btnLogin_Click
End Sub

Sub B4XPage_Appear
	txtUser.Text = ""
End Sub

