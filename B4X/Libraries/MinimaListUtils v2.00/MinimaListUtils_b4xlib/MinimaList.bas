B4J=true
Group=Modules
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
' Description	: Minimal List of Maps
' Version		: 2.00
' 2025-09-19 Update Clone
' 2025-07-10 Added ContainsKey, renamed CreatemType to CreateType
' 2024-10-29 Added Limit, replace dependency of KeyValueStore to RandomAccessFile
' 2024-10-27 Added Clone, update Reverse return the resulted object
' 2024-10-10 Update SortByKey, Added SortByKey2
' 2024-10-09 Update CopyList, Added CopyObject, Fix bug in SortByKey
' 2024-10-08 Added Reverse, FindByKey, SortByKey, Snippet 08
' 2024-04-24 Update Snippets, removed #plural tag
' 2023-12-09 Added CopyList
' 2023-10-24 Added Exclude, ExcludeAll and ExcludeAny subs, remove mMap
' 2023-10-18 Packaged as B4Xlib with Controller code snippet
' 2023-09-19 Added FindAnyLike sub
' 2023-08-16 Updated FindFirst and FindAll subs
' 2023-07-31 Added Count, Find, FindFirst and FindAll subs
' 2023-06-09 Added code sample when hover Sub Initialize
Sub Class_Globals
	Private mList As List
	Private mFirst As Map
	Private mLast As Map
	Type mType (id As Int, key As Object)
End Sub

Public Sub Initialize
	mList.Initialize
	mFirst.Initialize
	mLast.Initialize
End Sub

Public Sub setList (L1 As List)
	mList = L1
	If mList.Size > 0 Then
		mFirst = mList.Get(0)
		mLast = mList.Get(mList.Size - 1)
	End If
End Sub

Public Sub getList As List
	Return mList
End Sub

' Set First item
Public Sub setFirst (M As Map)
	mFirst = M
End Sub

' Get First item
Public Sub getFirst As Map
	Return mFirst
End Sub

' Set Last item
Public Sub setLast (M As Map)
	mLast = M
End Sub

' Get Last item
Public Sub getLast As Map
	Return mLast
End Sub

' Add new item
Public Sub Add (M As Map)
	Dim id As Long
	If mList.Size = 0 Then
		id = 1
		mFirst = M
	Else
		id = mList.Get(mList.Size - 1).As(Map).Get("id") + 1
	End If
	M.Put("id", id)
	mList.Add(M)
	mLast = M
End Sub

' Make a clone of MinimaList
Public Sub Clone As MinimaList
	Dim TempList As MinimaList
	TempList.Initialize
	Dim NewList As List = CopyList
	TempList.List = NewList
	If NewList.Size > 0 Then
		TempList.First = NewList.Get(0)
		TempList.Last = NewList.Get(NewList.Size - 1)
	End If
	Return TempList
End Sub

' Make a copy of the List
Public Sub CopyList As List
	Dim ser As B4XSerializator
	Return ser.ConvertBytesToObject(ser.ConvertObjectToBytes(mList))
End Sub

' Make a copy of an Object/Map
Public Sub CopyObject (xo As Object) As Object
	Dim ser As B4XSerializator
	Return ser.ConvertBytesToObject(ser.ConvertObjectToBytes(xo))
End Sub

' Count items where value of a key is equals to id
Public Sub Count (key As String, id As Long) As Int
	Dim num As Int
	For Each M As Map In mList
		If M.ContainsKey(key) And M.Get(key) <> "" Then
			If id = M.Get(key) Then
				num = num + 1
			End If
		End If
	Next
	Return num
End Sub

' Remove item by index
Public Sub Remove (index As Long)
	If mList.Size > 0 Then
		mList.RemoveAt(index)
	End If
	If mList.Size = 0 Then
		mFirst.Clear
		mLast.Clear
	Else
		mFirst = mList.Get(0)
		mLast = mList.Get(mList.Size - 1)
	End If
