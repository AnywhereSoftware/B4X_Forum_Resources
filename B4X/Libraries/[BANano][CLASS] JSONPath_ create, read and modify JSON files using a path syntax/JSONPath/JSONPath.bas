B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
' Created by Alain Bailleul (alwaysbusy) (c)2024
'
' Version 1.02
'
' A class to create and manipulate JSON using simple path syntax

Sub Class_Globals
	Private DBMap As Map
	Private DBLst As List
	Private InnerType As Int = 0
	
	Public const TYPE_MAP As Int = 1
	Public const TYPE_ARRAY As Int = 2
	Public const TYPE_UNDEFINED As Int = 0
	
	'Private FilterParams As Map
End Sub

' if jsonOrObject is an empty string, the JSONPath type will be TYPE_UNDEFINED until the first item is added
' jsonOrObject can be a json string, a map, a list or another JSONPath.
' Note: if it is another JSONPath, it is added by reference!
Public Sub Initialize(jsonOrObject As Object)
	'FilterParams.Initialize
	If jsonOrObject Is String Then
		If "" = jsonOrObject Then
			Return
		End If
		Dim jsonP As JSONParser
		jsonP.Initialize(jsonOrObject)
		Dim jsonOrObjectStr As String = jsonOrObject
		If jsonOrObjectStr.Trim.StartsWith("{") Then
			DBMap = jsonP.NextObject
			InnerType = TYPE_MAP
		Else
			DBLst = jsonP.NextArray
			InnerType = TYPE_ARRAY
		End If
		Return
	End If
	If jsonOrObject Is Map Then
		DBMap = jsonOrObject
		InnerType = TYPE_MAP
		Return
	End If
	If jsonOrObject Is List Then
		DBLst = jsonOrObject
		InnerType = TYPE_ARRAY
		Return
	End If
	If jsonOrObject Is JSONPath Then
		Dim tmpJsonOrObject As JSONPath = jsonOrObject
		Select Case tmpJsonOrObject.InnerType
			Case TYPE_MAP
				DBMap = tmpJsonOrObject.DBMap
				InnerType = TYPE_MAP
				Return
			Case TYPE_ARRAY
				DBLst = tmpJsonOrObject.DBLst
				InnerType = TYPE_ARRAY
				Return
			Case TYPE_UNDEFINED
				Return
		End Select
	End If
End Sub

' Creates a JSON string from the initialized object.
' The string does not include any extra white space.
public Sub ToString() As String
	Dim jsonG As JSONGenerator
	Select Case InnerType
		Case TYPE_MAP
			jsonG.Initialize(DBMap)
		Case TYPE_ARRAY
			jsonG.Initialize2(DBLst)
		Case TYPE_UNDEFINED
			Log("JSONPath is not initialized")
			Return ""
	End Select
	Return jsonG.ToString
End Sub

' Creates a JSON string from the initialized object.
' The string will be indented and easier for reading.
' Note that the string created is a valid JSON string.
' Indent - number of spaces to add to each level.
public Sub ToPrettyString(indent As Int) As String
	Dim jsonG As JSONGenerator
	Select Case InnerType
		Case TYPE_MAP
			jsonG.Initialize(DBMap)
		Case TYPE_ARRAY
			jsonG.Initialize2(DBLst)
		Case TYPE_UNDEFINED
			Log("JSONPath is not initialized")
			Return ""
	End Select
	Return jsonG.ToPrettyString(indent)
End Sub

' returns the type of the root: TYPE_MAP, TYPE_ARRAY, TYPE_UNDEFINED
public Sub getRootType() As Int
	Return InnerType
End Sub

' Gets the object given its full path.
' path - the full path to the object, each branch separated by a /
'        for an array use the index (starting from 0),
' 		 path can have wildcard:
'		 - use # to refer to the last item in an array
public Sub Get(path As String) As Object
	Dim keys() As String = PathToKeys(path)
	For i = 0 To keys.Length - 1
		If keys(i) = "*" Or keys(i).StartsWith("{") Or keys(i) = "@" Then
			Log("path can not contain the *, @, or json filter wildcard.")
			Return Null
		End If
	Next
	Dim ret As Object
	Select Case InnerType
		Case TYPE_MAP
			ret = GetInner(DBMap, path)
		Case TYPE_ARRAY
			ret = GetInner(DBLst, path)
		Case TYPE_UNDEFINED
			ret = Null
	End Select
	Return ret
