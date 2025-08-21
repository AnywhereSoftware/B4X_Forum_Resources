B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.1
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Public const DB_BOOL As String = "BOOL"
	Public const DB_INT As String = "INT"
	Public const DB_STRING As String = "STRING"
	Public const DB_REAL As String = "REAL"
	Public const DB_DATE As String = "DATE"
	Public const DB_BLOB As String = "BLOB"
	Public const DB_FLOAT As String = "FLOAT"
	Public const DB_INTEGER As String = "INTEGER"
	Public const DB_TEXT As String = "TEXT"
	Private recType As Map
	Private BANano As BANano  'ignore
	Private Schema As Map
	Private TableName As String
	Private PrimaryKey As String
	Public response As String
	Public result As List
	Public command As String
	Public types As List
	Public args As List
	Public query As String
	Public json As String
	Public error As String
	Public affectedRows As Long
	Public Record As Map
	Public OK As Boolean
End Sub

'simplified version
public Sub Initialize(tblName As String, priKey As String) As BANanoAlaSQLE
	recType.Initialize
	Schema.Initialize
	TableName = tblName
	PrimaryKey = priKey
	response = ""
	result.initialize
	command = ""
	types = Null
	args = Null
	query = ""
	json = ""
	error = ""
	affectedRows = 0
	Record.initialize
	OK = False
	Return Me
End Sub


Sub SchemaAddBlob(bools As List) As BANanoAlaSQLE
	For Each b As String In bools
		Schema.Put(b, DB_BLOB)
	Next
	AddBlobs(bools)
	Return Me
End Sub


'schema add boolean
Sub SchemaAddBoolean(bools As List) As BANanoAlaSQLE
	For Each b As String In bools
		Schema.Put(b, DB_BOOL)
	Next
	AddBooleans(bools)
	Return Me
End Sub


Sub SchemaAddDate(bools As List) As BANanoAlaSQLE
	For Each b As String In bools
		Schema.Put(b, DB_DATE)
	Next
	AddStrings(bools)
	Return Me
End Sub


Sub SchemaAddFloat(bools As List) As BANanoAlaSQLE
	For Each b As String In bools
		Schema.Put(b, DB_FLOAT)
	Next
	AddDoubles(bools)
	Return Me
End Sub

Sub SchemaAddText(bools As List) As BANanoAlaSQLE
	For Each b As String In bools
		Schema.Put(b, DB_STRING)
	Next
	AddStrings(bools)
	Return Me
End Sub



Sub SchemaAddInt(bools As List) As BANanoAlaSQLE
	For Each b As String In bools
		Schema.Put(b, DB_INT)
	Next
	AddIntegers(bools)
	Return Me
End Sub

Sub SchemaAddField(fldName As String, fldType As String)
	Schema.Put(fldName, fldType)
End Sub

Sub SetField(fldName As String, fldValue As Object) As BANanoAlaSQLE
	Record.Put(fldName, fldValue)
	Return Me
End Sub

Sub RecordFromMap(sm As Map)
	Record.Initialize
	For Each k As String In sm.Keys
		Dim v As Object = sm.Get(k)
		Record.Put(k, v)
	Next
End Sub


Sub FirstRecord As Map
	Dim rec As Map = result.Get(0)
	Return rec
End Sub


'convert the json
Sub FromJSON As BANanoAlaSQLE
	response = "Success"
	error = ""
	affectedRows = result.size
	OK = True
	Return Me
End Sub

Sub Update(priValue As String) As BANanoAlaSQLE
	Dim tblWhere As Map = CreateMap()
	tblWhere.Put(PrimaryKey, priValue)
	UpdateWhere(Record, tblWhere, Null)
	Return Me
End Sub

Sub Update1(rec As Map, priValue As String) As BANanoAlaSQLE
	Dim tblWhere As Map = CreateMap()
	tblWhere.Put(PrimaryKey, priValue)
	UpdateWhere(rec, tblWhere, Null)
	Return Me
End Sub


'prepare for new table definition
Sub SchemaClear As BANanoAlaSQLE
	Schema.clear
	Return Me
End Sub

Sub SchemaAddBlobs(blobs As List) As BANanoAlaSQLE
	SchemaAddBlob(blobs)
	Return Me
End Sub


