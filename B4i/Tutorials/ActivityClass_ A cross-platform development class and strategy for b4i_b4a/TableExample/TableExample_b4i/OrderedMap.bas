B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=1.78
@EndOfDesignText@
'Class module
Sub Class_Globals
	Private m As Map
	Private keysList As List
	Private valueList As List
End Sub

Public Sub Initialize
	m.Initialize
	keysList.Initialize
	valueList.Initialize
End Sub

Public Sub ToMap As Map
	Return m
End Sub

Public Sub Put(Key As Object, Value As Object)
	If m.ContainsKey(Key) Then keysList.RemoveAt(keysList.IndexOf(Key))
	m.Put(Key, Value)
	keysList.Add(Key)
	valueList.Add(Value)
End Sub

Public Sub Get(Key As Object) As Object
	Return m.Get(Key)
End Sub

Public Sub Remove(Key As Object)
	If m.ContainsKey(Key) Then 
		Dim i As Int =keysList.IndexOf(Key)
		keysList.RemoveAt(i)
		valueList.RemoveAt(i)
	End If
	m.Remove(Key)
End Sub

Public Sub Keys As List
	Return keysList
End Sub

Public Sub Values As List
	Return valueList
End Sub

Public Sub ContainsKey(KeyToFind As String) As Boolean
	Return Keys.IndexOf(KeyToFind)>-1
End Sub