B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.01
@EndOfDesignText@
'version: 1.00
#Event: SelectedIndexChanged (Index As Int)
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView
	Private xui As XUI 'ignore
	#if B4J
	Public cmbBox As ComboBox
	
	#Else If B4A
	Private cmbBox As Spinner
	#Else If B4i
	
	Private mItems As List
	Private mSelectedIndex As Int
	Private mBtn As B4XView
	#End If
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub


Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
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

Public Sub getSelectedIndex As Int
	#if B4J OR B4A
	Return cmbBox.SelectedIndex
	#Else
	Return mSelectedIndex
	#End If
End Sub

Public Sub setSelectedIndex(i As Int)
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
	CallSub2(mCallBack, mEventName & "_SelectedIndexChanged", getSelectedIndex)
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
	sheet.Initialize("sheet", "", "", "", mItems)
	sheet.Show(mBase)
	Wait For sheet_Click (Item As String)
	setSelectedIndex(mItems.IndexOf(Item))
	RaiseEvent
End Sub
#End If 

