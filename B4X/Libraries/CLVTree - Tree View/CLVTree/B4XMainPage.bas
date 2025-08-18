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
	Private CustomListView1 As CustomListView
	Private Tree As CLVTree
	Private logo As B4XBitmap
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	CustomListView1.DefaultTextBackgroundColor = xui.Color_White
	Tree.Initialize(CustomListView1)
	logo = xui.LoadBitmap(File.DirAssets, "logo.png")
	For i = 1 To 10
		Dim item As CLVTreeItem = Tree.AddItem(Tree.Root, $"Item #${i}"$, Null, "")
		For x = 1 To 5
			Dim text As Object
			#if B4J
			text = $"${i}-${x}"$
			#Else
			Dim cs As CSBuilder
			cs.Initialize.Color(xui.Color_Blue).Append(i).Pop.Append("-").Color(xui.Color_Red).Append(x).PopAll
			text = cs
			#End If
			Dim t As CLVTreeItem = Tree.AddItem(item, text, logo, "")
			Tree.CollapseItem(t)
			If Rnd(1, 8) = 6 Then
				For y = 1 To 5
					Tree.AddItem(t, $"${i}-${x}-${y}"$, Null, "")
				Next
			End If
		Next
	Next
End Sub


Private Sub CustomListView1_VisibleRangeChanged (FirstIndex As Int, LastIndex As Int)
	Tree.CLV_VisibleRangeChanged(FirstIndex, LastIndex)
End Sub

Private Sub CustomListView1_ItemClick (Index As Int, Value As Object)
	Dim item As CLVTreeItem = Value
	Log(item.Text)
	Tree.AddItem(item, $"new item - $Time{DateTime.Now}"$, logo, "")
	Tree.ExpandItem(item)
End Sub

Private Sub btnCollapseAll_Click
	Tree.CollapseAll
End Sub

Private Sub btnExpandAll_Click
	Tree.ExpandAll
End Sub