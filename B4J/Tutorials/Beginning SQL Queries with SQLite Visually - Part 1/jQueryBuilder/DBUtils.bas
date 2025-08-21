B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=5.9
@EndOfDesignText@
'version 1.01c
#IgnoreWarnings:12
Sub Process_Globals
	Public const DB_REAL As String = "REAL"
	Public const DB_INTEGER As String = "INTEGER"
	Public const DB_BLOB As String = "BLOB"
	Public const DB_TEXT As String = "TEXT"
	Public const DB_FLOAT As String = "FLOAT"
	Public const DB_NUMERIC As String = "NUMERIC"
	Dim HtmlCSS As String = "table {width: 100%;border: 1px solid #cef;text-align: left; }" _
		& " th { font-weight: bold;	background-color: #acf;	border-bottom: 1px solid #cef; }" _ 
		& "td,th {	padding: 4px 5px; }" _
		& ".odd {background-color: #def; } .odd td {border-bottom: 1px solid #cef; }" _
		& "a { text-decoration:none; color: #000;}"
	Private pool As ConnectionPool
	Public SQLite As SQL
	Public UsePool As Boolean
	Private DatabaseType As Int
	Public RanOK As Boolean
	Private tbl2Create As String
	Private tflds As Map
	Private tidxs As Map
	Private tprikey As String
	Private tauto As String
	Public IsDone As Boolean
	Public const TRIGGER_BEFORE_INSERT As String = "BEFORE INSERT"
	Public const TRIGGER_BEFORE_UPDATE As String = "BEFORE UPDATE"
	Public const TRIGGER_BEFORE_DELETE As String = "BEFORE DELETE"
	
	Public const TRIGGER_AFTER_INSERT As String = "AFTER INSERT"
	Public const TRIGGER_AFTER_UPDATE As String = "AFTER UPDATE"
	Public const TRIGGER_AFTER_DELETE As String = "AFTER DELETE"
	
	Public const TRIGGER_INSTEADOF_INSERT As String = "INSTEAD OF INSERT"
	Public const TRIGGER_INSTEADOF_UPDATE As String = "INSTEAD OF UPDATE"
	Public const TRIGGER_INSTEADOF_DELETE As String = "INSTEAD OF DELETE"
End Sub

'create a trigger when an event happens
Sub SQLiteCreateTriggerWhen(triggerName As String, tblName As String, triggerWhenEvent As String, triggerWhenSQL As String, triggerSQL As String) As String
	triggerName = triggerName.Replace(" ","")
Dim script As String = $"CREATE TRIGGER IF NOT EXISTS ${triggerName} ${triggerWhenEvent} ON ${tblName}
WHEN ${triggerWhenSQL}
BEGIN
${triggerSQL}
END;"$ 
Return script	
End Sub

'create a trigger without when
Sub SQLiteCreateTrigger(triggerName As String, tblName As String, triggerWhenEvent As String, triggerSQL As String) As String
	triggerName = triggerName.Replace(" ","")
Dim script As String = $"CREATE TRIGGER IF NOT EXISTS ${triggerName} ${triggerWhenEvent} ON ${tblName}
BEGIN
${triggerSQL}
END;"$ 
Return script	
End Sub

' copy db from assets
Sub CopyDatabase(Database As String, bReplace As Boolean)
	Database = Database.ToLowerCase
	If bReplace = True Then
		File.Copy(File.DirAssets,Database, File.dirapp,Database)
	Else
		If File.Exists(File.dirapp,Database) = False Then
			File.Copy(File.DirAssets,Database, File.dirapp,Database)
		End If
	End If
End Sub

'Inserts or Update the data to/in the table.
'ListOfMaps - A list with maps as items. Each map represents a record where the map keys are the columns names
'and the maps values are the values.
'Note that you should create a new map for each record (this can be done by calling Dim to redim the map).
Public Sub InsertOrUpdateMaps(SQL As SQL, TableName As String, Key As String, ListOfMaps As List)
	Dim sb, columns, values As StringBuilder
	'Small check for a common error where the same map is used in a loop
	If ListOfMaps.Size > 1 And ListOfMaps.Get(0) = ListOfMaps.Get(1) Then
		Log("Same Map found twice in list. Each item in the list should include a different map object.")
		Return
	End If
	SQL.BeginTransaction
	Try
		For i1 = 0 To ListOfMaps.Size - 1
			sb.Initialize
			columns.Initialize
			values.Initialize
			Dim listOfValues As List
			listOfValues.Initialize
			Dim m As Map = ListOfMaps.Get(i1)
			Dim value_exists As Map = ExecuteMap(SQL, "SELECT " & EscapeField(Key) & " FROM " & EscapeField(TableName) & " WHERE " & EscapeField(Key) & " = '" & m.Get(Key) & "'", Null)
			Log("value_exists: " & value_exists)
			If value_exists.IsInitialized=False Then
				sb.Append("INSERT INTO [" & TableName & "] (")
				For Each col As String In m.Keys
					Dim Value As Object = m.Get(col)
					If listOfValues.Size > 0 Then
						columns.Append(", ")
						values.Append(", ")
					End If
					columns.Append(EscapeField(col))
					values.Append("?")
					listOfValues.Add(Value)
				Next
				sb.Append(columns.ToString).Append(") VALUES (").Append(values.ToString).Append(")")
				If i1 = 0 Then Log("InsertMaps (first query out of " & ListOfMaps.Size & "): " & sb.ToString)
				SQL.ExecNonQuery2(sb.ToString, listOfValues)
			Else
				sb.Append("UPDATE [" & TableName & "] SET ")
				For Each col As String In m.Keys
					If listOfValues.Size>0 Then
						sb.Append(",")
					End If
					sb.Append(EscapeField(col)).Append("=?")
					listOfValues.Add(m.Get(col))
				Next
				sb.Append(" WHERE [" & Key & "] = ?")
				listOfValues.Add(value_exists.Get(Key))
				If i1 = 0 Then Log("UpdateMaps (first query out of " & ListOfMaps.Size & "): " & sb.ToString)
				SQL.ExecNonQuery2(sb.ToString, listOfValues)
			End If
		Next
		SQL.TransactionSuccessful
	Catch
		Log(LastException)
        #If B4i OR B4J
		SQL.Rollback
        #End If
	End Try
#If B4A
    SQL.EndTransaction
#End If
End Sub


'create an table with auto increment id
Sub SQLiteCreateTable(jSQL As SQL, tblName As String, newFields As Map, pkName As String, aiName As String) As Boolean
	Dim fldName As String
	Dim fldType As String
	Dim fldTot As Int
	Dim fldCnt As Int
	'create the audit trail table
	fldTot = newFields.Size - 1
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("(")
	For fldCnt = 0 To fldTot
		fldName = newFields.GetKeyAt(fldCnt)
		fldType = newFields.GetValueAt(fldCnt)
		If fldCnt > 0 Then sb.Append(", ")
		sb.Append(EscapeField(fldName)).Append(" ").Append(fldType)
		If fldType = DB_TEXT Then sb.Append(" COLLATE NOCASE")
		If fldName.EqualsIgnoreCase(pkName) Then sb.Append(" NOT NULL PRIMARY KEY")
		If fldName.EqualsIgnoreCase(aiName) Then sb.Append(" AUTOINCREMENT")
	Next
	sb.Append(")")
	'define the qry to execute
	Dim query As String = "CREATE TABLE IF NOT EXISTS " & EscapeField(tblName) & " " & sb.ToString
	'run the query
	jSQL.ExecNonQuery(query)
	Return SQLiteTableExists(jSQL,tblName)
End Sub

'create an audit trail
Sub SQLiteCreateAuditTrail(jSQL As SQL, tblName As String) As Boolean
	'define the audit trail table name
	Dim auditTrailTable As String = $"${tblName}_Audit"$
	'define the primary key
	Dim auditTrailPK As String = "id"
	'define the field to autoincrement
	Dim auditTrailAI As String = "id"
	Dim fldName As String
	Dim fldType As String
	'first get the structure of an existing table, lets leave the indexes out
	Dim existingTable As Map = GetTableStructure(jSQL,tblName)
	'for each field, create a new table with the cloned fields for old_ and new_
	Dim newFields As Map
	newFields.Initialize
	Dim fldTot As Int = existingTable.Size - 1
	Dim fldCnt As Int
	For fldCnt = 0 To fldTot
		'get the fldname and fldtype to create the old_x and new_x
		fldName = existingTable.GetKeyAt(fldCnt)
		fldType = existingTable.GetValueAt(fldCnt)
		Dim old_fldName As String = $"old_${fldName}"$
		Dim new_fldName As String = $"new_${fldName}"$
		newFields.Put(old_fldName,fldType)
		newFields.Put(new_fldName,fldType)
	Next
	'just ensure we have an id field
	newFields.Put(auditTrailPK,DB_INTEGER)
	'ensure we have an audit date field
	newFields.Put("Audit_Date", DB_TEXT)
	'ensure we have the type of action
	newFields.Put("Audit_Action", DB_TEXT)
	'create the audit trail table
	Dim atTable As Boolean = SQLiteCreateTable(jSQL,auditTrailTable,newFields,auditTrailPK,auditTrailAI)
	Return atTable
End Sub

'create an update trigger
Sub SQLiteCreateAfterUpdateTrigger(jSQL As SQL, tblName As String) As Boolean
	'define the trigger name
	Dim triggerName As String = $"${tblName}_after_update"$
	'define the audit trail table name
	Dim auditTrailTable As String = $"${tblName}_Audit"$
	'first get the structure of an existing table, lets leave the indexes out
	Dim existingTable As Map = GetTableStructure(jSQL,tblName)
	'for each existing field, lets build when
	Dim sbWhen As StringBuilder
	sbWhen.Initialize
	'for each existing field, lets build inserts
	Dim sbInsert As StringBuilder
	sbInsert.Initialize
	sbInsert.Append($"INSERT INTO ${auditTrailTable} ("$).Append(CRLF)
	'for each existing field, lets build values
	Dim sbValues As StringBuilder
	sbValues.Initialize 
	For Each fldName As String In existingTable.Keys
		'when any of the fields are not the same, create an audit trail
		Dim notSame As String = $"old.${fldName} <> new.${fldName}"$
		sbWhen.Append(notSame).Append(CRLF).Append("OR ")
		'build the insert fiels
		Dim old_fldName As String = $"old_${fldName}"$
		Dim new_fldName As String = $"new_${fldName}"$
		sbInsert.Append(old_fldName).Append(",").Append(CRLF)
		sbInsert.Append(new_fldName).Append(",").Append(CRLF)
		'build values
		old_fldName = $"old.${fldName}"$
		new_fldName = $"new.${fldName}"$
		sbValues.Append(old_fldName).Append(",").Append(CRLF)
		sbValues.Append(new_fldName).Append(",").Append(CRLF)
	Next
	'clean when last 'OR '
	sbWhen.Remove(sbWhen.Length-3,sbWhen.Length)
	'update the insert to include audit action and audit date
	sbInsert.Append("Audit_Action,").Append(CRLF)
	sbInsert.Append("Audit_Date").Append(CRLF)
	'do the same for the values
	sbValues.Append("'UPDATE',").Append(CRLF)
	sbValues.Append("DATETIME('NOW')").Append(CRLF)
	sbInsert.Append(")").Append(CRLF)
	sbInsert.Append("VALUES").Append(CRLF)
	sbInsert.Append("(").Append(CRLF)
	sbInsert.Append(sbValues.ToString)
	sbInsert.Append(");").Append(CRLF)
	'lets define the trigger.
	Dim trigger As String = SQLiteCreateTriggerWhen(triggerName,tblName,TRIGGER_AFTER_UPDATE,sbWhen.ToString,sbInsert.ToString)
	jSQL.ExecNonQuery(trigger)
	Return SQLiteTriggerExists(jSQL,triggerName)
End Sub

