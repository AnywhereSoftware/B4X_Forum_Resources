B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.3
@EndOfDesignText@
Sub Process_Globals
	
End Sub

Sub CopySQLiteDB(src As SQL, dest As SQL)
	Dim Tables As List = GetTableList(src,False)
	Dim Indexes As List = GetIndexList(src,False)
	
	For Each Table As String In Tables
		Log($"Processing table: ${Table}"$)
		dest.ExecNonQuery($"DROP TABLE IF EXISTS ${Table}"$)	
		
		' Create table
		Dim Table_SQL As String = GetObjectCreateSQL(src,Table)		
		dest.ExecNonQuery(Table_SQL)
		
		' Copy data
		Dim Cursor1 As ResultSet	
		Cursor1 = src.ExecQuery($"SELECT * FROM ${Table}"$)
			
		Dim Values As List
		
		dest.BeginTransaction

		Do While Cursor1.NextRow
			Values.Initialize
			
			For c = 0 To Cursor1.ColumnCount-1				
				Dim Value As String = Cursor1.GetString2(c)
				Values.Add(Value)
			Next
			
			dest.ExecNonQuery2($"INSERT INTO ${Table} VALUES (${GetPlaceholders(Values.Size)})"$, Values)
		Loop
		
		dest.TransactionSuccessful
	
		Cursor1.Close		
	Next
	
	For Each Index As String In Indexes
		Log($"Processing index: ${Index}"$)
		dest.ExecNonQuery($"DROP INDEX IF EXISTS ${Index}"$)
		
		' Create index
		Dim Index_SQL As String = GetObjectCreateSQL(src,Index)
		dest.ExecNonQuery(Index_SQL)
	Next
	
End Sub

Sub GetPlaceholders(Length As Int) As String
	Dim Output As String = ""
	
	For n = 0 To Length-1
		If Output.Length > 0 Then Output = Output & ","
		Output = Output & "?"
	Next
	
	Return Output
End Sub

Sub GetObjectCreateSQL(DBconn As SQL, ObjectName As String) As String
	Return DBconn.ExecQuerySingleResult($"SELECT sql FROM sqlite_schema WHERE name = '${ObjectName}'"$)
End Sub

Sub GetTableList(DBconn As SQL, LowerCase As Boolean) As List
	Dim Cursor1 As ResultSet
	
	Dim Tables As List
	Tables.Initialize

	Cursor1 = DBconn.ExecQuery("SELECT name FROM sqlite_master where type = 'table' and name not like 'sqlite_%' order by name")

	Do While Cursor1.NextRow
		If LowerCase = True Then
			Tables.Add(Cursor1.GetString("name").ToLowerCase)
		Else
			Tables.Add(Cursor1.GetString("name"))
		End If
	Loop
	
	Cursor1.Close
	
	Return Tables
End Sub

Sub GetIndexList(DBconn As SQL, LowerCase As Boolean) As List
	Dim Cursor1 As ResultSet
	
	Dim Indexes As List
	Indexes.Initialize

	Cursor1 = DBconn.ExecQuery("SELECT name FROM sqlite_master where type = 'index' and name not like 'sqlite_%' order by name")

	Do While Cursor1.NextRow
		If LowerCase = True Then
			Indexes.Add(Cursor1.GetString("name").ToLowerCase)
		Else
			Indexes.Add(Cursor1.GetString("name"))
		End If
	Loop
	
	Cursor1.Close
	
	Return Indexes
End Sub