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

'Creates a ListOfArrays from a list of maps (one map per row).
'Keys are used as column headers based on the first map, or OverrideHeaders if set.
'Missing keys in later maps will result in Null values.
'
'The optional OverrideHeaders array, serves two purposes:
'1. Sets the headers order (important in B4i where maps do not preserve order).
'2. Allows excluding columns.
'Note that the headers-keys matching is case sensitive.
Public Sub CreateFromListOfMaps(Maps As List, OverrideHeaders() As Object) As ListOfArrays
	Dim loa As ListOfArrays = CreateEmpty(OverrideHeaders)
	If Maps.Size = 0 Then Return loa
	If loa.Header.Length = 0 Then
		Dim FirstRow As Map = Maps.Get(0)
		Dim h(FirstRow.Size) As Object
		Dim c As Int
		For Each key As Object In FirstRow.Keys
			h(c) = key
			c = c + 1
		Next
		loa.Header = h
	End If
	Dim h() As Object = loa.Header
	For Each m As Map In Maps
		Dim row(h.Length) As Object
		For c = 0 To h.Length - 1
			row(c) = m.Get(h(c))
		Next
		loa.AddRow(row)
	Next
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
