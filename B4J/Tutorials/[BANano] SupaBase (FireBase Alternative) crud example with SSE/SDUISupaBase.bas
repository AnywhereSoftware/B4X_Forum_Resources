B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
#Event: Changes (eventType As String, New As Map, Old As Map, TableName As String)

#IgnoreWarnings:12
Sub Class_Globals
	Public const DB_BOOL As String = "BOOL"
	Public const DB_INT As String = "INT"
	Public const DB_STRING As String = "STRING"
	Public const DB_REAL As String = "REAL"
	Public const DB_BLOB As String = "BLOB"
	Public const DB_FLOAT As String = "FLOAT"
	Public const DB_INTEGER As String = "INTEGER"
	Public const DB_TEXT As String = "TEXT"
	Public const DB_DOUBLE As String = "DOUBLE"
	'
	Private mCallBack As Object			'ignore
	Private whereField As Map
	Private ops As List
	Private orderByL As Map
	Private flds As List
	Public RowCount As Int
	Private lastPosition As Int
	Public Record As Map
	Public result As List
	Private BANano As BANano 'ignore
	Public Success As Boolean
	Private client As BANanoObject
	Private mEvent As String
	Private sTableName As String
	Public Tag As Object
	Public Schema As Map
	Public PrimaryKey As String
	Public DisplayField As String
	Public Singular As String
	Public Plural As String
	Public DisplayValue As String
	Private supabase As BANanoObject 
End Sub

'<code>
''initialize the connection to pocketbase with a collection to access
'pb.Initialize(Me, "pb", "link", "apikey")
'</code>
Public Sub Initialize(Module As Object, eventName As String, url As String, sapiKey As String) As SDUISupaBase
	mCallBack = Module
	whereField.Initialize
	ops.Initialize
	orderByL.Initialize
	flds.Initialize
	Record.Initialize
	lastPosition = -1
	result.Initialize
	mEvent = eventName
	PrimaryKey = "id"
	Schema.Initialize
	SchemaAddText1("id")
	supabase.Initialize("supabase")
	client = supabase.RunMethod("createClient", Array(url, sapiKey))
	Return Me
End Sub

Sub setTableName(s As String)
	sTableName = s
End Sub

Sub SchemaAddBlob(bools As List) As SDUISupaBase
	For Each b As String In bools
		Schema.Put(b, DB_BLOB)
	Next
	Return Me
End Sub

Sub SchemaAddBlob1(b As String) As SDUISupaBase
	Schema.Put(b, DB_BLOB)
	Return Me
End Sub
'schema add boolean
Sub SchemaAddBoolean(bools As List) As SDUISupaBase
	For Each b As String In bools
		Schema.Put(b, DB_BOOL)
	Next
	Return Me
End Sub
Sub SchemaAddBoolean1(b As String) As SDUISupaBase
	Schema.Put(b, DB_BOOL)
	Return Me
End Sub
Sub SchemaAddDouble1(b As String) As SDUISupaBase
	Schema.Put(b, DB_DOUBLE)
	Return Me
End Sub
'add double fields
Sub SchemaAddDouble(bools As List) As SDUISupaBase
	For Each b As String In bools
		Schema.Put(b, DB_DOUBLE)
	Next
	Return Me
End Sub
Sub SchemaAddFloat1(b As String) As SDUISupaBase
	Schema.Put(b, DB_FLOAT)
	Return Me
End Sub
Sub SchemaAddFloat(bools As List) As SDUISupaBase
	For Each b As String In bools
		Schema.Put(b, DB_FLOAT)
	Next
	Return Me
End Sub
Sub SchemaAddText1(b As String) As SDUISupaBase
	Schema.Put(b, DB_STRING)
	Return Me
End Sub
Sub SchemaAddText(bools As List) As SDUISupaBase
	For Each b As String In bools
		Schema.Put(b, DB_STRING)
	Next
	Return Me
End Sub
Sub SchemaAddInt1(b As String) As SDUISupaBase
	Schema.Put(b, DB_INT)
	Return Me
End Sub
Sub SchemaAddInt(bools As List) As SDUISupaBase
	For Each b As String In bools
		Schema.Put(b, DB_INT)
	Next
	Return Me
End Sub

Sub SetField(fldName As String, fldValue As Object) As SDUISupaBase
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

'clear where clause
Sub CLEAR_WHERE As SDUISupaBase
	whereField.Initialize
	ops.Initialize
	orderByL.Initialize
	flds.Initialize
	Return Me
End Sub

Sub ADD_FIELD(fld As String) As SDUISupaBase
	flds.Add(fld)
	Return Me
End Sub

Sub ADD_FIELDS(fields As List) As SDUISupaBase
	For Each fld As String In fields
		ADD_FIELD(fld)
	Next
	Return Me