'create an after insert trigger
Sub SQLiteCreateAfterInsertTrigger(jSQL As SQL, tblName As String) As Boolean
	'define the trigger name
	Dim triggerName As String = $"${tblName}_after_insert"$
	'define the audit trail table name
	Dim auditTrailTable As String = $"${tblName}_Audit"$
	'first get the structure of an existing table, lets leave the indexes out
	Dim existingTable As Map = GetTableStructure(jSQL,tblName)
	'for each existing field, lets build inserts
	Dim sbInsert As StringBuilder
	sbInsert.Initialize
	sbInsert.Append($"INSERT INTO ${auditTrailTable} ("$).Append(CRLF)
	'for each existing field, lets build values
	Dim sbValues As StringBuilder
	sbValues.Initialize 
	For Each fldName As String In existingTable.Keys
		'build the insert fiels
		Dim new_fldName As String = $"new_${fldName}"$
		sbInsert.Append(new_fldName).Append(",").Append(CRLF)
		'build values
		new_fldName = $"new.${fldName}"$
		sbValues.Append(new_fldName).Append(",").Append(CRLF)
	Next
	'update the insert to include audit action and audit date
	sbInsert.Append("Audit_Action,").Append(CRLF)
	sbInsert.Append("Audit_Date").Append(CRLF)
	'do the same for the values
	sbValues.Append("'CREATE',").Append(CRLF)
	sbValues.Append("DATETIME('NOW')").Append(CRLF)
	sbInsert.Append(")").Append(CRLF)
	sbInsert.Append("VALUES").Append(CRLF)
	sbInsert.Append("(").Append(CRLF)
	sbInsert.Append(sbValues.ToString)
	sbInsert.Append(");").Append(CRLF)
	'lets define the trigger.
	Dim trigger As String = SQLiteCreateTrigger(triggerName,tblName,TRIGGER_AFTER_INSERT,sbInsert.ToString)
	jSQL.ExecNonQuery(trigger)
	Return SQLiteTriggerExists(jSQL,triggerName)
End Sub

'create an after delete trigger
Sub SQLiteCreateAfterDeleteTrigger(jSQL As SQL, tblName As String) As Boolean
	'define the trigger name
	Dim triggerName As String = $"${tblName}_after_delete"$
	'define the audit trail table name
	Dim auditTrailTable As String = $"${tblName}_Audit"$
	'first get the structure of an existing table, lets leave the indexes out
	Dim existingTable As Map = GetTableStructure(jSQL,tblName)
	'for each existing field, lets build inserts
	Dim sbInsert As StringBuilder
	sbInsert.Initialize
	sbInsert.Append($"INSERT INTO ${auditTrailTable} ("$).Append(CRLF)
	'for each existing field, lets build values
	Dim sbValues As StringBuilder
	sbValues.Initialize 
	For Each fldName As String In existingTable.Keys
		'build the insert fiels
		Dim new_fldName As String = $"old_${fldName}"$
		sbInsert.Append(new_fldName).Append(",").Append(CRLF)
		'build values
		new_fldName = $"old.${fldName}"$
		sbValues.Append(new_fldName).Append(",").Append(CRLF)
	Next
	'update the insert to include audit action and audit date
	sbInsert.Append("Audit_Action,").Append(CRLF)
	sbInsert.Append("Audit_Date").Append(CRLF)
	'do the same for the values
	sbValues.Append("'DELETE',").Append(CRLF)
	sbValues.Append("DATETIME('NOW')").Append(CRLF)
	sbInsert.Append(")").Append(CRLF)
	sbInsert.Append("VALUES").Append(CRLF)
	sbInsert.Append("(").Append(CRLF)
	sbInsert.Append(sbValues.ToString)
	sbInsert.Append(");").Append(CRLF)
	'lets define the trigger.
	Dim trigger As String = SQLiteCreateTrigger(triggerName,tblName,TRIGGER_AFTER_DELETE,sbInsert.ToString)
	jSQL.ExecNonQuery(trigger)
	Return SQLiteTriggerExists(jSQL,triggerName)
End Sub

'check to see if SQLite table exists
Sub SQLiteTableExists(jSQL As SQL, tblName As String) As Boolean
	Dim res As String
	Try
		Dim qry As String = $"select tbl_name from sqlite_master where type = 'table' and lower(tbl_name) = ?"$
		res = jSQL.ExecQuerySingleResult2(qry, Array As String(tblName.tolowercase))
	Catch
		Return False
	End Try
	If res = Null Then
		Return False
	Else
		Return True
	End If
End Sub

'check to see if SQLite trigger exists
Sub SQLiteTriggerExists(jSQL As SQL, tblName As String) As Boolean
	Dim res As String
	Try
		Dim qry As String = $"select name from sqlite_master where type = 'trigger' and lower(name) = ?"$
		res = jSQL.ExecQuerySingleResult2(qry, Array As String(tblName.tolowercase))
	Catch
		Return False
	End Try
	If res = Null Then
		Return False
	Else
		Return True
	End If
End Sub

Public Sub ExecuteHtml(SQL As SQL, Query As String, StringArgs() As String, Limit As Int, Clickable As Boolean) As String
	Dim cur As ResultSet
	If StringArgs <> Null Then
		cur = SQL.ExecQuery2(Query, StringArgs)
	Else
		cur = SQL.ExecQuery(Query)
	End If
	Log ("ExecuteHtml: " & Query)
                                                                                                                                                                                                                                                 
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("<html><body>").Append (CRLF)
	sb.Append("<style type='text/css'>").Append(HtmlCSS).Append("</style>").Append (CRLF)
	sb.Append("<table><thead><tr>").Append (CRLF)
	For i = 0 To cur.ColumnCount - 1
		sb.Append("<th>").Append(cur.GetColumnName(i)).Append ("</th>")
	Next
	sb.Append ("</thead>")
        
	'       For i = 0 To cur.ColumnCount - 1
	'               If i = 1 Then
	'                       sb.Append("<th style='width:200px;'>").Append(cur.GetColumnName(i)).Append("</th>")
	'               Else
	'                       sb.Append("<th>").Append(cur.GetColumnName(i)).Append("</th>")
	'               End If
	'       Next
                
	sb.Append("</tr>").Append (CRLF)
	Dim row As Int
	Do While cur.NextRow
		If row Mod 2 = 0 Then
			sb.Append ("<tr>")
		Else
			sb.Append ("<tr class='odd'>")
		End If
		For i = 0 To cur.ColumnCount - 1
			sb.Append ("<td>")
			If Clickable Then
				sb.Append("<a href='http://").Append(i).Append (".")
				sb.Append (row)
				sb.Append(".stub'>").Append(cur.GetString2(i)).Append ("</a>")
			Else
				sb.Append (cur.GetString2(i))
			End If
			sb.Append ("</td>")
		Next
		sb.Append("</tr>").Append (CRLF)
		row = row + 1
	Loop
	cur.Close
	sb.Append ("</table></body></html>")
	Return sb.ToString
End Sub

Public Sub ExecuteJSON (SQL As SQL, Query As String, StringArgs() As String, Limit As Int, DBTypes As List) As Map
	Dim table As List
	Dim cur As ResultSet
	If StringArgs <> Null Then
		cur = SQL.ExecQuery2(Query, StringArgs)
	Else
		cur = SQL.ExecQuery(Query)
	End If
	Log ("ExecuteJSON: " & Query)
	Dim table As List
	table.Initialize
	Do While cur.NextRow
		Dim m As Map
		m.Initialize
		For i = 0 To cur.ColumnCount - 1
			Select DBTypes.Get(i)
				Case DB_TEXT
					m.Put(cur.GetColumnName(i), cur.GetString2(i))
				Case DB_INTEGER
					m.Put(cur.GetColumnName(i), cur.GetLong2(i))
				Case DB_REAL
					m.Put(cur.GetColumnName(i), cur.GetDouble2(i))
				Case Else
					Log ("Invalid type: " & DBTypes.Get(i))
			End Select
		Next
		table.Add (m)
		If Limit > 0 And table.Size >= Limit Then Exit
	Loop
	cur.Close
	Dim root As Map
	root.Initialize
	root.Put("root", table)
	Return root
End Sub


Public Sub Execute2List(SQL As SQL, Query As String, StringArgs() As String, Limit As Int) As List
	Dim Table As List = ExecuteMemoryTable(SQL, Query, StringArgs, Limit)
	Dim res As List
	res.Initialize
	For Each Cols() As String In Table
		res.Add (Cols(0))
	Next
	Return res
End Sub

private Sub ConcatenateFields(iSQL As SQL, Table As String)	
	'update macros set key = framework || '.' || macro
End Sub

'use a particular field in a table to create a table with those distinct records
Sub CreateListFromAnotherTable(iSQL As SQL,SourceTable As String,SourceField As String,TargetTable As String, TargetField As String, TargetPriKey As String)
	'select from the source table
	Dim cats As List = ExecuteMaps(iSQL,$"select ${SourceField} from ${SourceTable} group by ${SourceField}"$,Null)
	'clear the target table
	TableClear(iSQL,TargetTable)
	'reset the counter for target
	SQLiteResetCounter(iSQL,TargetTable,TargetPriKey)
	Dim nList As List
	nList.Initialize
	For Each catM As Map In cats
		Dim scategory As String = catM.GetDefault(SourceField.tolowercase,"")
		Dim nrec As Map = CreateMap(TargetField.tolowercase:scategory)
		nList.Add(nrec)
	Next
	InsertMaps(iSQL,TargetTable,nList,False)
End Sub

public Sub LoadTable2View(db As SQL, TableName As String, qryBox As TextArea, tblView As TableView)
	Try
		Dim t As List
		t = ExecuteMemoryTable(db, "PRAGMA table_info ('" & TableName & "')", Null, 0)
		Dim query As StringBuilder
		query.Initialize
		query.Append("SELECT ")
		For i = 0 To t.Size - 1
			Dim values() As String
			values = t.Get(i) 't is a list of arrays
			query.Append("[").Append(values(1)).Append("]").Append(",")
		Next
		query.Remove(query.Length - 1, query.Length) 'remove last comma
		query.Append(" FROM ").Append(TableName)
		qryBox.Text = query.tostring
		ExecuteTableView(db,query.ToString,Null,500,tblView)
	Catch
		Log("LoadTable2View: " & LastException)
	End Try
End Sub


Sub CreateTableFromDefinition(jsql As SQL)
	'create the table
	CreateTable(jsql, tbl2Create,tflds,tprikey,tauto)
	'add the indexes
	AddIndexes(jsql,tbl2Create,tidxs)
	tbl2Create = ""
	tflds.Initialize
	tidxs.Initialize  
	tprikey = ""
	tauto = ""
End Sub

Sub InitializeNewTable(tblName As String, sprikey As String, sauto As String)
	tbl2Create = tblName
	tflds.Initialize
	tidxs.Initialize  
	tprikey = sprikey
	tauto = sauto
	If tauto.Length > 0 Then
		AddFieldOfInteger(sauto,True,True)
	End If
End Sub

Sub AddFieldOfInteger(fldName As String, isIndexed As Boolean, isunique As Boolean)
	tflds.Put(fldName, DB_INTEGER)
	If isIndexed = True Then
		tidxs.Put(fldName,isunique)
	End If
End Sub

Sub AddIndexedTextFields(fldNames As String)
	Dim spFields() As String = Regex.Split(",",fldNames)
	For Each strField As String In spFields
		strField = strField.trim
		If strField.Length > 0 Then AddFieldOfText(strField,True,False)
	Next
End Sub

Sub AddNormalTextFields(fldNames As String)
	Dim spFields() As String = Regex.Split(",",fldNames)
	For Each strField As String In spFields
		strField = strField.trim
		If strField.Length > 0 Then AddFieldOfText(strField,False,False)
	Next
End Sub

Sub AddFieldOfText(fldName As String, isIndexed As Boolean, isunique As Boolean)
	tflds.Put(fldName, DB_TEXT)
	If isIndexed = True Then
		tidxs.Put(fldName,isunique)
	End If
End Sub

Sub AddFieldOfReal(fldName As String, isIndexed As Boolean, isunique As Boolean)
	tflds.Put(fldName, DB_REAL)
	If isIndexed = True Then
		tidxs.Put(fldName,isunique)
	End If
End Sub

Sub AddFieldOfBlob(fldName As String, isIndexed As Boolean, isunique As Boolean)
	tflds.Put(fldName, DB_BLOB)
	If isIndexed = True Then
		tidxs.Put(fldName,isunique)
	End If
End Sub

Sub AddFieldOfNumeric(fldName As String, isIndexed As Boolean, isunique As Boolean)
	tflds.Put(fldName, DB_NUMERIC)
	If isIndexed = True Then
		tidxs.Put(fldName,isunique)
	End If
End Sub


Sub AddEditRecordWhere(jSQL As SQL,TableName As String, Fields As Map, WhereFields As Map) As Boolean
	Dim rExist As Boolean = SQLRecordExistsWhere(jSQL,TableName,WhereFields)
	'Log(rExist)
	If rExist = False Then
		AddRecord(jSQL,TableName,Fields) 
		Return SQLRecordExistsWhere(jSQL,TableName,WhereFields)
	Else
		Return SQLRecordUpdateWhere(jSQL,TableName,Fields,WhereFields)
	End If
