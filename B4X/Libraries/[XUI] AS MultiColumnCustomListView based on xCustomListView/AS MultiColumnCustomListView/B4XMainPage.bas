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
	Private AS_MultiColumnCustomListView1 As AS_MultiColumnCustomListView
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"AS MultiColumnCustomListView Example")
	
	AddItems

End Sub

Private Sub AddItems
	
	For i = 0 To 200 -1
		
		Dim xpnl As B4XView = xui.CreatePanel("")
		xpnl.SetLayoutAnimated(0,0,0,Root.Width/AS_MultiColumnCustomListView1.ColumnCount,Rnd(100dip,200dip))
		'xpnl.SetLayoutAnimated(0,0,0,Root.Width/AS_MultiColumnCustomListView1.ColumnCount,150dip)
		xpnl.Color = xui.Color_ARGB(255,Rnd(0,256),Rnd(0,256),Rnd(0,256))
		AS_MultiColumnCustomListView1.Add(xpnl,i+1)
		
	Next
	AS_MultiColumnCustomListView1.Commit
	
End Sub


Private Sub AS_MultiColumnCustomListView1_ItemClick (Index As Int, Value As Object)
	
End Sub

Private Sub AS_MultiColumnCustomListView1_ItemLongClick (Index As Int, Value As Object)
	
End Sub

Private Sub AS_MultiColumnCustomListView1_ReachEnd
	
End Sub

Private Sub AS_MultiColumnCustomListView1_LazyLoadingAddContent(Parent As B4XView, Value As Object)
	Dim xlbl As B4XView = CreateLabel
	xlbl.Text = "Test #" & Value
	xlbl.TextColor = xui.Color_White
	xlbl.Font = xui.CreateDefaultBoldFont(20)
	Parent.AddView(xlbl,10dip,0,Parent.Width - 10dip,50dip)
End Sub

Private Sub CreateLabel As B4XView
	Dim lbl As Label
	lbl.Initialize("")
	Return lbl
End Sub