B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
#IgnoreWarnings:12
#Event: Table_On (data As Map, id as string)
#Event: Table_Once (data As Map, id as string)
#Event: Table_Put (ack As Map)
#Event: Table_Set (ack As Map)
#Event: Table_UnSet (ack As Map)
#Event: Table_Exists (key As Object)
#Event: Table_Open (data As Map)
#Event: Table_Load (data As Map)
'
Sub Class_Globals
	Private BANano As BANano 'ignore
	Public collection As BANanoObject
	Public sTableName As String
	Public Record As Map
	Public RowCount As Int
	Private lastPosition As Int
	Public result As List
	Public Schema As Map
	Public PrimaryKey As String
	Public DisplayField As String
	Public Singular As String
	Public Plural As String
	Public DisplayValue As String
	Private whereField As Map
	Private ops As List
	Private orderByL As List
	Private flds As List
	Public const DB_BOOL As String = "BOOL"
	Public const DB_INT As String = "INT"
	Public const DB_STRING As String = "STRING"
	Public const DB_REAL As String = "REAL"
	Public const DB_BLOB As String = "BLOB"
	Public const DB_FLOAT As String = "FLOAT"
	Public const DB_INTEGER As String = "INTEGER"
	Public const DB_TEXT As String = "TEXT"
	Public const DB_DOUBLE As String = "DOUBLE"
	Private combineL As List
	Private mCallBack As Object
	Private g As BANanoObject
End Sub

Public Sub Initialize(Module As Object, gun As BANanoObject, collName As String) As SithasoGunDBCollection
	lastPosition = -1
	g = gun
	mCallBack = Module
	Record = CreateMap()
	whereField.Initialize
	ops.Initialize
	orderByL.Initialize
	flds.Initialize
	lastPosition = -1
	result.Initialize
	combineL.Initialize
	PrimaryKey = "id"
	SchemaAddText1("id")
	sTableName = collName
	If collName <> "" Then collection = gun.RunMethod("get", collName)
	Return Me
End Sub


'link to an existing collection
Sub LinkExisting(collName As String, collExist As BANanoObject)
	collection = collExist
	sTableName = collName
End Sub

'Get a collection within this collection
'Sub GetCollection(collName As String) As SithasoGunDBCollection
'	Dim coll As BANanoObject = collection.RunMethod("get", collName)
'	Dim gcollection As SithasoGunDBCollection
'	gcollection.Initialize(mCallBack, g, "")
'	gcollection.LinkExisting(collName, coll)
'	Return gcollection
'End Sub

'get a collection from the gun instance
Sub Get(collName As String) As SithasoGunDBCollection
	Dim boList As List
	boList.Initialize
	boList.Add(collection)
	Dim paths As List = modGunDB.StrParse(".", collName)
	Dim tPaths As Int = paths.Size - 1
	Dim cPath As Int = 0
	For cPath = 0 To tPaths
		'get the last item
		Dim pObject As BANanoObject = boList.Get(cPath)
		Dim nPart As String = paths.Get(cPath)
		Dim ni As BANanoObject = pObject.RunMethod("get", nPart)
		boList.Add(ni)
		collName = nPart
	Next
	'
	tPaths = boList.Size - 1
	Dim coll As BANanoObject = boList.Get(tPaths)
	Dim gcollection As SithasoGunDBCollection
	gcollection.Initialize(mCallBack, g, "")
	gcollection.LinkExisting(collName, coll)
	Return gcollection
End Sub

'subscribe to the collection and real time updates
'will be called many times
'<code>
'Sub collectionName_on (data As Map, id As String)
'End Sub
'</code>
Sub On As SithasoGunDBCollection
	Dim data As Map
	Dim id As String
	Dim cb As BANanoObject = BANano.CallBack(mCallBack, $"${sTableName}_On"$, Array(data, id))
	collection.RunMethod("on", cb)
	Return Me
End Sub

