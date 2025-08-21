B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.51
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Private recType As Map
	Public const DB_VARCHAR_20 As String = "VARCHAR(20)"
	Public const DB_VARCHAR_10 As String = "VARCHAR(10)"
	Public const DB_VARCHAR_30 As String = "VARCHAR(30)"
	Public const DB_VARCHAR_40 As String = "VARCHAR(40)"
	Public const DB_VARCHAR_50 As String = "VARCHAR(50)"
	Public const DB_VARCHAR_100 As String = "VARCHAR(100)"
	Public const DB_VARCHAR_255 As String = "VARCHAR(255)"
	Public const DB_STRING As String = "TEXT"
	Public const DB_INT As String = "INT"
	Public const DB_FLOAT As String = "FLOAT"
	Public const DB_BLOB As String = "BLOB"
	Public const DB_BOOL As String = "BOOL"
	Public const DB_REAL As String = "REAL"
	Public const DB_DATE As String = "DATE"
	Public const DB_INTEGER As String = "INTEGER"
	Public const DB_TEXT As String = "TEXT"
	'Public const DB_TINYINT As String = "TINYINT"
	'Public const DB_SMALLINT As String = "SMALLINT"
	'Public const DB_MEDIUMINT As String = "MEDIUMINT"
	'Public const DB_BIGINT As String = "BIGINT"
	Private BANano As BANano   'ignore
	Public MethodName As String
	Public MethodNameDynamic As String
	Private Schema As Map
	Private host As String
	Private username As String
	Private password As String
	Public DBase As String
	Public result As List
	Public command As String
	Public types As List
	Public args As List
	Public query As String
	Public response As String
	Public error As String
	Public affectedRows As Long
	Public json As String
	Public OK As Boolean
	Public TableName As String
	Public PrimaryKey As String
	Public Record As Map
	Public Auto As String
End Sub

'set database connection settings
Sub SetConnection(shost As String, susername As String, spassword As String, sdbname As String) As BANanoMySQLE
	host = shost
	username = susername
	password = spassword
	DBase = sdbname
	Return Me
End Sub

Sub RecordFromMap(sm As Map)
	Record.Initialize 
	For Each k As String In sm.Keys
		Dim v As Object = sm.Get(k)
		Record.Put(k, v)
	Next
End Sub

'convert the json
Sub FromJSON As BANanoMySQLE
	OK = False
	Dim m As Map = BANano.FromJson(json)
	response = m.Get("response")
	error = m.Get("error")
	result = m.Get("result")
	affectedRows = m.Get("affectedRows")
	If response = "Success" Then
		OK = True
	End If
	Return Me
End Sub


Sub SchemaAddField(fldName As String, fldType As String)
	Schema.Put(fldName, fldType)
End Sub


'return a sql to delete record of table where one exists
Sub GetMax As BANanoMySQLE
	Dim sb As String = $"SELECT MAX(${PrimaryKey}) As ${PrimaryKey} FROM ${EscapeField(TableName)}"$
	query = sb
	command = "getmax"
	Return Me
End Sub

'return a sql to delete record of table where one exists
Sub GetMin As BANanoMySQLE
	Dim sb As String = $"SELECT MIN(${PrimaryKey}) As ${PrimaryKey} FROM ${EscapeField(TableName)}"$
	query = sb
	command = "getmin"
	Return Me
End Sub


'get table names
Sub GetTableNames As BANanoMySQLE
	Dim sb As String = $"select table_name from information_schema.tables where table_schema = '${DBase}'"$
	query = sb
	command = "select"
	Return Me
End Sub

'get table structure
Sub GetTableStructure As BANanoMySQLE
	Dim sb As String = $"describe ${EscapeField(TableName)}"$
	query = sb
	command = "select"
	Return Me
End Sub

Sub GetNextID As String
	Dim nextid As Int
	Dim strid As String
	
	If result.Size = 0 Then
		nextid = 0
	Else
		Dim nr As Map = result.Get(0)
		Dim ni As String = nr.GetDefault(PrimaryKey,"0")
		nextid = BANano.parseInt(ni)
	End If
	nextid = nextid + 1
	strid = CStr(nextid)
	nextid = BANano.ParseInt(nextid)
	Return strid
End Sub

