B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
	
End Sub

'Option to return blobs as a
'It will affect the highlight column numbers.
Public Sub GetResultSetAsList(RS As ResultSet, OnlyReturnArrayTypes As Boolean) As List
	Return GetResultSetAsList2(RS, Array(), OnlyReturnArrayTypes)
End Sub

'ExcludeColumnsIndex allows excluding columns by position i.e. : Array(1,3) for the second and 4th columns.
'It will affect the highlight column numbers.
'Pass an empty array if not excluding any columns : Array()
Public Sub GetResultSetAsList2(RS As ResultSet, ExcludeColumnsIndex As List, OnlyReturnArrayTypes As Boolean) As List
	Dim MasterList As List
	MasterList.Initialize
	
	Dim HeaderList As List
	HeaderList.Initialize
	For i = 0 To RS.ColumnCount - 1
		If ExcludeColumnsIndex.IndexOf(i) > -1 Then Continue
		HeaderList.Add(RS.GetColumnName(i))
	Next
	MasterList.Add(HeaderList)
	
	Do While RS.NextRow
		Dim L As List
		L.Initialize
		For i = 0 To RS.ColumnCount - 1
			If ExcludeColumnsIndex.IndexOf(i) > -1 Then Continue
			If OnlyReturnArrayTypes Then
				Dim O As Object = RS.As(JavaObject).RunMethod("getObject",Array(i + 1))
				If O = Null Then
					L.Add("Null")
				Else If GetType(O).CharAt(0) = "[" Then
					L.Add(GetType(O))
				Else
					L.Add(RS.GetString2(i))
				End If
			Else
				Dim O As Object = RS.As(JavaObject).RunMethod("getObject",Array(i + 1))
				If O = Null Then
					L.Add("Null")
				Else
					L.Add(O)
				End If
			End If
		Next
		MasterList.Add(L)
	Loop
	
	Return MasterList
End Sub