End Sub

'add a where clause for your select where
Sub ADD_WHERE(fld As String, operator As String, value As Object) As SDUISupaBase
	Select Case operator
	Case "="
		operator = "eq"
	Case "<>"
		operator = "neq"
	Case ">"
		operator = "gt"
	Case ">="
		operator = "gte"
	Case "<"
		operator = "lt"
	Case "<="
		operator = "lte"
	End Select
	whereField.Put(fld, value)
	ops.Add(operator)
	Return Me
End Sub

Sub ADD_WHERE_STRING(fld As String, operator As String, value As Object) As SDUISupaBase
	ADD_WHERE(fld, operator, $"'${value}'"$)
	Return Me
End Sub

'add a sort field
Sub ADD_ORDER_BY(fld As String, ascending As Boolean) As SDUISupaBase
	orderByL.put(fld, ascending)
	Return Me
End Sub

'<code>
'Do while rs.NextRow
'Loop
'</code>
Sub NextRow As Boolean
	lastPosition = lastPosition + 1
	Dim realSize As Int = RowCount - 1
	If lastPosition > realSize Then
		Return False
	Else
		setPosition(lastPosition)
		Return True
	End If
End Sub

Sub SetRecord(rec As Map)
	For Each k As String In rec.Keys
		Dim v As Object = rec.Get(k)
		SetField(k, v)
	Next
End Sub

'prepare a new record
Sub PrepareRecord
	Record.Initialize
End Sub

'set the position of the current record
Sub setPosition(pos As Int)
	If result.Size > pos Then
		Record = result.Get(pos)
		lastPosition = pos
	Else
		lastPosition = -1
		Record.Initialize
	End If
End Sub

Sub getPosition As Int
	Return lastPosition
End Sub

'get an integer from the current record
Sub GetInt(fld As String) As Int
	fld = fld.tolowercase
	If BANano.IsUndefined(Record) Then Return 0
	If Record.ContainsKey(fld) Then
		Dim obj As Int = Record.GetDefault(fld, 0)
		obj = SDUIShared.CInt(obj)
		Return obj
	Else
		Return 0
	End If
End Sub

'get a long from the current record
Sub GetLong(fld As String) As Long
	Return GetInt(fld)
End Sub

'get a string from the current record
Sub GetString(fld As String) As String
	fld = fld.tolowercase
	If BANano.IsUndefined(Record) Then Return ""
	If Record.ContainsKey(fld) Then
		Dim obj As String = Record.GetDefault(fld, "")
		obj = SDUIShared.cstr(obj)
		Return obj
	Else
		Return ""
	End If
End Sub

'returns a placeholder if there is no image
Sub GetImage(fld As String) As String
	Dim simage As String = GetString(fld)
	If simage = "" Then Return "./assets/placeholderimg.jpg"
	Return simage
End Sub

'get a boolean from the current record
Sub GetBoolean(fld As String) As Boolean
	fld = fld.tolowercase
	If BANano.IsUndefined(Record) Then Return False
	If Record.ContainsKey(fld) Then
		Dim obj As Boolean = Record.GetDefault(fld, False)
		obj = SDUIShared.parseBool(obj)
		Return obj
	Else
		Return False
	End If
End Sub

'get a double from the current record
Sub GetDouble(fld As String) As Double
	fld = fld.tolowercase
	If Record.ContainsKey(fld) Then
		Dim obj As Double = Record.GetDefault(fld, 0)
		obj = SDUIShared.CDbl(obj)
		Return obj
	Else
		Return 0
	End If
End Sub

'get record at position
Sub GetRecord(pos As Int) As Map
	Dim rec As Map = result.Get(pos)
	Return rec
End Sub

'movefirst
Sub MoveFirst
	setPosition(0)
End Sub

'movelast
Sub MoveLast
	setPosition(RowCount - 1)
End Sub

'moveprevious
Sub MovePrevious
	lastPosition = lastPosition - 1
	If lastPosition < 0 Then
		lastPosition = 0
	End If
	setPosition(lastPosition)
End Sub

'movenext
Sub MoveNext
	lastPosition = lastPosition + 1
	If lastPosition > RowCount Then
		lastPosition = RowCount - 1
	End If
	setPosition(lastPosition)
End Sub

'define the real record from the db record
'using the schema defined fields
Sub AssignRealRecord(dbRecord As Map)
	Record.Initialize
	For Each k As String In Schema.Keys
		Dim v As Object = dbRecord.Get(k)
		Record.Put(k, v)
	Next
	DisplayValue = Record.GetDEfault(DisplayField, "")
End Sub