End Sub

' Gets the object given its full path.
' path - the full path to the object, each branch separated by a /
'        for an array use the index (starting from 0),
' 		 path can have wildcard:
'		 - use # to refer to the last item in an array
' default - a default value if the path was not found  
public Sub GetDefault(path As String, default As Object) As Object
	Dim keys() As String = PathToKeys(path)
	For i = 0 To keys.Length - 1
		If keys(i) = "*" Or keys(i).StartsWith("{") Or keys(i) = "@" Then
			Log("path can not contain the *, @, or json filter wildcard.")
			Return Null
		End If
	Next
	Dim ret As Object = Get(path)
	
	If ret = Null Then
		ret = default
	End If
	Return ret
End Sub

' Returns a clone of the object given its full path.
' path - the full path to the object, each branch separated by a /
'        for an array use the index (starting from 0)
' 		 path can have wildcard:
'		 - use # to refer to the last item in an array
public Sub GetClone(path As String) As Object
	Dim keys() As String = PathToKeys(path)
	For i = 0 To keys.Length - 1
		If keys(i) = "*" Or keys(i).StartsWith("{") Or keys(i) = "@" Then
			Log("path can not contain the *, @, or json filter wildcard.")
			Return Null
		End If
	Next
	Dim tmpObj As Object = Get(path)
	If tmpObj <> Null Then
		If tmpObj Is String Or IsNumber(tmpObj) Or tmpObj Is Boolean Then
			Return tmpObj
		End If
		Dim jsonG As JSONGenerator
		Dim tmpJson As String
		If tmpObj Is Map Then
			jsonG.Initialize(tmpObj)
			tmpJson = jsonG.ToString
			Dim jsonP As JSONParser
			jsonP.Initialize(tmpJson)
			Return jsonP.NextObject
		Else
			jsonG.Initialize2(tmpObj)
			tmpJson = jsonG.ToString
			Dim jsonP As JSONParser
			jsonP.Initialize(tmpJson)
			Return jsonP.NextArray
		End If
	End If
	Return Null
End Sub

' Sets an object at the given full path.
' path - the full path to the object, each branch separated by a /
'        for an array use the index (starting from 0)
' 		 path can have wildcards:	
'		 - use @ to add it to the end of an array
'		 - use # to refer to the last item in an array
'		 - use * to refer to all items in the array
' value - the value of the object at the path (can be another JSONPath)
public Sub Set(path As String, value As Object)
	Dim keys() As String = PathToKeys(path)
	For i = 0 To keys.Length - 1
		If keys(i).StartsWith("{") Then
			Log("path can not contain a json filter wildcard.")
			Return
		End If
	Next
	path = path.Replace("@", "-1")
	If InnerType = TYPE_UNDEFINED Then
		Dim keys() As String = PathToKeys(path)
		If keys.Length = 0 Then
			Return
		End If
		If IsNumber(keys(0)) Then
			DBLst.Initialize
			InnerType = TYPE_ARRAY
		Else
			DBMap.Initialize
			InnerType = TYPE_MAP
		End If
	End If
	Select Case InnerType
		Case TYPE_MAP
			SetInner(DBMap, path, GetValue(value), "")
		Case TYPE_ARRAY
			SetInner(DBLst, path, GetValue(value), "")
		Case TYPE_UNDEFINED
			Log("JSONPath is not initialized")
	End Select
End Sub

' Remove an object given its full path. 
' path can not have wildcards (@, #, *, {})
' Returns the removed object
public Sub Remove(path As String) As Object
	Dim keys() As String = PathToKeys(path)
	For i = 0 To keys.Length - 1
		If keys(i) = "*" Or keys(i).StartsWith("{") Or keys(i) = "@" Or keys(i) = "#" Then
			Log("path can not contain the *, @, # or json filter wildcard.")
			Return Null
		End If
	Next
	If InnerType <> TYPE_UNDEFINED Then
		Dim obj As Object = Get(path)
		Dim keys() As String = PathToKeys(path)
		If keys.Length = 0 Then
			Return Null
		End If
		Dim lastKey As String = keys(keys.Length - 1)
		path = ""
		For j = 0 To (keys.Length - 2)
			path = path & keys(j) & "/"
		Next
		Dim parentObj As Object = Get(path)
		If parentObj Is Map Then
			Dim map As Map = parentObj
			map.Remove(lastKey)
		Else
			Dim lst As List = parentObj
			If IsNumber(lastKey) Then
				Dim num As Int = lastKey
				If num < lst.Size Then
					lst.RemoveAt(num)
				Else
					Return Null
				End If
			Else
				Return Null
			End If
		End If
		Return obj
	End If
	Return Null