Sub CStr(o As Object) As String
	Return "" & o
End Sub


'initialize the class, a field named "id" is assumed to be an integer
Public Sub Initialize(dbName As String, tblName As String, PK As String, AI As String) As BANanoMySQLE
	Schema.Initialize
	recType.Initialize
	Record.Initialize 
	MethodName = "BANanoMySQL"
	MethodNameDynamic = "BANanoMySQLDynamic"
	result.Initialize
	command = ""
	PrimaryKey = PK
	DBase = dbName
	TableName = tblName
	types.Initialize
	args.Initialize
	types = Null
	args = Null
	query = ""
	response = ""
	error = ""
	affectedRows = 0
	json = ""
	OK = False
	host = ""
	username = ""
	password = ""
	Auto = AI
	Return Me
End Sub

'prepare for new table definition
Sub SchemaClear As BANanoMySQLE
	Schema.clear
	Return Me
End Sub

Sub SetField(fldName As String, fldValue As Object) As BANanoMySQLE
	Record.Put(fldName, fldValue)
	Return Me
End Sub

'schema add boolean
Sub SchemaAddBoolean(bools As List) As BANanoMySQLE
	For Each b As String In bools
		Schema.Put(b, DB_BOOL)
	Next
	AddBooleans(bools)
	Return Me
End Sub
'

Sub SchemaFromDesign(Booleans As List, Dates As List, Doubles As List, Integers As List, Strings As List) As BANanoMySQLE
	SchemaAddBoolean(Booleans)
	SchemaAddDate(Dates)
	SchemaAddFloat(Doubles)
	SchemaAddInt(Integers)
	SchemaAddText(Strings)
	'update field types
	AddStrings(Strings)
	AddIntegers(Integers)
	AddDoubles(Doubles)
	AddBooleans(Booleans)
	AddStrings(Dates)
	Return Me
End Sub


Sub SchemaAddInt(bools As List) As BANanoMySQLE
	For Each b As String In bools
		Schema.Put(b, DB_INT)
	Next
	AddIntegers(bools)
	Return Me
End Sub

Sub SchemaAddFloat(bools As List) As BANanoMySQLE
	For Each b As String In bools
		Schema.Put(b, DB_FLOAT)
	Next
	AddDoubles(bools)
	Return Me
End Sub

Sub SchemaAddBlob(bools As List) As BANanoMySQLE
	For Each b As String In bools
		Schema.Put(b, DB_BLOB)
	Next
	AddBlobs(bools)
	Return Me
End Sub

Sub SchemaAddText(bools As List) As BANanoMySQLE
	For Each b As String In bools
		Schema.Put(b, DB_STRING)
	Next
	AddStrings(bools)
	Return Me
End Sub

Sub SchemaCreateTable As BANanoMySQLE
	Return CreateTable(Schema)
End Sub

Sub SchemaAddDate(bools As List) As BANanoMySQLE
	For Each b As String In bools
		Schema.Put(b, DB_DATE)
	Next
	AddStrings(bools)
	Return Me
End Sub

'convert a json string to a map
Sub Json2Map(strJSON As String) As Map
	Dim jsonx As BANanoJSONParser
	Dim Map1 As Map
	Map1.Initialize
	Map1.clear
	Try
		If strJSON.length > 0 Then
			jsonx.Initialize(strJSON)
			Map1 = jsonx.NextObject
		End If
		Return Map1
	Catch
		Return Map1
	End Try
End Sub

'convert a map to a json string using BANanoJSONGenerator
Sub Map2Json(mp As Map) As String
	Dim jsonx As BANanoJSONGenerator
	jsonx.Initialize(mp)
	Return jsonx.ToString
End Sub


'excape fields with ``
Private Sub EscapeField(f As String) As String
	Return $"`${f}`"$
End Sub

'return string for test connection operation
Sub Connection As BANanoMySQLE
	command = "connection"
	Return Me
End Sub

' return string to create database
Sub CreateDatabase As BANanoMySQLE
	Dim sSQL As String = $"CREATE DATABASE IF NOT EXISTS ${EscapeField(DBase)}"$
	query = sSQL
	command = "createdb"
	Return Me
End Sub

