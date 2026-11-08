B4J=true
Group=Classes
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
' Version 3.00
' Minimal List of Maps
Sub Class_Globals
	Private mList As List
	Private mFirst As Map
	Private mLast As Map
	Private mCaseSensitive As Boolean
	Type mType (id As Int, value As Object)
End Sub

Public Sub Initialize
	mList.Initialize
	mFirst.Initialize
	mLast.Initialize
End Sub

' Set First item
'Public Sub setFirst (M As Map)
'	mFirst = M
'End Sub

' Get First item
Public Sub getFirst As Map
	Return mFirst
End Sub

' Set Last item
'Public Sub setLast (M As Map)
'	mLast = M
'End Sub

' Get Last item
Public Sub getLast As Map
	Return mLast
End Sub

Public Sub setList (L1 As List)
	mList = L1
	ResetFirstAndLast
End Sub

Public Sub getList As List
	Return mList
End Sub

Public Sub setCaseSensitive (value As Boolean)
	mCaseSensitive = value
End Sub

Public Sub getCaseSensitive As Boolean
	Return mCaseSensitive
End Sub

' Add new item
Public Sub Add (M As Map)
	Dim id As Int = mLast.GetDefault("id", 0)
	Dim M1 As Map
	M1.Initialize
	M1.Put("id", id + 1)
	For Each key As String In M.Keys
		M1.Put(key, M.Get(key))
	Next
	If mList.Size = 0 Then mFirst = M1
	mLast = M1
	mList.Add(M1)
End Sub

' Make a clone of MinimaList
Public Sub Clone As MinimaList
	Return CreateFromList(mList)
End Sub

' Check list contains specified key
Public Sub ContainsKey (key As String) As Boolean
	For Each M1 As Map In mList
		If M1.ContainsKey(key) Then Return True
	Next
	Return False
End Sub

' Make a copy of the List
Public Sub CopyList As List
	Dim ser As B4XSerializator
	Return ser.ConvertBytesToObject(ser.ConvertObjectToBytes(mList))
End Sub

' Make a copy of an Object/Map
Public Sub CopyObject (O As Object) As Object
	Dim ser As B4XSerializator
	Return ser.ConvertBytesToObject(ser.ConvertObjectToBytes(O))
End Sub

' Count items where value of a key is equals to id
Public Sub CountById (key As String, id As Int) As Int
	Dim count As Int
	For Each M1 As Map In mList
		If M1.ContainsKey(key) And M1.Get(key) <> "" Then
			If id = M1.Get(key) Then
				count = count + 1
			End If
		End If
	Next
	Return count
End Sub

' Create a new MinimaList from a List
Private Sub CreateFromList (L As List) As MinimaList
	Dim ML As MinimaList
	ML.Initialize
	ML.List = CopyObject(L)
	Return ML
End Sub

Private Sub CreateType (id As Int, value As Object) As mType
	Dim t1 As mType
	t1.Initialize
	t1.id = id
	t1.value = value
	Return t1
End Sub

' Exclude item based on id key
Public Sub Exclude (id As Int) As List
	Dim index As Int = IndexFromId(id)
	If index > -1 Then
		mList.RemoveAt(index)
	End If
	Return mList
End Sub

' Exclude given all keys and values are matched from list
Public Sub ExcludeAll (keys As List, values As List) As List
	Dim L1 As List ' List of excluded items
	L1.Initialize
	For i = 0 To mList.Size - 1
		Dim matched As Int
		Dim M1 As Map = mList.Get(i)
		For k = 0 To keys.Size - 1
			Dim key As String = keys.Get(k)
			Dim value As Object = values.Get(k)
			If M1.ContainsKey(key) = False Then Exit
			Dim value1 As String = M1.Get(key)
			Dim value2 As String = value
			If mCaseSensitive Then
				If value1 = value2 Then matched = matched + 1
			Else
				If value1.EqualsIgnoreCase(value2) Then matched = matched + 1
			End If
		Next
		If matched = keys.Size Then L1.Add(i)
	Next
	For Each index As Int In L1
		mList.RemoveAt(index)
	Next
	Return mList