End Sub

' copies an object from path to path
' paths can not have wildcards (@, #, *, {})
' returns the copied object
public Sub Copy(fromPath As String, toPath As String) As Object
	Dim keys() As String = PathToKeys(fromPath)
	For i = 0 To keys.Length - 1
		If keys(i) = "*" Or keys(i).StartsWith("{") Or keys(i) = "@" Then
			Log("path can not contain the *, @, or json filter wildcard.")
			Return Null
		End If
	Next
	Dim keys() As String = PathToKeys(toPath)
	For i = 0 To keys.Length - 1
		If keys(i) = "*" Or keys(i).StartsWith("{")Then
			Log("path can not contain the * or json filter wildcard.")
			Return Null
		End If
	Next
	Dim tmpObj As Object = GetClone(fromPath)
	If tmpObj <> Null Then
		Set(toPath, tmpObj)
	End If
	Return tmpObj
End Sub

' move an object from path to path
' paths can not have wildcards (@, #, *, {})
' returns the moved object
public Sub Move(fromPath As String, toPath As String) As Object
	Dim keys() As String = PathToKeys(fromPath)
	For i = 0 To keys.Length - 1
		If keys(i) = "*" Or keys(i).StartsWith("{") Or keys(i) = "@" Then
			Log("path can not contain the *, @, or json filter wildcard.")
			Return Null
		End If
	Next
	Dim keys() As String = PathToKeys(toPath)
	For i = 0 To keys.Length - 1
		If keys(i) = "*" Or keys(i).StartsWith("{") Then
			Log("path can not contain the * or json filter wildcard.")
			Return Null
		End If
	Next
	Dim tmpObj As Object = Remove(fromPath)
	Set(toPath, tmpObj)
	Return tmpObj
End Sub

' Finds objects given the full and some fields.
' The value can be a map of fields. Pass null for no filter.
' path - for an array use the index (starting from 0)
' 		 path can have wildcards:
'		 - use # to refer to the last item in an array
'		 - use * to refer to all items in the array
' 		 - use a json String to inner filter objects within an array
' Example:
' <code>
' Dim play as Map = Path.Filter($"teams/{"name": "De Caddie Clan"}/players/"$, CreateMap("name": "Catherine")) 
' </code>
' Returns a Map of objects found, the key is the full path to the object
Public Sub Filter(path As String, filterMap As Map) As Map
	Dim FilterParams As Map
	FilterParams.Initialize
	Dim keys() As String = PathToKeys(path)
	For i = 0 To keys.Length - 1
		If keys(i) = "@" Then
			Log("path can not contain the @ wildcard.")
			Return Null
		End If
		If keys(i).StartsWith("{") Then
			Dim jsonP As JSONParser
			jsonP.Initialize(keys(i))
			FilterParams.put(keys(i), jsonP.NextObject)
		End If
	Next
	
	Dim idms As Map
	Select Case InnerType
		Case TYPE_MAP
			idms = GetInnerFilter(DBMap, path, "", FilterParams)
		Case TYPE_ARRAY
			idms = GetInnerFilter(DBLst, path, "", FilterParams)
		Case TYPE_UNDEFINED
			idms = Null
	End Select
	
	Dim rets As Map
	rets.Initialize
	If idms <> Null And idms.IsInitialized Then
		InnerFindObjects(idms, rets, filterMap)
	End If
	Return rets
End Sub

