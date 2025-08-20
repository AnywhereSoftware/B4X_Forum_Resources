B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.9
@EndOfDesignText@
Sub Class_Globals
	Public Data As List
	Public TopLeft As XLAddress
	Public BottomRight As XLAddress
	Public Name As String
	Private xl As XLUtils
	Public DefaultEmptyCellValue As Object = ""
	
	Type XLHyperlink (LinkType As String, Address As String, Label As String)
	Public Hyperlinks As Map
End Sub

Public Sub Initialize (vXL As XLUtils)
	xl = vXL
	Hyperlinks.Initialize
End Sub


'Debugging method. Logs information about the result.
Public Sub LogResult (WithContent As Boolean)
	Log($"*** ${Name} ***"$)
	Log($"Number of rows: ${Data.Size}"$)
	If Data.Size > 0 Then
		Dim IsRectangle As Boolean = True
		Dim length As Int
		Dim first() As Object = Data.Get(0)
		length = first.Length
		For Each row() As Object In Data
			If row.Length <> length Then
				IsRectangle = False
				Exit
			End If
		Next
		Log($"Is rectangle region: ${IsRectangle}"$)
		Log($"${xl.AddressToString(TopLeft)} -> ${xl.AddressToString(BottomRight)}"$)
		If WithContent Then
			Log("Content:")
			For Each row() As Object In Data
				Dim sb As StringBuilder
				sb.Initialize
				Dim firstcell As Boolean = True
				If row.Length = 0 Then
					sb.Append("(empty row)")
				Else
					For Each cell As Object In row
						If firstcell = False Then sb.Append(", ") Else firstcell = False
						If cell = "" Then cell = DefaultEmptyCellValue
						If cell Is Long Then
							sb.Append(DateTime.Date(cell))
						Else
							sb.Append(cell)
						End If
					Next
				End If
				Log(sb.ToString)
			Next
		End If
	End If
End Sub

'Returns a value. Returns an empty string if the cell doesn't exist.
Public Sub Get(Address As XLAddress) As Object
	Return GetDefault(Address, DefaultEmptyCellValue)
End Sub

'Returns the hyperlink. Return an uninitialized XLHyperlink if none.
Public Sub GetHyperlink(Address As XLAddress) As XLHyperlink
	Dim a As String = xl.AddressToString(Address)
	If Hyperlinks.ContainsKey(a) Then
		Return Hyperlinks.Get(a)
	End If
	Dim Empty As XLHyperlink
	Return Empty
End Sub


'Returns a value. Returns the default value if the cell doesn't exist.
Public Sub GetDefault(Address As XLAddress, DefaultValue As Object) As Object
	Dim row As Int = Address.Row0Based - TopLeft.Row0Based
	Dim col As Int = Address.Col0Based - TopLeft.Col0Based
	If col < 0 Or row < 0 Or row >= Data.Size Then Return DefaultValue
	Dim rrow() As Object = Data.Get(row)
	If rrow.Length <= col Then Return DefaultValue
	Dim res As Object = rrow(col)
	If res = "" Then Return DefaultValue
	Return res 
End Sub

