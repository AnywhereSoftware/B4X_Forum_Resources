B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
	Private xui As XUI
	Type TreeViewItemData(TreeViewItemMetadata As Map, tvwItem As TreeItem, tvwItemParent As TreeItem)
	Private TreeViewItems As Map
	Private tview As TreeView
	Private tiCurrentTreeItem As TreeItem
	Private lPointerItems As List
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(tv As TreeView)
	tview = tv
	TreeViewItems.Initialize
	lPointerItems.Initialize
End Sub


'<code>
'Sub Class_Globals
'	Private Root As B4XView
'	Private xui As XUI
'	Private TreeView1 As TreeView
'   '**************************************
'	Private tvw As TreeViewHandler
'   '**************************************
'End Sub
'
'Public Sub Initialize
''	B4XPages.GetManager.LogEvents = True
'End Sub
'
''This event will be called once, before the page becomes visible.
'Private Sub B4XPage_Created (Root1 As B4XView)
'	Root = Root1
'	Root.LoadLayout("MainPage")
'	tvw.Initialize(TreeView1)
'End Sub
'
''You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.
'
'Private Sub Button1_Click
'	'It allows you to add items with MetaData you can get afterwards, both with pictures or not and save some of them that you need to reference in a List (Pointer Items)
'	
'	If TreeView1.Root.Children.Size <> 0 Then Return
'	
'	tvw.PointerItems_AddPointerItem(tvw.AddTreeItem("Treeview Item#1", Null, TreeView1.Root, CreateMap("DepID":1, "GroupID": 3)))
'	tvw.PointerItems_AddPointerItem(tvw.AddTreeItem("Treeview Item#2", xui.LoadBitmapResize(File.DirAssets, "Ampeross-Qetto-2-Music.48.png", 16, 16,True) , tvw.PointerItems_GetPointerItem(0), CreateMap("DepID":1, "GroupID": 4)))
'	tvw.AddTreeItem("Treeview Item#2-1", xui.LoadBitmapResize(File.DirAssets, "Ampeross-Qetto-2-Music.48.png", 16, 16,True) , tvw.PointerItems_GetPointerItem(1), CreateMap("DepID":1, "GroupID": 42))
'	tvw.PointerItems_AddPointerItem(tvw.AddTreeItem("Treeview Item#3", Null, TreeView1.Root, CreateMap("DepID":1, "GroupID": 5)))
'	tvw.AddTreeItem("Nikos", xui.LoadBitmapResize(File.DirAssets, "Ampeross-Qetto-2-Music.48.png", 16, 16,True) , tvw.PointerItems_GetPointerItem(2), CreateMap("DepID":1, "GroupID": 6))
'	
'End Sub
'
'
'Private Sub TreeView1_SelectedItemChanged (SelectedItem As TreeItem)
'	tvw.CurrentTreeItem = SelectedItem
'End Sub
'
'Private Sub Button2_Click
'	Log(tvw.GetTreeItemData(tvw.CurrentTreeItem))
'End Sub
'
'Private Sub Button3_Click
'	Log(tvw.GetTreeItemData(tvw.PointerItems_GetPointerItem(0)))
'End Sub
'
'Private Sub Button4_Click
'	tvw.ExpandAllTree
'End Sub
'
'Private Sub Button5_Click
'	tvw.ExpandTreeItem(tvw.CurrentTreeItem, True)
'End Sub
'
'Private Sub Button6_Click
'	tvw.ExpandTreeItem(tvw.CurrentTreeItem, False)
'End Sub
'
'Private Sub Button7_Click
'	tvw.CollapseAllTree
'End Sub
'
'Private Sub Button8_Click
'	tvw.CollapseTreeItem(tvw.CurrentTreeItem, True)
'End Sub
'
'Private Sub Button9_Click
'	tvw.CollapseTreeItem(tvw.CurrentTreeItem, False)
'End Sub
'
'Private Sub Button10_Click
'	Dim lList As List = tvw.GetAllSiblingsOfTreeItem(tvw.CurrentTreeItem, False)
'	For Each ti As TreeItem In lList
'		Log(ti.Text)
'	Next
'End Sub
'
'Private Sub Button11_Click
'	Dim lList As List = tvw.GetAllSiblingsOfTreeItem(tvw.CurrentTreeItem, True)
'	For Each ti As TreeItem In lList
'		Log(ti.Text)
'	Next
'End Sub
'</code>
Public Sub Instructions
	