Private Sub InnerFindObjects(idms As Map, rets As Map, value As Map)
	Dim tmpValue As Map = value
	For Each mainKey As String In idms.keys
		Dim mainidms As Map = idms.Get(mainKey)
		For Each key As String In mainidms.keys
			Dim currPath As String = ""
			If mainidms.Get(key) Is Map Then
				Dim tmpIdms As Map = mainidms.Get(key)
				Dim isSame As Boolean = True
				If tmpValue <> Null And tmpValue.IsInitialized Then
					For Each key2 As String In tmpValue.Keys
						If tmpIdms.ContainsKey(key2) = False Then
							isSame = False
							Exit
						Else
							Dim v1 As String = tmpIdms.Get(key2)
							Dim v2 As String = tmpValue.Get(key2)
							If v1 <> v2 Then
								isSame = False
								Exit
							End If
						End If
					Next
				End If
				If isSame Then
					If key.EndsWith("/") Then
						key = key.SubString2(0, key.Length - 1)
					End If
					currPath = currPath & key & "/"
					rets.put(currPath, tmpIdms)
				End If
			Else
				If mainidms.Get(key) Is List Then
					Dim tmpIdmsLst As List = mainidms.Get(key)
					If key.EndsWith("/") Then
						key = key.SubString2(0, key.Length - 1)
					End If
					currPath = currPath & key & "/"
					GoUntilNotList(tmpIdmsLst, rets, value, currPath)
				Else
					Dim isSame As Boolean = True
					If tmpValue <> Null And tmpValue.IsInitialized Then
						For Each key2 As String In tmpValue.Keys
							If mainidms.ContainsKey(key2) = False Then
								isSame = False
								Exit
							Else
								Dim v1 As String = mainidms.Get(key2)
								Dim v2 As String = tmpValue.Get(key2)
								If v1 <> v2 Then
									isSame = False
									Exit
								End If
							End If
						Next
					End If
					If isSame Then
						If mainKey.EndsWith("/") Then
							mainKey = mainKey.SubString2(0, mainKey.Length - 1)
						End If
						'currPath = currPath & key & "/"
						rets.put(mainKey & "/", mainidms)
					End If
				End If
			End If
		Next
	Next
End Sub

Private Sub SetFilter(path As String, filterMap As Map) As Map
	Dim emptyM As Map
	emptyM.Initialize
	
	Dim idms As Map
	Select Case InnerType
		Case TYPE_MAP
			idms = GetInnerFilter(DBMap, path, "", emptyM)
		Case TYPE_ARRAY
			idms = GetInnerFilter(DBLst, path, "", emptyM)
		Case TYPE_UNDEFINED
			idms = Null
	End Select
	
	Dim rets As Map
	rets.Initialize
	If idms <> Null And idms.IsInitialized Then
		SetInnerFindObjects(idms, rets, filterMap)
	End If
	Return rets
End Sub

Private Sub SetInnerFindObjects(idms As Map, rets As Map, value As Map)
	Dim tmpValue As Map = value
	For Each Key As String In idms.keys
		Dim currPath As String = ""
		If idms.Get(Key) Is Map Then
			Dim tmpIdms As Map = idms.Get(Key)
			Dim isSame As Boolean = True
			If tmpValue <> Null And tmpValue.IsInitialized Then
				For Each key2 As String In tmpValue.Keys
					If tmpIdms.ContainsKey(key2) = False Then
						isSame = False
						Exit
					Else
						Dim v1 As String = tmpIdms.Get(key2)
						Dim v2 As String = tmpValue.Get(key2)
						If v1 <> v2 Then
							isSame = False
							Exit
						End If
					End If
				Next
			End If
			If isSame Then
				If Key.EndsWith("/") Then
					Key = Key.SubString2(0, Key.Length - 1)
				End If
				currPath = currPath & Key & "/"
				rets.put(currPath, tmpIdms)
			End If
		Else
			If idms.Get(Key) Is List Then
				Dim tmpIdmsLst As List = idms.Get(Key)
				If Key.EndsWith("/") Then
					Key = Key.SubString2(0, Key.Length - 1)
				End If
				currPath = currPath & Key & "/"
				GoUntilNotList(tmpIdmsLst, rets, value, currPath)
			Else
				Dim isSame As Boolean = True
				If tmpValue <> Null And tmpValue.IsInitialized Then
					For Each key2 As String In tmpValue.Keys
						If idms.ContainsKey(key2) = False Then
							isSame = False
							Exit
						Else
							Dim v1 As String = idms.Get(key2)
							Dim v2 As String = tmpValue.Get(key2)
							If v1 <> v2 Then
								isSame = False
								Exit
							End If
						End If
					Next
				End If
				If isSame Then
					If Key.EndsWith("/") Then
						Key = Key.SubString2(0, Key.Length - 1)
					End If
					'currPath = currPath & Key & "/"
					rets.put(Key & "/", idms)
				End If
			End If
		End If
	Next