End Sub

'Update a mapped record and return true if successful
Sub SQLRecordUpdateWhere(xSQL As SQL, TableName As String, Fields As Map, WhereFieldEquals As Map) As Boolean
	If WhereFieldEquals.Size = 0 Then
		Log("WhereFieldEquals map empty!")
		Return False
	End If
	If Fields.Size = 0 Then
		Log("Fields empty")
		Return False
	End If
	Fields = DeDuplicateMap(Fields)
	WhereFieldEquals = DeDuplicateMap(WhereFieldEquals)
	Dim sb As StringBuilder
	xSQL.BeginTransaction
	Try
		sb.Initialize
		sb.Append("UPDATE ").Append(TableName).Append(" SET ")
		Dim args As List
		args.Initialize
		For i=0 To Fields.Size-1
			If i<>Fields.Size-1 Then
				sb.Append(Fields.GetKeyAt(i)).Append("=?,")
			Else
				sb.Append(Fields.GetKeyAt(i)).Append("=?")
			End If
			args.Add(Fields.GetValueAt(i))
		Next
    
		sb.Append(" WHERE ")
		For i = 0 To WhereFieldEquals.Size - 1
			If i > 0 Then
				sb.Append(" AND ")
			End If
			sb.Append(WhereFieldEquals.GetKeyAt(i)).Append(" = ?")
			args.Add(WhereFieldEquals.GetValueAt(i))
		Next
		'Log("SQLRecordUpdateWhere: " & sb.ToString)
		xSQL.ExecNonQuery2(sb.ToString, args)
		xSQL.TransactionSuccessful
		Return True
	Catch
		Log("SQLRecordUpdateWhere: " & LastException)
		xSQL.Rollback
		Return False
	End Try
End Sub


'insert/update a record and read it
Sub AddEditRecord(jsql As SQL, tblName As String, fldName As String, fldKey As String, flds As Map) As Map
	Dim recExist As Boolean = RecordExists(jsql,tblName,fldName, fldKey)
	If recExist = False Then
		' the list does not exist, add it
		AddRecord(jsql,tblName,flds)
	Else
		RecordUpdate(jsql,tblName,flds,fldName,fldKey)
	End If
	Dim rec As Map = ReadRecord(jsql,tblName,fldName,fldKey)
	Return rec
End Sub

'insert/update a record and read it
Sub AddEditRecordOnly(jsql As SQL, tblName As String, fldName As String, fldKey As String, flds As Map)
	Dim recExist As Boolean = RecordExists(jsql,tblName,fldName, fldKey)
	If recExist = False Then
		' the list does not exist, add it
		AddRecord(jsql,tblName,flds)
	Else
		RecordUpdate(jsql,tblName,flds,fldName,fldKey)
	End If
End Sub

'insert and read a record back as a map
Sub AddRecordRead(jsql As SQL, tblName As String,flds As Map) As Map
	Dim lr As Long = AddRecord(jsql,tblName,flds)
	Dim rec As Map = ReadRecord(jsql,tblName,"id",lr)
	Return rec
End Sub

'insert and read a record
Sub AddReadRecord(jsql As SQL, tblName As String,flds As Map) As Map
	Dim lr As Long = AddRecord(jsql,tblName,flds)
	Dim rec As Map = ReadRecord(jsql,tblName,"id",lr)
	Return rec
End Sub

'update and read an existing record as a map
Sub EditRecordRead(jsql As SQL, tblName As String, fldName As String, fldKey As String, flds As Map) As Map
	RecordUpdate(jsql,tblName,flds,fldName,fldKey)
	Dim rec As Map = ReadRecord(jsql,tblName,fldName,fldKey)
	Return rec
End Sub


'update and read an existing record
Sub EditReadRecord(jsql As SQL, tblName As String, fldName As String, fldKey As String, flds As Map) As Map
	RecordUpdate(jsql,tblName,flds,fldName,fldKey)
	Dim rec As Map = ReadRecord(jsql,tblName,fldName,fldKey)
	Return rec
End Sub

'update and read an existing record
Sub EditRecord(jsql As SQL, tblName As String, fldName As String, fldKey As String, flds As Map) 
	RecordUpdate(jsql,tblName,flds,fldName,fldKey)
End Sub

Sub GetSQL() As SQL
	If UsePool Then
		Return pool.GetConnection		
	Else
		Return SQLite
	End If	
End Sub

Sub CloseSQL(mySQL As SQL)
	If UsePool Then
		mySQL.Close
	End If	
End Sub

Sub InitializeSQLite(Dir As String, fileName As String, createIfNeeded As Boolean) As Int
	Try
		SQLite.InitializeSQLite(Dir, fileName, createIfNeeded)
		DatabaseType = 0
		UsePool = False
		RanOK = True
	Catch
		Log("InitializeSQLite: "&LastException.Message)
		RanOK = False
	End Try
End Sub

Public Sub SetDefault(jSQL As SQL, TableName As String, FldName As String, Default As String)
	Dim qry As String
	qry = "update [" & TableName & "] set [" & FldName & "] = " & Default & " where [" & FldName & "] Is Null"
	RunQuery(jSQL, qry,True)
	qry = "update [" & TableName & "] set [" & FldName & "] = " & Default & " where [" & FldName & "] = ''"
	RunQuery(jSQL, qry,True)
End Sub

Public Sub SetDefault1(jSQL As SQL, TableName As String, defaultmap As Map)
	Dim qry As String
	For Each FldName As String In defaultmap.Keys
		Dim Default As String = defaultmap.Get(FldName)
		qry = "update [" & TableName & "] set [" & FldName & "] = " & Default & " where [" & FldName & "] Is Null"
		RunQuery(jSQL,qry,False)
	Next
End Sub

private Sub MySQLConnectionString(serverIP As String,  serverPort As String, serverDB As String) As String
	Dim sb As StringBuilder
	sb.Initialize 
	sb.Append("jdbc:mysql://").Append(serverIP).Append(":").Append(serverPort).Append("/").Append(serverDB)
	Return sb.tostring
End Sub

private Sub MSSQLConnectionString(serverIP As String,  serverPort As String, serverDB As String) As String
	Dim sb As StringBuilder
	sb.Initialize 
	sb.Append("jdbc:jtds:sqlserver://").Append(serverIP).Append(":").Append(serverPort).Append("/").Append(serverDB)
	Return sb.tostring
End Sub

'jdbc:mysql://192.100.0.000:3306/DBname", "root", "root")
Sub InitializeMySQL(serverIP As String,  serverPort As String, serverDB As String, login As String, password As String, poolSize As Int) As Int
	DatabaseType = 1
	UsePool = True
	Try
		Dim jdbcUrl As String
		jdbcUrl = MySQLConnectionString(serverIP,serverPort,serverDB)
       pool.Initialize("com.mysql.jdbc.Driver", jdbcUrl, login, password)
	   RanOK = True
	Catch
		Log("InitializeMySQL: "&LastException.Message)
	   RanOK = False
	End Try

   ' change pool size...
    Dim jo As JavaObject = pool
    jo.RunMethod("setMaxPoolSize", Array(poolSize))	
End Sub

Sub InitializeMSSQL(serverIP As String,  serverPort As String, serverDB As String ,login As String, password As String, poolSize As Int) 'ignore
	DatabaseType = 2
	Try
		Dim jdbcUrl As String
		jdbcUrl = MSSQLConnectionString(serverIP,serverPort,serverDB)
		pool.Initialize("net.sourceforge.jtds.jdbc.Driver", jdbcUrl, login, password)
		RanOK = True
	Catch
		Log("InitializeMSSQL: " & LastException.Message)
		RanOK = False
	End Try
	' change pool size...	
	Dim jo As JavaObject = pool
	jo.RunMethod("setMaxPoolSize", Array(poolSize))
End Sub

'Make db multiaccess
Sub MakeMultiAccess(jSQL As SQL)
	RunQuery(jSQL,"PRAGMA journal_mode = wal",False)
End Sub

Private Sub EscapeField(f As String) As String
	Return $"[${f}]"$
End Sub

private Sub MvFromList(lst As List, Delim As String) As String
	Dim lTot As Int
	Dim lCnt As Int
	Dim lStr As StringBuilder
	lStr.Initialize
	lTot = lst.Size - 1
	For lCnt = 0 To lTot
		lStr.Append(lst.Get(lCnt))
		If lCnt <> lTot Then lStr.Append(Delim)
	Next
	Return lStr.tostring
End Sub

private Sub Join(Delimiter As String, lst As List) As String
	Return MvFromList(lst,Delimiter)
End Sub


'remove a delimiter from a string

private Sub RemDelim(sValue As String, Delim As String) As String
	If sValue.EndsWith(Delim) Then
		Dim lDelim As Int = Delim.Length
		Dim nValue As String = sValue
		nValue = nValue.SubString2(0, nValue.Length-lDelim)
		Return nValue
	End If
	Return sValue
End Sub

'get all column names from a table
private Sub GetTableTextColumnNames(jsql As SQL, tblName As String) As List
	Dim strFld As String
	Dim fType As String
	Dim curFields As List
	Dim cur As ResultSet
	curFields.Initialize
	cur = jsql.ExecQuery("PRAGMA table_info ('" & tblName & "')")
	Do While cur.NextRow
		strFld = cur.GetString("name")
		fType = cur.GetString("type")
		If fType.ToLowerCase = "text" Then curFields.Add(strFld)
	Loop
	cur.close
	Return curFields
End Sub

'get all column names from a table
private Sub GetTableColumnNames(jsql As SQL, tblName As String) As List
	Dim strFld As String
	Dim curFields As List
	Dim cur As ResultSet
	curFields.Initialize		
	cur = jsql.ExecQuery("PRAGMA table_info ('" & tblName & "')")
	Do While cur.NextRow
		strFld = cur.GetString("name")
		curFields.Add(strFld)
	Loop	
	cur.close
	Return curFields
End Sub

'gets the existance of a column from a table
private Sub ColumnExists(jsql As SQL, tblName As String, colName As String) As Boolean
	Dim lst As List = GetTableColumnNames(jsql,tblName)
	If lst.IndexOf(colName) = -1 Then
		Return False
	Else
		Return True
	End If
End Sub

'remove unwanted characters from sql command
Sub CleanSQL(sValue As String) As String
	Dim sb As StringBuilder
	Dim tCnt As Int= 0
	Dim tTot As Int = sValue.length - 1
	Dim sIt As String
	Dim sTo As String = "01234567890)[abcdefghijklmnopqrstuvwxyz_,]("
	sb.Initialize
	For tCnt = 0 To tTot
		 sIt = sValue.SubString2(tCnt,tCnt+1)
		 Select Case sIt
		 Case " "
		 	sb.Append(sIt)
		 Case Else
		 	If sTo.IndexOf(sIt.ToLowerCase) >= 0 Then
				sb.Append(sIt)
			End If
		 End Select
	Next
	Return sb.tostring
End Sub

