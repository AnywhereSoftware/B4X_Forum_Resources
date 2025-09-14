B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.5
@EndOfDesignText@
#DesignerProperty: Key: ItemHeight, DisplayName: Item Height, FieldType: Int, DefaultValue: 40, Description: List item height

#Event:ReservedItem(Item As String)
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Private clvList As CustomListView
	
	Private ManagedList As List
	Private Dialog As B4XDialog
	
	Private CSelections As CLVSelections
	Private btnMoveItemUp As Button
	Private btnMoveItemDown As Button
	Private ItemHeight As Int
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	ManagedList.Initialize
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
	
	ItemHeight = Props.GetDefault("ItemHeight",40)
	
	#If B4a
	Sleep(0)
	#End If
	mBase.LoadLayout("b4xlistmanager")
	Sleep(0)
	CSelections.Initialize(clvList)
	CSelections.Mode = CSelections.MODE_SINGLE_ITEM_PERMANENT
	
	Sleep(0)
	Dialog.Initialize(mBase.Parent)
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
End Sub

Public Sub ResizeDialog(Width As Double, Height As Double)
	If Dialog.Visible Then Dialog.Resize(Width,Height)
End Sub


Sub clvList_ItemClick (Index As Int, Value As Object)
	CSelections.ItemClicked(Index)
End Sub

Sub btnAdd_Click
	Dim T As B4XInputTemplate
	T.Initialize
	T.lblTitle.Text = "Add item"
	Wait For (Dialog.ShowTemplate(T,"OK","","Cancel")) Complete (Resp As Int)
	
	If Resp = xui.DialogResponse_Positive And T.Text <> "" Then
		If ManagedList.IndexOf(T.Text) > -1 Then
			Dialog.Title = "Duplicate entry"
			Dialog.Show(T.Text & " already exists","OK","","")
			Return
		End If
		Dim ML As List
		ML.Initialize
		ML.AddAll(ManagedList)
		ML.Add(T.Text)
		setList(ML)
	End If
End Sub

Sub btnRemove_Click
	Dim Btn As B4XView = Sender
	Dim Base As B4XView = Btn.Parent
	Dim Text As String = Base.GetView(0).Text
	If SubExists(mCallBack,mEventName & "_ReservedItem") Then
		If CallSub2(mCallBack,mEventName & "_ReservedItem",Text) = True Then 
			Dialog.Title = "Reserved Item"
			Wait For (Dialog.Show("Cannot remove item: " & Text,"OK","","")) Complete (Resp As Int)
			Return
		End If
	End If
	Dim Pos As Int = ManagedList.IndexOf(Text)
	If Pos > -1 Then
		ManagedList.RemoveAt(Pos)
		Dim ML As List
		ML.Initialize
		ML.AddAll(ManagedList)
		setList(ML)
	End If
	
End Sub

Sub getBase As B4XView
	Return mBase
End Sub

Sub btnEdit_Click
	Dim Btn As B4XView = Sender
	Dim Base As B4XView = Btn.Parent
	Dim Lbl As B4XView = Base.GetView(0)
	
	If SubExists(mCallBack,mEventName & "_ReservedItem") Then
		If CallSub2(mCallBack,mEventName & "_ReservedItem",Lbl.Text) = True Then
			Dialog.Title = "Reserved Item"
			Wait For (Dialog.Show("Cannot edit item: " & Lbl.Text,"OK","","")) Complete (Resp As Int)
			Return
		End If
	End If
	
	Dim T As B4XInputTemplate
	T.Initialize
	T.Text = Lbl.Text
	T.lblTitle.Text = "Change Name"
	
	Dialog.Title = "Edit Item"
	
	
	Wait For (Dialog.ShowTemplate(T,"OK","","Cancel")) Complete (Resp As Int)
	
	If Resp = xui.DialogResponse_Positive And T.Text <> "" Then
		Dim Pos As Int = ManagedList.IndexOf(Lbl.Text)
		If Pos > -1 Then
			ManagedList.Set(Pos,T.Text)
			Dim ML As List
			ML.Initialize
			ML.AddAll(ManagedList)
			setList(ML)
		End If
	End If
End Sub

Sub setList(ML As List)
	ManagedList.Clear
	ManagedList.AddAll(ML)
	clvList.Clear
	
	For Each S As String In ManagedList
'		clvList.AddTextItem(S,S)
		Dim P As B4XView = xui.CreatePanel("")
		P.SetLayoutAnimated(0,0,0,clvList.sv.Width,DipToCurrent(ItemHeight))
		P.LoadLayout("b4xlistmanageritem")
		P.GetView(0).Text = S
		clvList.Add(P,S)
	Next
End Sub

Sub getList As List
	Dim ML As List
	ML.Initialize
	ML.AddAll(ManagedList)
	Return ML
End Sub

Sub btnMoveItemUp_Click
	If CSelections.SelectedItems.Size = 1 Then
		Dim Index As Int = CSelections.SelectedItems.AsList.Get(0)
		If Index > 0 Then
			Dim P As B4XView = ManagedList.Get(Index)
			ManagedList.RemoveAt(Index)
			ManagedList.InsertAt(Index - 1,P)
			Dim ML As List
			ML.Initialize
			ML.AddAll(ManagedList)
			setList(ML)
			CSelections.ItemClicked(Index - 1)
			If clvList.FirstVisibleIndex >= Index - 1 Then clvList.ScrollToItem(Index - 1)
		End If
	End If
End Sub


Sub btnMoveItemDown_Click
	If CSelections.SelectedItems.Size = 1 Then
		Dim Index As Int = CSelections.SelectedItems.AsList.Get(0)
		If Index < ManagedList.Size -1 Then
			Dim P As B4XView = ManagedList.Get(Index)
			ManagedList.RemoveAt(Index)
			ManagedList.InsertAt(Index + 1,P)
			Dim ML As List
			ML.Initialize
			ML.AddAll(ManagedList)
			setList(ML)
			CSelections.ItemClicked(Index + 1)
			If clvList.LastVisibleIndex <= Index + 1 Then clvList.ScrollToItem(Index + 1)
		End If
	End If
End Sub