B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.31
@EndOfDesignText@
'v1.00
Sub Class_Globals
	Private xui As XUI
	Private fx As JFX
	Private list As CustomListView
	Private PressedColor As Int
End Sub

Public Sub Initialize (clv As CustomListView)
	list = clv
	PressedColor = list.PressedColor
End Sub

Public Sub Resize
	For i = 0 To list.Size - 1
		Dim p As B4XView = list.GetPanel(i)
		Dim v As B4XView = p.GetView(p.NumberOfViews - 1)
		If v Is Label And v.Tag = list Then
			v.Left = p.Width - 32dip
		End If
	Next
End Sub

Public Sub RemoveDragButtons
	For i = 0 To list.Size - 1
		Dim p As B4XView = list.GetPanel(i)
		If IsLastViewADragLabel(p) Then
			p.GetView(p.NumberOfViews - 1).RemoveViewFromParent
		End If
	Next
	list.PressedColor = PressedColor
End Sub

Private Sub IsLastViewADragLabel (p As B4XView) As Boolean
	If p.NumberOfViews > 0 Then
		Dim v As B4XView = p.GetView(p.NumberOfViews - 1)
		Return v Is Label And v.Tag = list
	End If
	Return False
End Sub

Public Sub AddDragButtons
	list.PressedColor = xui.Color_Transparent
	Dim fnt As B4XFont = xui.CreateMaterialIcons(30)
	For i = 0 To list.Size - 1
		Dim p As B4XView = list.GetPanel(i)
		If IsLastViewADragLabel(p) = False Then
			Dim lbl As Label
			lbl.Initialize("drag")
			lbl.MouseCursor = fx.Cursors.HAND
			Dim xlbl As B4XView = lbl
			xlbl.Font = fnt
			xlbl.Text = Chr(0xE25D)
			xlbl.TextColor = list.DefaultTextColor
			xlbl.Tag = list
			p.AddView(xlbl, p.Width - 32dip, p.Height / 2 - 15dip, 30dip, 30dip)
		End If
	Next
End Sub

Private Sub Drag_MousePressed (EventData As MouseEvent)
	Dim lbl As B4XView = Sender
	Dim list As CustomListView = lbl.Tag
	Dim pnl As B4XView = list.GetPanel(list.GetItemFromView(lbl)).Parent
	pnl.GetView(0).SetColorAndBorder(xui.Color_Transparent, 3dip, 0xFF503ACD, 0)
	Dim ListStartY As Int = EventData.Y + lbl.Top + pnl.Top
	pnl.BringToFront
	Dim Top As Int = pnl.Top
	Do While True
		Wait For (lbl) Drag_MouseDragged (EventData As MouseEvent)
		If pnl.Top < list.sv.ScrollViewOffsetY Then
			list.sv.ScrollViewOffsetY = Max(0, list.sv.ScrollViewOffsetY - 10dip)
		Else If list.sv.ScrollViewOffsetY + list.sv.Height < pnl.Top + pnl.Height Then
			list.sv.ScrollViewOffsetY = list.sv.ScrollViewOffsetY + 10dip
		End If
		Dim ListY As Int = EventData.Y + lbl.Top + pnl.Top
		Dim delta As Int = ListY - ListStartY
		pnl.Top = Top + delta
	Loop
End Sub

Private Sub Drag_MouseReleased (EventData As MouseEvent)
	Dim lbl As B4XView = Sender
	Dim list As CustomListView = lbl.Tag
	Dim index As Int = list.GetItemFromView(lbl)
	Dim pnl As B4XView = list.GetPanel(index).Parent
	Dim Offset As Int = pnl.Top + pnl.Height / 2
	Dim NewIndex As Int = list.FindIndexFromOffset(Offset)
	Dim UnderlyingItem As CLVItem = list.GetRawListItem(NewIndex)
	If Offset - UnderlyingItem.Offset > UnderlyingItem.Size / 2 Then NewIndex = NewIndex + 1
	Dim ActualItem As B4XView = pnl.GetView(0)
	ActualItem.SetColorAndBorder(pnl.Color, 0dip, xui.Color_Black, 0)
	Dim RawItem As CLVItem = list.GetRawListItem(index)
	list.RemoveAt(index)
	If NewIndex > index Then NewIndex = NewIndex - 1
	NewIndex = Max(0, Min(list.Size, NewIndex))
	list.InsertAt(NewIndex, ActualItem, RawItem.Value)
	list.GetRawListItem(NewIndex).TextItem = RawItem.TextItem
End Sub