'remove a column from sqlite table, the fldname to remove is case sensitive
Sub RemoveColumn1(jsql As SQL, TableName As String, FldName As String) As Boolean
	Dim isremoved As Boolean = False
	jsql.ExecNonQuery("PRAGMA foreign_keys=off;")
	jsql.BeginTransaction
	Try
		Dim newFields As List
		'get the current table columns 
		Dim curFields As List = GetTableColumnNames(jsql,TableName)
		'remove the column to be removed from the list and define new column names
		Dim newFields As List
		newFields.Initialize
		For Each strColumn As String In curFields
			If strColumn.EqualsIgnoreCase(FldName) = False Then newFields.Add(strColumn)
		Next
		' define the new fields to use in new table
		Dim newFieldsS As String = Join(",", newFields)
		'get the sql that was used to create the original table
		Dim sqlS As String = jsql.ExecQuerySingleResult("SELECT sql from sqlite_master where name = '" & TableName & "'")
		'clean the sql command to create the table
		sqlS = CleanSQL(sqlS)
		'establish splitting locations
		sqlS = sqlS.Replace(",",",~")
		'ensure the tabs are cleaned out
		sqlS = sqlS.Replace(TAB,"~")
		sqlS = sqlS.Replace(CRLF,"~")
		Dim spCode() As String = Regex.Split("~",sqlS)
		Dim sb As StringBuilder
		sb.Initialize 
		For Each strLine As String In spCode
			' see if line starts with column not needed
			If strLine.StartsWith("[" & FldName & "] ") = True Then
				' do nothing
			else if strLine.StartsWith(FldName & " ") = True Then
				' do nothing, this is precaution
			else If strLine.StartsWith(" [" & FldName & "] ") = True Then
				' do nothing
			Else
				' this should be used on a new table
				sb.Append(strLine)		
			End If
		Next
				
		'now rename the original table, we will copy records across 
		jsql.ExecNonQuery("ALTER TABLE " & TableName & " RENAME TO " & TableName & "_old")
		'create a new table with updated fields
		Dim sCommand As String = sb.ToString.trim
		If sCommand.EndsWith(",") = True Then
			sCommand = RemDelim(",",sCommand)
			sCommand = sCommand & ")"
		End If
		jsql.ExecNonQuery(sCommand)
		
		'copy records to new table from renamed table
		jsql.ExecNonQuery("INSERT INTO " & TableName & "(" & newFieldsS & ") SELECT " & newFieldsS & " FROM " & TableName & "_old")
		' drop the temporal table created
		jsql.ExecNonQuery("DROP TABLE " & TableName & "_old")
		isremoved = Not(ColumnExists(jsql, TableName, FldName))
		jsql.TransactionSuccessful
	Catch 
		jsql.Rollback
		Log("RemoveColumn: " & LastException)
	End Try	
	jsql.ExecNonQuery("PRAGMA foreign_keys=on;")
	Return isremoved
End Sub

public Sub RemDelimSB(delimiter As String, value As StringBuilder) As StringBuilder
	If value.tostring.EndsWith(delimiter) = True Then
		Dim delimLen As Int = delimiter.length
		value.Remove(value.Length-delimLen,value.Length)
	End If
	Return value
End Sub

'remove a column from sqlite table, the fldname to remove is case sensitive
Sub RemoveColumn(jsql As SQL, TableName As String, FldName As String) As Boolean
	'get the structure of the table
	Dim flds As Map = GetTableStructure(jsql,TableName)
	'get the primary key
	Dim pkey As String = GetTablePrimaryKey(jsql,TableName)
	'get the indexes of the table
	Dim idxs As Map = GetTableIndexes(jsql,TableName)
   	
	'remove the fldname to be deleted
	flds.Remove(FldName)
	flds.Remove(FldName.ToLowerCase)
	'remove the indexes
	idxs.Remove(FldName)
	idxs.Remove(FldName.ToLowerCase)
	'remove the old table
	DropTable(jsql,TableName & "_old")
	'create a new table with the updated fields
	CreateTable(jsql,TableName & "_old",flds,pkey,pkey)
	'add the indexes
	AddIndexes(jsql,TableName & "_old",idxs)
	'get the new field names created
	Dim newFlds As StringBuilder
	newFlds.Initialize
	For Each strFld As String In flds.Keys
		newFlds.Append("[").Append(strFld).Append("],") 
	Next
	newFlds = RemDelimSB(",",newFlds)
	'copy the data from original to old table
	jsql.ExecNonQuery("PRAGMA foreign_keys=off;")
	jsql.BeginTransaction
	Try
		'copy records to new table from original table
		jsql.ExecNonQuery("INSERT INTO [" & TableName & "_old] (" & newFlds & ") SELECT " & newFlds & " FROM [" & TableName & "]")
		' drop the original table
		jsql.ExecNonQuery("DROP TABLE [" & TableName & "]")
		'rename the old to new table
		jsql.ExecNonQuery("ALTER TABLE [" & TableName & "_old] RENAME TO [" & TableName & "]")
		jsql.TransactionSuccessful
	Catch 
		jsql.Rollback
		Log("RemoveColumn: " & LastException)
	End Try	
	'just in case
	'add the indexes
	AddIndexes(jsql,TableName,idxs)
	jsql.ExecNonQuery("PRAGMA foreign_keys=on;")
	'does the column exists
	Return Not(ColumnExists(jsql,TableName,FldName))
End Sub

' return a list of the table column names as a list
Sub GetFieldNames(jSQL As SQL,TableName As String) As List
	Dim res1 As List
	res1.Initialize 
	Try
		Dim cur As ResultSet
		cur = jSQL.ExecQuery("PRAGMA table_info ('" & TableName & "')")
		Dim Table As List
		Table.Initialize
		Do While cur.NextRow
			res1.Add(cur.GetString("name").ToLowerCase)
		Loop	
		cur.close
	Catch
		Log("GetFieldNames: " & LastException)
	End Try
	Return res1
End Sub

Sub RenameTable(jSQL As SQL, prevTable As String, newTable As String) As Boolean
	If jSQL.IsInitialized = False Then Return False
	jSQL.ExecNonQuery("PRAGMA foreign_keys=off;")
	jSQL.BeginTransaction
	Try
		jSQL.ExecNonQuery($"ALTER TABLE [${prevTable}] RENAME TO [${newTable}];"$)
		jSQL.TransactionSuccessful
	Catch
		jSQL.Rollback
		Log("RenameTable: " & LastException)
	End Try
	jSQL.ExecNonQuery("PRAGMA foreign_keys=on;")
	'check if table exists
	Return TableExists(jSQL,newTable)
End Sub

Sub CloneTable1(jSQL As SQL, prevTable As String, newTable As String) As Boolean
	If jSQL.IsInitialized = False Then Return False
	jSQL.ExecNonQuery("PRAGMA foreign_keys=off;")
	jSQL.BeginTransaction
	Try
		jSQL.ExecNonQuery($"CREATE TABLE [${newTable}] AS SELECT * FROM [${prevTable}];"$)		
		jSQL.TransactionSuccessful
	Catch
		jSQL.Rollback
		Log("CloneTable: " & LastException)
	End Try
	jSQL.ExecNonQuery("PRAGMA foreign_keys=on;")
	'check if table exists
	Return TableExists(jSQL,newTable)
End Sub


'get the table structure from the pragma statement
Sub GetTableStructure(jSQL As SQL, tblName As String) As Map
	Dim fld As Map
	fld.Initialize
	Dim fields As List = ExecuteMaps(jSQL,"PRAGMA table_info ('" & tblName & "')",Null)
	For Each fldm As Map In fields
		Dim fldname As String = fldm.GetDefault("name","")
		Dim fldtype As String = fldm.GetDefault("type","")
		fldname = fldname.tolowercase
		fld.put(fldname,fldtype)
	Next
	Return fld
End Sub

'get the primary key of the table
Sub GetTablePrimaryKey(jSQL As SQL, tblName As String) As String
	Dim fields As List = ExecuteMaps(jSQL,"PRAGMA table_info ('" & tblName & "')",Null)
	For Each fldm As Map In fields
		Dim fldname As String = fldm.GetDefault("name","")
		Dim fldpk As String = fldm.GetDefault("pk","")
		fldname = fldname.tolowercase
		If fldpk = "1" Then Return fldname
	Next
	Return ""
End Sub

'get indexes of the table
Sub GetTableIndexes(jSQL As SQL, tblName As String) As Map
	Dim fld As Map
	fld.initialize
	Dim fields As List = ExecuteMaps(jSQL, $"PRAGMA INDEX_LIST ('${tblName}')"$,Null)
	For Each fldm As Map In fields
		Dim fldname As String = fldm.GetDefault("name","")
		Dim unique As String = fldm.GetDefault("unique","")
		Dim bunique As Boolean = False
		If unique = "1" Then bunique = True
		'go deeper and get the column names for this index
		Dim idxcols As List = ExecuteMaps(jSQL,$"PRAGMA index_info('${fldname}');"$,Null)
		For Each idxm As Map In idxcols
			fldname = idxm.GetDefault("name","")
			fld.Put(fldname,bunique)
		Next
	Next
	Return fld
End Sub


'get indexes of the table
Sub GetTableIndexesWithColumns(jSQL As SQL, tblName As String) As Map
	Dim fld As Map
	fld.initialize
	Dim fields As List = ExecuteMaps(jSQL, $"PRAGMA INDEX_LIST ('${tblName}')"$,Null)
	For Each fldm As Map In fields
		Dim fldname As String = fldm.GetDefault("name","")
		Dim unique As String = fldm.GetDefault("unique","")
		Dim bunique As Boolean = False
		If unique = "1" Then bunique = True
		'go deeper and get the column names for this index
		Dim idxcols As List = ExecuteMaps(jSQL,$"PRAGMA index_info('${fldname}');"$,Null)
		Dim idxcolNames As List
		idxcolNames.Initialize 
		For Each idxm As Map In idxcols
			Dim idxcolName As String = idxm.GetDefault("name","")
			idxcolNames.Add(idxcolName)
		Next
		Dim nidx As Map = CreateMap("unique":bunique,"columns":idxcolNames)
		fld.Put(fldname,nidx)
	Next
	Return fld
End Sub

Sub CloneTable(jSQL As SQL, prevTable As String, newTable As String) As Boolean
	'get the structure of the table
	Dim flds As Map = GetTableStructure(jSQL,prevTable)
	'get the primary key
	Dim pkey As String = GetTablePrimaryKey(jSQL,prevTable)
	'get the indexes of the table
	Dim idxs As Map = GetTableIndexes(jSQL,prevTable)
	
	CreateTable(jSQL,newTable,flds,pkey,pkey)
	'add the indexes
	AddIndexes(jSQL,newTable,idxs)
	Return TableExists(jSQL,newTable)
End Sub


' return a list of the table column names as a list
Sub GetIndexNames(jsQL As SQL,TableName As String) As List
	Dim res1 As List
	res1.Initialize 
	Try
		Dim cur As ResultSet
		cur = jsQL.ExecQuery("PRAGMA INDEX_LIST ('" & TableName & "')")
		Dim Table As List
		Table.Initialize
		Do While cur.NextRow
			Dim m As Map
			m.Initialize 
			m.Put("name", cur.GetString("name").ToLowerCase)
			m.Put("unique", cur.GetString("unique"))
			res1.Add(m)
		Loop	
		cur.close
	Catch
		Log("GetIndexNames: " & LastException)
	End Try
	Return res1
End Sub

' return a list of the table index names and their column names
Sub GetIndexNamesPlusColumns(jSQL As SQL,TableName As String) As List
	Dim res1 As List
	res1.Initialize 
	Try
		Dim cur As ResultSet
		cur = jSQL.ExecQuery("select name,sql from sqlite_master where type='index' and tbl_name='" & TableName & "'")
		Dim table As List
		table.Initialize
		Do While cur.NextRow
			Dim sname As String = cur.GetString("name")
			Dim ssql As String = cur.GetString("sql")
			ssql = ssql.Replace("CREATE INDEX ","")
			ssql = ssql.Replace("\[" & TableName & "\]", "")
			ssql = ssql.Replace("ON ","")
			ssql = ssql.trim
			'clean the sql
			Dim m As Map
			m.Initialize 
			m.Put("name", sname)
			m.Put("columns", ssql)
			res1.Add(m)
		Loop	
		cur.close
	Catch
		Log("GetIndexNamesPlusColumns: " & LastException)
	End Try
	Return res1
End Sub

Sub FieldExist(jsQL As SQL, TableName As String, FldName As String) As Boolean
	FldName = FldName.tolowercase
	Dim xl As List
	xl = GetFieldNames(jsQL,TableName)
	If xl.IndexOf(FldName) = -1 Then
		Return False
	Else
		Return True
	End If
End Sub



Sub RunQuery1(jSQL As SQL, Qry As String, Args As List)
	'Log("RunQuery1: " & Qry)
	Try
		jSQL.ExecNonQuery2(Qry,  Args)
		RanOK = True
	Catch
		RanOK = False
		Log("RunQuery1: " & Qry)
		Log("RunQuery1: " & LastException)
	End Try
End Sub


' check the existence of a table
Sub FieldExists(jSQL As SQL,TableName As String, FldName As String) As Boolean
	FldName = FldName.ToLowerCase 
	Dim lFld As List
	Dim lPos As Int
	lFld.Initialize
	lFld = GetFieldNames(jSQL,TableName)
	If lFld = Null Then
		Return False
	Else
		lPos = lFld.IndexOf(FldName)
		If lPos = -1 Then
			Return False
		Else
			Return True
		End If
	End If
End Sub