End Sub

' Remove item by passing a Map object
Public Sub Remove2 (M As Map)
	If mList.Size > 0 Then
		For i = 0 To mList.Size - 1
			Dim O As Map = mList.Get(i)
			If O.Get("id") = M.Get("id") Then
				mList.RemoveAt(i)
				Exit
			End If
		Next
	End If

	If mList.Size = 0 Then
		mFirst.Clear
		mLast.Clear
	Else
		mFirst = mList.Get(0)
		mLast = mList.Get(mList.Size - 1)
	End If
End Sub

' Remove key in Map by index
Public Sub RemoveKey (key As String, index As Long)
	Dim M As Map = mList.Get(index)
	If M.ContainsKey(key) Then
		M.Remove(key)
	End If
End Sub

' Remove key in Map by passing a Map object
Public Sub RemoveKey2 (key As String, M As Map)
	If M.ContainsKey(key) Then
		M.Remove(key)
	End If
End Sub

' Get index of item by Map object
Public Sub IndexFromMap (M As Map) As Long
	Dim Index As Long
	For Each O As Map In mList
		If O.Get("id") = M.Get("id") Then
			Return Index
		End If
		Index = Index + 1
	Next
	Return -1
End Sub

' Get index of item by id key
Public Sub IndexFromId (id As Long) As Long
	Dim Index As Long
	For Each O As Map In mList
		If id = O.Get("id") Then
			Return Index
		End If
		Index = Index + 1
	Next
	Return -1
End Sub

' Find first item based on id key
Public Sub Find (id As Long) As Map
	For Each M As Map In mList
		If id = M.Get("id") Then
			Return M
		End If
	Next
	Return CreateMap()
End Sub

' Find first item where key and value list matched
Public Sub FindFirst (keys As List, values As List) As Map
	Dim index As Int = -1
	For i = 0 To mList.Size - 1
		Dim matched As Boolean
		Dim temp As Map = mList.Get(i)
		For k = 0 To keys.Size - 1
			If temp.ContainsKey(keys.Get(k)) = False Then Continue
			If temp.Get(keys.Get(k)).As(String).ToLowerCase = values.Get(k).As(String).ToLowerCase Then
				matched = True
				index = i
			Else
				matched = False
				Exit
			End If
		Next
		If matched Then Return mList.Get(index)
	Next
	Return CreateMap()
End Sub

' Find more than one item as list where all keys and values must matched
Public Sub FindAll (keys As List, values As List) As List
	'Dim index As Int = -1
	Dim result As List
	result.Initialize
	For i = 0 To mList.Size - 1
		Dim matched As Boolean
		Dim temp As Map = mList.Get(i)
		For k = 0 To keys.Size - 1
			If temp.Get(keys.Get(k)).As(String).ToLowerCase = values.Get(k).As(String).ToLowerCase Then
				matched = True
			Else
				matched = False
				Exit
			End If
		Next
		If matched Then result.Add(mList.Get(i))
	Next
	Return result
End Sub

' Find more than one item as list where at least one key and value matched
Public Sub FindAnyLike (keys As List, values As List) As List
	Dim result As List
	result.Initialize
	For i = 0 To mList.Size - 1
		Dim matched As Boolean
		Dim temp As Map = mList.Get(i)
		For k = 0 To keys.Size - 1
			If temp.Get(keys.Get(k)).As(String).ToLowerCase.Contains(values.Get(k).As(String).ToLowerCase) Then
				matched = True
			End If
		Next
		If matched Then result.Add(mList.Get(i))
	Next
	Return result
End Sub

' Exclude item based on id key
Public Sub Exclude (id As Long) As List
	For i = 0 To mList.Size - 1
		Dim temp As Map = mList.Get(i)
		If id = temp.Get("id") Then
			mList.RemoveAt(i)
			Exit
		End If
	Next
	Return mList
End Sub

