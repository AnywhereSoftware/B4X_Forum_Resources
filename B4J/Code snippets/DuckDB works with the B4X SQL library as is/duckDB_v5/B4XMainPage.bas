B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView	'ignore
	Private xui As XUI

	Private SQL As SQL
	Private dbPath As String = File.DirApp & "/my_analytics.duckdb" ' Path for persistent database file
End Sub

Public Sub Initialize
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Example
End Sub

Sub Example
	Log("Starting Example")
	Dim markTime As Long = DateTime.now
	Try
		' "jdbc:duckdb:" for an in-memory database or "jdbc:duckdb:file.duckdb" for a file
		SQL.Initialize("org.duckdb.DuckDBDriver", "jdbc:duckdb:" & dbPath)
	Catch
		Log(LastException.Message)
	End Try
	Log((DateTime.Now - markTime) & TAB & "Completed SQL.Initialize")  '232msecs

	Dim markTime As Long = DateTime.now
	Dim fldInfo As List = makeDB("CREATE OR REPLACE TABLE table1 (Random_Number INTEGER)")   'ignore
	Log((DateTime.Now - markTime) & TAB & "Created Table")  '11 msec

	Log(fldInfo)
	
	Dim markTime As Long = DateTime.now
	For i = 1 To 1000
		SQL.AddNonQueryToBatch("INSERT INTO table1 VALUES (?)", Array(Rnd(0, 100000)))
	Next
	Dim SenderFilter As Object = SQL.ExecNonQueryBatch("SQL")
	Wait For (SenderFilter) SQL_NonQueryComplete (Success As Boolean)
	Log((DateTime.Now - markTime) & TAB & "Finished 1000 Batch Inserts")  '97 msecs to insert 1000 simple random values in table1
	displayMap(getDBMap(fldInfo, "SELECT * FROM table1"))
		
	'Make another table	'data' using some helper Subs shown below - all just SQL methods
	Dim fldInfo As List = makeDB("CREATE OR REPLACE TABLE data (id INTEGER, value VARCHAR)")   'ignore
	changeDB("INSERT INTO data VALUES (1, 'test'), (2, 'hello')")

	displayMap(getDBMap("STRING", "SELECT list(id) FROM data"))

	displayMap(getDBMap(fldInfo, "SELECT * FROM data"))
	
	displayMap(getDBMap("TEXT", "SELECT list[1] AS element FROM (Select ['first', 'second', 'third'] AS list)"))
	
	displayMap(getDBMap("TEXT", "Select 'I love you! I know'[:-3] AS nearly_soloed"))
	
	displayMap(getDBMap("TEXT", Array("SELECT ['A-Wing', 'B-Wing', 'X-Wing', 'Y-Wing'] AS starfighter_list, ", _
			"{name: 'Star Destroyer', common_misconceptions: 'Can''t in fact destroy a star'} AS star_destroyer_facts")))

	Dim exMap As Map = CreateMap("name": "Tatooine", "Amount of sand": "High")
	displayMap(getDBMap("TEXT", $"SELECT ${mapToSQL(exMap)} AS planet"$))

	SQL.Close
	ExitApplication
End Sub

Private Sub mapToSQL(mp As Map) As String    'ignore
	Dim sb As StringBuilder: sb.initialize
	sb.Append("{")
	For Each kw As String In mp.keys
		sb.Append("'").Append(kw).Append("': '").Append(mp.Get(kw)).Append("', ")
	Next
	If sb.Length > 1 Then sb.Remove(sb.Length - 2, sb.length)
	sb.Append("}")
	Return sb.toString
End Sub

Private Sub getDBMap(Info As Object, query_ As Object) As B4XOrderedMap		'ignore
	Dim query As String
	If isArray(query_) Then
		Dim sb As StringBuilder: sb.Initialize
		Dim ar() As Object = query_
		For Each obj As Object In ar
			Dim s As String = obj
			sb.Append(s.Trim).Append(" ")
		Next
		If sb.Length > 0 Then sb.Remove(sb.Length - 1, sb.Length)
		query = sb.toString
	Else if query_ Is String Then
		query = query_
	End If
	If Info Is List Then
		Dim fldInfo As List = Info
		Try
			Dim rs As ResultSet = SQL.ExecQuery(query)
			Dim OMp As B4XOrderedMap
			OMp.initialize
			For i = 0 To rs.ColumnCount - 1
				Dim fld As DBFieldInfo = fldInfo.Get(i)
				Dim lst As List
				lst.initialize
				OMp.Put(fld.fieldName, lst)
			Next
			
			Do While rs.nextRow
				For i = 0 To rs.ColumnCount - 1
					Dim fld As DBFieldInfo = fldInfo.Get(i)
					Dim typ As String = fld.DataType
					Dim res As Object = getObj(rs, i, typ)
					OMp.get(fld.FieldName).As(List).Add(res)
				Next
			Loop
		Catch
			Log(LastException)
		End Try
	Else
		Dim typ As String = Info
		Try
			Dim rs As ResultSet = SQL.ExecQuery(query)
			Dim OMp As B4XOrderedMap
			OMp.initialize
			For i = 0 To rs.ColumnCount - 1
				Dim lst As List
				lst.initialize
				OMp.Put(rs.GetColumnName(i), lst)
			Next

			Do While rs.nextRow
				For i = 0 To rs.ColumnCount - 1
					Dim res As Object = getObj(rs, i, typ)
					OMp.get(rs.GetColumnName(i)).As(List).Add(res)
				Next
			Loop
		Catch
			Log(LastException)
		End Try
	End If
	rs.Close
	Return OMp
End Sub

Private Sub makeDB(query As String) As List			'ignore
	Try
		SQL.ExecNonQuery(query)
		Dim table As String = query.SubString(query.IndexOf("TABLE") + 5).trim
		table = table.SubString2(0, table.IndexOf(" "))
	Catch
		Log(LastException)
	End Try
	Return DBUtils.GetFieldsInfo(SQL, table)
End Sub

Private Sub changeDB(query As String)				'ignore
	Try
		SQL.ExecNonQuery(query)
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub getObj(rs As ResultSet, i As Int, type_ As String) As Object 		'ignore
	Dim res As Object
	Select type_
		Case "INTEGER", "TINYINT", "SMALLINT", "INT": res = rs.getInt2(i)
		Case "BIGINT", "HUGEINT": res = rs.getLong2(i)
		Case "REAL", "DOUBLE", "DECIMAL": res = rs.getDouble2(i)
		Case "BOOLEAN": res = (rs.getInt2(i) = 1)
		Case "VARCHAR", "STRING", "TEXT", "JSON": res = rs.getString2(i)
		Case "DATE", "TIME", "TIMESTAMP", "TIMESTAMP WITH TIME ZONE", "INTERVAL": res = rs.getLong2(i)
		Case Else: res = rs.getBlob2(i)
	End Select
	Return res
End Sub

Private Sub displayMap(mp As B4XOrderedMap)
	For i = 0 To mp.Size - 1
		Dim kw As String = mp.Keys.Get(i)
		Log(i & TAB & kw & TAB & mp.Get(kw))
	Next
	Log(TAB)
End Sub

Private Sub isArray(obj As Object) As Boolean
	If obj = Null Then Return False
	Return GetType(obj).StartsWith("[")
End Sub

' I use this as missing data in various situations
Private Sub isNaN(obj As Object) As Boolean
	If obj Is Float Then
		Dim x As Float = obj
		If x <> x Then Return True
	End If
	Return False
End Sub
