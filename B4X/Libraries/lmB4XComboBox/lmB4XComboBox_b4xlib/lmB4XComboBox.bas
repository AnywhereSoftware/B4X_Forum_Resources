B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.01
@EndOfDesignText@
'  lmB4XComboBox
'	B4X custom view
'	Author: LucaMs

#Region VERSIONS 
'	2.01	06/15/2021
'		Added: Method SetItems3(Data As Map)
'	2.00	03/05/2021
'		Fixed: InsertAt bug in B4A.
'	1.07	02/11/2021
'		Just added some missing comment line.
'	1.06	02/11/2021
'		Added:  SetItemsFromSQLiteSorted method - Added CaseSensitive parameter.
'	1.05	02/06/2021
'		Added:  SetItemsFromSQLiteSorted method.
'	1.04	02/03/2021
'		Added: InsertItemAt an InsertItemAt2 methods.
'	1.03	02/03/2021
'		Fixed: there was a call sub (event - callback) without checking if it existed.
'	1.02	04/25/2020
'		Ammended B4i errors (reported by Andrew (DigitWell); thanks)
'	1.01	04/23/2020
#End Region

#Region EVENTS 
	#Event: SelectedChanged (Index As Int)
	#Event: SelectedChanged2 (Text As String, Value as Object)
#End Region

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Private LastSelectedIndex As Int
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
	Private mmapValues As Map
	Public Const LMCB_FIELD_TYPE_INT As String = "Int"
	Public Const LMCB_FIELD_TYPE_TEXT As String = "String"
End Sub

#Region CLASS DEFAULT ROUTINES 

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	LastSelectedIndex = -1
	If xui.IsB4J Then DelayBeforeChangeEvent = 500
   #If b4i
		mItems.Initialize
   #End If
	mmapValues.Initialize
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

#End Region

#Region PROPERTIES 

' Gets/sets the selected index.
Public Sub getSelectedIndex As Int
	#if B4J OR B4A
		Return cmbBox.SelectedIndex
	#Else
		Return mSelectedIndex
	#End If
End Sub
Public Sub setSelectedIndex(i As Int)
	LastSelectedIndex = i
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

' Gets the value of the selected index.
Public Sub getSelectedValue As Object
	Dim Text As String = GetItemText(getSelectedIndex)
	Return mmapValues.Get(Text)
End Sub

#End Region

#Region PUBLIC METHODS 

' Sets the texts of all items.
Public Sub SetItems(Texts As List)
	#if B4J
		cmbBox.Items.Clear
		cmbBox.Items.AddAll(Texts)
	#Else If B4A
		cmbBox.Clear
		cmbBox.AddAll(Texts)
	#Else If B4i
		mItems.Clear
		mItems.AddAll(Texts)
		mSelectedIndex = -1
	#End If
	mmapValues.Clear
	For Each Text As String In Texts
		mmapValues.Put(Text, Null)
	Next
	If Texts.Size > 0 Then setSelectedIndex(0)
End Sub

' Sets the texts and values of all items.
Public Sub SetItems2(Texts As List, Values As List)
	If Texts.Size <> Values.Size Then
		Log("SetItems2 - The two lists must be the same size")
	End If
	SetItems(Texts)
	mmapValues.Clear
	For i = 0 To Texts.Size - 1
		mmapValues.Put(Texts.Get(i), Values.Get(i))
	Next
End Sub

' Sets texts and values of all items getting them from the Data map passed.
' Data keys must be strings.
Public Sub SetItems3(Data As Map)
	' USES: SetItems2.
	If Data.IsInitialized = False Or Data.Size = 0 Then Return
	Dim lstTexts As List
	Dim lstValues As List
	lstTexts.Initialize
	lstValues.Initialize
	For Each Text As String In Data.Keys
		lstTexts.Add(Text)
		lstValues.Add(Data.Get(Text))
	Next
	SetItems2(lstTexts, lstValues)
End Sub