'will be called many times and loads document full depth
'this is realtime
'<code>
'Sub collectionName_open (data As Map)
'End Sub
'</code>
Sub Open As SithasoGunDBCollection
	Dim data As Map
	Dim id As String
	Dim cb As BANanoObject = BANano.CallBack(mCallBack, $"${sTableName}_open"$, Array(data, id))
	collection.RunMethod("open", cb)
	Return Me
End Sub

'loads document full depth once
'<code>
'Sub collectionName_load (data As List)
'collection.MoveStart
'Do while collection.NextRow
'Loop
'End Sub
'</code>
Sub Load As SithasoGunDBCollection
	Dim data As Map
	Dim cb As BANanoObject = BANano.CallBack(Me, "LoadedX", Array(data))
	collection.RunMethod("load", cb)
	Return Me
End Sub

private Sub LoadedX(data As Map)
	result.Initialize 
	lastPosition = - 1
	For Each k As String In data.Keys
		Dim v As Map = data.Get(k)
		If BANano.IsMap(v) Then
			v.Put("id", k)
		End If
		result.Add(v)
	Next
	RowCount = result.size
	BANano.CallSub(mCallBack, $"${sTableName}_load"$, Array(data))
End Sub

'move to this node
Sub Path(sPath As String) As SithasoGunDBCollection
	Dim ref As BANanoObject = collection.RunMethod("path", sPath)
	Dim gcollection As SithasoGunDBCollection
	gcollection.Initialize(mCallBack, g, "")
	Dim collName As String = modGunDB.MvField(sPath,-1,".")
	gcollection.LinkExisting(collName, ref)
	Return gcollection
End Sub

'if a key exists or not
'<code>
'Sub collectionName_exists (Key As Object)
'End Sub
'</code>
Sub Exists As SithasoGunDBCollection
	Dim key As String
	Dim cb As BANanoObject = BANano.CallBack(mCallBack, $"${sTableName}_exists"$, Array(key))
	collection.RunMethod("not", cb)
	Return Me
End Sub

'get the data once. This is 1 layer deep
'<code>
'Sub collectionName_once (data As Map, id As String)
'End Sub
'</code>
Sub Once As SithasoGunDBCollection
	Dim data As Map
	Dim id As String
	Dim cb As BANanoObject = BANano.CallBack(mCallBack, $"${sTableName}_Once"$, Array(data, id))
	collection.RunMethod("once", cb)
	Return Me
End Sub

'call the map()
'use this if you wont use the collection again
Sub ForEach As SithasoGunDBCollection
	'execute the map call and return a new collection
	Dim ncol As BANanoObject = collection.RunMethod("map", Null)
	Dim gcollection As SithasoGunDBCollection
	gcollection.Initialize(mCallBack, g, "")
	gcollection.LinkExisting(sTableName, ncol)
	Return gcollection
End Sub

'set a key value pair on the gun object
Sub Create As BANanoPromise
	Dim skey As String = Record.Get(PrimaryKey)
	Dim bp As BANanoPromise = collection.RunMethod("get", skey).RunMethod("put", Record).RunMethod("then", Null)
	Return bp
End Sub

'execute put for the Record when using SetField
'<code>
'Sub collectionName_put (data As Map)
'End Sub
'</code>
Sub PutRecord
	Dim ack As Map
	Dim cb As BANanoObject = BANano.CallBack(mCallBack, $"${sTableName}_put"$, Array(ack))
	collection.RunMethod("put", Array(Record, cb))
End Sub

'set off event listener
Sub Off
	collection.RunMethod("off", Null)
End Sub

'go 1 level up
Sub Back
	collection.RunMethod("back", Null)
End Sub

'execute a soft delete
'<code>
'Sub collectionName_put (data As Map)
'End Sub
'</code>
Sub Delete As SithasoGunDBCollection
	Dim m As Map = CreateMap()
	m.put("deleted", True)
	Return Put(m)
End Sub

'execute a soft delete
'<code>
'Sub collectionName_put (data As Map)
'End Sub
'</code>
Sub UnDelete As SithasoGunDBCollection
	Dim m As Map = CreateMap()
	m.put("deleted", False)
	Return Put(m)
End Sub