'get records from a collection
'<code>
'BANano.Await(supabase.SELECT_ALL)
'Do while supabase.NextRow
'Loop
'</code>
Sub SELECT_ALL As List
	If Schema.Size = 0 Then
		BANano.Throw($"SDUISupaBase.SELECT_ALL. Please execute SchemaAdd?? first to define your table schema!"$)
		Return Null
	End If
	lastPosition = -1
	result.Initialize
	'
	Try
		Dim sflds As String = SDUIShared.Join(",", flds)
		If sflds = "" Then sflds = "*"
		
		Dim tclient As BANanoObject = client.RunMethod("from", sTableName)
		If orderByL.Size = 0 Then
			Dim out As Map = BANano.await(tclient.RunMethod("select", sflds))
			result = out.Get("data")
		Else
			tclient = tclient.RunMethod("select", sflds)
			For Each k As String In orderByL.Keys
				Dim v As Boolean = orderByL.Get(k)
				Dim sopt As Map = CreateMap()
				sopt.Put("ascending", v)
				tclient = tclient.RunMethod("order", Array(k, sopt))
			Next
			Dim out As Map = BANano.await(tclient)
			result = out.Get("data")
		End If		
	Catch
	End Try			'ignore
	RowCount = result.Size
	Return result
End Sub
'
'get records from a collection
'<code>
'supabase.CLEAR_WHERE
'supabase.ADD_FIELD("id")
'supabase.ADD_FIELD("title")
'supabase.ADD_WHERE("finished", "=", True)
'supabase.ADD_ORDER_BY("title", True)
'Dim lst As List = BANano.Await(supabase.SELECT_WHERE)
'</code>
Sub SELECT_WHERE As List
	If Schema.Size = 0 Then
		BANano.Throw($"SDUISupaBase.SELECT_ALL. Please execute SchemaAdd?? first to define your table schema!"$)
		Return Null
	End If
	Dim res As List
	res.Initialize 
	'
	'Try
		Dim sflds As String = SDUIShared.Join(",", flds)
		If sflds = "" Then sflds = "*"
		
		Dim tclient As BANanoObject = client.RunMethod("from", sTableName)
		tclient = tclient.RunMethod("select", sflds)
		'
		If whereField.Size > 0 Then
			Dim i As Int
			Dim iWhere As Int = whereField.Size - 1
			For i = 0 To iWhere
				Dim col As String = whereField.GetKeyAt(i)
				Dim val As String = whereField.GetValueAt(i)
				Dim opr As String = ops.Get(i)
				tclient = tclient.RunMethod(opr, Array(col, val))
			Next
		End If
		
		If orderByL.Size > 0 Then
			For Each k As String In orderByL.Keys
				Dim v As Boolean = orderByL.Get(k)
				Dim sopt As Map = CreateMap()
				sopt.Put("ascending", v)
				tclient = tclient.RunMethod("order", Array(k, sopt))
			Next
		End If
		Dim out As Map = BANano.await(tclient)
		res = out.Get("data")
	'Catch
	'End Try			'ignore
	Return res
End Sub



'record is saved as json string
'returns the record id
'<code>
'supabase.PrepareRecord
'supabase.SetField("a", "xxxx")
'supabase.SetField("b", "ddd")
'dim bAdded As Boolean = BANano.Await(supabase.CREATE)
'</code>
Sub CREATE As Boolean
	If Schema.Size = 0 Then
		BANano.Throw($"SDUISupaBase.CREATE. Please execute SchemaAdd?? first to define your table schema!"$)
		Return False
	End If
	Try
		Dim tclient As BANanoObject = client.RunMethod("from", sTableName)
	    Dim out As Map = BANano.await(tclient.RunMethod("insert", Record))
		Dim status As String = out.Get("status")
		status = SDUIShared.CStr(status)
		If status = "201" Then
			'added
			Return True
		Else
			Return False
		End If
	Catch
		Return False
	End Try
End Sub

'record is saved as json string
'returns the record id
'<code>
'supabase.PrepareRecord
'supabase.SetField("id", 9)
'supabase.SetField("a", "xxxx")
'supabase.SetField("b", "ddd")
'dim bUpdated As Boolean = BANano.Await(supabase.UPDATE)
'</code>
Sub UPDATE As Boolean
	If Schema.Size = 0 Then
		BANano.Throw($"SDUISupaBase.UPDATE. Please execute SchemaAdd?? first to define your table schema!"$)
		Return Null
	End If
	Try
		Dim id As String = Record.Get("id")
		Dim tclient As BANanoObject = client.RunMethod("from", sTableName)
		Record.Remove("id")
		tclient = tclient.RunMethod("update", Record)
		Dim out As Map = BANano.await(tclient.RunMethod("eq", Array(PrimaryKey, id)))
		Dim status As String = out.Get("status")
		status = SDUIShared.CStr(status)
		If status = "204" Then
			'added
			Return True
		Else
			Return False
		End If
	Catch
		Return False
	End Try
