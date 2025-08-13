B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=4.4
@EndOfDesignText@
'
'Version: 1.02
'
Sub Class_Globals
	Private SQL1 As SQL
	Private Language, default As String
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	'Die Datenbank muss immer kopiert werden, sonst Update-Probleme.
	File.Copy(File.DirAssets, "language.dbx", File.DirTemp, "language.dbx")
	SQL1.Initialize(File.DirTemp, "language.dbx", False)
	
	Dim lst As List
	lst.Initialize
	
	Dim rs As ResultSet = SQL1.ExecQuery("PRAGMA table_info(language)")
	Do While rs.NextRow
  	'work with records
		lst.Add(rs.GetString("name"))
	Loop
	rs.Close

	'Default-Language
	default = "en_US"
	
	Dim lang As String = GetPreferredLanguage.SubString2(0,2)
	
	Dim tmp As String
	For i = 0 To lst.Size -1
		tmp = lst.Get(i)
		If tmp.StartsWith(lang) Then
			Language = tmp
			Exit
		End If
	Next
	If Language = "" Then Language = default

	'ShowAllIndex
End Sub

'NSString * myString = [[NSLocale preferredlanguage]objectAtIndex:0];
Private Sub GetPreferredLanguage As String
    Dim no As NativeObject
    Return no.Initialize("NSLocale") _
        .RunMethod("preferredLanguages", Null).RunMethod("objectAtIndex:", Array(0)).AsString
End Sub

Public Sub getCurrent As String
	'die erste 3 Buchstaben
	Return Language.SubString2(0,3)
End Sub

Public Sub getPreferred As String
	Return GetPreferredLanguage
End Sub

Public Sub Value(Key As String) As String
	Dim ret As String
	ret = SQL1.ExecQuerySingleResult("SELECT " & Language & " FROM Language WHERE key='" & Key & "'")
	'Log("Key=" & Key & " ;ret=" & ret)
	If ret = Null Or ret = "" Then
		Return Key & " = Null-String"
	Else
		Return ret
	End If
End Sub

Private Sub ShowAllIndex 'ignore
	Dim rs As ResultSet = SQL1.ExecQuery("SELECT * FROM Language ORDER BY id")
	Do While rs.NextRow
		For i = 0 To rs.ColumnCount - 1
			Log(rs.GetColumnName(i).ToLowerCase)
			Log(rs.GetString2(i))
		Next
	Loop
	Log("***********")
	rs.Close
End Sub