'drop the database
Sub DropDataBase As BANanoMySQLE
	Dim sSQL As String = $"DROP DATABASE ${EscapeField(DBase)}"$
	query = sSQL
	command = "dropdb"
	Return Me
End Sub

Sub Execute(strSQL As String) As BANanoMySQLE
	query = strSQL
	command = "execute"
	Return Me
End Sub

'return a sql command to create the table
public Sub CreateTable(tblFields As Map) As BANanoMySQLE
	Dim fldName As String
	Dim fldType As String
	Dim fldTot As Int
	Dim fldCnt As Int
	fldTot = tblFields.Size - 1
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("(")
	For fldCnt = 0 To fldTot
		fldName = tblFields.GetKeyAt(fldCnt)
		fldType = tblFields.Get(fldName)
		fldType = fldType.Replace("STRING", "TEXT")
		fldType = fldType.Replace("TEXT", "VARCHAR(255)")
		If fldCnt > 0 Then
			sb.Append(", ")
		End If
		sb.Append(EscapeField(fldName))
		sb.Append(" ")
		sb.Append(fldType)
		If fldName.EqualsIgnoreCase(PrimaryKey) Then
			sb.Append(" NOT NULL PRIMARY KEY")
		End If
		If fldName.EqualsIgnoreCase(Auto) Then
			sb.Append(" AUTO_INCREMENT")
		End If
	Next
	sb.Append(")")
	'define the qry to execute
	query = "CREATE TABLE IF NOT EXISTS " & EscapeField(TableName) & " " & sb.ToString
	command = "createtable"
	Return Me
End Sub

'return sql command to drop a table
public Sub DropTable As BANanoMySQLE
	'define the qry to execute
	query = "DROP TABLE " & EscapeField(TableName)
	command = "droptable"
	Return Me
End Sub


'get the list of types
private Sub GetMapTypes(sourceMap As Map) As List
	Dim listOfTypes As List
	listOfTypes.Initialize
	Dim iCnt As Int
	Dim iTot As Int
	iTot = sourceMap.Size - 1
	For iCnt = 0 To iTot
		Dim col As String = sourceMap.GetKeyAt(iCnt)
		Dim colType As String = recType.GetDefault(col,"STRING")
		Select Case colType
			Case "INTEGER", "INT", "BOOL","BOOLEAN"
				listOfTypes.add("i")
			Case "BLOB"
				listOfTypes.add("b")
			Case "REAL","FLOAT","DOUBLE"
				listOfTypes.add("d")
			Case Else
				listOfTypes.add("s")
		End Select
	Next
	Return listOfTypes
End Sub


private Sub GetMapType(k As String) As String
	If recType.ContainsKey(k) Then
		Dim colType As String = recType.GetDefault(k, "STRING")
		Select Case colType
			Case "INTEGER", "INT", "BOOL","BOOLEAN"
				Return "i"
			Case "BLOB"
				Return "b"
			Case "REAL","FLOAT","DOUBLE"
				Return "d"
			Case Else
				Return "s"
		End Select
	Else
		Return "s"
	End If
End Sub

'get map values
private Sub GetMapValues(sourceMap As Map) As List
	Dim listOfValues As List
	listOfValues.Initialize
	Dim iCnt As Int
	Dim iTot As Int
	iTot = sourceMap.Size - 1
	For iCnt = 0 To iTot
		'get the value
		Dim key As String = sourceMap.getkeyat(iCnt)
		Dim value As String = sourceMap.GetValueAt(iCnt)
		value = CStr(value)
		value = value.trim
		'get the type
		Dim vtype As String = GetMapType(key)
		Select Case vtype
			Case "i"
				'integer
				If value = "" Then value = "0"
				value = BANano.parseInt(value)
			Case "d"
				'double
				If value = "" Then value = "0"
				value = BANano.parsefloat(value)
			Case "s", "b"
				'string
		End Select
		listOfValues.Add(value)
	Next
	Return listOfValues
End Sub

'get map keys to a list
private Sub GetMapKeys(sourceMap As Map) As List
	Dim listOfValues As List
	listOfValues.Initialize
	Dim iCnt As Int
	Dim iTot As Int
	iTot = sourceMap.Size - 1
	For iCnt = 0 To iTot
		Dim value As String = sourceMap.GetKeyAt(iCnt)
		listOfValues.Add(value)
	Next
	Return listOfValues
