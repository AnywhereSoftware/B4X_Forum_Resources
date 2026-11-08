B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.01
@EndOfDesignText@
#Event: SelectedIndexChanged (Index As Int)

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	'Private LastSelectedIndex As Int
	#if B4J
	Public cmbBox As ComboBox
	#Else If B4A
	Public cmbBox As Spinner
	#Else If B4i
	Private mItems As List
	Private mSelectedIndex As Int
	Public mBtn As B4XView
	#End If
	Public DelayBeforeChangeEvent As Int
	
	Private DelayIndex As Int
	Public Tag As Object
	Public B4iCancelButton As String = "Cancel"
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	'LastSelectedIndex = -1
	If xui.IsB4J Then DelayBeforeChangeEvent = 500
End Sub


Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag : mBase.Tag = Me
	Dim xlbl As B4XView = Lbl
#if B4J
	cmbBox.Initialize("cmbBox")
	Dim xbox As B4XView = cmbBox
	xbox.Font = xlbl.Font
	mBase.AddView(cmbBox, 0, 0, mBase.Width, mBase.Height)
#Else If B4A
	cmbBox.Initialize("cmbBox")
	cmbBox.TextSize = xlbl.TextSize
	mBase.AddView(cmbBox, 0, 0, mBase.Width, mBase.Height)
#Else If B4i
	Dim btn As Button
	btn.Initialize("btn", btn.STYLE_SYSTEM)
	mBtn = btn
	mBtn.Font = xlbl.Font
	mBase.AddView(mBtn, 0, 0, mBase.Width, mBase.Height)
#End If
	
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	mBase.GetView(0).SetLayoutAnimated(0, 0, 0, Width, Height)
End Sub

Public Sub SetItems(Items As List)
	#if B4J
	cmbBox.Items.Clear
	cmbBox.Items.AddAll(Items)
	#Else If B4A
	cmbBox.Clear
	cmbBox.AddAll(Items)
	#Else If B4i
	Dim mItems As List
	mItems.Initialize
	mItems.AddAll(Items)
	mSelectedIndex = -1
	#End If
	If Items.Size > 0 Then setSelectedIndex(0)
End Sub

'Returns the number of items.
Public Sub getSize As Int
	#if B4J
	Return cmbBox.Items.Size
	#Else If B4A
	Return cmbBox.Size
	#Else If B4i
	Return mItems.Size
	#End If
End Sub

'Returns the index of the item with the given value. Returns -1 if not found.
Public Sub IndexOf(Item As String) As Int
	#if B4J
	Return cmbBox.Items.IndexOf(Item)
	#Else If B4A
	Return cmbBox.IndexOf(Item)
	#Else If B4i
	Return mItems.IndexOf(Item)
	#End If
End Sub

'Gets or sets the selected index
Public Sub getSelectedIndex As Int
	#if B4J OR B4A
	Return cmbBox.SelectedIndex
	#Else
	Return mSelectedIndex
	#End If
End Sub

Public Sub setSelectedIndex(i As Int)
	'LastSelectedIndex = i
	#if B4J OR B4A
	cmbBox.SelectedIndex = i
	#Else
	mSelectedIndex = i
	If i < 0 Then
		mBtn.Text = ""
	Else
		mBtn.Text = mItems.Get(i)
	End If
	#End If
End Sub

'Gets the selected item. Returns an empty string if nothing is selected.
Public Sub getSelectedItem As String
	Dim i As Int = getSelectedIndex
	If i = -1 Then Return ""
	Return GetItem(i)
End Sub

Public Sub GetItem(Index As Int) As String
	#if B4J
	Return cmbBox.Items.Get(Index)
	#Else If B4A
	Return cmbBox.GetItem(Index)
	#Else
	Return mItems.Get(Index)
	#End If
End Sub

Private Sub RaiseEvent
	Dim index As Int = getSelectedIndex
	'If LastSelectedIndex = index Then Return
	If DelayBeforeChangeEvent > 0 Then
		DelayIndex = DelayIndex + 1
		Dim MyIndex As Int = DelayIndex
		Sleep(DelayBeforeChangeEvent)
		If MyIndex <> DelayIndex Then Return
	End If
	'LastSelectedIndex = index
	If xui.SubExists(mCallBack, mEventName & "_SelectedIndexChanged", 1) Then
		CallSub2(mCallBack, mEventName & "_SelectedIndexChanged", index)
	End If
End Sub

#If B4J
Private Sub CmbBox_SelectedIndexChanged(Index As Int, Value As Object)
	RaiseEvent
End Sub
#Else If B4A
Private Sub CmbBox_ItemClick (Position As Int, Value As Object)
	RaiseEvent
End Sub

#else
Private Sub btn_Click
	Dim sheet As ActionSheet
	sheet.Initialize("sheet", "", B4iCancelButton, "", mItems)
	sheet.Show(mBase)
	Wait For sheet_Click (Item As String)
	if B4iCancelButton <> "" and Item = B4iCancelButton Then Return
	setSelectedIndex(mItems.IndexOf(Item))
	'LastSelectedIndex = -1
	RaiseEvent
End Sub
#End If 

