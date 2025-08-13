B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.3
@EndOfDesignText@
'
'Version: 1.01
'
Sub Class_Globals
	Private SQL1 As SQL
	Private Language, default As String
	Private lst As List
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	'Die Datenbank muss immer kopiert werden, sonst Update-Probleme.
	File.Copy(File.DirAssets, "language.dbx", File.DirInternal, "language.dbx")
	SQL1.Initialize(File.DirInternal, "language.dbx", False)
	
	lst.Initialize
	
	Dim Cur As Cursor
	Cur = SQL1.ExecQuery("PRAGMA table_info(language)")
	For i = 2 To Cur.RowCount - 1
		Cur.Position = i
		lst.Add(Cur.GetString("name"))
'		Log(Cur.GetString("name"))
	Next
	Cur.Close

	'Default-Language
	default = "en_US"
	
	Dim lang As String = GetDefaultLanguage
	ChangeLanguage(lang)
		
	'Nur zum Testen
'	ShowAllIndex
End Sub

Public Sub ChangeLanguage(lang As String)
	Dim tmp As String
	For i = 0 To lst.Size -1
		tmp = lst.Get(i)
		If tmp.StartsWith(lang.Replace("-", "_")) Then
			Language = tmp
			Exit
		End If
	Next
	If Language = "" Then Language = default	
End Sub

Private Sub GetDefaultLanguage As String
   Dim r As Reflector
   r.Target = r.RunStaticMethod("java.util.Locale", "getDefault", Null, Null)
   Return r.RunMethod("getLanguage")
End Sub

Public Sub getCurrent As String
	Return Language
End Sub

Public Sub getPreferred As String
	Return GetDefaultLanguage
End Sub

Public Sub Value(Key As String) As String
	Dim ret As String
	ret = SQL1.ExecQuerySingleResult("SELECT " & Language & " FROM Language WHERE key='" & Key & "'")
	'Log("Key=" & Key & " ;ret=" & ret)
	If ret = Null Then
		Return Key & " = Null-String"
	Else
		Return ret
	End If
End Sub

Private Sub ShowAllIndex 'ignore
	Dim Cur As Cursor
	Cur = SQL1.ExecQuery("SELECT text FROM Language ORDER BY id")
	For i = 0 To Cur.RowCount - 1
		Cur.Position = i
		Log(i & "=" & Cur.GetString2(0))
	Next
	Cur.Close
End Sub
