B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.3
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Public result As List
	Private DBase As String  'ignore
	Private where As Map
	Private order As Map
	Public RowCount As Int
	Public Record As Map
	Public const EQ_OP As String = "$eq"
	Public const NE_OP As String = "$ne"
	Public const GT_OP As String = "$gt"
	Public const LT_OP As String = "$lt"
	Public const GTE_OP As String = "$gte"
	Public const LTE_OP As String = "$lte"
	Public const IN_OP As String = "$in"
	Public const NIN_OP As String = "$nin"
	Private lastPosition As Int
	Private indexes As Map
	Private iskip As Int
	Private ilimit As Int
	Private mongo As MongoClient
	Private db As MongoDatabase
	Private collection As MongoCollection
	Private command As String
	Private projection As List
End Sub

''<code>
''initialize the class
'Dim dbMongo As SithasoMongoDB
'dbMongo.Initialize("127.0.0.1", 27017, "test", "users")
'</code>
Sub Initialize(sHost As String, iPort As Int, dbName As String, tblName As String) As SithasoMongoDB
	DBase = dbName
	result.initialize
	order.Initialize
	where.Initialize
	projection.Initialize 	
	lastPosition = 0
	RowCount = 0
	indexes.Initialize
	iskip = 0
	ilimit = 0
	mongo.Initialize("", $"mongodb://${sHost}:${iPort}"$)
	db = mongo.GetDatabase(dbName)
	collection = db.GetCollection(tblName)
	ClearWhere
	Return Me
End Sub


private Sub InsertOrUpdate As UpdateResult
	Dim jco As JavaObject = collection
	Dim utils As JavaObject
	utils.InitializeStatic("anywheresoftware.mongo.MongoUtils")
	Dim options As JavaObject
	options.InitializeNewInstance("com.mongodb.client.model.UpdateOptions", Null)
	options.RunMethod("upsert", Array(True))
	Return jco.RunMethod("updateMany", Array( _
       utils.RunMethod("MapToBson", Array(where)), _
       utils.RunMethod("MapToBson", Array(Record)), _
       options))
End Sub


'prepare the record for insert/update
Sub PrepareRecord As SithasoMongoDB
	Record.Initialize
	Return Me
End Sub

'set a field on the record
Sub SetField(fld As String, value As Object) As SithasoMongoDB
	Record.Put(fld, value)
	Return Me
End Sub

'set limit
Sub SetLimit(l As Int) As SithasoMongoDB
	ilimit = l
	Return Me
End Sub

'set skip
Sub SetSkip(l As Int) As SithasoMongoDB
	iskip = l
	Return Me
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

'clear where clause
Sub ClearWhere As SithasoMongoDB
	where.Initialize
	order.Initialize
	indexes.Initialize
	projection.Initialize 
	Return Me
End Sub

'add projection
Sub AddFields(flds As List) As SithasoMongoDB
	For Each fld As String In flds
		projection.Add(fld)
	Next
	Return Me
End Sub

'add a sort order
Sub AddSort(fld As String, desc As Boolean) As SithasoMongoDB
	If desc = False Then
		order.Put(fld, 1)
	Else
		order.Put(fld, -1)
	End If
	Return Me
End Sub

'add a where clause for your select where statement
'_id will be ignored
Sub AddWhere(fld As String, operator As String, value As Object) As SithasoMongoDB
	If fld = "_id" Then Return Me
	Dim qry As Map = CreateMap()
	qry.Put(operator, value)
	where.Put(fld, qry)
	Return Me
End Sub

'<code>
''update a record, returns number of records updated
''you can specify a where clause optionally
''dbConnect.ClearWhere
''dbConnect.AddWhere("name", dbConnect.EQ_OP, "Anele")
'dbConnect.PrepareRecord
'dbConnect.SetField("age", 50)
'dbConnect.SetField("work", "Software Engineer")
'dbConnect.Update
'if dbConnect.RowCount >= 1 then
''the records were updated
'end if
'</code>
Sub Update As Int
	command = "update"
	If where.Size > 0 Then
		command = "updatewhere"
	End If
	MongoDynamic
	Return RowCount
End Sub

'<code>
''delete record and returns number of records deleted
'dbMongo.Delete("1234567")
'if dbMongo.RowCount = 1 then
''the record was deleted
'end if
'</code>
Sub Delete(id As String) As Int
	command = "delete"
	If id <> "" Then
		where.Initialize
		'define the object id
		Dim objectID As Object = mongo.StringToObjectId(id)
		where.Initialize
		where.Put("_id", objectID)
	End If
	MongoDynamic
	Return RowCount
End Sub

'<code>
''delete record by id or where clause returns number of records deleted
''dbConnect.ClearWhere
''dbConnect.AddWhere("name", dbConnect.EQ_OP, "Anele")
'dbMongo.DeleteWhere
'if dbMongo.RowCount = 1 then
''the record was deleted
'end if
'</code>
Sub DeleteWhere As Int
	command = "delete"
	Record.Remove("_id")
	MongoDynamic
	Return RowCount
End Sub

'<code>
''delete all records
'dbMongo.DeleteAll
'if dbMongo.RowCount > 0 then
''the records were deleted
'end if
'</code>
Sub DeleteAll As Int
	command = "deleteall"
	MongoDynamic
	Return RowCount
End Sub