'Description: Set all text fields to '' where they are null
Sub TableSetTextFieldDetaults(jSQL As SQL, TableName As String)
	'get all text fields
	Dim textFields As List = GetTableTextColumnNames(jSQL,TableName)
	For Each strField As String In textFields
		Dim qry As String = $"update [${TableName}] set [${strField}] = '' where [${strField}] isnull"$
		jSQL.AddNonQueryToBatch(qry,Null)
	Next
	ExecuteBatch(jSQL)
End Sub


Sub AddColumnsList(jSQL As SQL, tablename As String, fldList As List)
	Dim nFields As Map
	nFields.Initialize
	For Each strField As String In fldList
		nFields.Put(strField,DB_TEXT)
	Next
	AddColumns(jSQL,tablename,nFields)
End Sub

' update an existing table and add columns
Sub AddColumns1(jSQL As SQL,TableName As String, FieldsAndTypes As Map)
	IsDone = False
	Dim fldTot As Int = 0
	FieldsAndTypes = DeDuplicateMap(FieldsAndTypes)
	Dim ExistingColumns As List = GetFieldNames(jSQL,TableName)
	Dim i As Int
	For i = 0 To FieldsAndTypes.Size - 1
		Dim sb, field, ftype As String
		field = FieldsAndTypes.GetKeyAt(i)
		ftype = FieldsAndTypes.GetValueAt(i)
		If field.Length > 0 And ftype.Length > 0 Then
			If ExistingColumns.IndexOf(field.tolowercase) = -1 Then
				sb = "ALTER TABLE [" & TableName & "] ADD COLUMN [" & field & "] " & ftype
				jSQL.AddNonQueryToBatch(sb,Null)
				fldTot = fldTot + 1
				Select Case ftype
				Case DB_FLOAT, DB_INTEGER, DB_NUMERIC, DB_REAL
					sb = "UPDATE [" & TableName & "] SET [" & field & "] = 0"
					jSQL.AddNonQueryToBatch(sb,Null)
					fldTot = fldTot + 1
				Case DB_TEXT
					sb = "UPDATE [" & TableName & "] SET [" & field & "] = ''"
					jSQL.AddNonQueryToBatch(sb,Null)
					fldTot = fldTot + 1
				End Select
			End If
		End If
	Next
	If fldTot > 0 Then
		ExecuteBatch(jSQL)
	End If
End Sub

' update an existing table and add columns
Sub AddColumns(jSQL As SQL,TableName As String, FieldsAndTypes As Map)
	IsDone = False
	jSQL.ExecNonQuery("PRAGMA foreign_keys=off;")
	jSQL.BeginTransaction
	Try
		FieldsAndTypes = DeDuplicateMap(FieldsAndTypes)
		Dim ExistingColumns As List = GetFieldNames(jSQL,TableName)
		Dim i As Int
		For i = 0 To FieldsAndTypes.Size - 1
			Dim sb, field, ftype As String
			field = FieldsAndTypes.GetKeyAt(i)
			ftype = FieldsAndTypes.GetValueAt(i)
			If field.Length > 0 And ftype.Length > 0 Then
				If ExistingColumns.IndexOf(field.tolowercase) = -1 Then 
					sb = "ALTER TABLE [" & TableName & "] ADD COLUMN [" & field & "] " & ftype
					jSQL.ExecNonQuery(sb)
				End If
			End If
		Next
		jSQL.TransactionSuccessful
		IsDone = True		
	Catch
		jSQL.Rollback
		Log("AddColumns: " & LastException)
		IsDone = False
	End Try
	jSQL.ExecNonQuery("PRAGMA foreign_keys=on;")
End Sub


Sub SQL_NonQueryComplete (Success As Boolean)
	IsDone = True
    'Log("NonQuery: " & Success)
	If Success = False Then Log("SQL_NonQueryComplete: " & LastException)
End Sub

'executes a query and returns a result
Sub RunQuery(jSQL As SQL, Qry As String, bUseTransaction As Boolean)	
	If bUseTransaction = True Then 
		jSQL.BeginTransaction
	End If
	Try
		'Log("RunQuery: " & Qry)
		jSQL.ExecNonQuery(Qry)
		If bUseTransaction = True Then jSQL.TransactionSuccessful
		RanOK = True
	Catch
		If bUseTransaction = True Then jSQL.rollback
		RanOK = False
		Log("RunQuery: " & Qry)
		Log("RunQuery: " & LastException)
	End Try
End Sub

' update an existing table and add columns
Sub AddIndexes1(jSQL As SQL,TableName As String, Fields As Map)
	Dim i As Int
	Dim iadd As Int = 0
	For i = 0 To Fields.Size - 1
		Try
			iadd = iadd + 1
			Dim sb As StringBuilder
			Dim field As String
			Dim unique As Boolean
			field = Fields.GetKeyAt(i)
			unique = Fields.GetValueAt(i)
			sb.Initialize
			sb.Append("CREATE ")
			If unique = True Then sb.Append("UNIQUE ")
			sb.Append("INDEX IF NOT EXISTS [").Append(TableName).Append(field).Append("]")
			sb.Append(" ON [").Append(TableName).Append("] ([").Append(field).Append("] COLLATE NOCASE)")
			jSQL.AddNonQueryToBatch(sb.tostring,Null)
		Catch
			Log("AddIndexes: " & LastException)
		End Try
	Next
	If iadd > 0 Then
		ExecuteBatch(jSQL)
	End If
End Sub


'copy records from 1 table to another, existing records should match
Sub CopyRecords(jSQL As SQL, sourceTable As String, targetTable As String) As Boolean
	Dim bOk As Boolean = False
	'does the source have records
	Dim sourcecount As Int = jSQL.ExecQuerySingleResult($"SELECT count(*) from ${sourceTable}"$)
	If sourcecount = 0 Then Return True
	'get field names from old table
	Dim newFields As List
	newFields.Initialize 
	'get the current table columns
	Dim oldFields As List = GetTableColumnNames(jSQL,sourceTable)
	'get field names from new table
	Dim targetFields As List = GetTableColumnNames(jSQL,targetTable)
	'extract only matching fields
	For Each strField As String In targetFields
		If OnList(oldFields,strField) = True Then
			newFields.Add(strField)	
		End If
	Next
	Dim copyFields As String = Join(",", newFields)
	'copy the data from original to old table
	jSQL.ExecNonQuery("PRAGMA foreign_keys=off;")
	jSQL.BeginTransaction
	Try
		'copy records to new table from original table
		jSQL.ExecNonQuery($"INSERT INTO ${targetTable} (${copyFields}) SELECT ${copyFields} FROM ${sourceTable};"$)
		jSQL.TransactionSuccessful
		'count records on both
		Dim sourcecount As Int = jSQL.ExecQuerySingleResult($"SELECT count(*) from ${sourceTable}"$)
		Dim targetcount As Int = jSQL.ExecQuerySingleResult($"SELECT count(*) from ${targetTable}"$)
		If sourcecount = targetcount Then
			bOk = True
		Else
			bOk = False
		End If
	Catch
		jSQL.Rollback
		Log("CopyRecords: " & LastException)
	End Try
	'just in case
	jSQL.ExecNonQuery("PRAGMA foreign_keys=on;")
	Return bOk
End Sub


Sub OnList(searchList As List, searchValue As String) As Boolean
	'If searchList.IsInitialized = False Then Return False
	For Each strTable As String In searchList
		If strTable.EqualsIgnoreCase(searchValue) = True Then
			Return True
		End If
	Next
	Return False
End Sub

' update an existing table and add columns
Sub AddIndexes(jSQL As SQL,TableName As String, FieldsAndTypes As Map)
	IsDone = False
	jSQL.ExecNonQuery("PRAGMA foreign_keys=off;")
	jSQL.BeginTransaction
	Try
		FieldsAndTypes = DeDuplicateMap(FieldsAndTypes)
		Dim i As Int
		For i = 0 To FieldsAndTypes.Size - 1
			Dim sb As StringBuilder
			Dim field As String
			Dim unique As Boolean
			field = FieldsAndTypes.GetKeyAt(i)
			unique = FieldsAndTypes.GetValueAt(i)
			If field.Length > 0 Then
				sb.Initialize
				sb.Append("CREATE ")
				If unique = True Then sb.Append("UNIQUE ")
				sb.Append("INDEX IF NOT EXISTS [").Append(TableName).Append(field).Append("]")
				sb.Append(" ON [").Append(TableName).Append("] ([").Append(field).Append("] COLLATE NOCASE)")
				jSQL.ExecNonQuery(sb.tostring)
			End If
		Next
		jSQL.TransactionSuccessful
		IsDone = True		
	Catch
		jSQL.Rollback
		Log("AddIndexes: " & LastException)
		IsDone = False
	End Try
	jSQL.ExecNonQuery("PRAGMA foreign_keys=on;")
End Sub

Sub TableClear(jSQL As SQL, tblName As String)
	ClearTable(jSQL,tblName)
End Sub

' clear table a table from a database
Sub ClearTable(jSQL As SQL,TableName As String)
	RunQuery(jSQL,"DELETE FROM [" & TableName & "]",True)
End Sub

' delete an index from a table
Sub DropIndex(jSQL As SQL,TableName As String,IndexName As String)
	jSQL.ExecNonQuery("PRAGMA foreign_keys=off;")
	jSQL.BeginTransaction
	Try
		Dim idxName As String
		idxName = TableName & IndexName
		RunQuery(jSQL, "DROP INDEX [IF EXISTS] [" & idxName & "]",False)
		jSQL.TransactionSuccessful
	Catch
		Log("DropIndex: " & LastException.Message)
		jSQL.Rollback
	End Try
	jSQL.ExecNonQuery("PRAGMA foreign_keys=on;")
End Sub

Sub RemoveIndexes(jSQL As SQL,TableName As String, idxList As List)
	IsDone = False
	jSQL.ExecNonQuery("PRAGMA foreign_keys=off;")
	jSQL.BeginTransaction
	Try
		For Each idxname As String In idxList
			idxname = TableName & idxname
			RunQuery(jSQL, "DROP INDEX [IF EXISTS] [" & idxname & "]",False)
		Next
		jSQL.TransactionSuccessful
		IsDone = True		
	Catch
		jSQL.Rollback
		Log("RemoveIndexes: " & LastException)
		IsDone = False
	End Try
	jSQL.ExecNonQuery("PRAGMA foreign_keys=on;")
End Sub

'Creates a new table with the given name.
'FieldsAndTypes - A map with the fields names as keys and the types as values.
'You can use the DB_... constants for the types.
'PrimaryKey - The column that will be the primary key. Pass empty string if not needed.
Public Sub CreateTable(jSQL As SQL, TableName As String, FieldsAndTypes As Map, PrimaryKey As String, AutoIncrement As String)
	If TableExists(jSQL,TableName) = False Then
		Dim sb As StringBuilder
		sb.Initialize
		sb.Append("(")
		For i = 0 To FieldsAndTypes.Size - 1
			Dim field, ftype As String
			field = FieldsAndTypes.GetKeyAt(i)
			ftype = FieldsAndTypes.GetValueAt(i)
			If i > 0 Then sb.Append(", ")
			sb.Append(EscapeField(field)).Append(" ").Append(ftype)
			If ftype = DB_TEXT Then sb.Append(" COLLATE NOCASE")
			If field.EqualsIgnoreCase(PrimaryKey) Then sb.Append(" NOT NULL PRIMARY KEY")
			If field.EqualsIgnoreCase(AutoIncrement) Then sb.Append(" AUTOINCREMENT")
		Next
		sb.Append(")")
		Dim query As String
		query = "CREATE TABLE IF NOT EXISTS " & EscapeField(TableName) & " " & sb.ToString
		RunQuery(jSQL,query,True)
	End If
	AddColumns(jSQL,TableName,FieldsAndTypes)
End Sub

'Deletes the given table.
Public Sub DropTable(jSQL As SQL, TableName As String) As Boolean
	Dim query As String
	query = "DROP TABLE IF EXISTS " & EscapeField(TableName)
	RunQuery(jSQL,query,True)
	Return Not(TableExists(jSQL,TableName))
End Sub


'Deletes the given trigger.
Public Sub DropTrigger(jSQL As SQL, TableName As String) As Boolean
	jSQL.ExecNonQuery("DROP TRIGGER IF EXISTS " & TableName)
	Return Not(SQLiteTriggerExists(jSQL,TableName))
End Sub

'Delete a table
Sub DeleteTable(jsql As SQL, tblName As String) As Boolean
	Return DropTable(jsql,tblName)
End Sub

