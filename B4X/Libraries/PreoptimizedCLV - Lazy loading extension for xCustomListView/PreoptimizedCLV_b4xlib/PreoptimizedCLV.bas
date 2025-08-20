B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.1
@EndOfDesignText@
#Event: HintRequested (Index As Int) As Object
Sub Class_Globals
	Private mCLV As CustomListView
	Private items As List
	Private PanelsCache As List
	Private StubPanel As B4XView
	Private horizontal As Boolean
	Private AssignedItems() As B4XSet
	Private AssignedItemsAsIndex As Int
	#if B4i
	Private jclv As NativeObject
	#else
	Private jclv As JavaObject
	#End If
	Public ExtraItems As Int = 3
	Private ListOfItemsThatShouldBeUpdated As List
	Private xui As XUI
	Public ShowScrollBar As Boolean = True
	Public B4XSeekBar1 As B4XSeekBar
	Public pnlOverlay As B4XView
	Public lblHint As B4XView
	Private LastUserChangeIndex As Int
	Public NumberOfSteps As Int = 20
	Public DelayBeforeHidingOverlay As Int = 50
	Private mCallback As Object
	Private mEventName As String
End Sub

Public Sub Initialize (Callback As Object, EventName As String, CLV As CustomListView)
	mCLV = CLV
	jclv = mCLV 'ignore
	#if B4i
	items = jclv.GetField("__items").RunMethod("object", Null)
	horizontal = jclv.GetField("__horizontal").AsBoolean
	#else
	items = jclv.GetFieldJO("_items").RunMethod("getObject", Null)
	horizontal = jclv.GetField("_horizontal")
	#End If
	PanelsCache.Initialize
	StubPanel = CreatePanel
	StubPanel.AddView(xui.CreatePanel(""), 0, 0, 10dip, 10dip)
	AssignedItems = Array As B4XSet(B4XCollections.CreateSet, B4XCollections.CreateSet)
	ListOfItemsThatShouldBeUpdated.Initialize
	mCLV.AsView.LoadLayout("PCLVSeekBar")
	B4XSeekBar1.Size1 = 1dip
	B4XSeekBar1.Size2 = 1dip
	B4XSeekBar1.Radius1 = 8dip
	B4XSeekBar1.Update
	mCallback = Callback
	mEventName = EventName
End Sub

Public Sub AddItem (Size As Int, Clr As Int, Value As Object)
	Dim NewItem As CLVItem
	NewItem.Color = Clr
	NewItem.Panel = StubPanel
	NewItem.Value = Value
	NewItem.Size = Size
	items.Add(NewItem)
End Sub

Public Sub Commit
	ClearAssignedItems
	Dim DividerSize As Int = mCLV.DividerSize
	Dim TotalSize As Int = DividerSize
	For i = 0 To items.Size - 1
		Dim it As CLVItem = items.Get(i)
		it.Offset = TotalSize
		TotalSize = TotalSize + it.Size + DividerSize
	Next
	If horizontal Then
		mCLV.sv.ScrollViewContentWidth = TotalSize
	Else
		mCLV.sv.ScrollViewContentHeight = TotalSize
	End If
	B4XSeekBar1.mBase.Visible = ShowScrollBar
	If ShowScrollBar Then
		B4XSeekBar1.MaxValue = items.Size
		B4XSeekBar1.Interval = items.Size / NumberOfSteps
	End If
	RaiseVisibleRangeEvent
	
End Sub

Private Sub RaiseVisibleRangeEvent
	jclv.RunMethod("_resetvisibles", Null)
	jclv.RunMethod("_updatevisiblerange", Null)
End Sub

Private Sub CreatePanel As B4XView
	#if B4i
	Return jclv.RunMethod("_createpanel:", Array("Panel")).RunMethod("object", Null)
	#else
	Return jclv.RunMethodJO("_createpanel", Array("Panel")).RunMethod("getObject", Null)
	#End If
End Sub

