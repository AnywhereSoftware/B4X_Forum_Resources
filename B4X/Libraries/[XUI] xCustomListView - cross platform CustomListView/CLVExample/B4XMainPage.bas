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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=CLVExample.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private clv1 As CustomListView
	Private clv2 As CustomListView
	Private dd As DDD
End Sub

Public Sub Initialize
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	dd.Initialize
	'The designer script calls the DDD class. A new class instance will be created if needed.
	'In this case we want to create it ourselves as we want to access it in our code.
	xui.RegisterDesignerClass(dd)
	
	Root.LoadLayout("MainPage")
	clv1.AddTextItem("1 Aaaa" & CRLF & "Bbbb", "Value 1")
	clv1.AddTextItem("2 Aaaa" & CRLF & "Bbbb" & CRLF & "Cccc", "Value 2")
	clv1.AddTextItem($"3Aaaa
Bbbb
Cccc
Dddd"$, "value 3")
	clv1.AddTextItem($"4 Aaaa
Bbbb
Cccc
Dddd
Eeee"$, "value 4")
	For i = 1 To 20
		clv2.Add(CreateListItem($"Item #${i}"$, clv2.AsView.Width, 60dip), $"Item #${i}"$)
	Next
End Sub

'This event is raised when the user scrolls the list and reaches the last item.
Private Sub Clv1_ReachEnd
	Log("reach end")
	clv1.AddTextItem($"New item: $Time{DateTime.Now}"$, "New Item")
End Sub

Private Sub clv1_ItemClick (Index As Int, Value As Object)
	B4XPages.SetTitle(Me, Value)
End Sub

Private Sub clv2_ItemClick(Index As Int, Value As Object)
	Log(Index & " = " & Value)
	clv2.InsertAt(Index, CreateListItem($"Item !!!"$, clv2.AsView.Width, 60dip), $"Item !!!"$)
End Sub

Private Sub CreateListItem(Text As String, Width As Int, Height As Int) As B4XView
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, Width, Height)
	p.LoadLayout("CellItem")
	'Note that we call DDD.CollectViewsData in CellItem designer script. This is required if we want to get views with dd.GetViewByName. 
	dd.GetViewByName(p, "Label1").Text = Text
	Return p
End Sub

#if B4i
Private Sub CheckBox1_ValueChanged (Value As Boolean)
#else if B4A or B4J
Private Sub CheckBox1_CheckedChange(Checked As Boolean)
#End If
	Dim index As Int = clv2.GetItemFromView(Sender)
	Dim pnl As B4XView = clv2.GetPanel(index)
	Dim chk As B4XView = dd.GetViewByName(pnl, "CheckBox1")
	xui.MsgboxAsync($"Item value: ${clv2.GetValue(index)}
Check value: ${chk.Checked}"$, "")
End Sub

Private Sub Button1_Click
	Dim button As B4XView = Sender
	button.Text = "Check Logs"
	Dim index As Int = clv2.GetItemFromView(Sender)
Dim pnl As B4XView = clv2.GetPanel(index)
Dim lbl As B4XView = dd.GetViewByName(pnl, "Label1")
Dim chk As B4XView = dd.GetViewByName(pnl, "CheckBox1")
	lbl.Text = "Clicked!"
	Dim checkedItems As List
	checkedItems.Initialize
	'find all checked items.
	For i = 0 To clv2.GetSize - 1
		Dim chk As B4XView = dd.GetViewByName(clv2.GetPanel(i), "CheckBox1")
		If chk.Checked Then
			checkedItems.Add(clv2.GetValue(i))
		End If
	Next
	Log("Checked items: " & checkedItems)
	Sleep(500)
	button.Text = "Click Me"
End Sub





	
