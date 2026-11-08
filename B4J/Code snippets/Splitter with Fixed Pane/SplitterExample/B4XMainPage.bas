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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	
	Public Const splDefault As Int = -1
	Public Const splLeft As Int = 0
	Public Const splRight As Int = 1
	Public Const splTop As Int = 2
	Public Const splBottom As Int = 3

	Public KVS As KeyValueStore
	
	Private VerticalSplitter As cSplitter
	Private HorizontalSplitter As cSplitter
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
  xui.SetDataFolder("SplitterExample")
  KVS.Initialize(xui.DefaultFolder, "Options.kvs")
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)	
	Root = Root1
	
	B4XPages.SetTitle(Me, "Splitter Example")
	
	VerticalSplitter.Initialize(Root, splLeft, "VerticalSplitter")
	HorizontalSplitter.Initialize(VerticalSplitter.FlexPanel, splTop, "HorizontalSplitter")
	
	VerticalSplitter.FixedPanel.LoadLayout("MainPage")
	HorizontalSplitter.FixedPanel.LoadLayout("HorzTop")
	HorizontalSplitter.FlexPanel.LoadLayout("HorzBottom")
	
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	xui.MsgboxAsync("Hello world!", "B4X")
End Sub