public Sub RecordInsert(jSQL As SQL, TableName As String, nRecord As Map) As Long
	Return AddRecord(jSQL,TableName,nRecord)
End Sub

public Sub LastInsertID(jsql As SQL) As Long
	Dim res As Long = jsql.ExecQuerySingleResult("SELECT last_insert_rowid()")
	Return res
End Sub

public Sub LastRecordID(jsql As SQL, tblName As String, pk As String) As Long
	Dim res As Long = jsql.ExecQuerySingleResult("SELECT COUNT(" & pk & ") FROM " & tblName)
	If res = 0 Then
		Return 0
	Else
		Dim res As Long = jsql.ExecQuerySingleResult("SELECT MAX(" & pk & ") FROM " & tblName)
		Return res
	End If
End Sub

public Sub RecordCount(jsql As SQL, tblName As String, pk As String) As Long
	Dim res As Long = jsql.ExecQuerySingleResult("SELECT COUNT(" & pk & ") FROM " & tblName)
	Return res
End Sub

public Sub RecordCountQry(jsql As SQL, tblQry As String) As Long
	Dim res As Long = jsql.ExecQuerySingleResult(tblQry)
	Return res
End Sub

'insert a record and return its id
public Sub AddRecord(jSQL As SQL, TableName As String, nRecord As Map) As Long
	Dim nList As List
	nList.Initialize
	nList.Add(nRecord)
	If InsertMaps(jSQL, TableName, nList,False) = True Then
		Dim lastrec As Long = LastInsertID(jSQL)
		Return lastrec
	Else
		Return -1
	End If
End Sub

public Sub InsertMap(jSQL As SQL, TableName As String, Map2Insert As Map,bDebug As Boolean) As Boolean
	Dim ListOfMaps As List
	ListOfMaps.Initialize 
	ListOfMaps.Add(Map2Insert)
	Return InsertMaps(jSQL,TableName,ListOfMaps,bDebug)
End Sub

'Inserts the data to the table.
'ListOfMaps - A list with maps as items. Each map represents a record where the map keys are the columns names
'and the maps values are the values.
'Note that you should create a new map for each record (this can be done by calling Dim to redim the map).
Public Sub InsertMaps(jSQL As SQL, TableName As String, ListOfMaps As List,bDebug As Boolean) As Boolean
	Dim sb, columns, values As StringBuilder
	'Small check for a common error where the same map is used in a loop
	If ListOfMaps.Size > 1 And ListOfMaps.Get(0) = ListOfMaps.Get(1) Then
		Log("Same Map found twice in list. Each item in the list should include a different map object.")
		Return False
	End If
	jSQL.BeginTransaction
	Try
		For i1 = 0 To ListOfMaps.Size - 1
			sb.Initialize
			columns.Initialize
			values.Initialize
			Dim listOfValues As List
			listOfValues.Initialize
			sb.Append("INSERT INTO [" & TableName & "] (")
			Dim m As Map
			m = ListOfMaps.Get(i1)
			m = DeDuplicateMap(m)
			For i2 = 0 To m.Size - 1
				Dim col As String
				Dim value As Object	
				col = m.GetKeyAt(i2)
				value = m.GetValueAt(i2)
				If i2 > 0 Then
					columns.Append(", ")
					values.Append(", ")
				End If
				columns.Append(EscapeField(col))
				
				values.Append("?")
				listOfValues.Add(value)
			Next
			sb.Append(columns.ToString)
			sb.Append(") VALUES (")
			sb.Append(values.ToString)
			sb.Append(")")
			'If i1 = 0 Then Log("InsertMaps (first query out of " & ListOfMaps.Size & "): " & sb.ToString)
			If bDebug = True Then
				Log(sb.ToString)
				Log(listOfValues)
			End If
			jSQL.ExecNonQuery2(sb.tostring,  listOfValues)
		Next
		jSQL.TransactionSuccessful
		Return True
	Catch
		Log("InsertMaps: " & LastException)
		jSQL.Rollback
		Return False
	End Try
End Sub

'Inserts the data to the table.
'ListOfMaps - A list with maps as items. Each map represents a record where the map keys are the columns names
'and the maps values are the values.
'Note that you should create a new map for each record (this can be done by calling Dim to redim the map).

Public Sub UpdateMaps(jSQL As SQL, TableName As String, ListOfMaps As List) As Boolean
	'Small check for a common error where the same map is used in a loop
	If ListOfMaps.Size > 1 And ListOfMaps.Get(0) = ListOfMaps.Get(1) Then
		Log("Same Map found twice in list. Each item in the list should include a different map object.")
		Return False
	End If
	jSQL.BeginTransaction
	Try
		For i1 = 0 To ListOfMaps.Size - 1
			Dim qrymap As Map = ListOfMaps.Get(i1)
			If qrymap.IsInitialized Then
				Dim qry As String = qrymap.Get("qry")
				Dim args As List = qrymap.Get("args")
				jSQL.ExecNonQuery2(qry, args)
			End If
		Next
		jSQL.TransactionSuccessful
		Return True
	Catch
		Log("UpdateMaps: " & LastException)
		jSQL.Rollback
		Return False
	End Try
End Sub

public Sub RecordUpdateField(jSQL As SQL, TableName As String, Field As String, NewValue As String, KeyField As String, KeyValue As String)
	Dim w As Map
	w.Initialize 
	w.Put(KeyField,KeyValue)
	UpdateRecord(jSQL,TableName,Field,NewValue,w)
End Sub

' updates a single field in a record
' Field is the column name
Public Sub UpdateRecord(jSQL As SQL, TableName As String, Field As String, NewValue As Object, _
	WhereFieldEquals As Map)
	WhereFieldEquals = DeDuplicateMap(WhereFieldEquals)
	Dim sb As StringBuilder
	'jSQL.BeginTransaction
	Try
		sb.Initialize
		sb.Append("UPDATE ").Append(EscapeField(TableName)).Append(" SET ").Append(EscapeField(Field)) _
			.Append(" = ? WHERE ")
		If WhereFieldEquals.Size = 0 Then
			Log("WhereFieldEquals map empty!")
			Return
		End If
		Dim args As List
		args.Initialize
		args.Add(NewValue)
		For i = 0 To WhereFieldEquals.Size - 1
			If i > 0 Then sb.Append(" AND ")
			Dim sfield As String = WhereFieldEquals.GetKeyAt(i)
			sfield = $"lower(${sfield})"$
			sb.Append(sfield).Append(" = ?")
			Dim sValue As String = WhereFieldEquals.GetValueAt(i)
			sValue = sValue.ToLowerCase
			args.Add(sValue)
		Next
		jSQL.ExecNonQuery2(sb.tostring,  args)
		'jSQL.TransactionSuccessful
	Catch
		Log("UpdateRecord: " & LastException)
		'jSQL.Rollback
	End Try
End Sub

Sub RecordUpdateMap(TableName As String, fields As Map,PrimaryKey As String, PrimaryValue As String) As Map
	Return UpdateRecordMap(TableName,fields,CreateMap(PrimaryKey:PrimaryValue))
End Sub

Sub RecordUpdate(jSQL As SQL, TableName As String, Fields As Map, PrimaryKey As String, PrimaryValue As String)
	Dim w As Map
	w.Initialize
	w.Put(PrimaryKey, PrimaryValue)
	UpdateRecord2(jSQL,TableName,Fields,w)
End Sub


Sub RecordsUpdateWhere(jSQL As SQL, TableName As String, Fields As Map, WhereFieldsEqual As Map)
	UpdateRecord2(jSQL,TableName,Fields,WhereFieldsEqual)
End Sub

' updates multiple fields in a record
' in the Fields map the keys are the column names
Public Sub UpdateRecord2(jSQL As SQL, TableName As String, Fields As Map, WhereFieldEquals As Map)
	If WhereFieldEquals.Size = 0 Then
		Log("WhereFieldEquals map empty!")
		Return
	End If
	If Fields.Size = 0 Then
		Log("Fields empty")
		Return
	End If
	Fields = DeDuplicateMap(Fields)
	WhereFieldEquals = DeDuplicateMap(WhereFieldEquals)
	Dim sb As StringBuilder
	'jSQL.BeginTransaction
	Try
		sb.Initialize
		sb.Append("UPDATE ").Append(EscapeField(TableName)).Append(" SET ")
		Dim args As List
		args.Initialize
		For i=0 To Fields.Size-1
			If i<>Fields.Size-1 Then
				sb.Append(EscapeField(Fields.GetKeyAt(i))).Append("=?,")
			Else
				sb.Append(EscapeField(Fields.GetKeyAt(i))).Append("=?")
			End If
			args.Add(Fields.GetValueAt(i))
		Next
    
		sb.Append(" WHERE ")
		For i = 0 To WhereFieldEquals.Size - 1
			If i > 0 Then 
				sb.Append(" AND ")
			End If
			Dim skey As String = WhereFieldEquals.GetKeyAt(i)
			skey = $"lower(${skey})"$
			sb.Append(skey).Append(" = ?")
			Dim svalue As String = WhereFieldEquals.GetValueAt(i)
			svalue = svalue.ToLowerCase
			args.Add(svalue)
		Next
		jSQL.ExecNonQuery2(sb.tostring, args)
		'jSQL.TransactionSuccessful 
	Catch
		Log("UpdateRecord2: " & LastException)
		'jSQL.Rollback
	End Try
End Sub

Public Sub UpdateRecordMap(TableName As String, Fields As Map, WhereFieldEquals As Map) As Map
	Dim out As Map
	If WhereFieldEquals.Size = 0 Then
		Log("WhereFieldEquals map empty!")
		Return out
	End If
	If Fields.Size = 0 Then
		Log("Fields empty")
		Return out
	End If
	Fields = DeDuplicateMap(Fields)
	WhereFieldEquals = DeDuplicateMap(WhereFieldEquals)
	Dim sb As StringBuilder
	Try
		sb.Initialize
		sb.Append("UPDATE ").Append(EscapeField(TableName)).Append(" SET ")
		Dim args As List
		args.Initialize
		For i=0 To Fields.Size-1
			If i<>Fields.Size-1 Then
				sb.Append(EscapeField(Fields.GetKeyAt(i))).Append("=?,")
			Else
				sb.Append(EscapeField(Fields.GetKeyAt(i))).Append("=?")
			End If
			args.Add(Fields.GetValueAt(i))
		Next
    
		sb.Append(" WHERE ")
		For i = 0 To WhereFieldEquals.Size - 1
			If i > 0 Then 
				sb.Append(" AND ")
			End If
			Dim skey As String = WhereFieldEquals.GetKeyAt(i)
			skey = $"lower(${skey})"$
			sb.Append(skey).Append(" = ?")
			Dim svalue As String = WhereFieldEquals.GetValueAt(i)
			svalue = svalue.ToLowerCase
			args.Add(svalue)
		Next
		out = CreateMap("qry":sb.tostring,"args":args)
		Return out
	Catch
		Return out
	End Try
End Sub

'description: use batch update methods
'tag: AddNonQueryToBatch, multiple updates
Public Sub UpdateRecord4(jSQL As SQL, TableName As String, Fields As Map, WhereFieldEquals As Map)
	If WhereFieldEquals.Size = 0 Then
		Log("WhereFieldEquals map empty!")
		Return
	End If
	If Fields.Size = 0 Then
		Log("Fields empty")
		Return
	End If
	WhereFieldEquals = DeDuplicateMap(WhereFieldEquals)
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("UPDATE ").Append(TableName).Append(" SET ")
	Dim args As List
	args.Initialize
	For i=0 To Fields.Size-1
		If i<>Fields.Size-1 Then
			sb.Append(Fields.GetKeyAt(i)).Append("=?,")
		Else
			sb.Append(Fields.GetKeyAt(i)).Append("=?")
		End If
		args.Add(Fields.GetValueAt(i))
	Next
    
	sb.Append(" WHERE ")
	For i = 0 To WhereFieldEquals.Size - 1
		If i > 0 Then 
			sb.Append(" AND ")
		End If
		Dim skey As String = WhereFieldEquals.GetKeyAt(i)
		skey = $"lower(${skey})"$
		sb.Append(skey).Append(" = ?")
		Dim svalue As String = WhereFieldEquals.GetValueAt(i)
		svalue = svalue.ToLowerCase
		args.Add(svalue)
	Next
	jSQL.ExecNonQuery2(sb.ToString,args)
End Sub

