B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.801
@EndOfDesignText@
'Code module
'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub

' Generalised sub to Create a table in a DataBase
Sub CreateSQLTable(SQL As SQL,DBName As String, TotColNo As Int)
	'Log("CreateSQLDB")
	Private Query As String  = "CREATE TABLE " & DBName & "("
	For i = 0 To TotColNo-1
		If i > 0 Then
			Query = Query & ", "
		End If
		Query = Query & Starter.ColNames(i) & " " & Starter.ColDataTypes(i)
	Next
	Query = Query & ")"
	SQL.ExecNonQuery(Query)
End Sub


'General sub to remove a Table
Sub DropTable(SQL As SQL, DBName As String)
'	Log("Drop SQL DB")
	Dim Query As String
	Query = "DROP TABLE IF EXISTS " & DBName
	SQL.ExecNonQuery(Query)
End Sub


'General sub to Delete all items in the Table
'Does not delete the Table
Sub DeleteDataSQLTable(SQL As SQL,DBname As Object)
	'Log("Delete data from SQLDB")
	Dim Query As String = "DELETE FROM " & DBname
	SQL.ExecNonQuery(Query)
End Sub


'Returns True if Table Name Appears
Sub TableExists(SQL As SQL, DBName As Object) As Boolean
	Dim rs As ResultSet
	Dim Found As Boolean = False
	Dim cmd As String = "SELECT * FROM sqlite_master WHERE TYPE=""table"" ORDER BY name;"
	Try
		rs= SQL.ExecQuery (cmd)
		Do While rs.NextRow
			'Log(rs.GetString("name"))
			If rs.GetString("name") = DBName Then
				Found = True
			End If
		Loop
	Catch
		Log("ERROR: " & LastException.Message)
	End Try
	Return Found
End Sub

'Generalised sub to Add a row list to a Table
Sub AddRowValues (SQL As SQL,DBname As Object, TotColNo As Int, Values As List)
'Log("Add a Row of Values to " & DBname)
	Dim Query As String = "INSERT INTO " & DBname & " VALUES ("
	For j = 0 To  TotColNo-1
		If j > 0 Then
			Query = Query & "?,"
		End If
	Next
	Query = Query & "?)"
	SQL.ExecNonQuery2(Query,Values)
End Sub



