B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.98
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	Public mBase As B4XView
	Public CustomListView1 As CustomListView
	Public Options As List
	Public SelectedItem As String
	Private xDialog As B4XDialog
	Public AllowMultiSelection As Boolean
	Public SelectionColor As Int = 0xAA0086FF
	Public SelectedItems As List
	Public MultiSelectionMinimum As Int = 0
End Sub

Public Sub Initialize
	mBase = xui.CreatePanel("mBase")
	mBase.SetLayoutAnimated(0, 0, 0, 300dip, 300dip)
	mBase.LoadLayout("ListTemplate")
	mBase.SetColorAndBorder(xui.Color_Transparent, 0, 0, 0)
	CustomListView1.sv.SetColorAndBorder(xui.Color_Transparent, 0, 0, 0)
	CustomListView1.DefaultTextBackgroundColor = 0xFF555555
	CustomListView1.DefaultTextColor = xui.Color_White
	#if B4J
	Dim sv As Node = CustomListView1.sv
	sv.StyleClasses.Add("b4xdialog")
	#end if
	Options.Initialize
	SelectedItems.Initialize
End Sub


Public Sub Resize(Width As Int, Height As Int)
	mBase.SetLayoutAnimated(0, 0, 0, Width, Height)
	CustomListView1.Base_Resize(Width, Height)
End Sub


Public Sub GetPanel (Dialog As B4XDialog) As B4XView
	Return mBase
End Sub

Private Sub Show (Dialog As B4XDialog)
	xDialog = Dialog
	CustomListView1.Clear
	For Each opt As Object In Options
		CustomListView1.AddTextItem(opt, opt)
	Next
	If AllowMultiSelection Then
		Sleep(20)
		For i = 0 To CustomListView1.Size - 1
			Dim item As CLVItem = CustomListView1.GetRawListItem(i)
			SelectItem (item, False)
		Next
	End If
	XUIViewsUtils.AddStubToCLVIfNeeded(CustomListView1, CustomListView1.DefaultTextBackgroundColor)
	SelectedItem = ""
	
End Sub

Private Sub SelectItem (Item As CLVItem, Toggle As Boolean)
	Dim index As Int = SelectedItems.IndexOf(Item.Value)
	Dim Selected As Boolean = index > -1
	If Toggle Then Selected = Not(Selected)
	If Selected Then
		If Not(Toggle) Then Item.Panel.Color = SelectionColor
		Item.Color = CustomListView1.DefaultTextBackgroundColor
		If index = -1 Then SelectedItems.Add(Item.Value)
	Else
		Item.Color = SelectionColor
		If Not(Toggle) Then Item.Panel.Color = CustomListView1.DefaultTextBackgroundColor
		If index > -1 Then SelectedItems.RemoveAt(index)
	End If
	xDialog.SetButtonState(xui.DialogResponse_Positive, SelectedItems.Size >= MultiSelectionMinimum)
End Sub


Private Sub CustomListView1_ItemClick (Index As Int, Value As Object)
	If Value = "" Then Return
	If AllowMultiSelection Then
		Dim Item As CLVItem = CustomListView1.GetRawListItem(Index)
		SelectItem (Item, True)
	Else
		SelectedItem = Value
		SelectedItems.Clear
		SelectedItems.Add(Value)
		xDialog.Close(xui.DialogResponse_Positive)
	End If
End Sub

Private Sub DialogClosed(Result As Int) 'ignore

End Sub