Sub SchemaAddBooleans(bools As List) As BANanoAlaSQLE
	SchemaAddBoolean(bools)
	Return Me
End Sub


Sub SchemaAddIntegers(ints As List) As BANanoAlaSQLE
	SchemaAddInt(ints)
	Return Me
End Sub

Sub SchemaAddDoubles(dbls As List) As BANanoAlaSQLE
	SchemaAddFloat(dbls)
	Return Me
End Sub


Sub SchemaAddDates(dates As List) As BANanoAlaSQLE
	SchemaAddDate(dates)
	Return Me
End Sub

Sub SchemaAddStrings(strings As List) As BANanoAlaSQLE
	SchemaAddText(strings)
	Return Me
End Sub

'
Sub SchemaFromDesign(Booleans As List, Dates As List, Doubles As List, Integers As List, Strings As List) As BANanoAlaSQLE
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

Sub ResetTypes As BANanoAlaSQLE
	recType.Initialize
	Return Me
End Sub

Sub GetNextID As String
	Dim nextid As Int
	Dim strid As String
	
	If result.Size = 0 Then
		nextid = 0
	Else
		Dim nr As Map = result.Get(0)
		Dim ni As String = nr.Getdefault(PrimaryKey,"0")
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


'specify strings field types, this is default for all strings
Sub AddStrings(fieldNames As List) As BANanoAlaSQLE
	For Each strfld As String In fieldNames
		recType.Put(strfld,"STRING")
	Next
	Return Me
End Sub

'specify integer field types
Sub AddIntegers(fieldNames As List) As BANanoAlaSQLE
	For Each strfld As String In fieldNames
		recType.Put(strfld,"INT")
	Next
	Return Me
End Sub

'specify double field types
Sub AddDoubles(fieldNames As List) As BANanoAlaSQLE
	For Each strfld As String In fieldNames
		recType.Put(strfld,"DOUBLE")
	Next
	Return Me
End Sub

'specify boolean field types
Sub AddBooleans(fieldNames As List) As BANanoAlaSQLE
	For Each strfld As String In fieldNames
		recType.Put(strfld,"BOOL")
	Next
	Return Me
End Sub

'specify blobs field types
Sub AddBlobs(fieldNames As List) As BANanoAlaSQLE
	For Each strfld As String In fieldNames
		recType.Put(strfld,"BLOB")
	Next
	Return Me
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

'get map keys
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

Sub Delete(primaryValue As String) As BANanoAlaSQLE
	Dim qw As Map = CreateMap()
	qw.Put(PrimaryKey, primaryValue)
	DeleteWhere(qw, Array("="))
	Return Me
End Sub

Private Sub EscapeField(f As String) As String
	Return $"[${f}]"$
End Sub

Sub SchemaCreateTable As BANanoAlaSQLE
	CreateTable(Schema)
	Return Me
End Sub

'return a sql command to create the table
public Sub CreateTable(tblFields As Map) As BANanoAlaSQLE
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
		If fldCnt > 0 Then
			sb.Append(", ")
		End If
		sb.Append(EscapeField(fldName))
		sb.Append(" ")
		sb.Append(fldType)
		If fldName.EqualsIgnoreCase(PrimaryKey) Then
			sb.Append(" PRIMARY KEY")
		End If
	Next
	sb.Append(")")
	'define the qry to execute
	query = "CREATE TABLE IF NOT EXISTS " & EscapeField(TableName) & " " & sb.ToString
	args = Null
	types = Null
	command = "createtable"
	response = ""
	error = ""
	result = NewList
	json = ""
	affectedRows = 0
	Return Me
End Sub


Sub NewList As List
	Dim lst As List
	lst.Initialize
	Return lst
End Sub

'insert multiple records commands, pass the list name on ExecuteSQL
Sub InsertList As BANanoAlaSQLE
	Dim sSQL As String = $"SELECT * INTO [${TableName}] FROM ?"$
	query = sSQL
	args = Null
	types = Null
	command = "insert"
	response = ""
	error = ""
	result = NewList
	json = ""
	affectedRows = 0
	Return Me
End Sub

'return a sql to delete record of table where one exists
Sub GetMax As BANanoAlaSQLE
	Dim sb As String = $"SELECT MAX([${PrimaryKey}]) As [${PrimaryKey}] FROM ${EscapeField(TableName)}"$
	query = sb
	args = Null
	types = Null
	command = "getmax"
	response = ""
	error = ""
	result = NewList
	json = ""
	affectedRows = 0
	Return Me