' Sets the texts and values of all items getting them from an SQLite table.
' ValueFieldType: pass one of LMCB_FIELD_TYPE_ constants provided by this class.
' Example:
'<code>
'SetItemsFromSQLite(SQL1, "Person", "LastName", 15, "ID", LMCB_FIELD_TYPE_INT)
'</code>
Public Sub SetItemsFromSQLite(DB As SQL, TableName As String, DisplayFieldName As String, MaxTextLength As Int, ValueFieldName As String, ValueFieldType As String)
	If Not(DB.IsInitialized) Then
		Log("SetItemsFromSQLite - DB is not inizialized")
	End If
	
	Dim lstTexts, lstValues As List
	lstTexts.Initialize
	lstValues.Initialize
	Dim Query As String = $"SELECT ${DisplayFieldName}, ${ValueFieldName} FROM ${TableName}"$
	
	Dim Cursor As ResultSet
	Cursor = DB.ExecQuery(Query)
	Dim DisplayText As String
	Do While Cursor.NextRow
		DisplayText = Cursor.GetString(DisplayFieldName)
		DisplayText = DisplayText.SubString2(0, Min(MaxTextLength, DisplayText.Length))
		lstTexts.Add(DisplayText)
		If ValueFieldType = LMCB_FIELD_TYPE_INT Then
			lstValues.Add(Cursor.GetInt(ValueFieldName))
		Else
			lstValues.Add(Cursor.GetString(ValueFieldName))
		End If
	Loop
	Cursor.Close
	
	If lstTexts.Size > 0 Then
		SetItems2(lstTexts, lstValues)
	End If
End Sub

' Same as SetItemsFromSQLite plus the ability to sort values.
Public Sub SetItemsFromSQLiteSorted(DB As SQL, TableName As String, DisplayFieldName As String, MaxTextLength As Int, ValueFieldName As String, ValueFieldType As String, Ascending As Boolean, CaseSensitive As Boolean)
	Dim SortOrderClause As String = ""
	Dim NOCASE As String = "COLLATE NOCASE"
	If CaseSensitive Then
		NOCASE = ""
	End If
	If Ascending Then
		SortOrderClause = $" ORDER BY ${DisplayFieldName} ${NOCASE} ASC "$
	Else
		SortOrderClause = $" ORDER BY ${DisplayFieldName} ${NOCASE} DESC "$
	End If
	
	If Not(DB.IsInitialized) Then
		Log("SetItemsFromSQLite - DB is not inizialized")
	End If
	
	Dim lstTexts, lstValues As List
	lstTexts.Initialize
	lstValues.Initialize
	Dim Query As String = $"SELECT ${DisplayFieldName}, ${ValueFieldName} FROM ${TableName} ${SortOrderClause}"$
	Dim Cursor As ResultSet
	Cursor = DB.ExecQuery(Query)
	Dim DisplayText As String
	Do While Cursor.NextRow
		DisplayText = Cursor.GetString(DisplayFieldName)
		DisplayText = DisplayText.SubString2(0, Min(MaxTextLength, DisplayText.Length))
		lstTexts.Add(DisplayText)
		If ValueFieldType = LMCB_FIELD_TYPE_INT Then
			lstValues.Add(Cursor.GetInt(ValueFieldName))
		Else
			lstValues.Add(Cursor.GetString(ValueFieldName))
		End If
	Loop
	Cursor.Close
	
	If lstTexts.Size > 0 Then
		SetItems2(lstTexts, lstValues)
	End If
End Sub

' Sets the value of the item at the specified index.
Public Sub SetValue(Index As Int, Value As Object)
	If Index >= 0 And Index < mmapValues.Size Then
		mmapValues.Put(GetItemText(Index), Value)
	End If
End Sub

' Adds a text item (its related value is automatically set to Null)
Public Sub AddItem(Text As String)
	#if B4J
		If cmbBox.Items.IndexOf(Text) = - 1 Then
			cmbBox.Items.Add(Text)
		End If
	#Else If B4A
		If cmbBox.IndexOf(Text) = - 1 Then
			cmbBox.Add(Text)
		End If
	#Else
		If mItems.IndexOf(Text) = - 1 Then
			mItems.Add(Text)
		End If
	#End If
	mmapValues.Put(Text, Null)
End Sub

' Adds an item, its text and its related value.
Public Sub AddItem2(Text As String, Value As Object)
	AddItem(Text)
	mmapValues.Put(Text, Value)
End Sub