End Sub


'return a sql insert statement
Sub Insert As BANanoMySQLE
	Insert1(Record)
	Return Me
End Sub

'return a sql insert statement
Sub Insert1(Rec As Map) As BANanoMySQLE
	If Schema.Size = 0 Then
		Log($"BANanoMySQL.Insert: '${TableName}' schema is not set!"$)
	End If	
	Dim sb As StringBuilder
	Dim columns As StringBuilder
	Dim values As StringBuilder
	Dim listOfValues As List = GetMapValues(Rec)
	Dim listOfTypes As List = GetMapTypes(Rec)
	Dim iCnt As Int
	Dim iTot As Int
	sb.Initialize
	columns.Initialize
	values.Initialize
	sb.Append($"INSERT INTO ${EscapeField(TableName)} ("$)
	iTot = Rec.Size - 1
	For iCnt = 0 To iTot
		Dim col As String = Rec.GetKeyAt(iCnt)
		If iCnt > 0 Then
			columns.Append(", ")
			values.Append(", ")
		End If
		columns.Append(EscapeField(col))
		values.Append("?")
	Next
	sb.Append(columns.ToString)
	sb.Append(") VALUES (")
	sb.Append(values.ToString)
	sb.Append(")")
	query = sb.ToString
	args = listOfValues
	types = listOfTypes
	command = "insert"
	Return Me
End Sub



'return a sql insert statement
Sub InsertReplace As BANanoMySQLE
	Dim sb As StringBuilder
	Dim columns As StringBuilder
	Dim values As StringBuilder
	Dim listOfValues As List = GetMapValues(Record)
	Dim listOfTypes As List = GetMapTypes(Record)
	Dim iCnt As Int
	Dim iTot As Int
	sb.Initialize
	columns.Initialize
	values.Initialize
	sb.Append($"REPLACE INTO ${EscapeField(TableName)} ("$)
	iTot = Record.Size - 1
	For iCnt = 0 To iTot
		Dim col As String = Record.GetKeyAt(iCnt)
		If iCnt > 0 Then
			columns.Append(", ")
			values.Append(", ")
		End If
		columns.Append(EscapeField(col))
		values.Append("?")
	Next
	sb.Append(columns.ToString)
	sb.Append(") VALUES (")
	sb.Append(values.ToString)
	sb.Append(")")
	query = sb.ToString
	args = listOfValues
	types = listOfTypes
	command = "replace"
	Return Me
End Sub

'delete a single value based on the primary key
Sub Delete(primaryValue As String) As BANanoMySQLE
	Dim qw As Map = CreateMap()
	qw.Put(PrimaryKey, primaryValue)
	DeleteWhere(TableName, qw, Array("="))
	Return Me
End Sub


'join list to multi value string
private Sub JoinFields(delimiter As String, lst As List) As String
	Dim i As Int
	Dim sb As StringBuilder
	Dim fld As String
	sb.Initialize
	fld = lst.Get(0)
	fld = EscapeField(fld)
	sb.Append(fld)
	For i = 1 To lst.size - 1
		Dim fld As String = lst.Get(i)
		fld = EscapeField(fld)
		sb.Append(delimiter).Append(fld)
	Next
	Return sb.ToString
End Sub

'join list to mv string
private Sub Join(delimiter As String, lst As List) As String
	Dim i As Int
	Dim sb As StringBuilder
	Dim fld As String
	sb.Initialize
	fld = lst.Get(0)
	sb.Append(fld)
	For i = 1 To lst.size - 1
		Dim fld As String = lst.Get(i)
		sb.Append(delimiter).Append(fld)
	Next
	Return sb.ToString
End Sub

'read
Sub Read(primaryValue As String) As BANanoMySQLE
	Dim qw As Map = CreateMap()
	qw.Put(PrimaryKey, primaryValue)
	SelectWhere(TableName, Array("*"), qw, Null, Array(PrimaryKey))
	Return Me
End Sub

'exists
Sub Exists(primaryValue As String) As BANanoMySQLE
	Dim qw As Map = CreateMap()
	qw.Put(PrimaryKey, primaryValue)
	SelectWhere(TableName, Array(PrimaryKey), qw, Null, Array(PrimaryKey))
	Return Me