End Sub

'return a sql to delete record of table where one exists
Sub GetMin As BANanoAlaSQLE
	Dim sb As String = $"SELECT MIN([${PrimaryKey}]) As [${PrimaryKey}] FROM ${EscapeField(TableName)}"$
	query = sb
	args = Null
	types = Null
	command = "getmin"
	response = ""
	error = ""
	result = NewList
	json = ""
	affectedRows = 0
	Return Me
End Sub


'return sql command to drop a table
public Sub DropTable As BANanoAlaSQLE
	'define the qry to execute
	query = "DROP TABLE " & EscapeField(TableName)
	args = Null
	types = Null
	response = ""
	error = ""
	command = "droptable"
	result = NewList
	json = ""
	affectedRows = 0
	Return Me
End Sub

Sub Execute(strSQL As String) As BANanoAlaSQLE
	strSQL = strSQL.trim
	query = strSQL
	args = Null
	types = Null
	command = "execute"
	response = ""
	error = ""
	result = NewList
	json = ""
	affectedRows = 0
	Return Me
End Sub

'return a sql map to insert record to table. sql = query string, values = list of values
Sub Insert As BANanoAlaSQLE
	Insert1(Record)
	Return Me
End Sub

'return a sql map to insert record to table. sql = query string, values = list of values
Sub Insert1(Rec As Map) As BANanoAlaSQLE
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
	response = ""
	error = ""
	result = NewList
	json = ""
	affectedRows = 0
	Return Me
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


Sub EQOperators(sm As Map) As List    'ignore
	Dim nl As List
	nl.initialize
	For Each k As String In sm.Keys
		nl.Add("=")
	Next
	Return nl
End Sub

'return a sql to update records of table where one exists
Sub UpdateWhere(tblfields As Map, tblWhere As Map, operators As List) As BANanoAlaSQLE
	If operators = Null Then operators = EQOperators(tblWhere)
	Dim listOfTypes As List = GetMapTypes(tblfields)
	Dim listOfTypes1 As List = GetMapTypes(tblWhere)
	listOfTypes.AddAll(listOfTypes1)
	Dim listOfValues As List = GetMapValues(tblfields)
	Dim listOfValues1 As List = GetMapValues(tblWhere)
	listOfValues.AddAll(listOfValues1)
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append($"UPDATE ${EscapeField(TableName)} SET "$)
	Dim i As Int
	Dim iTot As Int = tblfields.Size - 1
	For i = 0 To iTot
		Dim col As String = tblfields.GetKeyAt(i)
		sb.Append(EscapeField(col))
		If i <> iTot Then
			sb.Append(" = ?,")
		Else
			sb.Append(" = ?")
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
	response = ""
	error = ""
	result = NewList
	json = ""
	affectedRows = 0
	Return Me
End Sub

'return a sql to delete record of table where one exists
Sub DeleteWhere(tblWhere As Map, operators As List) As BANanoAlaSQLE
	If operators = Null Then operators = EQOperators(tblWhere)
	Dim listOfTypes As List = GetMapTypes(tblWhere)
	Dim listOfValues As List = GetMapValues(tblWhere)
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append($"DELETE FROM ${EscapeField(TableName)} WHERE "$)
	Dim i As Int
	Dim iWhere As Int = tblWhere.Size - 1
	For i = 0 To iWhere
		If i > 0 Then
			sb.Append(" AND ")
		End If
		Dim col As String = tblWhere.GetKeyAt(i)
		sb.Append(col)
		Dim opr As String = operators.Get(i)
		sb.Append($" ${opr} ?"$)
	Next
	query = sb.tostring
	args = listOfValues
	types = listOfTypes
	command = "delete"
	response = ""
	error = ""
	result = NewList
	json = ""
	affectedRows = 0
	Return Me
End Sub

'return a sql to delete record of table where one exists
Sub DeleteAll As BANanoAlaSQLE
	Dim sb As String = $"DELETE FROM ${EscapeField(TableName)} WHERE 1=1"$
	query = sb
	args = Null
	types = Null
	command = "delete"
	response = ""
	error = ""
	result = NewList
	json = ""
	affectedRows = 0
	Return Me
