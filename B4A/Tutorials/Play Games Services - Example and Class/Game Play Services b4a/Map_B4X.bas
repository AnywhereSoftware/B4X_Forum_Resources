B4i=true
Group=Default Group\Classes
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
	Private KeysList2 As List 'used for double keying
	Private ValueList As List
	Private ValueList2 As List 'used for second value list
	Private TimeMap As Map
End Sub

Public Sub Initialize
	m.Initialize
	KeysList.Initialize
	ValueList.Initialize
	ValueList2.Initialize
	TimeMap.Initialize
End Sub

Public Sub ToMap As Map
	Return m
End Sub

'Return a map with the 2nd values
Public Sub ToMap2 As Map
	Dim m2 As Map
	m2.Initialize
	For x = 0 To KeysList.Size-1
		m2.Put(KeysList.Get(x), ValueList2.Get(x))
	Next
	Return m2
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

'adds all keys from a map_b4x to existing map_b4x
Public Sub AddAll(MapB4XToAdd As Map_B4X)
	For Each k As Object In MapB4XToAdd.Keys
		Dim currval As Object = MapB4XToAdd.Get(k)
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

'allows for use of 2 keys
Public Sub PutDoubleKey(Key1 As Object, Key2 As Object, Value As Object)
	RemoveDoubleKey(Key1, Key2)
	m.Put(Key1, Value)
	KeysList.Add(Key1)
	KeysList2.Add(Key2)
	ValueList.Add(Value)
End Sub

''allows for use of 2 values
Public Sub PutDoubleValue(Key As Object, Value As Object, Value2 As Object)
	Remove(Key)
	m.Put(Key, Value)
	KeysList.Add(Key)
	ValueList.Add(Value)
	ValueList2.Add(Value2)
End Sub


'ads the key value pair
'if the key already exists, then it ads the current value to the existing one
'if either the existing value or the value attempting to ad is non-numeric, then it replaces current value
Public Sub Put_Sum_If_Exists(Key As Object, Value As Object)
	If IsNumber(Key) And IsNumber(Value) Then
		Dim CurrentValue As Long
		If m.ContainsKey(Key) Then
			CurrentValue=m.Get(Key)
			Dim i = KeysList.IndexOf(Key) As Int
			KeysList.RemoveAt(i)
			ValueList.RemoveAt(i)
		End If
		m.Put(Key, (Value+CurrentValue))
		KeysList.Add(Key)
		ValueList.Add(Value)
	Else
		Put(Key, Value)		
	End If
End Sub


Public Sub Get(Key As Object) As Object
	Return m.Get(Key)
End Sub

'get second value
Public Sub Get2(Key As Object) As Object
	Return ValueList2.Get(KeysList.IndexOf(Key))
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
	If IsNull(RetObj) Then 
		Return Default
	Else
		Return RetObj
	End If
End Sub

Private Sub IsNull(o As Object) As Boolean
	If o = Null Then
		Return True
	Else
		Return False
	End If
End Sub

Public Sub Remove(Key As Object)
	If m.ContainsKey(Key) Then
		Dim i As Int =KeysList.IndexOf(Key)
		KeysList.RemoveAt(i)
		ValueList.RemoveAt(i)
		If ValueList2.Size>0 Then ValueList2.RemoveAt(i)
	End If
	m.Remove(Key)
End Sub

Public Sub RemoveDoubleKey(Key1 As Object, Key2 As Object)
	Dim i = KeysList.IndexOf(Key1) As Int
	Dim i2 = KeysList2.IndexOf(Key2) As Int
	If i>-1 And i2>-1 And i=i2 Then
		KeysList.RemoveAt(i)
		KeysList2.RemoveAt(i2)
		ValueList.RemoveAt(i)
	End If
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
'			''LogColor($"Old Key = ${KeysList.Get(x)} New Key = ${OldNewKeyMap.Get(KeysList.Get(x))}"$, Colors.Green)
			m.Remove(KeysList.Get(x))
			m.Put(NewKey, ValueList.Get(x))
			NewReplacedKeys.Add(NewKey)
		Else
'			''LogColor($"Key not found ${KeysList.Get(x)}"$, Colors.Green)
		End If
	Next
	'remove non-replaced keys if specified
	KeysList.Clear
	For Each key As Object In m.Keys
		KeysList.Add(key)
	Next
	ValueList.Clear
	For Each value As Object In m.Values
		ValueList.Add(value)
	Next
'	KeysList=ListHelper.ByRefListCopyFromMapList(m.Keys)
'	ValueList=ListHelper.ByRefListCopyFromMapList(m.Values)
	If Not(RetainNonReplaced) Then
		Dim KeysToRemove As List = ListHelper.ListSubtract(KeysList, NewReplacedKeys)
		For Each key As Object In KeysToRemove
			m.Remove(key)
			Dim Index As Int = KeysList.IndexOf(key)
			KeysList.RemoveAt(Index)
			ValueList.RemoveAt(Index)
		Next
	End If
	