' Insert a new text item at the specified Index position (its related value is automatically set to Null).
Public Sub InsertItemAt(Index As Int, Text As String)
	#If Not(B4A)
		cmbBox.Items.InsertAt(Index, Text)
	#Else
		Dim lstFirst, lstLast As List
		lstFirst.Initialize
		lstLast.Initialize
		For i = 0 To Index - 1
			lstFirst.Add(cmbBox.GetItem(i))
		Next
		For i = Index To cmbBox.Size - 1
			lstLast.Add(cmbBox.GetItem(i))
		Next
		cmbBox.Clear
		For i = 0 To lstFirst.Size - 1
			cmbBox.Add(lstFirst.Get(i))
		Next
		cmbBox.Add(Text)
		For i = 0 To lstLast.Size - 1
			cmbBox.Add(lstLast.Get(i))
		Next
	#End If
	mmapValues.Put(Text, Null)
End Sub

' Insert a new text and value item at the specified Index position.
Public Sub InsertItemAt2(Index As Int, Text As String, Value As Object)
	InsertItemAt(Index, Text)
	mmapValues.Put(Text, Value)
End Sub

' Returns the texts of items as list.
Public Sub GetItems As List
	Dim lstResult As List
	lstResult.Initialize
	For Each key As String In mmapValues.Keys
		lstResult.Add(key)
	Next
	Return lstResult
End Sub

' Returns the values of all items as list.
Public Sub GetValues As List
	Dim lstResult As List
	lstResult.Initialize
	For Each Value As Object In mmapValues.Values
		lstResult.Add(Value)
	Next
	Return lstResult
End Sub

' Removes the item at specified index.
Public Sub RemoveItemByIndex(Index As Int)
	Dim Item As String = GetItemText(Index)
	#If B4J
		cmbBox.Items.RemoveAt(Index)
	#Else If B4A
		cmbBox.RemoveAt(Index)
	#Else
		mItems.RemoveAt(Index)
	#End If
	mmapValues.Remove(Item)
End Sub

' Remove the item whose text is as specified.
Public Sub RemoveItemByText(Text As String)
	Dim IndexOf As Int
	#IF B4A
		IndexOf = cmbBox.IndexOf(Text)
	#Else If B4J
	IndexOf = cmbBox.Items.IndexOf(Text)
	#Else
		IndexOf = mItems.IndexOf(Text)
	#End If
	If IndexOf <> - 1 Then
		RemoveItemByIndex(IndexOf)
	End If
End Sub

' Remove the item whose value is as specified.
Public Sub RemoveItemByValue(Value As Object)
	Dim objFound As Object = Null
	Dim Index As Int
	For Each V As Object In mmapValues.Values
		If V = Value Then
			objFound = V
			Exit
		End If
		Index = Index + 1
	Next
	If objFound <> Null Then
		RemoveItemByIndex(Index)
	End If
End Sub

' Returns the value at the specified index.
Public Sub GetItemValue(Index As Int) As Object
	Return mmapValues.GetDefault(GetItemText(Index), Null)
End Sub

' Returns the text at the specified index.
Public Sub GetItemText(Index As Int) As String
	#if B4J
		Return cmbBox.Items.Get(Index)
	#Else If B4A
		Return cmbBox.GetItem(Index)
	#Else
		Return mItems.Get(Index)
	#End If
End Sub

#End Region

#Region PRIVATE METHODS 

Private Sub RaiseEvent
	Dim Index As Int = getSelectedIndex
	If LastSelectedIndex = Index Then Return
	If DelayBeforeChangeEvent > 0 Then
		DelayIndex = DelayIndex + 1
		Dim MyIndex As Int = DelayIndex
		Sleep(DelayBeforeChangeEvent)
		If MyIndex <> DelayIndex Then Return
	End If
	LastSelectedIndex = Index
	If SubExists(mCallBack, mEventName & "_SelectedChanged") Then
		CallSub2(mCallBack, mEventName & "_SelectedChanged", Index)
	End If
	Dim Item As String = GetItemText(Index)
	If SubExists(mCallBack, mEventName & "_SelectedChanged2") Then
		CallSub3(mCallBack, mEventName & "_SelectedChanged2", Item, mmapValues.Get(Item))
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
		LastSelectedIndex = -1
		RaiseEvent
	End Sub
#End If

#End Region