End Sub


'convert a map to a json string
Sub Map2Json(mp As Map) As String
	Dim xjson As BANanoJSONGenerator
	xjson.Initialize(mp)
	Return xjson.ToString
End Sub

'convert a list to json
Sub List2Json(mp As List) As String
	Dim xjson As BANanoJSONGenerator
	xjson.Initialize2(mp)
	Return xjson.ToString
End Sub

' convert a json string to a list
Sub Json2List(strValue As String) As List
	Dim lst As List
	lst.Initialize
	lst.clear
	If strValue.Length = 0 Then
		Return lst
	End If
	Try
		Dim parser As BANanoJSONParser
		parser.Initialize(strValue)
		Return parser.NextArray
	Catch
		Return lst
	End Try
End Sub

'Return a SQL To update all records of table
Sub UpdateAll(tblFields As Map, operators As List) As BANanoAlaSQLE
	If operators = Null Then operators = EQOperators(tblFields)
	Dim listOfTypes As List = GetMapTypes(tblFields)
	Dim args As List = GetMapValues(tblFields)
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append($"UPDATE ${EscapeField(TableName)} SET "$)
	Dim i As Int
	Dim iTot As Int = tblFields.Size - 1
	For i = 0 To iTot
		Dim oper As String = operators.Get(i)
		Dim col As String = tblFields.GetKeyAt(i)
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
	response = ""
	error = ""
	result = NewList
	json = ""
	affectedRows = 0
	Return Me
End Sub


Sub Read(primaryValue As String) As BANanoAlaSQLE
	Dim qw As Map = CreateMap()
	qw.Put(PrimaryKey, primaryValue)
	SelectWhere(Array("*"), qw, Array("="), Array(PrimaryKey))
	Return Me
End Sub

'exists
Sub Exists(primaryValue As String) As BANanoAlaSQLE
	Dim qw As Map = CreateMap()
	qw.Put(PrimaryKey, primaryValue)
	SelectWhere(Array(PrimaryKey), qw, Array("="), Array(PrimaryKey))
	Return Me
End Sub


'return a sql to delete record of table where one exists
Sub GetMaxWhere(fldName As String, tblWhere As Map, operators As List) As BANanoAlaSQLE
	If operators = Null Then operators = EQOperators(tblWhere)
	Dim listOfTypes As List = GetMapTypes(tblWhere)
	Dim listOfValues As List = GetMapValues(tblWhere)
	'
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append($"SELECT MAX([${fldName}]) As [${fldName}] FROM ${EscapeField(TableName)} WHERE "$)
	Dim i As Int
	Dim iWhere As Int = tblWhere.Size - 1
	For i = 0 To iWhere
		If i > 0 Then
			sb.Append(" AND ")
		End If
		Dim col As String = tblWhere.GetKeyAt(i)
		sb.Append(col)
		Dim opr As String = operators.Get(i)
		sb.Append($" ${opr} ?"$)
	Next
	
	query = sb.tostring
	args = listOfValues
	types = listOfTypes
	command = "getmax"
	response = ""
	error = ""
	result = NewList
	json = ""
	affectedRows = 0
	Return Me
End Sub

'return a sql to select record of table where one exists
Sub SelectWhere(tblfields As List, tblWhere As Map, operators As List, orderBy As List) As BANanoAlaSQLE
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
	sb.Append($"SELECT ${selFIelds} FROM ${EscapeField(TableName)} WHERE "$)
	Dim i As Int
	Dim iWhere As Int = tblWhere.Size - 1
	For i = 0 To iWhere
		If i > 0 Then
			sb.Append(" AND ")
		End If
		Dim col As String = tblWhere.GetKeyAt(i)
		sb.Append(col)
		Dim opr As String = operators.Get(i)
		sb.Append($" ${opr} ?"$)
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
	response = ""
	error = ""
	result = NewList
	json = ""
	affectedRows = 0
	Return Me
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

'return a sql to select record of table where one exists
Sub SelectAll(tblfields As List, orderBy As List) As BANanoAlaSQLE
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
	args = Null
	types = Null
	command = "select"
	response = ""
	error = ""
	result = NewList
	json = ""
	affectedRows = 0
	Return Me
End Sub