End Sub

'return a sql to select record of table where one exists
Sub SelectWhere(tblName As String, tblfields As List, tblWhere As Map, operators As List, orderBy As List) As BANanoMySQLE
	If Schema.Size = 0 Then
		Log($"BANanoMySQL.SelectWhere: '${tblName}' schema is not set!"$)
	End If
	If operators = Null Then operators = EQOperators(tblWhere)
	Dim listOfTypes As List = GetMapTypes(tblWhere)
	Dim listOfValues As List = GetMapValues(tblWhere)
	'are we selecting all fields or just some
	Dim fld1 As String = tblfields.Get(0)
	Dim selFIelds As String = ""
	Select Case fld1
		Case "*"
			selFIelds = "*"
		Case Else
			selFIelds = JoinFields(",", tblfields)
	End Select
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append($"SELECT ${selFIelds} FROM ${EscapeField(tblName)} WHERE "$)
	Dim i As Int
	Dim iWhere As Int = tblWhere.Size - 1
	For i = 0 To iWhere
		If i > 0 Then
			sb.Append(" AND ")
		End If
		Dim col As String = tblWhere.GetKeyAt(i)
		Dim oper As String = operators.Get(i)
		sb.Append(EscapeField(col))
		sb.Append($" ${oper} ?"$)
	Next
	If orderBy <> Null Then
		'order by
		Dim stro As String = JoinFields(",", orderBy)
		If stro.Length > 0 Then
			sb.Append(" ORDER BY ").Append(stro)
		End If
	End If
	query = sb.tostring
	args = listOfValues
	types = listOfTypes
	command = "select"
	Return Me
End Sub

'return a sql to select record of table where one exists
Sub SelectDistinctWhere(tblName As String, tblfields As List, tblWhere As Map, operators As List, orderBy As List) As BANanoMySQLE
	If Schema.Size = 0 Then
		Log($"BANanoMySQL.SelectWhere: '${tblName}' schema is not set!"$)
	End If
	If operators = Null Then operators = EQOperators(tblWhere)
	Dim listOfTypes As List = GetMapTypes(tblWhere)
	Dim listOfValues As List = GetMapValues(tblWhere)
	'are we selecting all fields or just some
	Dim fld1 As String = tblfields.Get(0)
	Dim selFIelds As String = ""
	Select Case fld1
		Case "*"
			selFIelds = "*"
		Case Else
			selFIelds = JoinFields(",", tblfields)
	End Select
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append($"SELECT DISTINCT ${selFIelds} FROM ${EscapeField(tblName)} WHERE "$)
	Dim i As Int
	Dim iWhere As Int = tblWhere.Size - 1
	For i = 0 To iWhere
		If i > 0 Then
			sb.Append(" AND ")
		End If
		Dim col As String = tblWhere.GetKeyAt(i)
		Dim oper As String = operators.Get(i)
		sb.Append(EscapeField(col))
		sb.Append($" ${oper} ?"$)
	Next
	If orderBy <> Null Then
		'order by
		Dim stro As String = JoinFields(",", orderBy)
		If stro.Length > 0 Then
			sb.Append(" ORDER BY ").Append(stro)
		End If
	End If
	query = sb.tostring
	args = listOfValues
	types = listOfTypes
	command = "select"
	Return Me
End Sub

'return a sql to delete record of table where one exists
Sub DeleteAll As BANanoMySQLE
	Dim sb As String = $"DELETE FROM ${EscapeField(TableName)}"$
	query = sb
	command = "delete"
	Return Me
End Sub

private Sub EQOperators(sm As Map) As List  'ignore
	Dim nl As List
	nl.initialize
	For Each k As String In sm.Keys
		nl.Add("=")
	Next
	Return nl
End Sub


