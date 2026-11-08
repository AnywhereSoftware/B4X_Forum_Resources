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

'https://www.b4x.com/android/forum/threads/b4x-comment-links.119897/


'You will need B4XLibTemplate to use the following

'******************************************************************************************
'TODO: Initialy Ctrl+A --> Ctrl+H --> Replace "B4XLibFilename" with "{MyLibName}.b4xlib"
'******************************************************************************************

'Edit manifest.txt: ide://run?file=%WINDIR%\System32\notepad.exe&Args=%PROJECT%\..\manifest.txt


'1 - Create the B4XLib and open it in Winrar for editing (you can double click manifest.txt edit it, save it and close it in order to be updated in b4xlib. You can also delete files or directories
'Ctrl + click to build b4xlib: 'ide://run?file=C:\B4X\MyCode\b4xlibcreate.bat&Args=%PROJECT%\..&Args=%JAVABIN%&Args=NHTreeViewHandler.b4xlib

'2 - Move to B4X special sub-folder of additional libraries folder
'Ctrl + click to move b4xlib to Additional Libraries B4X sub-folder: 
'ide://run?file=C:\B4X\MyCode\b4xlibmoveonadditionalb4xlibs.bat&Args=%PROJECT%\..\NHTreeViewHandler.b4xlib&Args=%ADDITIONAL%\..\B4J
'If you accidentally hit the previous line link but you intented for B4X lib then click the immediately bellow link:
'ide://run?file=C:\B4X\MyCode\b4xlibdeleteifmistake.bat&Args=%ADDITIONAL%\..\B4J\NHTreeViewHandler.b4xlib



Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private TreeView1 As TreeView
	'**************************************
	Private tvw As TreeViewHandler
	'**************************************
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	tvw.Initialize(TreeView1)
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	'It allows you to add items with MetaData you can get afterwards, both with pictures or not and save some of them that you need to reference in a List (Pointer Items)

	If TreeView1.Root.Children.Size <> 0 Then Return

	tvw.PointerItems_AddPointerItem(tvw.AddTreeItem("Treeview Item#1", Null, TreeView1.Root, CreateMap("DepID":1, "GroupID": 3)))
	tvw.PointerItems_AddPointerItem(tvw.AddTreeItem("Treeview Item#2", xui.LoadBitmapResize(File.DirAssets, "Ampeross-Qetto-2-Music.48.png", 16, 16,True) , tvw.PointerItems_GetPointerItem(0), CreateMap("DepID":1, "GroupID": 4)))
	tvw.AddTreeItem("Treeview Item#2-1", xui.LoadBitmapResize(File.DirAssets, "Ampeross-Qetto-2-Music.48.png", 16, 16,True) , tvw.PointerItems_GetPointerItem(1), CreateMap("DepID":1, "GroupID": 42))
	tvw.PointerItems_AddPointerItem(tvw.AddTreeItem("Treeview Item#3", Null, TreeView1.Root, CreateMap("DepID":1, "GroupID": 5)))
	tvw.AddTreeItem("Nikos", xui.LoadBitmapResize(File.DirAssets, "Ampeross-Qetto-2-Music.48.png", 16, 16,True) , tvw.PointerItems_GetPointerItem(2), CreateMap("DepID":1, "GroupID": 6))

End Sub


Private Sub TreeView1_SelectedItemChanged (SelectedItem As TreeItem)
	tvw.CurrentTreeItem = SelectedItem
End Sub

Private Sub Button2_Click
	Log(tvw.GetTreeItemData(tvw.CurrentTreeItem))
End Sub

Private Sub Button3_Click
	Log(tvw.GetTreeItemData(tvw.PointerItems_GetPointerItem(0)))
End Sub

Private Sub Button4_Click
	tvw.ExpandAllTree
End Sub

Private Sub Button5_Click
	tvw.ExpandTreeItem(tvw.CurrentTreeItem, True)
End Sub

Private Sub Button6_Click
	tvw.ExpandTreeItem(tvw.CurrentTreeItem, False)
End Sub

Private Sub Button7_Click
	tvw.CollapseAllTree
End Sub

Private Sub Button8_Click
	tvw.CollapseTreeItem(tvw.CurrentTreeItem, True)
End Sub

Private Sub Button9_Click
	tvw.CollapseTreeItem(tvw.CurrentTreeItem, False)
End Sub

Private Sub Button10_Click
	Dim lList As List = tvw.GetAllSiblingsOfTreeItem(tvw.CurrentTreeItem, False)
	For Each ti As TreeItem In lList
		Log(ti.Text)
	Next
End Sub

Private Sub Button11_Click
	Dim lList As List = tvw.GetAllSiblingsOfTreeItem(tvw.CurrentTreeItem, True)
	For Each ti As TreeItem In lList
		Log(ti.Text)
	Next
End Sub