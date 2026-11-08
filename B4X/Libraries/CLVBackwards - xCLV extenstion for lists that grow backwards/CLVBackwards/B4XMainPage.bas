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
	Private Backwards As CLVBackwards
	Private CustomListView1 As CustomListView
	Private Button1 As B4XView
	Private Counter As Int
	Private AddItemsWhenScrolling As Boolean
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	Backwards.Initialize(CustomListView1)
	Wait For (Backwards.IsReady) Complete (Unused As Boolean)
	Log("ready")
	For i = 1 To 10
		AddItem
	Next
	AddItemsWhenScrolling = True
End Sub

Private Sub AddItem
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, CustomListView1.AsView.Width, 50dip)
	p.Color = Rnd(0xff000000, 0xffffffff)
	Backwards.AddItem(p, Null)
	Dim lbl As Label
	lbl.Initialize("")
	Dim xlbl As B4XView = lbl
	Counter = Counter + 1
	xlbl.Text = $"$time{DateTime.now} - ${Counter}"$
	xlbl.SetTextAlignment("CENTER", "CENTER")
	xlbl.TextColor = xui.Color_White
	p.AddView(xlbl, 0, 0, p.Width, p.Height)
	Log("add new item: " & Counter)
End Sub


Private Sub Button1_Click
	AddItem
	CustomListView1.JumpToItem(1)
End Sub

Private Sub CustomListView1_VisibleRangeChanged (FirstIndex As Int, LastIndex As Int)
	If Backwards.SpacerRemoved Or AddItemsWhenScrolling = False Then Return
	If FirstIndex <= 1 Then
		For i = 1 To 5
			AddItem
		Next
		'make sure that at least one real item is visible.
		If LastIndex = 0 Then
			Sleep(0)
			Backwards.ScrollToItemNow (1)
		End If
	End If
	'Example: we ran out of items so remove the spacer.
	If CustomListView1.Size > 80 Then
		Log("spacer removed")
		Backwards.RemoveTheSpacer
		Button1.Enabled = False
	End If
End Sub