End Sub

private Sub GoUntilNotList(idms As List, rets As Map, value As Map, currPath As String)
	For i = 0 To idms.Size - 1
		Dim tmpCurrPath As String = currPath
		If idms.Get(i) Is List Then
			GoUntilNotList(idms.Get(i), rets, value, currPath)
		Else
			Dim tmpValue As Map = value
			Dim isSame As Boolean = True
			Dim idmsM As Map = idms.Get(i)
			If tmpValue <> Null And tmpValue.IsInitialized Then
				For Each key2 As String In tmpValue.Keys
					If idmsM.ContainsKey(key2) = False Then
						isSame = False
						Exit
					Else
						Dim v1 As String = idmsM.Get(key2)
						Dim v2 As String =  tmpValue.Get(key2)
						If v1 <> v2 Then
							isSame = False
							Exit
						End If
					End If
				Next
			End If
			If isSame Then
				tmpCurrPath = tmpCurrPath & i & "/"
				rets.put(tmpCurrPath, idmsM)
			End If
		End If
	Next
End Sub

' Returns the size of the array, given the full path to the array. 
' Returns -1 if not found
public Sub GetArraySize(Path As String) As Long
	Dim idms As List = Get(Path)
	If idms <> Null And idms.IsInitialized Then
		Return idms.Size
	End If
	Return -1
End Sub

' returns an array of all the keys in the path
public Sub PathToKeys(path As String) As String()
	' temprary fix for BANano, will be fixed in 9.03+
	If path.IndexOf("/") < 0 Then
		Dim arr(1) As String
		arr(0) = path
		Return arr
	End If
	Return Regex.Split("/", path)
End Sub

' makes a path from an array of keys
public Sub KeysToPath(keys() As String) As String
	Dim ret As String
	For i = 0 To keys.Length - 1
		ret = ret & keys(i) & "/"
	Next
	Return ret
End Sub

private Sub SetInner(obj As Object, Path As String, val As Object, lastKey As String)
	Dim Keys() As String = PathToKeys(Path)
	Path = ""
	For j = 0 To Keys.Length - 2
		Path = Path & Keys(j) & "/"
	Next
	If Keys.Length = 0 Then
		If InnerType = TYPE_MAP Then
			DBMap.Put(lastKey, GetValue(val))
		Else
			If IsNumber(lastKey) Then
				If DBLst.Size <= lastKey Then
					Dim num As Int = lastKey
					AddWithEmpties(DBLst, num, GetValue(val))
				Else
					If lastKey < 0 Then
						DBLst.Add(GetValue(val))
					Else
						DBLst.Set(lastKey, GetValue(val))
					End If
				End If
			Else
				DBLst.Add(GetValue(val))
			End If
		End If
		Return
	End If
	
	Dim resMap As Map
	resMap.Initialize
	If Path.Contains("*") Then
		resMap = SetFilter(Path, Null)
	End If
	If resMap.Size > 0 Then
		For Each resMapKey As String In resMap.Keys
			Dim ret As Object
			If InnerType = TYPE_MAP Then
				ret = GetInner(DBMap, resMapKey)
			Else
				ret = GetInner(DBLst, resMapKey)
			End If
						
			If ret <> Null Then
				If ret Is Map Then
					Dim map As Map = ret
					map.Put(Keys(Keys.Length-1), GetValue(val))
				Else
					Dim lst As List = ret
					If lst.Size <= Keys(Keys.Length-1) Then
						Dim num As Int = Keys(Keys.Length-1)
						AddWithEmpties(lst, num, GetValue(val))
					Else
						If Keys(Keys.Length-1) < 0 Then
							lst.add(val)
						Else
							lst.Set(Keys(Keys.Length-1), GetValue(val))
						End If
					End If
				End If
			Else
				If IsNumber(Keys(Keys.Length-1)) Then
					Dim num As Int = Keys(Keys.Length-1)
					Dim lst As List
					lst.Initialize
					AddWithEmpties(lst, num, GetValue(val))
					SetInner(obj, Path, lst, Keys(Keys.Length-1))
				Else
					Dim map As Map
					map.Initialize
					map.Put(Keys(Keys.Length-1), GetValue(val))
					SetInner(obj, Path, map, Keys(Keys.Length-1))
				End If
			End If
		Next
	Else
		Dim ret As Object
		If InnerType = TYPE_MAP Then
			ret = GetInner(DBMap, Path)
		Else
			ret = GetInner(DBLst, Path)
		End If
		If ret <> Null Then
			If ret Is Map Then
				Dim map As Map = ret
				map.Put(Keys(Keys.Length-1), GetValue(val))
			Else
				Dim lst As List = ret
				If lst.Size <= Keys(Keys.Length-1) Then
					Dim num As Int = Keys(Keys.Length-1)
					AddWithEmpties(lst, num, GetValue(val))
				Else
					If Keys(Keys.Length-1) < 0 Then
						lst.add(val)
					Else
						lst.Set(Keys(Keys.Length-1), GetValue(val))
					End If
				End If
			End If
		Else
			If IsNumber(Keys(Keys.Length-1)) Then
				Dim num As Int = Keys(Keys.Length-1)
				Dim lst As List
				lst.Initialize
				AddWithEmpties(lst, num, GetValue(val))
				SetInner(obj, Path, lst, Keys(Keys.Length-1))
			Else
				Dim map As Map
				map.Initialize
				map.Put(Keys(Keys.Length-1), GetValue(val))
				SetInner(obj, Path, map, Keys(Keys.Length-1))
			End If
		End If
	End If