End Sub




Public Sub AddTreeItem(Text As String, Image As B4XBitmap, Parent As TreeItem, TreeViewItemMetadata As Map) As TreeItem
	Dim ti As TreeItem
	ti.Initialize("ti", Text)
	If Image.IsInitialized = True Then
		ti.Image = Image
	End If
	
	
	Dim tid As TreeViewItemData
	tid.Initialize
	tid.TreeViewItemMetadata = TreeViewItemMetadata
	tid.tvwItem = ti
	tid.tvwItemParent = Parent

	tview.PickOnBounds = True
	
	TreeViewItems.Put(ti, tid)
	Parent.Children.Add(ti)
	Return ti
End Sub


Public Sub GetTreeItemData(ti As TreeItem) As TreeViewItemData
	Return TreeViewItems.Get(ti).As(TreeViewItemData)
End Sub

Public Sub GetAllSiblingsOfTreeItem(ti As TreeItem, IncludeCurrentTreeItem As Boolean) As List
	Dim lRet As List
	lRet.Initialize
	lRet.AddAll(ti.Parent.Children)
	If IncludeCurrentTreeItem Then
		'
	Else
		lRet.RemoveAt(lRet.IndexOf(ti))
	End If
	Return lRet
End Sub

Public Sub setCurrentTreeItem(ti As TreeItem)
	tiCurrentTreeItem = ti
End Sub

Public Sub getCurrentTreeItem As TreeItem
	Return tiCurrentTreeItem
End Sub

Public Sub ExpandAllTree
	ExpandTreeItem(tview.Root, True)
End Sub

Public Sub ExpandTreeItem(ti As TreeItem, ExpandAlsoChildren As Boolean)
	ti.Expanded = True
	If ExpandAlsoChildren = True Then
		For Each tich As TreeItem In ti.Children
			tich.Expanded = True
			ExpandTreeItem(tich, ExpandAlsoChildren)
		Next
	End If
End Sub

Public Sub CollapseAllTree
	CollapseTreeItem(tview.Root, True)
	tview.Root.Expanded = True
End Sub

Public Sub CollapseTreeItem(ti As TreeItem, CollapseAlsoChildren As Boolean)
	
	If CollapseAlsoChildren = True Then
		For Each tich As TreeItem In ti.Children
			tich.Expanded = False
			CollapseTreeItem(tich, CollapseAlsoChildren)
		Next
	End If
	ti.Expanded = False
End Sub

Public Sub RemoveTreeItem(ti As TreeItem)
	If ti.Root Then
		
	Else
		ti.Parent.Children.RemoveAt(ti.Parent.Children.IndexOf(ti))
	End If
End Sub


Public Sub PointerItems_AddPointerItem(ti As TreeItem)
	lPointerItems.Add(ti)
End Sub

Public Sub PointerItems_GetPointerItem(Index As Int) As TreeItem
	Return lPointerItems.Get(Index)
End Sub

Public Sub PointerItems_SetPointerItem(Index As Int, ti As TreeItem)
	Try
		lPointerItems.Set(Index, ti)
	Catch
		Log(LastException)
	End Try
	
End Sub

Public Sub PointerItems_RemovePointerItemWithItem(ti As TreeItem)
	PointerItems_RemovePointerItemWithIndex(lPointerItems.IndexOf(ti))
End Sub

Public Sub PointerItems_RemovePointerItemWithIndex(Index As Int)
	Try
		lPointerItems.RemoveAt(Index)
	Catch
		Log(LastException)
	End Try
End Sub