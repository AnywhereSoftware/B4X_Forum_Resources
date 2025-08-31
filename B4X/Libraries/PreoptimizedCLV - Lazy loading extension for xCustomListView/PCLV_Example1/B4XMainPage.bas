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
	Private CustomListView1 As CustomListView
	Private PCLV As PreoptimizedCLV
	Private xui As XUI
	Private Label1 As B4XView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	B4XPages.SetTitle(Me, "Preoptimized CLV")
	Root.LoadLayout("MainPage")
	PCLV.Initialize(Me, "PCLV", CustomListView1)
	Dim words As List = File.ReadList(File.DirAssets, "english.txt")
	For Each word As String In words
		PCLV.AddItem(100dip, xui.Color_White, word)
	Next
	PCLV.Commit
End Sub


'Return the hint that will be displayed when the user fast scrolls the list. It can be a string or CSBuilder.
Private Sub PCLV_HintRequested (Index As Int) As Object
	Dim word As String = CustomListView1.GetValue(Index)
	Return word
End Sub

Private Sub CustomListView1_VisibleRangeChanged (FirstIndex As Int, LastIndex As Int)
	For Each i As Int In PCLV.VisibleRangeChanged(FirstIndex, LastIndex)
		Dim item As CLVItem = CustomListView1.GetRawListItem(i)
		Dim pnl As B4XView = xui.CreatePanel("")
		item.Panel.AddView(pnl, 0, 0, item.Panel.Width, item.Panel.Height)
		'Create the item layout
		pnl.LoadLayout("Item")
		Label1.Text = item.Value
	Next
End Sub


Private Sub CustomListView1_ItemClick (Index As Int, Value As Object)
	Log(Index & ", " & Value)
	CustomListView1.InsertAtTextItem(Index, "New Item", "")
	PCLV.ListChangedExternally
End Sub