End Sub

' Exclude given any keys and values are matched from list
Public Sub ExcludeAny (keys As List, values As List) As List
	Dim L1 As List ' List of excluded items
	L1.Initialize
	For i = 0 To mList.Size - 1
		Dim M1 As Map = mList.Get(i)
		For k = 0 To keys.Size - 1
			Dim key As String = keys.Get(k)
			Dim value As Object = values.Get(k)
			If M1.ContainsKey(key) = False Then Exit
			Dim value1 As String = M1.Get(key)
			Dim value2 As String = value
			If mCaseSensitive Then
				If value1.Contains(value2) Then
					L1.Add(i)
					Exit
				End If
			Else
				If value1.ToLowerCase.Contains(value2.ToLowerCase) Then
					L1.Add(i)
					Exit
				End If
			End If
		Next
	Next
	For Each index As Int In L1
		mList.RemoveAt(index)
	Next
	Return mList
End Sub

' Find first item based on id key
Public Sub Find (id As Int) As Map
	For Each M1 As Map In mList
		If M1.ContainsKey("id") And id = M1.Get("id") Then
			Return M1
		End If
	Next
	Return CreateMap()
End Sub

' Find more than one item as list where all keys and values must matched
Public Sub FindAll (keys As List, values As List) As List
	Dim L1 As List
	L1.Initialize
	For Each M1 As Map In mList
		Dim matched As Int
		For k = 0 To keys.Size - 1
			Dim key As String = keys.Get(k)
			Dim value As Object = values.Get(k)
			If M1.ContainsKey(key) = False Then Exit
			Dim value1 As String = M1.Get(key)
			Dim value2 As String = value
			If mCaseSensitive Then
				If value1 = value2 Then matched = matched + 1
			Else
				If value1.EqualsIgnoreCase(value2) Then matched = matched + 1
			End If
		Next
		If matched = keys.Size Then L1.Add(M1)
	Next
	Return L1
End Sub

' Find more than one item as list where at least value of one key contains given value
Public Sub FindAnyLike (keys As List, values As List) As List
	Dim L1 As List
	L1.Initialize
	For Each M1 As Map In mList
		For k = 0 To keys.Size - 1
			Dim key As String = keys.Get(k)
			Dim value As Object = values.Get(k)
			If M1.ContainsKey(key) = False Then Exit
			Dim value1 As String = M1.Get(key)
			Dim value2 As String = value
			If mCaseSensitive Then
				If value1.Contains(value2) Then
					L1.Add(M1)
					Exit
				End If
			Else
				If value1.ToLowerCase.Contains(value2.ToLowerCase) Then
					L1.Add(M1)
					Exit
				End If
			End If
		Next
	Next
	Return L1
End Sub

' Find first item (initialized map) based on a key
Public Sub FindByKey (key As String, value As Object) As Map
	For Each M1 As Map In mList
		If M1.ContainsKey(key) And value = M1.Get(key) Then
			Return M1
		End If
	Next
	Return CreateMap()
End Sub

' Find first item where list of all keys and values matched
Public Sub FindFirst (keys As List, values As List) As Map
	For Each M1 As Map In mList
		Dim matched As Int
		For k = 0 To keys.Size - 1
			Dim key As String = keys.Get(k)
			Dim value As Object = values.Get(k)
			If M1.ContainsKey(key) = False Then Exit
			Dim value1 As String = M1.Get(key)
			Dim value2 As String = value
			If mCaseSensitive Then
				If value1 = value2 Then matched = matched + 1
			Else
				If value1.EqualsIgnoreCase(value2) Then matched = matched + 1
			End If
		Next
		If matched = keys.Size Then Return M1
	Next
	Return CreateMap()
End Sub

' Get index of item by id key
Public Sub IndexFromId (id As Int) As Int
	For i = 0 To mList.Size - 1
		Dim M1 As Map = mList.Get(i)
		If M1.ContainsKey("id") And id = M1.Get("id") Then
			Return i
		End If
	Next
	Return -1