'Description: execute a batch for AddNonQueryToBatch
'Tags: wait for, ExecNonQueryBatch execute
Sub ExecuteBatch(jSQL As SQL)
	Dim SenderFilter As Object = jSQL.ExecNonQueryBatch("SQL")
	Wait For (SenderFilter) SQL_NonQueryComplete (Success As Boolean)
	'Log("NonQuery: " & Success)
End Sub

public Sub UpdateRecords(jSQL As SQL, TableName As String, KeyField As String, KeyValue As String)
	Dim w As Map
	w.Initialize 
	w.Put(KeyField,KeyValue)
	UpdateRecord3(jSQL,TableName,w)
End Sub

Public Sub UpdateRecord3(jSQL As SQL, TableName As String, Fields As Map)
	If Fields.Size = 0 Then
		Log("Fields empty")
		Return
	End If
	Fields = DeDuplicateMap(Fields)
	Dim sb As StringBuilder
	jSQL.BeginTransaction
	Try
		sb.Initialize
		sb.Append("UPDATE ").Append(EscapeField(TableName)).Append(" SET ")
		Dim args As List
		args.Initialize
		For i=0 To Fields.Size-1
			If i<>Fields.Size-1 Then
				sb.Append(EscapeField(Fields.GetKeyAt(i))).Append("=?,")
			Else
				sb.Append(EscapeField(Fields.GetKeyAt(i))).Append("=?")
			End If
			args.Add(Fields.GetValueAt(i))
		Next
		jSQL.ExecNonQuery2(sb.tostring,  args)
		jSQL.TransactionSuccessful
	Catch
		Log("UpdateRecord3: " & LastException)
		jSQL.Rollback
	End Try
End Sub

Sub Records2JSON(jSQL As SQL, TableName As String, Query As String) As String
	Dim records As List
	records = ExecuteMaps(jSQL, Query, Null)
	Dim root As Map
	root.Initialize
	root.Put("root", records)
	root.Put("table", TableName)
	
	Dim gen As JSONGenerator
	gen.Initialize(root)
	
	Dim outJSON As String
	outJSON = gen.ToString
	Return outJSON
End Sub




'Executes the query and returns the result as a list of arrays.
'Each item in the list is a strings array.
'StringArgs - Values to replace question marks in the query. Pass Null if not needed.
'Limit - Limits the results. Pass 0 for all results.
Public Sub ExecuteMemoryTable(jSQL As SQL, Query As String, StringArgs() As String, Limit As Int) As List
	Dim table As List
	table.Initialize
	Try
		Dim cur As ResultSet
		If StringArgs = Null Then 
			Dim StringArgs(0) As String
		End If
		cur = jSQL.ExecQuery2(Query, StringArgs)
		Do While cur.NextRow
			Dim values(cur.ColumnCount) As String
			For col = 0 To cur.ColumnCount - 1
				Dim fValue As String = cur.GetString2(col)
				fValue = FixNull(fValue)
				values(col) = fValue
			Next
			table.Add(values)
			If Limit > 0 And table.Size >= Limit Then Exit
		Loop
		cur.Close
		Return table
	Catch
		Log(Query)
		Log(StringArgs)
		Log("ExecuteMemoryTable: " & LastException)
		Return table
	End Try	
End Sub


Sub CStr(o As Object) As String
	Return "" & o
End Sub


Sub FixNull(sObj As Object) As String
	Dim sValue As String
	If sObj = Null Then 
		sValue = ""
	Else
		sValue = CStr(sObj)
	End If
	sValue = sValue.Replace("NULL","").Replace("null","")
	Return sValue
End Sub

'Executes the query and returns a Map with the column names as the keys 
'and the first record values As the entries values.
'The keys are lower cased.
'Returns an uninitialized map if there are no results.
Public Sub ExecuteMap(jSQL As SQL, Query As String, StringArgs() As String) As Map
	Dim res As Map
	Try
	Dim cur As ResultSet
	If StringArgs <> Null Then 
		cur = jSQL.ExecQuery2(Query, StringArgs)
	Else
		cur = jSQL.ExecQuery(Query)
	End If
	If cur.NextRow = False Then
		'Log("No records found.")
		Return res
	End If
	res.Initialize
	For i = 0 To cur.ColumnCount - 1
		Dim fName As String = cur.GetColumnName(i).tolowercase
		Dim fValue As String = cur.GetString2(i)
		fValue = FixNull(fValue)
		res.Put(fName, fValue)
	Next
	cur.Close
	Catch
		Log(LastException)
	End Try
	Return res
End Sub

public Sub GetField(jSQL As SQL, TableName As String, PrimField As String, PrimValue As String, ReturnField As String) As String
	Dim mr As Map = ExecuteMap(jSQL, "SELECT [" & ReturnField & "] From [" & TableName & "] WHERE lower(" & PrimField & ") = ?", Array As String(PrimValue.tolowercase))
	If mr.IsInitialized Then
		Dim sout As String = mr.Getdefault(ReturnField.tolowercase,"")
		Return sout
	Else
		Return ""
	End If
End Sub

public Sub RecordExists(jSQL As SQL, TableName As String, PrimField As String, PrimValue As String) As Boolean
	Dim mr As Map = ExecuteMap(jSQL, "SELECT [" & PrimField & "] From [" & TableName & "] WHERE lower(" & PrimField & ") = ?", Array As String(PrimValue.tolowercase))
	If mr.IsInitialized = False Then
		Return False
	Else
		Return True 
	End If
End Sub

Public Sub CountRecords(jSQL As SQL, TableName As String, PrimaryField As String, PrimaryValue As String) As Int
	Dim qry As String
	qry = $"SELECT Count(*) As Records From ${TableName} WHERE lower(${PrimaryField}) = ?"$
	Dim mr As Map = ExecuteMap(jSQL, qry, Array As String(PrimaryValue.tolowercase))
	If mr.IsInitialized = False Then
		Return 0
	Else
		Return mr.Get("records") 
	End If
End Sub

public Sub ExecuteQuery(jSQL As SQL, qry As String)
	Try
		jSQL.ExecNonQuery(qry)
	Catch
		Log("ExecuteQuery: " & qry & CRLF & LastException)
	End Try
End Sub

'get a particular field contents from a table
public Sub ExecuteField(jSQL As SQL, TableName As String, FieldName As String, bIncludeBlank As Boolean,bSort As Boolean) As List
	Dim lst As List = ExecuteMaps(jSQL,"select distinct [" & FieldName & "] from [" & TableName & "] order by [" & FieldName & "]",Null)
	Dim lstCnt As Int
	Dim lstTot As Int
	Dim lstMap As Map
	Dim lstStr As String
	Dim lstOut As List
	lstOut.Initialize 
	lstTot = lst.Size - 1
	For lstCnt = 0 To lstTot
		lstMap = lst.Get(lstCnt)
		lstStr = lstMap.Get(FieldName.ToLowerCase)
		lstOut.Add(lstStr)
	Next
	If bIncludeBlank = True Then
		lstOut.Add("")
	End If
	If bSort = True Then lstOut.Sort(True)
	Return lstOut
End Sub

public Sub ExecuteField1(jSQL As SQL, Qry As String, FieldName As String, bIncludeBlank As Boolean,bSort As Boolean) As List
	Dim lst As List = ExecuteMaps(jSQL, Qry, Null)
	Dim lstCnt As Int
	Dim lstTot As Int
	Dim lstMap As Map
	Dim lstStr As String
	Dim lstOut As List
	lstOut.Initialize 
	lstTot = lst.Size - 1
	For lstCnt = 0 To lstTot
		lstMap = lst.Get(lstCnt)
		lstStr = lstMap.Get(FieldName.ToLowerCase)
		lstOut.Add(lstStr)
	Next
	If bIncludeBlank = True Then
		lstOut.Add("")
	End If
	If bSort = True Then lstOut.Sort(True)
	Return lstOut
End Sub


public Sub NextCount1(jSQL As SQL, TableName As String, PrimaryKey As String) As String
	'The SQLite coalesce function returns the first non-null expression in the list.
	Dim ll As List
	ll = ExecuteMemoryTable(jSQL, "select coalesce(max(" & PrimaryKey & "),0) as records from " & TableName,Null,1)
	Dim Cols() As String
	Cols = ll.Get(0)
	Return Cols(0)
End Sub

' get the next available record based on this key
public Sub NextAvailable(jSQL As SQL, TableName As String, PrimaryKey As String, PrimaryValue As String) As String
	Dim bExist As Boolean
	Dim mainKey As String
	Dim counter As Int
	mainKey = PrimaryValue
	bExist = RecordExists(jSQL,TableName,PrimaryKey,PrimaryValue)
	If bExist = False Then
		Return mainKey
	Else
		Do Until bExist = False
			counter = counter + 1
			PrimaryValue = mainKey & counter
			bExist = RecordExists(jSQL,TableName,PrimaryKey,PrimaryValue)
		Loop
		Return PrimaryValue
	End If
End Sub

Public Sub ExecuteMaps(jSQL As SQL, Query As String, StringArgs() As String) As List
	If Query.trim.ToLowerCase.StartsWith("select ") Then
	else If Query.trim.ToLowerCase.StartsWith("pragma ") Then
	else If Query.trim.ToLowerCase.StartsWith("show ") Then
	else If Query.trim.ToLowerCase.StartsWith("describe ") Then
	else If Query.trim.ToLowerCase.StartsWith("insert ") Then
	else If Query.trim.ToLowerCase.StartsWith("update ") Then
	else If Query.trim.ToLowerCase.StartsWith("delete ") Then
	Else
		Query = $"select * from ${Query}"$
	End If
	Dim lst As List
	lst.Initialize 
	Try
		Dim res As Map
		Dim cur As ResultSet
		If 	StringArgs <> Null Then 
			cur = jSQL.ExecQuery2(Query, StringArgs)
		Else
			cur = jSQL.ExecQuery(Query)
		End If
		Do While cur.NextRow
			res.Initialize 
			For i = 0 To cur.ColumnCount - 1
				Dim fValue As String = cur.GetString2(i)
				fValue = FixNull(fValue)
				res.Put(cur.GetColumnName(i).ToLowerCase, fValue)
			Next
			lst.Add(res)
		Loop
		cur.Close
		Return lst
	Catch
		Log(Query)
		Log("ExecuteMaps: " & LastException.Message)
		Return lst
	End Try
End Sub

private Sub ListOfMaps2JSON(lst As List) As String
	Dim sOut As String
	Dim jsonGen As JSONGenerator
    jsonGen.Initialize2(lst)
    sOut = jsonGen.ToString
	Return sOut
End Sub

Public Sub TableRecords2Maps(jSQL As SQL, tblName As String) As List
	Return ExecuteMaps(jSQL,"select * from " & tblName,Null)
End Sub

public Sub TableRecords2JSON(jSQL As SQL, tblName As String) As String
	Dim lst As List = TableRecords2Maps(jSQL,tblName)
	Dim json As String = ListOfMaps2JSON(lst)
	Return json	
End Sub

public Sub TableRecords2JSONWhere(jSQL As SQL, tblName As String, w As Map) As String
	Dim tbl As StringBuilder
	Dim args As List
	args.initialize
	tbl.initialize
	tbl.Append($"select * from ${tblName} WHERE "$)
	For i = 0 To w.Size - 1
		If i > 0 Then
			tbl.Append(" AND ")
		End If
		tbl.Append(w.GetKeyAt(i)).Append(" = ?")
		args.Add(w.GetValueAt(i))
	Next
	Dim lst As List = ExecuteMapsWhere(jSQL,tbl.tostring,args)
	Dim json As String = ListOfMaps2JSON(lst)
	Return json	
End Sub

Public Sub SQLExecuteMaps(jSQL As SQL, Query As String, StringArgs() As String) As List
	Dim lst As List
	lst.Initialize 
	Try
	Dim res As Map
	Dim cur As ResultSet
	If StringArgs <> Null Then 
		cur = jSQL.ExecQuery2(Query, StringArgs)
	Else
		cur = jSQL.ExecQuery(Query)
	End If
	Do While cur.NextRow
		res.Initialize 
		For i = 0 To cur.ColumnCount - 1
			Dim fValue As String = cur.GetString2(i)
			fValue = FixNull(fValue)
			res.Put(cur.GetColumnName(i).ToLowerCase, fValue)
		Next
		lst.Add(res)
	Loop
	cur.Close
	Catch
	Log("SQLExecuteMaps: " & LastException.Message)
	End Try
	Return lst
End Sub

