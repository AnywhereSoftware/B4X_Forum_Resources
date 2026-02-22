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
	Private Panel1 As Panel
	Dim vTagView As TagView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	vTagView.Initialize(Me, "vTagView", Panel1.Width, Panel1.Height)
	Panel1.AddView(vTagView.GetView, 0,0, Panel1.Width, Panel1.Height)
	
	Dim items_tag As Map
	items_tag.Initialize
	items_tag.Put("Apple", False)	
	items_tag.Put("Banana", True) ' selected
	items_tag.Put("Alpine Strawberry", False)
	items_tag.Put("Banana Banana", False)
	items_tag.Put("Amaou Strawberries", False)
	items_tag.Put("Banana Banana", False)
	items_tag.Put("Acerola Cherries", False)
	items_tag.Put("African Breadfruit", False)
	items_tag.Put("Akebi Fruit", False)	
	items_tag.Put("African Mango", True)  ' selected
	items_tag.Put("Amanatsu Oranges", False)
	items_tag.Put("Ambarella", True)  ' selected
	
	
	vTagView.SetItems(items_tag)
	
End Sub

Private Sub Button1_Click
	Dim rs As List = vTagView.GetSelectedItem
	For Each item In rs
		Log(item)
	Next
	
End Sub

Sub vTagView_ItemClick(index As Int, selected As Boolean)
	Log("Position= " & index)
	Log("selected= " & selected)
End Sub

