B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7
@EndOfDesignText@
Sub Class_Globals
	Private map As B4XOrderedMap
End Sub

Public Sub Initialize
	map.Initialize
End Sub

Public Sub Add(Value As Object)
	map.Put(Value, "")
End Sub

Public Sub Remove(Value As Object)
	map.Remove(Value)
End Sub

Public Sub Contains (Value As Object) As Boolean
	Return map.ContainsKey(Value)
End Sub

Public Sub getSize As Int
	Return map.Size
End Sub

Public Sub Clear
	map.Clear
End Sub

Public Sub AsList As List
	Return map.Keys
End Sub