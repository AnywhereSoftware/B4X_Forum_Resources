Type=Class
Version=5.5
ModulesStructureVersion=1
B4A=true
@EndOfDesignText@
'version 1.00
'Class module
Sub Class_Globals
	Private prefixList As Map
	Private substringList As Map
	Private et As EditText
	Public lv As ListView
	Private MIN_LIMIT, MAX_LIMIT As Int
	MIN_LIMIT = 1
	MAX_LIMIT = 4 'doesn't limit the words length. Only the index.
	Private mCallback As Object
	Private mEventName As String
	Private allItems As List
	Private IME As IME
End Sub

'Initializes the object and sets the module and sub that will handle the ItemClick event
Public Sub Initialize (Callback As Object, EventName As String)
	IME.Initialize("")
	et.Initialize("et")
	'Remove the suggestions bar
	et.InputType = Bit.Or(et.INPUT_TYPE_TEXT, 0x00080000)
	Dim jo As JavaObject = et
	jo.RunMethod("setImeOptions", Array(268435456)) 'disable the full screen mode in landscape
	lv.Initialize("lv")
	lv.SingleLineLayout.ItemHeight = 50dip
	lv.SingleLineLayout.Label.TextSize = 14
	lv.Visible = False
	prefixList.Initialize
	substringList.Initialize
	mCallback = Callback
	mEventName = EventName
End Sub

'Adds the view to the parent. The parent can be an Activity or Panel.
Public Sub AddToParent(Parent As Panel, Left As Int, Top As Int, Width As Int, Height As Int)
	Parent.AddView(et, Left, Top, Width, 60dip)
	Parent.AddView(lv, Left, Top + et.Height, Width, Height - et.Height)
	et_TextChanged("", "")
End Sub

Private Sub lv_ItemClick (Position As Int, Value As Object)
	et.Text = Value
	et.SelectionStart = et.Text.Length
	IME.HideKeyboard
	lv.Visible = False
	If SubExists(mCallback, mEventName & "_ItemClick") Then
		CallSub2(mCallback, mEventName & "_ItemClick", Value)
	End If
End Sub

Private Sub et_TextChanged (Old As String, New As String)
	lv.Clear
	If lv.Visible = False Then lv.Visible = True
	If New.Length < MIN_LIMIT Then 
		AddAll
		Return
	End If
	Dim str1, str2 As String
	str1 = New.ToLowerCase
	If str1.Length > MAX_LIMIT Then
		str2 = str1.SubString2(0, MAX_LIMIT)
	Else
		str2 = str1
	End If
	AddItemsToList(prefixList.Get(str2), str1)
	AddItemsToList(substringList.Get(str2), str1)
End Sub

Private Sub AddAll
	If allItems.IsInitialized = False Then Return
	For Each s As String In allItems
		lv.AddSingleLine(s)
	Next
End Sub

Private Sub AddItemsToList(li As List, full As String)
	If li.IsInitialized = False Then Return
	For i = 0 To li.Size - 1
		If lv.Size > 500 Then Return
		Dim item As String = allItems.Get(li.Get(i))
		If full.Length > MAX_LIMIT And item.ToLowerCase.Contains(full) = False Then
			Continue
		End If
		lv.AddSingleLine(item)
	Next
	
	
End Sub

''Builds the index and returns an object which you can store as a process global variable
''in order to avoid rebuilding the index when the device orientation changes.
'Public Sub SetItems(Items As List) As Object
'	allItems = Items
'	AddAll
'	Dim startTime As Long 
'	startTime = DateTime.Now
'	'ProgressDialogShow2("Building index...", False)
'	Dim noDuplicates As Map
'	noDuplicates.Initialize
'	prefixList.Clear
'	substringList.Clear
'	Dim m As Map
'	Dim li As List
'	For i = 0 To Items.Size - 1
'		Dim item As String
'		item = Items.Get(i)
'		item = item.ToLowerCase
'		noDuplicates.Clear
'		For start = 0 To item.Length
'			Dim count As Int
'			count = MIN_LIMIT
'			Do While count <= MAX_LIMIT And start + count <= item.Length
'				Dim str As String
'				str = item.SubString2(start, start + count)
'				If noDuplicates.ContainsKey(str) = False Then 
'					noDuplicates.Put(str, "")
'					If start = 0 Then m = prefixList Else m = substringList
'					li = m.Get(str)
'					If li.IsInitialized = False Then
'						li.Initialize
'						m.Put(str, li)
'					End If
'					li.Add(Items.Get(i)) 'Preserve the original case
'				End If
'				count = count + 1
'			Loop
'		Next
'	Next
'	ProgressDialogHide
'	Log("Index time: " & (DateTime.Now - startTime) & " ms (" & Items.Size & " Items)")
'	Return Array As Object(prefixList, substringList)
'End Sub

Public Sub LoadFirst(obj As Object)
	Dim o() As Object = obj
	allItems = o(0)
	prefixList = o(1)
	AddAll
End Sub

Public Sub LoadSecond(obj As Object)
	substringList = obj
	if et.Text.Length > 0 then et_TextChanged("", et.Text)
End Sub

Public Sub RemoveView
	lv.RemoveView
	et.RemoveView
End Sub