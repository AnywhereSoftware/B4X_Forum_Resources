B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10.45
@EndOfDesignText@
'Static code module
Sub Process_Globals
End Sub

'Creates an empty LOA with optional headers. Pass Null if header isn't needed.
Public Sub CreateEmpty(Header() As Object) As ListOfArrays
	Dim loa As ListOfArrays
	loa.Initialize(Null)
	If Initialized(Header) And Header.Length > 0 Then
		loa.Header = Header
	End If
	Return loa
End Sub

'Wraps the list and treats the first row as the header.
Public Sub WrapWithHeader(Items As List) As ListOfArrays
	Dim loa As ListOfArrays
	loa.Initialize(Items)
	loa.FirstRowIsHeader = True
	Return loa
End Sub

'Wraps the list, without a header.
Public Sub WrapWithoutHeader(Items As List) As ListOfArrays
	Dim loa As ListOfArrays
	loa.Initialize(Items)
	Return loa
End Sub

'Wraps the list and adds a header. The header will be added as the first item in the list.
Public Sub WrapAddHeader(Items As List, Header() As Object) As ListOfArrays
	Dim loa As ListOfArrays
	loa.Initialize(Items)
	loa.Header = Header
	Return loa
End Sub

'Helper method to convert a list to an array of objects.
Public Sub ListToArray(Items As List) As Object()
    #if B4A or B4J
	Return Items.As(JavaObject).RunMethod("toArray", Null)
    #Else
    Dim b(Items.Size) As Object
    For i = 0 To Items.Size - 1
        b(i) = Items.Get(i)
    Next
    Return b
    #End If
End Sub