'execute a put using own object
'<code>
'Sub collectionName_put (data As Map)
'End Sub
'</code>
Sub Put(rec As Object) As SithasoGunDBCollection
	Dim ack As Map
	Dim cb As BANanoObject = BANano.CallBack(mCallBack, $"${sTableName}_put"$, Array(ack))
	Dim bo As BANanoObject = rec
	Dim sname As String = bo.GetField("constructor").GetField("name").result
	Select Case sname
	Case "banano_sithasogundb_sithasogundbcollection"
		'we have passed the actual object
		Dim coll As SithasoGunDBCollection = rec
		collection.RunMethod("put", Array(coll.collection, cb))
		Return coll
	Case Else
		collection.RunMethod("put", Array(rec, cb))
		Return Me
	End Select
End Sub

'remove a record from the set
'<code>
'Sub collectionName_unset (data As Map)
'End Sub
'</code>
Sub UnSet(rec As Object) As SithasoGunDBCollection
	Dim ack As Map
	Dim cb As BANanoObject = BANano.CallBack(mCallBack, $"${sTableName}_unset"$, Array(ack))
	Dim bo As BANanoObject = rec
	Dim sname As String = bo.GetField("constructor").GetField("name").result
	Select Case sname
		Case "banano_sithasogundb_sithasogundbcollection"
			'we have passed the actual object
			Dim coll As SithasoGunDBCollection = rec
			collection.RunMethod("unset", Array(coll.collection, cb))
			Return coll
		Case Else
			collection.RunMethod("unset", Array(rec, cb))
			Return Me
	End Select
End Sub

'insert a record to the set
'<code>
'Sub collectionName_set (data As Map)
'End Sub
'</code>
Sub Set(rec As Object) As SithasoGunDBCollection
	Dim ack As Map
	Dim cb As BANanoObject = BANano.CallBack(mCallBack, $"${sTableName}_set"$, Array(ack))
	Dim bo As BANanoObject = rec
	Dim sname As String = bo.GetField("constructor").GetField("name").result
	Select Case sname
	Case "banano_sithasogundb_sithasogundbcollection"
		'we have passed the actual object
		Dim coll As SithasoGunDBCollection = rec
		collection.RunMethod("set", Array(coll.collection, cb))
		Return coll
	Case Else
		collection.RunMethod("set", Array(rec, cb))
		Return Me
	End Select
End Sub

'Sub Read(key As String) As BANanoPromise
'	Dim bp As BANanoPromise = collection.RunMethod("get", key).RunMethod("once", Null).RunMethod("then", Null)
'	Return bp
'End Sub
'
'Sub Delete(key As String) As BANanoPromise
'	Dim del As Map = CreateMap()
'	del.Put("deleted", True)
'	Dim bp As BANanoPromise = collection.RunMethod("get", key).RunMethod("put", del).RunMethod("then", Null)
'	Return bp
'End Sub

Sub SchemaAddBlob(bools As List) As SithasoGunDBCollection
	For Each b As String In bools
		Schema.Put(b, DB_BLOB)
	Next
	Return Me
End Sub

Sub SchemaAddBlob1(b As String) As SithasoGunDBCollection
	Schema.Put(b, DB_BLOB)
	Return Me
End Sub

Sub SchemaAddBoolean(bools As List) As SithasoGunDBCollection
	For Each b As String In bools
		Schema.Put(b, DB_BOOL)
	Next
	Return Me
End Sub

Sub SchemaAddBoolean1(b As String) As SithasoGunDBCollection
	Schema.Put(b, DB_BOOL)
	Return Me
End Sub

Sub SchemaAddDouble1(b As String) As SithasoGunDBCollection
	Schema.Put(b, DB_DOUBLE)
	Return Me
End Sub

Sub SchemaAddDouble(bools As List) As SithasoGunDBCollection
	For Each b As String In bools
		Schema.Put(b, DB_DOUBLE)
	Next
	Return Me
End Sub

Sub SchemaAddFloat1(b As String) As SithasoGunDBCollection
	Schema.Put(b, DB_FLOAT)
	Return Me
