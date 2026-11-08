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
	Private Search As TrieBasedSearch
	Private Dialog As B4XDialog
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	'it is already sorted
	Dim items As List = File.ReadList(File.DirAssets, "cities.txt")
	Search.Initialize
	Search.BuildIndex(items)
	Dialog.Initialize(Root)
	Dialog.Title = "Trie Based Search"
	SetDialogTheme
End Sub

Private Sub Button1_Click
	Wait For (Dialog.ShowTemplate(Search, "", "", "Cancel")) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		B4XPages.SetTitle(Me, Search.SelectedItem)
	End If
End Sub

'https://www.b4x.com/android/forum/threads/b4x-share-your-b4xdialog-templates-theming-code.131243/
Private Sub SetDialogTheme
	Dim TextColor As Int = 0xFF5B5B5B
	Search.SearchField.TextField.TextColor = TextColor
	Search.SearchField.NonFocusedHintColor = TextColor
	Search.CustomListView1.sv.ScrollViewInnerPanel.Color = 0xFFDFDFDF
	Search.CustomListView1.sv.Color = Dialog.BackgroundColor
	Search.CustomListView1.DefaultTextBackgroundColor = xui.Color_White
	Search.CustomListView1.DefaultTextColor = TextColor
	If Search.SearchField.lblV.IsInitialized Then Search.SearchField.lblV.TextColor = TextColor
	If Search.SearchField.lblClear.IsInitialized Then Search.SearchField.lblClear.TextColor = TextColor
	Dialog.BackgroundColor = xui.Color_White
	Dialog.ButtonsColor = xui.Color_White
	Dialog.BorderColor = xui.Color_Gray
	Dialog.ButtonsTextColor = 0xFF007DC3
End Sub