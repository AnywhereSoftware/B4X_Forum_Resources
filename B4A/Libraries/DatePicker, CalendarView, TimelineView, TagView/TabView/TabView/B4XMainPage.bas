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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private TabView1 As TabView
	Private btnLayout1 As Button
	Dim tab1 As Panel
	Dim tab2 As Panel
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	TabView1.AddTab("Home")
	TabView1.AddTab("My Tier")
	TabView1.AddTab("Activities")
	
	TabView1.DrawTab
	
	tab1.Initialize("")
	tab1.LoadLayout("layout1")
	
	tab2.Initialize("")
	tab2.LoadLayout("layout2")
	
	TabView1.SetLayout(0, tab1)
	TabView1.SetLayout(1, tab2)
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub btnLayout1_Click
	xui.MsgboxAsync("Hello world!", "B4X")
End Sub


Private Sub TabView1_TabChanged(tabIndex As Int)
	Log("Tab index = " & tabIndex)
End Sub