End Sub

Sub SchemaAddFloat(bools As List) As SithasoGunDBCollection
	For Each b As String In bools
		Schema.Put(b, DB_FLOAT)
	Next
	Return Me
End Sub

Sub SchemaAddText1(b As String) As SithasoGunDBCollection
	Schema.Put(b, DB_STRING)
	Return Me
End Sub

Sub SchemaAddText(bools As List) As SithasoGunDBCollection
	For Each b As String In bools
		Schema.Put(b, DB_STRING)
	Next
	Return Me
End Sub

Sub SchemaAddInt1(b As String) As SithasoGunDBCollection
	Schema.Put(b, DB_INT)
	Return Me
End Sub

Sub SchemaAddInt(bools As List) As SithasoGunDBCollection
	For Each b As String In bools
		Schema.Put(b, DB_INT)
	Next
	Return Me
End Sub

'set schema from data models
Sub SetSchemaFromDataModel(models As Map)
	If models.ContainsKey(sTableName) = False Then
		BANano.Throw($"SetSchemaFromDataModel.${sTableName} data-model does NOT exist!"$)
		Return
	End If
	Dim tm As Map = models.Get(sTableName)
	PrimaryKey = tm.GetDefault("pk", "")
	Schema.Initialize
	'set the field types
	Dim fldsx As List = tm.Get("fields").As(List)
	For Each fm As Map In fldsx
		Dim fldType As String = fm.Get("type")
		Dim fldName As String = fm.Get("name")
		Select Case fldType
			Case "TEXT", "STRING"
				SchemaAddText1(fldName)
			Case "BLOB"
				SchemaAddBlob1(fldName)
			Case "INT", "INTEGER"
				SchemaAddInt1(fldName)
			Case "DOUBLE", "REAL", "FLOAT"
				SchemaAddDouble1(fldName)
			Case "BOOL"
				SchemaAddBoolean1(fldName)
		End Select
	Next
End Sub


Sub Prepare As SithasoGunDBCollection
	Record.Initialize
	Return Me
End Sub

Sub setKey(s As String)
	SetField(PrimaryKey, s)
End Sub

'set multiple fields
Sub SetRecord(rec As Map) As SithasoGunDBCollection
	For Each k As String In rec.Keys
		Dim v As Object = rec.Get(k)
		SetField(k, v)
	Next
	Return Me
End Sub


'to delete the file set the fldValue = null
Sub SetField(fldName As String, fldValue As Object) As SithasoGunDBCollection
	If fldName.IndexOf(".") Then
		'this has dot notation
		modGunDB.PutRecursive(Record, fldName, fldValue)	
		Return Me
	End If
	'
	Dim dt As String = Schema.Get(fldName)
	Select Case dt
		Case DB_BOOL
			fldValue = CBool(fldValue)
		Case DB_INT
			fldValue = CInt(fldValue)
		Case DB_STRING
			fldValue = CStr(fldValue)
		Case DB_REAL
			fldValue = CDbl(fldValue)
		Case DB_BLOB
		Case DB_FLOAT
			fldValue = CDbl(fldValue)
		Case DB_INTEGER
			fldValue = CInt(fldValue)
		Case DB_TEXT
			fldValue = CStr(fldValue)
		Case DB_DOUBLE
			fldValue = CDbl(fldValue)
	End Select
	
	Record.Put(fldName, fldValue)
	Return Me
End Sub


'join list to mv string
private Sub Join(delimiter As String, lst As List) As String
	If lst.Size = 0 Then Return ""
	Dim i As Int
	Dim sbx As StringBuilder
	Dim fld As String
	sbx.Initialize
	fld = lst.Get(0)
	sbx.Append(fld)
	For i = 1 To lst.size - 1
		Dim fld As String = lst.Get(i)
		sbx.Append(delimiter).Append(fld)
	Next
	Return sbx.ToString
End Sub

'convert object to string
private Sub CStr(o As Object) As String
	If BANano.isnull(o) Or BANano.IsUndefined(o) Then o = ""
	If o = "null" Then Return ""
	If o = "undefined" Then Return ""
	Return "" & o