' Exclude given all keys and values are matched from list
Public Sub ExcludeAll (keys As List, values As List) As List
	For i = 0 To mList.Size - 1
		Dim matched As Boolean = True
		Dim temp As Map = mList.Get(i)
		For k = 0 To keys.Size - 1
			If temp.Get(keys.Get(k)).As(String).ToLowerCase <> values.Get(k).As(String).ToLowerCase Then
				' At least a key is not matched
				matched = False
				Exit
			End If
		Next
		If matched Then mList.RemoveAt(i)
	Next
	Return mList
End Sub

' Exclude given any keys and values are matched from list
Public Sub ExcludeAny (keys As List, values As List) As List
	For i = 0 To mList.Size - 1
		Dim matched As Boolean = False
		Dim temp As Map = mList.Get(i)
		For k = 0 To keys.Size - 1
			If temp.Get(keys.Get(k)).As(String).ToLowerCase = values.Get(k).As(String).ToLowerCase Then
				' At least a key is matched
				matched = True
				Exit
			End If
		Next
		If matched Then mList.RemoveAt(i)
	Next
	Return mList
End Sub

Public Sub Reverse As MinimaList
	Dim sList As List
	sList.Initialize
	For i = mList.Size - 1 To 0 Step - 1
		sList.Add(mList.Get(i))
	Next
	setList(sList)
	Return Me
End Sub

Public Sub Limit (Number As Int) As MinimaList
	Dim OldList As List = CopyList
	If Number > OldList.Size Then Number = OldList.Size
	Dim TempList As List
	TempList.Initialize
	For i = 0 To Number - 1
		TempList.Add(OldList.Get(i))
	Next
	Dim NewList As MinimaList
	NewList.Initialize
	NewList.List = TempList
	NewList.First = NewList.List.Get(0)
	NewList.Last = NewList.List.Get(NewList.List.Size-1)
	Return NewList
End Sub

' Find first item based on any key
Public Sub FindByKey (key As String, value As Object) As Map
	For Each M As Map In mList
		If value = M.Get(key) Then
			Return M
		End If
	Next
	Return CreateMap()
End Sub

' Check list contains specified key
Public Sub ContainsKey (key As String) As Boolean
	For Each M As Map In mList
		If M.ContainsKey(key) Then Return True
	Next
	Return False
End Sub

' Assume all items contain key to sort
Public Sub SortByKey (key As String, ascending As Boolean)
	Dim sorted As List
	sorted.Initialize
	For h = 0 To mList.Size - 1
		Dim m1 As Map = mList.Get(h)
		sorted.Add(CreateType(m1.Get("id"), m1.Get(key)))
	Next
	sorted.SortType("key", ascending)
	Dim sList As List
	sList.Initialize
	For i = 0 To sorted.Size - 1
		Dim mt As mType = sorted.Get(i)
		Dim m2 As Map = CopyObject(Find(mt.id)) ' don't use FindByKey
		sList.Add(m2)
	Next
	setList(sList)
End Sub

' Put default value if key does not exist
Public Sub SortByKey2 (key As String, ascending As Boolean, default As Object)
	Dim sorted As List
	sorted.Initialize
	For h = 0 To mList.Size - 1
		Dim m1 As Map = mList.Get(h)
		If m1.ContainsKey(key) Then
			default = m1.GetDefault(key, default)
		Else
			m1.Put(key, default)
		End If
		sorted.Add(CreateType(m1.Get("id"), default))
	Next
	sorted.SortType("key", ascending)
	Dim sList As List
	sList.Initialize
	For i = 0 To sorted.Size - 1
		Dim t1 As mType = sorted.Get(i)
		Dim m2 As Map = CopyObject(Find(t1.id))
		sList.Add(m2)
	Next
	setList(sList)
End Sub

Private Sub CreateType (id As Int, key As Object) As mType
	Dim t1 As mType
	t1.Initialize
	t1.id = id
	t1.key = key
	Return t1
End Sub