'return a sql to delete record of table where one exists
Sub DeleteWhere(tblName As String, tblWhere As Map, operators As List) As BANanoMySQLE
	If Schema.Size = 0 Then
		Log($"BANanoMySQL.DeleteWhere: '${tblName}' schema is not set!"$)
	End If	
	If operators = Null Then operators = EQOperators(tblWhere)
	Dim listOfTypes As List = GetMapTypes(tblWhere)
	Dim listOfValues As List = GetMapValues(tblWhere)
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append($"DELETE FROM ${EscapeField(tblName)} WHERE "$)
	Dim i As Int
	Dim iWhere As Int = tblWhere.Size - 1
	For i = 0 To iWhere
		If i > 0 Then
			sb.Append(" AND ")
		End If
		Dim col As String = tblWhere.GetKeyAt(i)
		sb.Append(EscapeField(col))
		Dim opr As String = operators.Get(i)
		sb.Append($" ${opr} ?"$)
	Next
	query = sb.tostring
	args = listOfValues
	types = listOfTypes
	command = "delete"
	Return Me
End Sub


'return a sql to select record of table where one exists
Sub SelectAll(tblfields As List, orderBy As List) As BANanoMySQLE
	'are we selecting all fields or just some
	Dim fld1 As String = tblfields.Get(0)
	Dim selFIelds As String = ""
	Select Case fld1
		Case "*"
			selFIelds = "*"
		Case Else
			selFIelds = JoinFields(",", tblfields)
	End Select
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append($"SELECT ${selFIelds} FROM ${EscapeField(TableName)}"$)
	If orderBy <> Null Then
		'order by
		Dim stro As String = JoinFields(",", orderBy)
		If stro.Length > 0 Then
			sb.Append(" ORDER BY ").Append(stro)
		End If
	End If
	query = sb.tostring
	command =  "select"
	Return Me
End Sub

'return a sql to select record of table where one exists
Sub SelectDistinctAll(tblfields As List, orderBy As List) As BANanoMySQLE
	'are we selecting all fields or just some
	Dim fld1 As String = tblfields.Get(0)
	Dim selFIelds As String = ""
	Select Case fld1
		Case "*"
			selFIelds = "*"
		Case Else
			selFIelds = JoinFields(",", tblfields)
	End Select
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append($"SELECT DISTINCT ${selFIelds} FROM ${EscapeField(TableName)}"$)
	If orderBy <> Null Then
		'order by
		Dim stro As String = JoinFields(",", orderBy)
		If stro.Length > 0 Then
			sb.Append(" ORDER BY ").Append(stro)
		End If
	End If
	query = sb.tostring
	command =  "select"
	Return Me
End Sub

Sub Build As Map
	Dim b As Map = CreateMap()
	b.Put("command", command)
	b.Put("query", query)
	b.Put("args", args)
	b.Put("types", types)
	Return b
End Sub

'build with connection settings
Sub BuildDynamic As Map
	Dim b As Map = CreateMap()
	b.Put("command", command)
	b.Put("query", query)
	b.Put("args", args)
	b.Put("types", types)
	b.put("host", host)
	b.Put("username", username)
	b.Put("password", password)
	b.Put("dbname", DBase)
	Return b
End Sub


'specify strings field types, this is default for all strings
private Sub AddStrings(fieldNames As List) As BANanoMySQLE
	For Each strfld As String In fieldNames
		recType.Put(strfld,"STRING")
	Next
	Return Me
End Sub

'specify integer field types
private Sub AddIntegers(fieldNames As List) As BANanoMySQLE
	For Each strfld As String In fieldNames
		recType.Put(strfld,"INT")
	Next
	Return Me
End Sub

'specify double field types
private Sub AddDoubles(fieldNames As List) As BANanoMySQLE
	For Each strfld As String In fieldNames
		recType.Put(strfld,"DOUBLE")
	Next
	Return Me
End Sub

'specify double field types
private Sub AddBooleans(fieldNames As List) As BANanoMySQLE
	For Each strfld As String In fieldNames
		recType.Put(strfld,"BOOL")
	Next
	Return Me
End Sub

Sub FirstRecord As Map
	Dim rec As Map = result.Get(0)
	Return rec
End Sub

'specify blob field types
private Sub AddBlobs(fieldNames As List) As BANanoMySQLE
	For Each strfld As String In fieldNames
		recType.Put(strfld,"BLOB")
	Next
	Return Me
End Sub

Sub Update(priValue As String) As BANanoMySQLE
	Dim tblWhere As Map = CreateMap()
	tblWhere.Put(PrimaryKey, priValue)
	UpdateWhere(TableName, Record, tblWhere, Null)
	Return Me