'Executes the query and fills the list with the values in the first column.
Public Sub ExecuteList(jSQL As SQL, Query As String, StringArgs() As String, Limit As Int, List1 As List)
	If List1.IsInitialized = False Then List1.Initialize
	List1.clear 
	Dim Table As List
	Table = ExecuteMemoryTable(jSQL, Query, StringArgs, Limit)
	If Table.Size = 0 Then Return
	Dim Cols() As String
	For i = 0 To Table.Size - 1
		Cols = Table.Get(i)
		List1.Add(Cols(0))
	Next
End Sub





Public Sub ExecuteTableView(jSQL As SQL, Query As String, StringArgs() As String, Limit As Int, TableView1 As TableView) As Boolean
	Try
	Dim cur As ResultSet
	If StringArgs = Null Then 
		Dim StringArgs(0) As String
	End If
	cur = jSQL.ExecQuery2(Query, StringArgs)
	Dim cols As List
	cols.Initialize
	For i = 0 To cur.ColumnCount - 1
		cols.Add(cur.GetColumnName(i))
	Next
	TableView1.SetColumns(cols)
	TableView1.Items.clear
	Do While cur.NextRow
		Dim values(cur.ColumnCount) As String
		For col = 0 To cur.ColumnCount - 1
			Dim fValue As String = cur.GetString2(col)
			fValue = FixNull(fValue)
			values(col) = fValue
		Next
		TableView1.Items.Add(values)
		If Limit > 0 And TableView1.Items.Size >= Limit Then Exit
	Loop
	cur.Close
	Return True
	Catch
		Return False
	End Try
End Sub

Public Sub GetFieldNamesFromQuery(jSQL As SQL, Query As String, StringArgs() As String) As String
	Dim sb As StringBuilder
	sb.Initialize 
	Try
	Dim cur As ResultSet
	If StringArgs = Null Then 
		Dim StringArgs(0) As String
	End If
	cur = jSQL.ExecQuery2(Query, StringArgs)
	Dim cols As List
	cols.Initialize
	For i = 0 To cur.ColumnCount - 1
		sb.Append(cur.GetColumnName(i)).Append(",")
	Next
	sb.Remove(sb.Length-1,sb.Length)
	cur.Close
	Return sb.tostring
	Catch
		Return ""
	End Try
End Sub


Sub ReadField(jSQL As SQL, tablename As String, PrimaryKey As String, PrimaryValue As String, Field As String) As String
	Dim rec As Map = ReadRecord(jSQL,tablename,PrimaryKey,PrimaryValue)
	If rec.IsInitialized Then
		Field = Field.ToLowerCase
		Return rec.GetDefault(Field,"")
	Else
		Return ""
	End If 
End Sub

Sub RecordRead(jSQL As SQL, tablename As String, PrimaryKey As String, PrimaryValue As String) As Map
	Return ReadRecord(jSQL,tablename,PrimaryKey,PrimaryValue)
End Sub

Sub ReadRecord(jSQL As SQL, TableName As String, PrimaryKey As String, PrimaryValue As String) As Map
	Return ExecuteMap(jSQL, "SELECT * FROM [" & TableName & "] WHERE lower(" & PrimaryKey & ") = ?", Array As String(PrimaryValue.tolowercase))
End Sub

public Sub RecordDelete(jSQL As SQL, TableName As String, KeyField As String, KeyValue As String) As Boolean
	DeleteRecord(jSQL,TableName,KeyField,KeyValue)
	Return Not(RecordExists(jSQL,TableName,KeyField,KeyValue))
End Sub

public Sub DeleteRecord(jSQL As SQL, TableName As String, KeyField As String, KeyValue As String)
	Dim w As Map
	w.Initialize 
	w.Put(KeyField,KeyValue)
	DeleteRecordWhere(jSQL,TableName,w,True)
End Sub

Sub RecordDeleteWhere(jSQL As SQL, TableName As String, WhereFieldsEqual As Map)
	DeleteRecordWhere(jSQL, TableName, WhereFieldsEqual,True)
End Sub


'Description: Count records where
'Tag: count records
Public Sub CountRecordsWhere(jSQL As SQL, TableName As String,Field As String, WhereFieldEquals As Map) As Int
	If WhereFieldEquals.Size = 0 Then
		Log("WhereFieldEquals map empty!")
		Return 0
	End If
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append($"SELECT Count(${Field}) As records From [${TableName}] WHERE "$)
	Dim args As List
	args.Initialize
	For i = 0 To WhereFieldEquals.Size - 1
		If i > 0 Then sb.Append(" AND ")
		Dim skey As String = WhereFieldEquals.GetKeyAt(i)
		skey = $"lower(${skey})"$
		sb.Append(skey).Append(" = ?")
		Dim svalue As String = WhereFieldEquals.GetValueAt(i)
		svalue = svalue.ToLowerCase
		args.Add(svalue)
	Next
	Dim intRes As Int = jSQL.ExecQuerySingleResult2(sb.ToString,args)
	Return intRes
End Sub

Public Sub DeleteRecordWhere(jSQL As SQL, TableName As String, WhereFieldEquals As Map, bUseTransaction As Boolean)
   Dim sb As StringBuilder
   sb.Initialize
   sb.Append("DELETE FROM [").Append(TableName).Append("] WHERE ")
   If WhereFieldEquals.Size = 0 Then
      Log("WhereFieldEquals map empty!")
      Return
   End If
   Dim args As List
   args.Initialize
   For i = 0 To WhereFieldEquals.Size - 1
      If i > 0 Then sb.Append(" AND ")
      sb.Append("lower(").Append(WhereFieldEquals.GetKeyAt(i)).Append(") = ?")
	  Dim svalue As String = WhereFieldEquals.GetValueAt(i)
	  svalue = svalue.ToLowerCase
      args.Add(svalue)
   Next
   If bUseTransaction = True Then jSQL.BeginTransaction
   jSQL.ExecNonQuery2(sb.tostring,  args)
   If bUseTransaction = True Then jSQL.TransactionSuccessful
End Sub

Private Sub List2Array (a_lstArgs As List) As String()
    Dim arrArgs(a_lstArgs.Size) As String
    For i = 0 To arrArgs.Length - 1
        arrArgs(i) = a_lstArgs.Get(i)
    Next
    Return arrArgs
End Sub

Public Sub SQLSelectRecordWhereMap(jSQL As SQL, TableName As String, WhereFieldEquals As Map) As Map
   Dim lst As Map
   Dim sb As StringBuilder
   sb.Initialize
   sb.Append("SELECT * FROM ").Append(TableName).Append(" WHERE ")
   If WhereFieldEquals.Size = 0 Then
      Log("WhereFieldEquals map empty!")
      Return lst
   End If
   Dim args As List
   args.Initialize
   For i = 0 To WhereFieldEquals.Size - 1
		If i > 0 Then sb.Append(" AND ")
		Dim sKey As String = WhereFieldEquals.GetKeyAt(i)
		sKey = sKey.trim
		If sKey.EndsWith(">") Or sKey.EndsWith(">=") Or sKey.EndsWith("=") Or sKey.EndsWith("<") Or sKey.endswith("<>") Or sKey.EndsWith("<=") Then
			sKey = ""
		Else
			sKey = "="
		End If
		sb.Append(WhereFieldEquals.GetKeyAt(i)).Append(sKey).Append(" ?")
      args.Add(WhereFieldEquals.GetValueAt(i))
   Next
   Return ExecuteMap(jSQL,sb.ToString, List2Array(args))
End Sub


Sub SQLRecordExistsWhere(jSQL As SQL, TableName As String, WhereFieldEquals As Map) As Boolean
	Dim mr As Map = SQLSelectRecordWhereMap(jSQL, TableName,WhereFieldEquals)
	If mr.IsInitialized = False Then
		Return False
	Else
		Return True
	End If
End Sub

Public Sub SQLSelectRecordWhereMaps(jSQL As SQL, TableName As String, WhereFieldEquals As Map, OrderBy As String) As List
   Dim lst As List
   lst.Initialize 
   Dim sb As StringBuilder
   sb.Initialize
   If TableName.ToLowerCase.StartsWith("select ") Then
		sb.Append(TableName).Append(" WHERE ")
   Else
	   sb.Append("SELECT * FROM ").Append(TableName).Append(" WHERE ")
   End If
   If WhereFieldEquals.Size = 0 Then
      Log("WhereFieldEquals map empty!")
      Return lst
   End If
   Dim args As List
   args.Initialize
   For i = 0 To WhereFieldEquals.Size - 1
      If i > 0 Then sb.Append(" AND ")
	  Dim sKey As String = WhereFieldEquals.GetKeyAt(i)
	  sKey = sKey.Trim
	  If sKey.EndsWith(">") Or sKey.EndsWith(">=") Or sKey.EndsWith("=") Or sKey.EndsWith("<") Or sKey.endswith("<>") Or sKey.EndsWith("<=") Then
	  	sKey = ""
	  Else
	  	sKey = "="
	  End If	
	  sb.Append(WhereFieldEquals.GetKeyAt(i)).Append(sKey).Append(" ?")
      args.Add(WhereFieldEquals.GetValueAt(i))
   Next
   If OrderBy.Length > 0 Then sb.append($" ORDER BY ${OrderBy}"$)
   Return ExecuteMaps(jSQL,sb.ToString, List2Array(args))
End Sub

Public Sub ExecuteMapsWhere(jsql As SQL, sqlQuery As String, wl As List) As List
   Return ExecuteMaps(jsql,sqlQuery, List2Array(wl))
End Sub

Sub GetSQLiteTableNames(jSQL As SQL) As List
	Dim xy As List
	xy.Initialize
	ExecuteList(jSQL,"select tbl_name from sqlite_master where type = 'table' and tbl_name NOT IN ('sqlite_sequence') order by lower(tbl_name)",Null,0,xy)
	Return xy
End Sub

Sub ListRemoveItem(lst As List, item As String)
	Dim lPos As Int = lst.IndexOf(item)
	If lPos <> -1 Then lst.RemoveAt(lPos)
End Sub

Sub TableExists(jSQL As SQL, tblName As String) As Boolean
	Return SQLiteTableExists(jSQL, tblName)
End Sub

Sub TableNames(jSQL As SQL) As List
	Return GetSQLiteTableNames(jSQL)
End Sub

Sub SQLiteTableExists1(jsql As SQL, tblName As String) As Boolean
	Dim xy As List = GetSQLiteTableNames(jsql)
	For Each strTable As String In xy
		If strTable.EqualsIgnoreCase(tblName) = True Then
			Return True
		End If
	Next
	Return False
End Sub

Sub ReplaceAll(Text As String, Pattern As String, Replacement As String) As String
  Dim jo As JavaObject = Regex.Matcher(Pattern, Text)
  Return jo.RunMethod("replaceAll", Array(Replacement))
End Sub

Sub DeDuplicateMap(oldMap As Map) As Map
	Dim nMap As Map
	Dim strValue As Object
	nMap.Initialize
	For Each strKey As String In oldMap.Keys
		 strValue = oldMap.Get(strKey)
		 strKey = strKey.ToLowerCase
		If strKey <> "null" Then nMap.Put(strKey,strValue) 
	Next
	Return nMap
End Sub

Sub SQLiteResetCounter(jSQL As SQL, tblName As String, id As String)
	jSQL.BeginTransaction
	Try
		'get the last max on the table
		Dim lastmax As String = jSQL.ExecQuerySingleResult2($"SELECT MAX(${id}) FROM ${tblName}"$, Null)
		If lastmax = Null Then lastmax = 0
		'reset the counter to lastmax
		jSQL.ExecNonQuery($"UPDATE SQLITE_SEQUENCE SET SEQ=${lastmax} WHERE NAME='${tblName}'"$)
		jSQL.TransactionSuccessful
	Catch
		Log("SQLiteResetCounter: " & LastException)
		jSQL.Rollback
	End Try
End Sub




Sub InsertFile(sql As SQL, tablename As String, fldname As String, dir As String, filename As String)
	'convert the image file to a bytes array
	Dim InputStream1 As InputStream
	InputStream1 = File.OpenInput(dir, filename)
	Dim OutputStream1 As OutputStream
	OutputStream1.InitializeToBytesArray(1000)
	File.Copy2(InputStream1, OutputStream1)
	Dim Buffer() As Byte 'declares an empty array
	Buffer = OutputStream1.ToBytesArray
	'write the image to the database
	'sql.ExecNonQuery2("INSERT INTO " & tablename & " VALUES('smiley', ?)", Array As Object(Buffer))
End Sub