End Sub

Sub UnSubscribeAll
	client.RunMethod("removeAllChannels", Null)
End Sub

Sub Subscribe
	If sTableName = "" Then
		BANano.Throw($"SDUISupaBase.Subscribe. The tablename has not been specified!"$)
		Return
	End If
	Dim opt As Map = CreateMap()
	opt.Put("event", "*")
	opt.Put("schema", "public")
	opt.Put("table", sTableName)
	Dim channel As BANanoObject = client.RunMethod("channel", "*")
	Dim payload As Map
	Dim cb As BANanoObject = BANano.CallBack(Me, "Changes", Array(payload))
	channel.RunMethod("on", Array("postgres_changes", opt, cb))
	channel.RunMethod("subscribe", Null)
End Sub

Private Sub Changes (payload As Map)
	Dim seventType As String = payload.Get("eventType")
	Dim mnew As Map = payload.Get("new")
	Dim mold As Map = payload.Get("old")
	Dim stable As String = payload.Get("table")
	BANano.CallSub(mCallBack, $"${mEvent}_changes"$, Array( seventType, mnew, mold, stable))
End Sub







'record is saved as json string
'returns the record id
'<code>
'dim bUpdated As Boolean = BANano.Await(supabase.DELETE(9))
'</code>
Sub DELETE(id As String) As Boolean
	If Schema.Size = 0 Then
		BANano.Throw($"SDUISupaBase.DELETE. Please execute SchemaAdd?? first to define your table schema!"$)
		Return Null
	End If
	Try
		Dim tclient As BANanoObject = client.RunMethod("from", sTableName)
		tclient = tclient.RunMethod("delete", Null)
		Dim out As Map = BANano.await(tclient.RunMethod("eq", Array(PrimaryKey, id)))
		Dim status As String = out.Get("status")
		status = SDUIShared.CStr(status)
		If status = "204" Then
			Return True
		Else
			Return False
		End If
	Catch
		Return False
	End Try
End Sub

'get a value using key
'<code>
'Dim res As Map = BANano.Await(supabase.READ("name"))
'</code>
Sub READ(id As String) As Map
	If Schema.Size = 0 Then
		BANano.Throw($"SDUISupaBase.READ. Please execute SchemaAdd?? first to define your table schema!"$)
		Return Null
	End If
	'
	Dim m As Map = CreateMap()
	CLEAR_WHERE
	ADD_WHERE("id", "=", id)
	Dim lst As List = BANano.Await(SELECT_WHERE)
	If lst.Size > 0 Then
		m = lst.Get(0)
	End If
	AssignRealRecord(m)
	Return m
End Sub

'Execute a where clause on the records
'The result is a list with the values.
'<code>
'Dim WhereRecords As List = BANano.Await(supabase.findWhereOrderBy(m, array("="), orderBy)
'</code>
Sub findWhereOrderBy(whereMap As Map, whereOps As List, orderBy As List) As List
	If Schema.Size = 0 Then
		BANano.Throw($"SDUISupaBase.findWhereOrderBy. Please execute SchemaAdd?? first to define your table schema!"$)
		Return Null
	End If
	'
	CLEAR_WHERE
	whereField = whereMap
	ops = whereOps
	If BANano.IsNull(orderBy) = False Then
		For Each s As String In orderBy
			ADD_ORDER_BY(s, True)
		Next
	End If
	Dim nl As List = BANano.Await(SELECT_WHERE)
	Return nl
End Sub
'
'Execute a where clause on the records
'The result is a list with the values.
'<code>
'Dim WhereRecords As List = BANano.Await(kvs.findWhereOR(m, array("="))
'</code>
Sub findWhere(whereMap As Map, whereOps As List) As List
	Dim res As List = BANano.Await(findWhereOrderBy(whereMap, whereOps, Null))
	Return res
End Sub


'Execute a delete clause on the records
'<code>
'BANano.Await(supabase.deleteWhere("id", m, array("=")))
'</code>
Sub deleteWhere(priKey As String, whereMap As Map, whereOps As List) As Boolean
	If Schema.Size = 0 Then
		BANano.Throw($"SDUISupaBase.deleteWhere. Please execute SchemaAdd?? first to define your table schema!"$)
		Return Null
	End If
	'get all the records
	Dim recs As List = BANano.Await(findWhere(whereMap, whereOps))
	For Each rec As Map In recs
		Dim pvalue As String = rec.Get(priKey)
		BANano.Await(DELETE(pvalue))
	Next
	Return True
End Sub

Sub DELETE_WHERE
	deleteWhere("id", whereField, ops)
End Sub