End Sub

private Sub ListOfMapsGetProperty(lst As List, key As String) As List
	key = CStr(key)
	Dim nList As List
	nList.Initialize
	'
	Dim recTot As Int = lst.Size - 1
	Dim recCnt As Int
	For recCnt = 0 To recTot
		Dim m As Map = lst.Get(recCnt)
		If m.ContainsKey(key) Then
			Dim v As String = m.Get(key)
			v = CStr(v)
			nList.Add(v)
		End If
	Next
	Return nList
End Sub




'double
private Sub CDbl(o As String) As Double
	o = Val(o)
	Dim out As Double = NumberFormat(o,0,2)
	Dim nvalue As String = CStr(out)
	nvalue = nvalue.replace(",", ".")
	nvalue = Val(nvalue)
	Dim nout As Double = BANano.parseFloat(nvalue)
	Return nout
End Sub

'convert to int
private Sub CInt(o As Object) As Int
	o = Val(o)
	Return BANano.parseInt(o)
End Sub

'check if value isNaN
private Sub isNaN(obj As Object) As Boolean
	Dim res As Boolean = BANano.Window.RunMethod("isNaN", Array(obj)).Result
	Return res
End Sub


private Sub Val(value As String) As String
	value = CStr(value)
	value = value.Trim
	If value = "" Then value = "0"
	If isNaN(value) Then value = "0"
	Try
		Dim sout As String = ""
		Dim mout As String = ""
		Dim slen As Int = value.Length
		Dim i As Int = 0
		For i = 0 To slen - 1
			mout = value.CharAt(i)
			If InStr("0123456789.-", mout) <> -1 Then
				sout = sout & mout
			End If
		Next
		Return sout
	Catch
		Return value
	End Try
End Sub

private Sub InStr(sText As String, sFind As String) As Int
	Return sText.tolowercase.IndexOf(sFind.tolowercase)
End Sub

private Sub CBool(v As Object) As Boolean
	If BANano.IsNull(v) Or BANano.IsUndefined(v) Then
		v = False
	End If
	If GetType(v) = "string" Or GetType(v) = "object" Then
		Dim s As String = v & ""
		s = s.tolowercase
		If s = "" Then Return False
		If s = "false" Then Return False
		If S = "true" Then Return True
		If s = "1" Then Return True
		If s = "y" Then Return True
		If s = "0" Then Return False
		If s = "n" Then Return False
		If s = "no" Then Return False
		If s = "yes" Then Return True
	End If
	Return v
End Sub

'return the first record
Sub FirstRecord As Map
	Dim rec As Map = result.Get(0)
	Return rec
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
		obj = CInt(obj)
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
		obj = CStr(obj)
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
		obj = CBool(obj)
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
		obj = CDbl(obj)
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
'<code>
'rs.MoveFirst
'Do while rs.NextRow
'Loop
'</code>
Sub MoveFirst
	setPosition(0)
End Sub

'movelast
'<code>
'rs.MoveLast
'Do while rs.NextRow
'Loop
'</code>
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


private Sub RemDelim(sValue As String, Delim As String) As String
	Dim sw As Boolean = sValue.EndsWith(Delim)
	If sw Then
		Dim lDelim As Int = Delim.Length
		Dim nValue As String = sValue
		sw = nValue.EndsWith(Delim)
		If sw Then
			nValue = nValue.SubString2(0, nValue.Length-lDelim)
		End If
		Return nValue
	Else
		Return sValue
	End If
End Sub


'moveStart
'<code>
'rs.MoveStart
'Do while rs.NextRow
'Loop
'</code>
Sub MoveStart
	lastPosition = -1
End Sub

'Sub ADD_ORDER_BY_UPDATED_AT As SithasoGunDBCollection
'	ADD_ORDER_BY("updated")
'	Return Me
'End Sub

'Sub ADD_ORDER_BY_CREATED_AT As SithasoGunDBCollection
'	ADD_ORDER_BY("created")
'	Return Me
'End Sub



