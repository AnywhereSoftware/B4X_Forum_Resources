B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=1.78
@EndOfDesignText@
'Class module
'This class was started by Erel as OrderedMap.  
'Modified by Jack Cole to contain more functions and methods

Sub Class_Globals
	Public m As Map
	Private KeysList As List
	Private ValueList As List
End Sub

Public Sub Initialize
	m.Initialize
	KeysList.Initialize
	ValueList.Initialize
End Sub

Public Sub ToMap As Map
	Return m
End Sub

'loads the data in the map into the map_b4x
'clears existing data
Public Sub LoadFromMap(mapToLoad As Map)
	Clear
	For Each k As Object In mapToLoad.Keys
		Dim currval As Object = mapToLoad.Get(k)
		Put(k, currval)
	Next
End Sub

Public Sub Put(Key As Object, Value As Object)
	If m.ContainsKey(Key) Then
		Dim i = KeysList.IndexOf(Key) As Int
		KeysList.RemoveAt(i)
		ValueList.RemoveAt(i)
	End If
	m.Put(Key, Value)
	KeysList.Add(Key)
	ValueList.Add(Value)
End Sub

Public Sub Get(Key As Object) As Object
	Return m.Get(Key)
End Sub


'This reverses the key/value.  It returns the Key for the provided value.
Public Sub GetByValue(Value As Object) As Object
	Return Keys.Get(ValueList.IndexOf(Value))
End Sub

Public Sub GetDefault(Key As Object, Default As Object) As Object
	Try
		Dim RetObj As Object = m.Get(Key)
	Catch
		RetObj=Default
	End Try
	Return RetObj
	
End Sub

Public Sub Remove(Key As Object)
	If m.ContainsKey(Key) Then
		Dim i As Int =KeysList.IndexOf(Key)
		KeysList.RemoveAt(i)
		ValueList.RemoveAt(i)
	End If
	m.Remove(Key)
End Sub

'this sub replaces the current keys with the values in the passed map
Public Sub ReplaceKeys(OldNewKeyMap As Map_B4X, RetainNonReplaced As Boolean)
'	Dim x As Int
'	Do While x < KeysList.Size - 1
'		Dim NewKey As Object = OldNewKeyMap.Get(KeysList.Get(x))
'		m.Remove(KeysList.Get(x))
'		m.Put(NewKey, ValueList.Get(x))
'		KeysList.RemoveAt(x)
'		KeysList.Insertat(x-1, NewKey)
'		x=x+1
'	Loop
	Dim NewReplacedKeys As List
	NewReplacedKeys.Initialize
	
	For x = 0 To KeysList.Size-1
		If OldNewKeyMap.ContainsKey(KeysList.Get(x)) Then
			Dim NewKey As Object = OldNewKeyMap.Get(KeysList.Get(x))
'			'LogColor($"Old Key = ${KeysList.Get(x)} New Key = ${OldNewKeyMap.Get(KeysList.Get(x))}"$, Colors.Green)
			m.Remove(KeysList.Get(x))
			m.Put(NewKey, ValueList.Get(x))
			KeysList.RemoveAt(x)
			If x-1>-1 Then 
				KeysList.Insertat(x-1, NewKey)	
			Else
				KeysList.Insertat(0, NewKey)
			End If
			NewReplacedKeys.Add(NewKey)
		Else
'			'LogColor($"Key not found ${KeysList.Get(x)}"$, Colors.Green)
		End If
	Next
	'remove non-replaced keys if specified
	If Not(RetainNonReplaced) Then
		Dim KeysToRemove As List = ListSubtract(KeysList, NewReplacedKeys)
		For Each key As Object In KeysToRemove
			m.Remove(key)
			Dim Index As Int = KeysList.IndexOf(key)
			KeysList.RemoveAt(Index)
			ValueList.RemoveAt(Index)
		Next
	End If
	
'	Log("End of ReplaceKeys")
End Sub

'removes all items in denomenator from numerator
Public Sub ListSubtract(numerator As List, denomenator As List) As List
	Dim ThisNumerator As List = ByRefListCopy(numerator)
	Try
		If denomenator.Size=0 Then Return
	Catch
		Return ThisNumerator
	End Try
	For x=0 To denomenator.Size-1
		Dim ind=ThisNumerator.IndexOf(denomenator.Get(x))
		If ind>-1 Then ThisNumerator.RemoveAt(ind)
	Next
	Return ThisNumerator
End Sub


'returns a copy of the list of keys so you can't modify the list directly
Public Sub Keys As List
	'LogColor($"Getting copy of keys list"$, Colors.Green)
	Return ByRefListCopy(KeysList)
End Sub

'returns a copy of the list of values so you can't modify the list directly
Public Sub Values As List
	'LogColor($"Getting copy of values list"$, Colors.Green)
	Return ByRefListCopy(ValueList)
End Sub

Private Sub ByRefListCopy(ListToCopy As List) As List
	Dim ReturnList As List
	ReturnList.Initialize
	For Each s As Object In ListToCopy
		ReturnList.Add(s)
	Next
	Return ReturnList
End Sub

Public Sub ContainsKey(KeyToFind As String) As Boolean
	Return KeysList.IndexOf(KeyToFind)>-1
End Sub

Public Sub GetKeyAt(Index As Int) As Object
	Return KeysList.Get(Index)
End Sub

Public Sub GetValueAt(Index As Int) As Object
	Return ValueList.Get(Index)
End Sub

Public Sub Clear
	m.Clear
	ValueList.Clear
	KeysList.Clear
End Sub

Public Sub Size
	Return m.Size
End Sub

