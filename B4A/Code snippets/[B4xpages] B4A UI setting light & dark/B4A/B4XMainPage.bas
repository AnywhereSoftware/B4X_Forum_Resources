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
	Private CmdDark As Button
	Private cmdLight As Button
	Public PageImpostazioni As FrmSetting
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
	PageImpostazioni.Initialize
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.AddPage("FrmSetting",PageImpostazioni)
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.



Private Sub cmdLight_Click
	B4XPages.MainPage.PageImpostazioni.Dark=0
	
	B4XPages.ShowPage("FrmSetting")
	B4XPages.MainPage.PageImpostazioni.CreaVoci
End Sub

Private Sub CmdDark_Click
	B4XPages.MainPage.PageImpostazioni.Dark=1
	
	B4XPages.ShowPage("FrmSetting")
	B4XPages.MainPage.PageImpostazioni.CreaVoci
End Sub