End Sub

private Sub GetInner(obj As Object, path As String) As Object
	Dim keys() As String = PathToKeys(path)
	path = ""
	If keys.Length = 0 Then
		Return obj
	End If
	
	Dim key As String
	For i = 0 To keys.Length - 1
		key = keys(i)
		If key <> "" Then
			Exit
		End If
	Next
	If key.Length = 0 Then
		Return obj
	End If
	
	For j = i + 1 To keys.Length - 1
		path = path & keys(j) & "/"
	Next
	If obj Is Map Then
		Dim map As Map = obj
		obj = GetInner(map.GetDefault(key, Null), path)
	Else If obj Is List Then
		Dim lst As List = obj
		Try
			If key = "#" Then
				obj = GetInner(lst.Get(lst.Size - 1), path)
			Else
				obj = GetInner(lst.Get(key), path)
			End If
		Catch
			obj = Null
		End Try
	End If
	Return obj
End Sub

private Sub GetInnerFilter(obj As Object, path As String, prePath As String, filterParams As Map) As Object
	Dim keys() As String = PathToKeys(path)
	path = ""
	If keys.Length = 0 Then
		Return obj
	End If
	
	Dim key As String
	For i = 0 To keys.Length - 1
		key = keys(i)
		If key <> "" Then
			Exit
		End If
	Next
	If key.Length = 0 Then
		If obj Is List Then
			key = "*"
		Else
			Return obj
		End If
	End If
	
	For j = i + 1 To keys.Length - 1
		path = path & keys(j) & "/"
	Next
	If obj Is Map Then
		prePath = prePath & key & "/"
		Dim map As Map = obj
		obj = GetInnerFilter(map.GetDefault(key, Null), path, prePath, filterParams)
		Dim tmpPath As String = path
		If tmpPath.EndsWith("/") Then
			tmpPath = tmpPath.SubString2(0, tmpPath.Length-1)
		End If
		If tmpPath = "" Then
			Dim retLst As Map
			retLst.Initialize
			If prePath.EndsWith("/") Then
				prePath = prePath.SubString2(0, prePath.Length-1)
			End If
			retLst.put(prePath, obj)
			obj = retLst
		End If
	Else If obj Is List Then
		Dim lst As List = obj
		Try
			If key = "*" Then
				Dim retLst As Map
				retLst.Initialize
				Dim tmpPath As String = path
				If tmpPath.EndsWith("/") Then
					tmpPath = tmpPath.SubString2(0, tmpPath.Length-1)
				End If
				If tmpPath = "" Then
					For i = 0 To lst.Size - 1
						retLst.put(prePath & i & "/", GetInnerFilter(lst.Get(i), path, prePath & i & "/", filterParams))
					Next
					obj = retLst
				Else
					For i = 0 To lst.Size - 1
						Dim m As Map  = GetInnerFilter(lst.Get(i), path, prePath & i & "/", filterParams)
						If m <> Null Then
							For Each mKey As String In m.Keys
								retLst.Put(mKey, m.Get(mKey))
							Next
						End If
					Next
					obj = retLst
				End If
			Else
				If key.StartsWith("{") Then
					Dim retLst As Map
					retLst.Initialize
					Dim tmpPath As String = path
					If tmpPath.EndsWith("/") Then
						tmpPath = tmpPath.SubString2(0, tmpPath.Length-1)
					End If
					
					Dim tmpFilt As Map = filterParams.Get(key)
					
					If tmpPath = "" Then
						For i = 0 To lst.Size - 1
							Dim m As Map = GetInnerFilter(lst.Get(i), path, prePath & i & "/", filterParams)
							Dim isSame As Boolean = True
							If tmpFilt <> Null And tmpFilt.IsInitialized Then
								For Each key2 As String In tmpFilt.Keys
									If m.ContainsKey(key2) = False Then
										isSame = False
										Exit
									Else
										Dim v1 As String = m.Get(key2)
										Dim v2 As String = tmpFilt.Get(key2)
										If v1 <> v2 Then
											isSame = False
											Exit
										End If
									End If
								Next
							End If
							If isSame Then
								retLst.put(prePath & i & "/", m)
							End If
						Next
						obj = retLst
					Else
						For i = 0 To lst.Size - 1
							Dim m As Map = lst.Get(i)
							Dim isSame As Boolean = True
							If tmpFilt <> Null And tmpFilt.IsInitialized Then
								For Each key2 As String In tmpFilt.Keys
									If m.ContainsKey(key2) = False Then
										isSame = False
										Exit
									Else
										Dim v1 As String = m.Get(key2)
										Dim v2 As String = tmpFilt.Get(key2)
										If v1 <> v2 Then
											isSame = False
											Exit
										End If
									End If
								Next
							End If
							If isSame Then
								Dim mFilt As Map = GetInnerFilter(lst.Get(i), path, prePath & i & "/", filterParams)
								If mFilt <> Null Then
									For Each mKey As String In mFilt.Keys
										retLst.Put(mKey, mFilt.Get(mKey))
									Next
								End If
							End If
						Next
						obj = retLst
					End If
				Else
					If key = "#" Then
						prePath = prePath & (lst.Size - 1) & "/"
						obj = GetInnerFilter(lst.Get(lst.Size - 1), path, prePath, filterParams)
					Else
						prePath = prePath & key & "/"
						obj = GetInnerFilter(lst.Get(key), path, prePath, filterParams)
					End If
					Dim tmpPath As String = path
					If tmpPath.EndsWith("/") Then
						tmpPath = tmpPath.SubString2(0, tmpPath.Length-1)
					End If
					If tmpPath = "" Then
						Dim retLst As Map
						retLst.Initialize
						If prePath.EndsWith("/") Then
							prePath = prePath.SubString2(0, prePath.Length-1)
						End If
						retLst.put(prePath, obj)
						obj = retLst
					End If
				End If
			End If
		Catch
			obj = Null
		End Try
	End If
	Return obj
End Sub

private Sub AddWithEmpties(lst As List, num As Int, val As Object)
	Dim emptyM As Map
	emptyM.Initialize
	Dim emptyL As List
	emptyL.Initialize
	
	If num < 0 Then
		lst.Add(val)
		Return
	End If
	
	If val Is Map Then
		For i = lst.Size To num - 1
			lst.Add(emptyM)
		Next
	Else
		If val Is List Then
			For i = lst.Size To num - 1
				lst.Add(emptyL)
			Next
		Else
			If IsNumber(val) Then
				For i = lst.Size To num - 1
					lst.Add(0)
				Next
			Else
				For i = lst.Size To num - 1
					lst.Add("")
				Next
			End If
		End If
	End If
	lst.Add(val)
End Sub

private Sub GetValue(obj As Object) As Object
	If obj Is JSONPath Then
		Dim tmpVal As JSONPath = obj
		Select Case tmpVal.InnerType
			Case TYPE_MAP
				Return tmpVal.DBMap
			Case TYPE_ARRAY
				Return tmpVal.DBLst
			Case Else
				Return obj
		End Select
	Else
		Return obj
	End If
End Sub




