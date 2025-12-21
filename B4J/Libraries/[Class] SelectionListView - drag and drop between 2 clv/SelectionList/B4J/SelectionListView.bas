B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
' --- Class Globals ---
Sub Class_Globals
	Private mRoot As B4XView
	Private mPane As B4XView
	Private mCallback As Object
	Private mEventName As String
	Private xui As XUI
	Private fx As JFX

	Private AviableList As List
	Private SelectedList As List

	Private clvAvailable As CustomListView
	Private clvSelected As CustomListView
	Private lblItem As B4XView

	Private CSelections_a As CLVSelections
	Private CSelections_s As CLVSelections

	Private Aviable_SelectedValue As List
	Private Selected_SelectedValue As List

	Private IsDragging As Boolean
	Private DragGhost As B4XView
	Private DragValue As String
	Private DragSource As CustomListView
	Private DragOffsetX As Double
	Private DragOffsetY As Double
	Private lblGhost As B4XView

	Private dragger As CLVDragger
	Private t_on As B4XBitmap
	Private t_off As B4XBitmap
	Private SwitchOn As Boolean = False
	Private imv_Switch As B4XView
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mCallback = Callback
	mEventName = EventName
	AviableList.Initialize
	SelectedList.Initialize
	Aviable_SelectedValue.Initialize
	Selected_SelectedValue.Initialize
End Sub


' --- Setup to pass the parameterss ---
Public Sub Setup(Container As B4XView, RootPane As B4XView)
	mPane = Container
	mRoot = RootPane
	mPane.LoadLayout("slv")

	CSelections_a.Initialize(clvAvailable)
	CSelections_a.Mode = CSelections_a.MODE_MULTIPLE_ITEMS
	CSelections_s.Initialize(clvSelected)
	CSelections_s.Mode = CSelections_s.MODE_MULTIPLE_ITEMS

	dragger.Initialize(clvSelected)
	t_on = xui.LoadBitmap(File.DirAssets, "t_on.png")
	t_off = xui.LoadBitmap(File.DirAssets, "t_off.png")

	UpdateSwitch
End Sub

Public Sub SetAvailableList(lst As List)
	AviableList = lst
	clvAvailable.Clear
	For Each s As String In lst
		AddItemToCLV(clvAvailable, s)
	Next
End Sub

Public Sub AddItemToCLV(clv As CustomListView, txt As String)
	Dim p As B4XView = xui.CreatePanel("dragitem")
	p.SetLayoutAnimated(0, 0, 0, clv.AsView.Width, 30dip)
	p.LoadLayout("clv_item")
	lblItem.Text = txt

	' Memorize owner + value in Tag
	Dim m As Map
	m.Initialize
	m.Put("value", txt)
	m.Put("owner", clv)
	p.Tag = m

	clv.Add(p, txt)
End Sub

#Region Custom drag on items
Private Sub dragitem_MousePressed (EventData As MouseEvent)
	Dim p As B4XView = Sender
	Dim m As Map = p.Tag
	DragValue = m.Get("value")
	DragSource = m.Get("owner")
	
	DragGhost = xui.CreatePanel("")
	DragGhost.Color = xui.Color_RGB(128,180,250)
	DragGhost.Enabled = False

	Dim pos() As Int = GetAbsPos(p)
	DragGhost.SetLayoutAnimated(0, pos(0), pos(1), p.Width, p.Height)
	mRoot.AddView(DragGhost, DragGhost.Left, DragGhost.Top, DragGhost.Width, DragGhost.Height)
	

	Dim jo As JavaObject = EventData
	Dim MouseX As Double = jo.RunMethod("getSceneX", Null)
	Dim MouseY As Double = jo.RunMethod("getSceneY", Null)
	DragOffsetX = MouseX - pos(0)
	DragOffsetY = MouseY - pos(1)

	Dim l As Label
	l.Initialize("")
	lblGhost = l
	
	If DragSource = clvAvailable Then
		lblGhost.Text = IIf(Aviable_SelectedValue.Size > 1, Aviable_SelectedValue.Size & " items", DragValue)
	Else
		lblGhost.Text = IIf(Selected_SelectedValue.Size > 1, Selected_SelectedValue.Size & " items", DragValue)
	End If
	
	lblGhost.SetTextAlignment("CENTER", "CENTER")
	lblGhost.TextColor = xui.Color_Black
	lblGhost.Visible = False

	' Dimensions du label
	Dim w As Int = 120dip
	Dim h As Int = 30dip

	' Calculation to center in the DragGhost
	Dim left As Int = (DragGhost.Width - w) / 2
	Dim top  As Int = (DragGhost.Height - h) / 2

	DragGhost.AddView(lblGhost, left, top, w, h)

	IsDragging = True
	EventData.Consume
End Sub


Private Sub dragitem_MouseDragged (EventData As MouseEvent)
	If IsDragging And DragGhost.IsInitialized Then
		lblGhost.Visible = True
		Dim jo As JavaObject = EventData
		Dim MouseX As Double = jo.RunMethod("getSceneX", Null)
		Dim MouseY As Double = jo.RunMethod("getSceneY", Null)

		DragGhost.Left = MouseX - DragOffsetX
		DragGhost.Top  = MouseY - DragOffsetY
	End If
End Sub

