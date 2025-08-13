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
	Private AS_TextFieldAdvanced1 As AS_TextFieldAdvanced
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	B4XPages.SetTitle(Me,"AS TextFieldAdvanced ComboBox Example")
	
	Dim lst_Items As List
	lst_Items.Initialize
	lst_Items.Add("Item #1")
	lst_Items.Add("Item #2")
	lst_Items.Add("Item #3")
	lst_Items.Add("Item #4")
	lst_Items.Add("Item #5")
	
	AS_TextFieldAdvanced1.SetItems(lst_Items)
	
End Sub


Private Sub AS_TextFieldAdvanced1_ComboBoxSelectedIndexChanged(Index As Int)
	Log("Selected Item Text: " & AS_TextFieldAdvanced1.Text)
End Sub