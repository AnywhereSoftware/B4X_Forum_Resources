B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.3
@EndOfDesignText@
'version 1.01
#Event: ItemClick (Value As String)
#DesignerProperty: Key: HighlightColor, DisplayName: Highlight Color, FieldType: Color, DefaultValue: 0xFFFD5C5C
#DesignerProperty: Key: TextColor, DisplayName: Text Color, FieldType: Color, DefaultValue: Null
'Class module
Sub Class_Globals
	Private prefixList As Map
	Private substringList As Map
	Private et As EditText
	Private lv As ListView
	Private MIN_LIMIT = 2, MAX_LIMIT = 4 As Int 'doesn't limit the words length. Only the index.
	Private mCallback As Object
	Private mEventName As String
	Private mBase As Panel
	Private ime As IME
	Private maxHeight As Int
	Private highlightColor As Int = 0xFFFD5C5C
	Private Const DefaultColorConstant As Int = -984833 'ignore
End Sub

Public Sub Initialize (vCallback As Object, vEventName As String)
	mEventName = vEventName
	mCallback = vCallback
	et.Initialize("et")
	'Remove the suggestions bar
	et.InputType = Bit.Or(et.INPUT_TYPE_TEXT, 0x00080000)
	lv.Initialize("lv")
	lv.SingleLineLayout.ItemHeight = 50dip
	lv.SingleLineLayout.Label.TextSize = 14
	lv.Visible = False
	prefixList.Initialize
	substringList.Initialize
	ime.Initialize("")
End Sub

Public Sub DesignerCreateView (Base As Panel, Lbl As Label, Props As Map)
	mBase = Base
	mBase.AddView(et, 0, 0, mBase.Width, 60dip)
	mBase.AddView(lv, 0, et.Height, mBase.Width, mBase.Height - et.Height)
	maxHeight = mBase.Height
	highlightColor = Props.Get("HighlightColor")
	Dim c As Int = Props.Get("TextColor")
	If c <> DefaultColorConstant Then 
		lv.SingleLineLayout.Label.TextColor = c
		et.TextColor = c
	End If
End Sub

Public Sub ActivityHeightChanged(NewHeight As Int)
	Dim baseHeight As Int = Min(maxHeight, NewHeight - mBase.Top)
	mBase.SetLayout(mBase.Left, mBase.Top, mBase.Width, baseHeight)
	lv.SetLayout(0, lv.Top, lv.Width, baseHeight - lv.Top)
End Sub


Private Sub lv_ItemClick (Position As Int, Value As Object)
	et.Text = Value
	et.SelectionStart = et.Text.Length
	ime.HideKeyboard
	lv.Visible = False
	If SubExists(mCallback, mEventName & "_ItemClick") Then
		CallSub2(mCallback, mEventName & "_ItemClick", Value)
	End If
End Sub

Private Sub et_TextChanged (Old As String, New As String)
	lv.Clear
	If lv.Visible = False Then lv.Visible = True
	If New.Length < MIN_LIMIT Then Return
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

Private Sub AddItemsToList(li As List, full As String)
	If li.IsInitialized = False Then Return
	Dim cs As CSBuilder
	For i = 0 To li.Size - 1
		Dim item As String = li.Get(i)
		Dim x As Int = item.ToLowerCase.IndexOf(full)
		If x = -1 Then
			Continue
		End If
		cs.Initialize.Append(item.SubString2(0, x)).Color(highlightColor).Append(item.SubString2(x, x + full.Length)).Pop
		cs.Append(item.SubString(x + full.Length))
		lv.AddSingleLine(cs)
	Next
End Sub

'Builds the index and returns an object which you can store as a process global variable
'in order to avoid rebuilding the index when the device orientation changes.
Public Sub SetItems(Items As List) As Object
	Dim startTime As Long = DateTime.Now
	Dim noDuplicates As Map
	noDuplicates.Initialize
	prefixList.Clear
	substringList.Clear
	Dim m As Map
	Dim li As List
	For i = 0 To Items.Size - 1
		Dim item As String
		item = Items.Get(i)
		item = item.ToLowerCase
		noDuplicates.Clear
		For start = 0 To item.Length
			Dim count As Int
			count = MIN_LIMIT
			Do While count <= MAX_LIMIT And start + count <= item.Length
				Dim str As String
				str = item.SubString2(start, start + count)
				If noDuplicates.ContainsKey(str) = False Then
					noDuplicates.Put(str, "")
					If start = 0 Then m = prefixList Else m = substringList
					li = m.Get(str)
					If li.IsInitialized = False Then
						li.Initialize
						m.Put(str, li)
					End If
					li.Add(Items.Get(i)) 'Preserve the original case
				End If
				count = count + 1
			Loop
		Next
	Next
	Log("Index time: " & (DateTime.Now - startTime) & " ms (" & Items.Size & " Items)")
	Return Array As Object(prefixList, substringList)
End Sub

'Sets the index from the previously stored index.
Public Sub SetIndex(Index As Object)
	Dim obj() As Object
	obj = Index
	prefixList = obj(0)
	substringList = obj(1)
End Sub