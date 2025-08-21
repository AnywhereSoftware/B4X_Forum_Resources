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
	For Each k As Object In m.Keys
		Dim currval As Object = m.Get(k)
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

'returns a copy of the list of keys so you can't modify the list directly
Public Sub Keys As List
	Return ByRefListCopy(ValueList)
End Sub

'returns a copy of the list of values so you can't modify the list directly
Public Sub Values As List
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