End Sub

' Get index of item by Map object
Public Sub IndexFromMap (M As Map) As Int
	For i = 0 To mList.Size - 1
		Dim M1 As Map = mList.Get(i)
		If M1.ContainsKey("id") And M.ContainsKey("id") Then
			If M1.Get("id") = M.Get("id") Then
				Return i
			End If
		End If
	Next
	Return -1
End Sub

Public Sub Limit (size As Int) As MinimaList
	If size > mList.Size Then size = mList.Size
	Dim L1 As List
	L1.Initialize
	For i = 0 To size - 1
		L1.Add(mList.Get(i))
	Next
	Return CreateFromList(L1)
End Sub

' Merge another MinimaList as a new MinimaList
Public Sub Merge (ML As MinimaList, key1 As String, key2 As String) As MinimaList
	Dim L1 As List = CopyObject(mList)
	Dim L2 As List = CopyObject(ML.List)
	For Each M1 As Map In L1
		For Each M2 As Map In L2
			' Convert to String type
			Dim value1 As String = M1.Get(key1)
			Dim value2 As String = M2.Get(key2)
			If mCaseSensitive Then
				If value1 = value2 Then
					For Each key As String In M2.Keys
						If M1.ContainsKey(key) = False Then
							M1.Put(key, M2.Get(key))
						End If
					Next
				End If
			Else
				If value1.EqualsIgnoreCase(value2) Then
					For Each key As String In M2.Keys
						If M1.ContainsKey(key) = False Then
							M1.Put(key, M2.Get(key))
						End If
					Next
				End If
			End If
		Next
	Next
	Return CreateFromList(L1)
End Sub

' Remove item by index
Public Sub Remove (index As Int)
	If index < mList.Size And index > -1 Then
		mList.RemoveAt(index)
		ResetFirstAndLast
	End If
End Sub

' Remove item by passing a Map object
Public Sub Remove2 (M As Map)
	Dim index As Int = IndexFromMap(M)
	Remove(index)
End Sub

' Remove key in Map by index
Public Sub RemoveKey (key As String, index As Int)
	Dim M1 As Map = mList.Get(index)
	RemoveKey2(key, M1)
End Sub

' Remove key in Map by passing a Map object
Public Sub RemoveKey2 (key As String, M As Map)
	If M.ContainsKey(key) Then
		M.Remove(key)
	End If
End Sub

Private Sub ResetFirstAndLast
	If mList.Size = 0 Then
		mFirst.Clear
		mLast.Clear
	Else
		mFirst = mList.Get(0)
		mLast = mList.Get(mList.Size - 1)
	End If
End Sub

Public Sub Reverse As MinimaList
	Dim L1 As List
	L1.Initialize
	For i = mList.Size - 1 To 0 Step - 1
		L1.Add(mList.Get(i))
	Next
	setList(L1)
	Return Me
End Sub

' Assume all items contain key to sort
Public Sub SortByKey (key As String, ascending As Boolean)
	Dim L1 As List
	L1.Initialize
	For Each M1 As Map In mList
		L1.Add(CreateType(M1.Get("id"), M1.Get(key)))
	Next
	L1.SortType("key", ascending)
	Dim L2 As List
	L2.Initialize
	For Each T1 As mType In L1
		L2.Add(Find(T1.id)) ' don't use FindByKey
	Next
	setList(L2)
End Sub

' Put default value if key does not exist
Public Sub SortByKey2 (key As String, ascending As Boolean, default As Object)
	Dim L1 As List
	L1.Initialize
	For Each M1 As Map In mList
		L1.Add(CreateType(M1.Get("id"), M1.GetDefault(key, default)))
	Next	
	L1.SortType("key", ascending)
	Dim L2 As List
	L2.Initialize
	For Each T1 As mType In L1
		L2.Add(Find(T1.id)) ' don't use FindByKey
	Next	
	setList(L2)
End Sub

'Private Sub IsString (O As Object) As Boolean
'	Return Initialized(O) And GetType(O) = "java.lang.String"
'End Sub