'<code>
''read record by id, get result
'dbMongo.Read("1234567")
'if dbMongo.RowCount = 1 then
''the record was read
''dbConnect.MoveFirst
'dim sname As String = dbMongo.GetString("name")
'log(sname)
'end if
'</code>
Sub Read(id As String) As Map
	Record = CreateMap()
	Record.Put("_id", id)
	command = "read"
	MongoDynamic
	setPosition(0)
	Return Record
End Sub

'<code>
''insert record, returns the number of records inserted
''_id will be ignore
'dbMongo.PrepareRecord
'dbMongo.SetField("name", "Anele")
'dbMongo.SetField("email", "email@email.com")
'dbConnect.Insert
'</code>
Sub Insert
	command = "insert"
	MongoDynamic
	RowCount = -1
End Sub

'<code>
''select where records and show specific fields
'dbConnect.ClearWhere
'dbConnect.AddFields(array("name", "lastname", "_id"))
'dbConnect.AddWhere("name", dbConnect.EQ_OP, "Anele")
'dbConnect.SetSkip(1)
'dbConnect.SetLimit(1)
'dbConnect.SelectAll
'if dbConnect.RowCount >= 1 then
''the records were selected
'end if
'</code>
Sub SelectAll() As List
	command = "select"
	MongoDynamic
	Return result
End Sub

private Sub MongoDynamic()
	Dim id As String
	'how many items in order
	Select Case command
	Case "insert"
		'remove the id
		Record.Remove("_id")
		Dim documents As List
		documents.Initialize
		documents.Add(Record)
		collection.Insert(documents)
	Case "read"
		'Read an element by id
		id = Record.Get("_id")
		Dim objectID As Object = mongo.StringToObjectId(id)
		where.Initialize 
		where.Put("_id", objectID) 
		result = collection.Find(where, Null, Null)
		RowCount = result.Size
	Case "update"
		'Read an element by id
		id = Record.Get("_id")
		'remove the id from the record		
		Record.Remove("_id")
		'define the object id
		Dim objectID As Object = mongo.StringToObjectId(id)
		where.Initialize 
		where.Put("_id", objectID)
		Dim ur As UpdateResult = collection.Update(where, CreateMap("$set": Record))
		RowCount = ur.ModifiedCount
	Case "updatewhere"
		'remove the id from the record
		Record.Remove("_id")
		Dim ur As UpdateResult = collection.Update(where, CreateMap("$set": Record))
		RowCount = ur.ModifiedCount
	Case "select"
		If where.Size = 0 Then where = Null
		If projection.Size = 0 Then projection = Null
		If order.Size = 0 Then order = Null
		result = collection.Find2(where, projection, order, iskip, ilimit)
		RowCount = result.size
	Case "delete"
		RowCount = collection.Delete(where)
	Case "deleteall"
		RowCount = collection.Delete(CreateMap())
	End Select
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

'get an integer from the current record
Sub GetInt(fld As String) As Int
	fld = fld.tolowercase
	If Record = Null Then Return 0
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
	fld = fld.tolowercase
	If Record = Null Then Return 0
	If Record.ContainsKey(fld) Then
		Dim obj As Int = Record.GetDefault(fld, 0)
		obj = CLng(obj)
		Return obj
	Else
		Return 0
	End If
End Sub

'get the id of this record
Sub GetID As String
	Return GetString("_id")
End Sub

'get a string from the current record
Sub GetString(fld As String) As String
	fld = fld.tolowercase
	If Record = Null Then Return ""
	If Record.ContainsKey(fld) Then
		Dim obj As String = Record.GetDefault(fld, "")
		obj = parseNull(obj)
		Return obj
	Else
		Return ""
	End If
End Sub

'get a boolean from the current record
Sub GetBoolean(fld As String) As Boolean
	fld = fld.tolowercase
	If Record = Null Then Return False
	If Record.ContainsKey(fld) Then
		Dim obj As Boolean = Record.GetDefault(fld, False)
		obj = parseBool(obj)
		Return obj
	Else
		Return False
	End If
End Sub

'get a double from the current record
Sub GetDouble(fld As String) As Double
	fld = fld.tolowercase
	If Record.ContainsKey(fld) Then
		Dim obj As Float = Record.GetDefault(fld, 0)
		obj = CDbl(obj)
		Return obj
	Else
		Return 0
	End If
End Sub

private Sub parseBool(v As Object) As Boolean
	If v = Null Then
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

private Sub CDbl(o As String) As Double
	If o = Null Then
		o = 0
	End If
	If CStr(o) = "" Then
		o = 0
	End If
	Try
		o = CStr(o)
		o = o.Trim
		If o = "" Then o= "0"
		o = o.Replace(",","")
		Dim out As Double = NumberFormat2(o,0,2,2,False)
		Return out
	Catch
		Return o
	End Try
End Sub

'convert object to string
private Sub CStr(o As Object) As String
	If o = Null Then o = ""
	Return "" & o
End Sub

private Sub CInt(o As Object) As Int
	If o = Null Then
		o = 0
	End If
	If CStr(o) = "" Then
		o = 0
	End If
	Return Floor(o)
End Sub

private Sub CLng(o As Object) As Long
	If o = Null Then
		o = 0
	End If
	If CStr(o) = "" Then
		o = 0
	End If
	Return Floor(o)
End Sub

private Sub parseNull(v As Object) As String
	If v = Null Then
		Return ""
	End If
	v = CStr(v)
	If v = "null" Then Return ""
	If v = "undefined" Then Return ""
	Return v
End Sub