'	Log("End of ReplaceKeys")
End Sub

'returns a copy of the list of keys so you can't modify the list directly
Public Sub Keys As List
'	'LogColor($"Getting copy of keys list"$, Colors.Green)
	Return ByRefListCopy(KeysList)
End Sub

'returns a copy of the list of values so you can't modify the list directly
Public Sub Values As List
'	'LogColor($"Getting copy of values list"$, Colors.Green)
	Return ByRefListCopy(ValueList)
End Sub

Private Sub ByRefListCopy(ListToCopy As List) As List
	Dim ReturnList As List
	ReturnList.Initialize
	For Each s As Object In ListToCopy
'		'LogColor($"item=${s}"$, Colors.Green)
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

'records datetime.now when each key value pair is saved
Public Sub PutWithTime(Key As Object, Value As Object)
	Put(Key, Value)
	TimeMap.Put(Key, DateTime.Now)	
End Sub

'returns a map_b4x for all pairs that were created after the given date/time
Public Sub GetWithTime(TimeMininum As Long) As Map_B4X
	Dim RetMap As Map_B4X
	Dim TheseTimesMapB4x As Map_B4X
	TheseTimesMapB4x.Initialize
	TheseTimesMapB4x.LoadFromMap(TimeMap)
	RetMap.Initialize
	For Each ThisTime As Long In TimeMap.Values
		If ThisTime>TimeMininum Then
			Dim Key As Object = TheseTimesMapB4x.GetByValue(ThisTime)
			Dim Value As Object = Get(Key)
			RetMap.Put(Key, Value)
		End If
	Next
	Return RetMap
End Sub

'returns a map_b4x with the last N items entered in sequence
Public Sub GetLastNItems(n As Int) As Map_B4X
	Dim RetMap As Map_B4X
	RetMap.Initialize
	If Keys.Size-n-1>0 Then
		For x = Keys.Size-n-1 To Keys.Size-1
			RetMap.Put(KeysList.Get(x), ValueList.get(x))
		Next
	End If
	Return RetMap
End Sub

Public Sub Clear
	m.Clear
	ValueList.Clear
	KeysList.Clear
	TimeMap.Clear
End Sub

Public Sub Size
	Return m.Size
End Sub

'get the map_b4x values for all keys specified in the list
Sub GetValuesByList(TheKeysList As List) As List
	Dim RetList As List
	RetList.Initialize
	If TheKeysList.Size>0 Then
		For Each item As Object In TheKeysList
			RetList.Add(M.Get(item))
		Next
	End If
	Return RetList
End Sub

'get comma separated string for keys
Sub GetCSVKeys
	Dim RetVal As String
	For Each item As String In KeysList
		RetVal=RetVal&item&","
	Next
	If RetVal.Length>0 Then RetVal=RetVal.SubString2(0, RetVal.Length-1)
	Return RetVal
End Sub

'get comma separated string for values
Sub GetCSVValues
	Dim RetVal As String
	For Each item As String In ValueList
		RetVal=RetVal&item&","
	Next
	If RetVal.Length>0 Then RetVal=RetVal.SubString2(0, RetVal.Length-1)
	Return RetVal
End Sub

'get comma separated string for values
Sub GetCSVValues2
	Dim RetVal As String
	For Each item As String In ValueList2
		RetVal=RetVal&item&","
	Next
	If RetVal.Length>0 Then RetVal=RetVal.SubString2(0, RetVal.Length-1)
	Return RetVal
End Sub

'reverse the keys and values
Sub ReverseKeysAndValues
	Dim KeysListTemp As List = KeysList
	KeysList=ValueList
	ValueList=KeysListTemp
End Sub

'Returns a map4x with values and keys reversed
Sub ReverseKeysAndValues_ByVal As Map_B4X
	Dim Ret4x As Map_B4X
	Ret4x.Initialize
'	Dim KeysListTemp As List = KeysList
'	Ret4x.KeysList=ListHelper.ByRefListCopy(ValueList)
'	Ret4x.ValueList=KeysListTemp
'	m.Initialize
	For x = 0 To ValueList.Size-1
		Ret4x.Put(ValueList.Get(x), KeysList.Get(x))
	Next
	Return Ret4x
End Sub

'Drops keys not contained in the reference list. Also drops the associated values
Sub DropExtraKeys(Reference4X As Map_B4X)
	Dim ItemsToRemove As List = ListHelper.ListSubtract(KeysList, Reference4X.Keys)
	For Each key As Object In ItemsToRemove
		Remove(key)
	Next
End Sub