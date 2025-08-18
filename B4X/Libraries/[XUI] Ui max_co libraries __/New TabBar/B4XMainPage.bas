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
	Private UM_TabBar21 As UM_TabBar2
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	UM_TabBar21.AddText("B4A")
	UM_TabBar21.AddText("B4i")
	UM_TabBar21.AddText("B4J")
	UM_TabBar21.Fonts(xui.CreateDefaultBoldFont(16))
	
	UM_TabBar21.Show
	
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	UM_TabBar21.TextSize(12)
End Sub

Private Sub UM_TabBar21_itemYouClicked (ItemName As String,ItemIndex As Int)
	Log(ItemName)
	Log(ItemIndex)
End Sub