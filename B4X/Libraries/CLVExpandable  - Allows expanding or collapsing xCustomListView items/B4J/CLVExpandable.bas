B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.01
@EndOfDesignText@
'version 1.00
Sub Class_Globals
	Type ExpandableItemData (CollapsedHeight As Int, ExpandedHeight As Int, Value As Object, Expanded As Boolean)
	Private mCLV As CustomListView
	Private xui As XUI
End Sub

Public Sub Initialize (CLV As CustomListView)
	mCLV = CLV
End Sub

Public Sub CreateValue(pnl As B4XView, Value As Object) As ExpandableItemData
	Dim e As ExpandableItemData
	e.Initialize
	e.CollapsedHeight = pnl.GetView(0).Height
	e.ExpandedHeight = pnl.GetView(0).Height + pnl.GetView(1).Height
	e.Value = Value
	Return e
End Sub

Public Sub GetValue (Index As Int) As Object
	If mCLV.GetValue(Index) Is ExpandableItemData Then
		Dim e As ExpandableItemData = mCLV.GetValue(Index)
		Return e.Value
	End If
	Return mCLV.GetValue(Index)
End Sub

Public Sub ExpandItem (index As Int)
	ResizeItem(index, False)
End Sub


Sub CollapseItem(index As Int)
	ResizeItem(index, True)
End Sub

Private Sub ResizeItem (Index As Int, Collapse As Boolean)
	Dim item As CLVItem = mCLV.GetRawListItem(Index)
	Dim p As B4XView = item.Panel.GetView(0)
	If p.NumberOfViews = 0 Or (item.Value Is ExpandableItemData) = False Then Return
	Dim NewPanel As B4XView = xui.CreatePanel("")
	MoveItemBetweenPanels(p, NewPanel)
	Dim id As ExpandableItemData = item.Value
	id.Expanded = Not(Collapse)
	mCLV.sv.ScrollViewInnerPanel.AddView(NewPanel, 0, item.Offset, p.Width, id.ExpandedHeight)
	If Collapse Then
		AnimatedArrow(180, 0, NewPanel)
	Else
		AnimatedArrow(0, 180, NewPanel)
	End If
	Dim NewSize As Int
	If Collapse Then NewSize = id.CollapsedHeight Else NewSize = id.ExpandedHeight
	mCLV.ResizeItem(Index, NewSize)
	NewPanel.SendToBack
	Sleep(mCLV.AnimationDuration)
	If p.Parent.IsInitialized Then
		MoveItemBetweenPanels(NewPanel, p)
	End If
	NewPanel.RemoveViewFromParent
End Sub

Private Sub MoveItemBetweenPanels (Src As B4XView, Target As B4XView)
	Do While Src.NumberOfViews > 0
		Dim v As B4XView = Src.GetView(0)
		v.RemoveViewFromParent
		Target.AddView(v, v.Left, v.Top, v.Width, v.Height)
	Loop
End Sub

Private Sub AnimatedArrow(From As Int, ToDegree As Int, Pnl As B4XView)
	Dim title As B4XView = Pnl.GetView(0) 'pnlTitle is the first item
	Dim iv As B4XView = title.GetView(1) 'ImageView1 is the second item
	iv.SetRotationAnimated(0, From)
	iv.SetRotationAnimated(mCLV.AnimationDuration, ToDegree)
End Sub

Public Sub ToggleItem (Index As Int)
	Dim i As ExpandableItemData = mCLV.GetValue(Index)
	If i.Expanded = True Then
		CollapseItem(Index)
	Else
		ExpandItem(Index)
	End If
End Sub
