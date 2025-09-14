B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10
@EndOfDesignText@
'Static code module: IndexOfObject
'V. 1.00	03/17/2024
'Author: Sagenut & LucaMs

Sub Process_Globals
End Sub

'Collection must be a List Or a Map.
'If List, returns the index of the item or - 1 if not found.
'If Map, returns the key of the item or Null if not found.
'Example:
'<code>
'	Dim Index As Int
'	Index = IndexOfObject.Find(SomeList, SomeObject)
'	If Index <> - 1 Then
'	End If
'	'Or:
'	Dim strKey As String
'	strKey = IndexOfObject.Find(SomeMapWithStringKeys, SomeObject)
'	If strKey <> "null" Then
'	End If
'	'Or:
'	Dim objKey As MyCustomType ' or any other type of object.
'	objKey = IndexOfObject.Find(SomeMapWithMyCustomTypeKeys, SomeObject)
'	If objKey <> Null Then
'	End If
'</code>
Public Sub Find(Collection As Object, ObjToSearch As Object) As Object
	Dim Result As Object

	Dim Ser As B4XSerializator
	Dim ToSearch() As Byte = Ser.ConvertObjectToBytes(ObjToSearch)
	
	If Collection Is List Then
		Dim lst As List = Collection
		Result = - 1
		For i = 0 To lst.Size - 1
			Dim ItemBytes() As Byte = Ser.ConvertObjectToBytes(lst.Get(i))
			If SearchForBytes(ToSearch, ItemBytes) Then
				Result = i
				Exit
			End If
		Next
	Else If Collection Is Map Then
		Dim mp As Map = Collection
		Result = Null
		For Each Key As Object In mp.Keys
			Dim ItemBytes() As Byte = Ser.ConvertObjectToBytes(mp.Get(Key))
			If SearchForBytes(ToSearch, ItemBytes) Then
				Result = Key
				Exit
			End If
		Next
	End If

	Return Result
End Sub

Private Sub SearchForBytes(SearchIn() As Byte, SearchFor() As Byte) As Boolean
	Dim bbItem As B4XBytesBuilder
	bbItem.Initialize
	bbItem.Append(SearchIn)
	Return (bbItem.IndexOf(SearchFor) <> - 1)
End Sub