Public Sub VisibleRangeChanged (FirstIndex As Int, LastIndex As Int) As List
	Dim FromIndex As Int = Max(0, FirstIndex - ExtraItems)
	Dim ToIndex As Int = Min(mCLV.Size - 1, LastIndex + ExtraItems)
	Dim PrevSet As B4XSet = AssignedItems(AssignedItemsAsIndex)
	AssignedItemsAsIndex = (AssignedItemsAsIndex + 1) Mod 2
	Dim NextSet As B4XSet = AssignedItems(AssignedItemsAsIndex)
	NextSet.Clear
	ListOfItemsThatShouldBeUpdated.Initialize
	For i = FromIndex To ToIndex
		Dim it As CLVItem = items.Get(i)
		If it.Panel = StubPanel Then
			it.Panel = GetPanel
			it.Panel.Tag = i
			it.Panel.Color = it.Color
			If horizontal Then
				mCLV.sv.ScrollViewInnerPanel.AddView(it.Panel, it.offset, 0, it.Size, mCLV.sv.Height)
			Else
				mCLV.sv.ScrollViewInnerPanel.AddView(it.Panel, 0, it.Offset, mCLV.sv.Width, it.Size)
			End If
			NextSet.Add(it.Panel)
			ListOfItemsThatShouldBeUpdated.Add(i)
		Else if PrevSet.Contains(it.Panel) Then
			NextSet.Add(it.Panel)
		End If
	Next
	For Each pnl As B4XView In PrevSet.AsList
		If NextSet.Contains(pnl) = False Then
			If pnl.Parent.IsInitialized Then
				pnl.RemoveViewFromParent
				pnl.GetView(0).RemoveAllViews
				pnl.RemoveAllViews
				PanelsCache.Add(pnl)
				Dim it As CLVItem = items.Get(pnl.Tag)
				it.Panel = StubPanel
			End If
		End If
	Next
	HandleScrollBar (FirstIndex)
	Return ListOfItemsThatShouldBeUpdated
End Sub

Private Sub HandleScrollBar (FirstVisible As Int)
	If ShowScrollBar = False Then Return
	B4XSeekBar1.Value = items.Size - FirstVisible
End Sub

Private Sub GetPanel As B4XView
	If PanelsCache.Size = 0 Then Return CreatePanel
	Dim p As B4XView = PanelsCache.Get(PanelsCache.Size - 1)
	PanelsCache.RemoveAt(PanelsCache.Size - 1)
	Return p
End Sub

Private Sub ClearAssignedItems
	For Each s As B4XSet In AssignedItems
		s.Clear
	Next
End Sub

Public Sub ListChangedExternally
	ClearAssignedItems
	Sleep(0)
	RaiseVisibleRangeEvent
End Sub

Sub B4XSeekBar1_TouchStateChanged (Pressed As Boolean)
	If Pressed = False Then
		mCLV.JumpToItem(LastUserChangeIndex)
		Sleep(DelayBeforeHidingOverlay)
		pnlOverlay.Visible = False
	Else
		pnlOverlay.Visible = True
		#if B4A
		Dim jo As JavaObject = mCLV.sv
		jo.RunMethod("fling", Array(0))
		#end if
	End If
End Sub

Sub B4XSeekBar1_ValueChanged (Value As Int)
	LastUserChangeIndex = Max(0, items.Size - 1 - Value)
	If LastUserChangeIndex < B4XSeekBar1.Interval Then LastUserChangeIndex = 0
	lblHint.Text = ""
	If xui.SubExists(mCallback, mEventName & "_HintRequested", 1) Then
		Dim t As Object = CallSub2(mCallback, mEventName & "_HintRequested", LastUserChangeIndex)
		If t <> Null Then
			InternalSetTextOrCSBuilderToLabel(lblHint, t)
		End If
	End If
End Sub

Private Sub InternalSetTextOrCSBuilderToLabel(xlbl As B4XView, Text As Object)
	#if B4A or B4J
	xlbl.Text = Text
	#else if B4i
	If Text Is CSBuilder And xlbl Is Label Then
		Dim lbl As Label = xlbl
		lbl.AttributedText = Text
	Else 
		If GetType(Text) = "__NSCFNumber" Then Text = "" & Chr(Text)
		xlbl.Text = Text
	End If
	#end if
End Sub