End Sub

Sub Update1(Rec As Map, priValue As String) As BANanoMySQLE
	Dim tblWhere As Map = CreateMap()
	tblWhere.Put(PrimaryKey, priValue)
	UpdateWhere(TableName, Rec, tblWhere, Null)
	Return Me
End Sub

'return a sql to update records of table where one exists
Sub UpdateWhere(tblName As String, tblfields As Map, tblWhere As Map, operators As List) As BANanoMySQLE
	If Schema.Size = 0 Then
		Log($"BANanoMySQL.UpdateWhere: '${tblName}' schema is not set!"$)
	End If	
	If operators = Null Then operators = EQOperators(tblWhere)
	Dim listOfTypes As List = GetMapTypes(tblfields)
	Dim listOfTypes1 As List = GetMapTypes(tblWhere)
	listOfTypes.AddAll(listOfTypes1)
	Dim listOfValues As List = GetMapValues(tblfields)
	Dim listOfValues1 As List = GetMapValues(tblWhere)
	listOfValues.AddAll(listOfValues1)
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append($"UPDATE ${EscapeField(tblName)} SET "$)
	Dim i As Int
	Dim iTot As Int = tblfields.Size - 1
	For i = 0 To iTot
		Dim col As String = tblfields.GetKeyAt(i)
		sb.Append(EscapeField(col))
		If i <> iTot Then
			sb.Append("= ?,")
		Else
			sb.Append("= ?")
		End If
	Next
	sb.Append($" WHERE "$)
	Dim iWhere As Int = tblWhere.Size - 1
	For i = 0 To iWhere
		If i > 0 Then
			sb.Append(" AND ")
		End If
		Dim col As String = tblWhere.GetKeyAt(i)
		sb.Append(EscapeField(col))
		Dim opr As String = operators.Get(i)
		sb.Append($" ${opr} ?"$)
	Next
	query = sb.tostring
	args = listOfValues
	types = listOfTypes
	command = "update"
	Return Me
End Sub


'return a sql to update all records of table
Sub UpdateAll(tblFields As Map, operators As List) As BANanoMySQLE
	If operators = Null Then operators = EQOperators(tblFields)
	Dim listOfTypes As List = GetMapTypes(tblFields)
	Dim args As List = GetMapValues(tblFields)
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append($"UPDATE ${EscapeField(TableName)} SET "$)
	Dim i As Int
	Dim iTot As Int = tblFields.Size - 1
	For i = 0 To iTot
		Dim col As String = tblFields.GetKeyAt(i)
		Dim oper As String = operators.Get(i)
		sb.Append(col)
		If i <> iTot Then
			sb.Append(" = ?,")
		Else
			sb.Append($" ${oper} ?"$)
		End If
	Next
	query = sb.tostring
	args = args
	types = listOfTypes
	command = "update"
	Return Me
End Sub

#if PHP
function prepareMySQL($conn, $query, $types, $args) {
	//paramater types to execute
	/* Bind parameters. Types: s = string, i = integer, d = double,  b = blob */
	$stmt = $conn->prepare($query);
	if(is_array($types)){
		$a_params = array();
		$param_type = '';
		$n = count($types);
		for($i = 0; $i < $n; $i++) {
			$param_type .= $types[$i];
		}
		$a_params[] = & $param_type;
		//values to execute
		for($i = 0; $i < $n; $i++) {
			$a_params[] = & $args[$i];
		}
		call_user_func_array(array($stmt, 'bind_param'), $a_params);
	}
	return $stmt;
}

