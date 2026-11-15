B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region
#CustomBuildAction: folders ready, %ADDITIONAL%\..\B4X\ThemeCreator.jar, %PROJECT%\Files

#Macro: Title, Export B4XPages, ide://run?File=%B4X%\Zipper.jar&Args=ThemeManager.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Public Themes As ThemeManager
	Private CustomListView1 As CustomListView
	Private AnotherProgressBar1 As AnotherProgressBar
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
	B4XPages.GetManager.TransitionAnimationDuration = 0
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Themes.Initialize("green")
	Themes.RegisterPage(Me) 'ResetLayout will be called
	
	Dim p2 As Page2
	B4XPages.AddPage("page2", p2.Initialize)
End Sub

Private Sub ResetLayout
	If Initialized(AnotherProgressBar1) Then AnotherProgressBar1.Visible = False 'stop the previous one
	Root.RemoveAllViews
	Themes.SetBars("primary", "onPrimary") 'should only be called from main page
	If False Then Root.LoadLayout("MainPage") 'to remove warnings and for the useful Ctrl + Click
	Root.LoadLayout(Themes.LayoutName("MainPage")) 'load layouts with Theme.LayoutName
	Themes.SetTitle(Me, "onPrimary", "Themes Example") 'should be called from each page
	For i = 1 To 10
		Dim p As B4XView = xui.CreatePanel("")
		p.SetLayoutAnimated(0, 0, 0, CustomListView1.AsView.Width, 110dip)
		p.Color = Themes.ColorFromMap("surface") 'get color for runtime usage
		If False Then p.LoadLayout("ItemLayout")
		p.LoadLayout(Themes.LayoutName("ItemLayout"))
		p.GetView(0).Text = "This is the title"
		p.GetView(1).Text = "Item #" & i
		CustomListView1.Add(p, "")
	Next
End Sub


Private Sub btnLight_Click
	Themes.SetTheme("light")
End Sub

Private Sub btnDark_Click
	Themes.SetTheme("dark")
End Sub

Private Sub btnPage2_Click
	B4XPages.ShowPage("page2")
End Sub