Private Sub dragitem_MouseReleased (EventData As MouseEvent)
	If IsDragging Then
		Dim jo As JavaObject = EventData
		Dim dropX As Double = jo.RunMethod("getSceneX", Null)
		Dim dropY As Double = jo.RunMethod("getSceneY", Null)

		Dim target As CustomListView = GetDropTarget(dropX, dropY)

		DragGhost.RemoveViewFromParent
		IsDragging = False

		If target.IsInitialized And target <> DragSource Then
			Dim values As List
			values.Initialize

			' Choose the right selection list
			If DragSource = clvAvailable Then
				values = Aviable_SelectedValue
			Else If DragSource = clvSelected Then
				values = Selected_SelectedValue
			End If

			' loop through all selected elements
			For Each s As String In values
				If DragSource = clvAvailable Then
					MoveItem(s, AviableList, SelectedList, clvAvailable, clvSelected)
				Else
					MoveItem(s, SelectedList, AviableList, clvSelected, clvAvailable)
				End If
			Next

			' Clean up selections from both lists after transfer
			ClearSelections(CSelections_a, Aviable_SelectedValue)
			ClearSelections(CSelections_s, Selected_SelectedValue)
		End If
	End If
End Sub

' Cleans the internal selection AND the visual highlight
Private Sub ClearSelections(selections As CLVSelections, selectedValues As List)
	' Clears the selection list and highlighting in the CLV
	selectedValues.Clear
	selections.Clear
	
End Sub

Private Sub GetDropTarget(x As Double, y As Double) As CustomListView
	If PointInViewScene(clvAvailable.AsView, x, y) Then Return clvAvailable
	If PointInViewScene(clvSelected.AsView, x, y) Then Return clvSelected
	Dim dummy As CustomListView
	Return dummy
End Sub

Private Sub PointInViewScene(v As B4XView, x As Double, y As Double) As Boolean
	Dim pos() As Int = GetAbsPos(v)
	Return x >= pos(0) And x <= pos(0) + v.Width And y >= pos(1) And y <= pos(1) + v.Height
End Sub

Private Sub GetAbsPos(v As B4XView) As Int()
	Dim jo As JavaObject = v
	Dim node As JavaObject = jo
	Dim bounds As JavaObject = node.RunMethod("localToScene", Array(node.RunMethod("getBoundsInLocal", Null)))
	Dim x As Double = bounds.RunMethod("getMinX", Null)
	Dim y As Double = bounds.RunMethod("getMinY", Null)
	Return Array As Int(x, y)
End Sub
#End Region


#Region Click on the buttons
Private Sub btn_AviableToSelected_Click
	For Each s As String In Aviable_SelectedValue
		MoveItem(s, AviableList, SelectedList, clvAvailable, clvSelected)
	Next
	ClearSelections(CSelections_a, Aviable_SelectedValue)
End Sub

Private Sub btn_SelectedToAviable_Click
	For Each s As String In Selected_SelectedValue
		MoveItem(s, SelectedList, AviableList, clvSelected, clvAvailable)
	Next
	AviableList.Sort(True)
	SetAvailableList(AviableList)
	ClearSelections(CSelections_s, Selected_SelectedValue)
End Sub

Private Sub clvAvailable_ItemClick (Index As Int, Value As Object)
	ToggleSelection(Aviable_SelectedValue, CSelections_a, Index, Value)
End Sub

Private Sub clvSelected_ItemClick (Index As Int, Value As Object)
	ToggleSelection(Selected_SelectedValue, CSelections_s, Index, Value)
End Sub

' --- Deletion by value ---
Private Sub RemoveValueFromCLV(clv As CustomListView, value As String)
	For i = clv.Size - 1 To 0 Step -1
		If clv.GetValue(i) = value Then
			clv.RemoveAt(i)
		End If
	Next
End Sub

Private Sub btAccept_MouseClicked (EventData As MouseEvent)
	Dim l As List
	l.Initialize
	For i = 0 To clvSelected.Size - 1
		Dim s As String = clvSelected.GetValue(i)
		l.Add(s)
	Next
	CallSubDelayed2(mCallback, mEventName, l)
End Sub
#End Region

' Moves an item from one list/CLV to another
Private Sub MoveItem(value As String, fromList As List, toList As List, fromCLV As CustomListView, toCLV As CustomListView)
	' Updating source lists
	If fromList.IndexOf(value) > -1 Then
		fromList.RemoveAt(fromList.IndexOf(value))
	End If
	toList.Add(value)

	' CLV Update
	RemoveValueFromCLV(fromCLV, value)
	AddItemToCLV(toCLV, value)

	' If we put available items back into the CLV, we sort and reload them.
	If toCLV = clvAvailable Then
		AviableList.Sort(True)
		SetAvailableList(AviableList)
	End If
End Sub

' Toggle item selection: adds/removes from the list and updates the highlighting
Private Sub ToggleSelection(values As List, selections As CLVSelections, index As Int, value As String)
	Dim pos As Int = values.IndexOf(value)
	If pos > -1 Then
		' already selected: remove it
		values.RemoveAt(pos)
		selections.ItemClicked(index)
	Else
		' Not yet selected: we'll add it
		values.Add(value)
		selections.ItemClicked(index)
	End If
End Sub

Private Sub imv_Switch_MouseClicked (EventData As MouseEvent)
	SwitchOn = Not(SwitchOn)
	UpdateSwitch
End Sub

Private Sub UpdateSwitch
	If SwitchOn Then
		dragger.AddDragButtons
		imv_Switch.SetBitmap(t_on)
	Else
		dragger.RemoveDragButtons
		imv_Switch.SetBitmap(t_off)
	End If
End Sub