function BANanoMySQL($command, $query, $args, $types) {
	$resp = array();
	header('Access-Control-Allow-Origin: *');
	header('content-type: application/json; charset=utf-8');
	require_once './assets/config.php';
    //connect To MySQL
    $conn = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);
    //we cannot connect Return an error
    if ($conn->connect_error) {
        $response = $conn->connect_error;
        $resp['response'] = "Error";
		$resp['error'] = $response;
		$resp['result'] = array();
		$output = json_encode($resp);
        die($output);
    }
    mysqli_set_charset($conn, 'utf8');
    //$query = mysqli_real_escape_string($conn, $query);
    $commands = array('delete', 'update', 'replace', 'insert', 'connection', 'createdb', 'dropdb', 'createtable', 'droptable');
    if (in_array($command, $commands)) {
        $command = 'changes';
    }
    switch ($command) {
    case "changes":
        $stmt = prepareMySQL($conn, $query, $types, $args);
        if (! $stmt -> execute()) {
			$response = $stmt->error;
        	$resp['response'] = "Error";
			$resp['error'] = $response;
			$resp['result'] = array();
			$output = json_encode($resp);
	        die($output);
		}
	
		$affRows = $conn->affected_rows;
    	$resp['response'] = "Success";
		$resp['error'] = '';
		$resp['result'] = array();
		$resp['affectedRows'] = $affRows;
		$output = json_encode($resp);
        break;
    default:
        $stmt = prepareMySQL($conn, $query, $types, $args);
        //$result = $stmt->execute();
		//$result = $stmt->get_result();
        
		if (!($result = $stmt->execute())) {
			$response = $stmt->error;
        	$resp['response'] = "Error";
			$resp['error'] = $response;
			$resp['result'] = array();
			$output = json_encode($resp);
	        die($output);
		}
		
		if (!($result = $stmt->get_result())) {
			$response = $stmt->error;
        	$resp['response'] = "Error";
			$resp['error'] = $response;
			$resp['result'] = array();
			$output = json_encode($resp);
	        die($output);
		}
		
		$affRows = $conn->affected_rows;
    	$rows = array();
        while ($row = $result->fetch_assoc()) {
            $rows[] = $row;
        }
    	$resp['response'] = "Success";
		$resp['error'] = '';
		$resp['result'] = $rows;
		$resp['affectedRows'] = $affRows;
		$output = json_encode($resp);
        break;
	}
	echo ($output);
    $stmt->close();
    $conn->close();
}

function BANanoMySQLDynamic($command, $query, $args, $types, $host, $username, $password, $dbname) {
	$resp = array();
	header('Access-Control-Allow-Origin: *');
	header('content-type: application/json; charset=utf-8');
	//connect To MySQL
    $conn = new mysqli($host, $username, $password, $dbname);
    //we cannot connect Return an error
    if ($conn->connect_error) {
        $response = $conn->connect_error;
        $resp['response'] = "Error";
		$resp['error'] = $response;
		$resp['result'] = array();
		$output = json_encode($resp);
        die($output);
    }
    mysqli_set_charset($conn, 'utf8');
    $commands = array('delete', 'update', 'replace', 'insert', 'connection', 'createdb', 'dropdb', 'createtable', 'droptable');
    if (in_array($command, $commands)) {
        $command = 'changes';
    }
    switch ($command) {
    case "changes":
        $stmt = prepareMySQL($conn, $query, $types, $args);
        if (! $stmt -> execute()) {
			$response = $stmt->error;
        	$resp['response'] = "Error";
			$resp['error'] = $response;
			$resp['result'] = array();
			$output = json_encode($resp);
	        die($output);
		}
	
		$affRows = $conn->affected_rows;
    	$resp['response'] = "Success";
		$resp['error'] = '';
		$resp['result'] = array();
		$resp['affectedRows'] = $affRows;
		$output = json_encode($resp);
        break;
    default:
        $stmt = prepareMySQL($conn, $query, $types, $args);
        //$result = $stmt->execute();
		//$result = $stmt->get_result();
        
		if (!($result = $stmt->execute())) {
			$response = $stmt->error;
        	$resp['response'] = "Error";
			$resp['error'] = $response;
			$resp['result'] = array();
			$output = json_encode($resp);
	        die($output);
		}
		
		if (!($result = $stmt->get_result())) {
			$response = $stmt->error;
        	$resp['response'] = "Error";
			$resp['error'] = $response;
			$resp['result'] = array();
			$output = json_encode($resp);
	        die($output);
		}
		
		$affRows = $conn->affected_rows;
    	$rows = array();
        while ($row = $result->fetch_assoc()) {
            $rows[] = $row;
        }
    	$resp['response'] = "Success";
		$resp['error'] = '';
		$resp['result'] = $rows;
		$resp['affectedRows'] = $affRows;
		$output = json_encode($resp);
        break;
	}
	echo ($output);
    $stmt->close();
    $conn->close();
}
#end if