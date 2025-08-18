B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private BANano As BANano   'ignore
End Sub

'parse a string
Sub StrParse(delim As String, inputString As String) As List
	Dim nl As List
	nl.Initialize
	inputString = CStr(inputString)
	If BANano.IsNull(inputString) Or BANano.IsUndefined(inputString) Then inputString = ""
	If inputString = "" Then Return nl
	Dim values() As String = BANano.Split(delim,inputString)
	nl.AddAll(values)
	Return nl
End Sub

'convert object to string
private Sub CStr(o As Object) As String
	If BANano.isnull(o) Or BANano.IsUndefined(o) Then o = ""
	Return "" & o
End Sub

'mvfield sub
Sub MvField(sValue As String, iPosition As Int, Delimiter As String) As String
	If sValue.Length = 0 Then Return ""
	Dim xPos As Int = sValue.IndexOf(Delimiter)
	If xPos = -1 Then Return sValue
	Dim mValues As List = StrParse(Delimiter,sValue)
	Dim tValues As Int
	tValues = mValues.size -1
	Select Case iPosition
		Case -1
			Return mValues.get(tValues)
		Case -2
			Return mValues.get(tValues - 1)
		Case -3
			Dim sb As StringBuilder
			sb.Initialize
			Dim startcnt As Int
			sb.Append(mValues.Get(1))
			For startcnt = 2 To tValues
				sb.Append(Delimiter)
				sb.Append(mValues.get(startcnt))
			Next
			Return sb.tostring
		Case Else
			iPosition = iPosition - 1
			If iPosition <= -1 Then
				Return mValues.get(tValues)
			End If
			If iPosition > tValues Then
				Return ""
			End If
			Return mValues.get(iPosition)
	End Select
End Sub