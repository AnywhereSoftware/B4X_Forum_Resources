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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=xGridListViewSample.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private xGridListView1 As xGridListView
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	'xGridListView1.ItemWidth=150dip 
	'log("Num cols max (for 150dip) is:" & xGridListView1.MaxCol)
	xGridListView1.SetCol(2)
	
	For i=1 To 5
		xGridListView1.AddWithImage($"Voce ${i}"$,"Second","info",i,xui.LoadBitmap(File.DirAssets,"sd.png"),True)
	Next
	
	For i=11 To 15
		xGridListView1.Add($"Voce ${i}"$,"Second","info",i)
	Next
	
	'Add alement
	Sleep(4000)
	For i=10 To 6 Step -1
		xGridListView1.InsertWithImageAt(5,$"Voce ${i}"$,"Second","info",i,xui.LoadBitmap(File.DirAssets,"sd.png"),False)
	Next

	'delete element
	Sleep(4000)
	For i=1 To 2
		xGridListView1.removeAt(10)
	Next
End Sub

Private Sub xGridListView1_ItemClick(Text As String,Value As Object)
	Log("Click " & Value)
End Sub

Private Sub xGridListView1_ItemLongClick(Text As String,Value As Object)
	Log("Long or Right Click " & Value)
End Sub