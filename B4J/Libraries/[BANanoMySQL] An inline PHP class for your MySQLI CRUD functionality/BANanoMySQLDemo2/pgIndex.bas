B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7.51
@EndOfDesignText@
'Static code module
#IgnoreWarnings:12
Sub Process_Globals
	Private body As BANanoElement
	Private BANano As BANano  'ignore
	Private dummy As UOENowData
	Private elNotif As BANanoElement
	Private elCommand As BANanoElement
	Private elArgs As BANanoElement
	Private mysql As BANanoMySQL
End Sub

Sub Init
	'get the body of the page
	body = BANano.GetElement("#body")
	'empty the body
	body.Empty
	'
	'command
	Dim command As UOENowHTML
	command.Initialize("command","label").SetText("Command: ")
	body.Append(command.HTML).Append("<br><br>")
	'
	'arguements
	Dim args As UOENowHTML
	args.Initialize("args","label").SetText("Arguements: ")
	body.Append(args.HTML).Append("<br><br>")
	 
	'results
	Dim notify As UOENowHTML
	notify.Initialize("notify","label").SetText("Notifications:")
	body.Append(notify.HTML).Append("<br><br>")
	'
	'create the insert button
	Dim btn As UOENowHTML
	btn.Initialize("btninserts","button").SetText("Inserts")
	'append insert to the body
	body.Append(btn.HTML)
	'create the select button
	Dim btnSelect As UOENowHTML
	btnSelect.Initialize("btnselect","button").SetText("Select")
	'add select to the body
	body.Append(btnSelect.HTML)
	'deletes
	Dim btnDelete As UOENowHTML
	btnDelete.Initialize("btndelete","button").SetText("Delete All")
	body.Append(btnDelete.HTML)
	' 
	'updates
	Dim btnUpdates As UOENowHTML
	btnUpdates.Initialize("btnupdate","button").SetText("Update All")
	body.Append(btnUpdates.HTML)
	'
	body.Append("<br><br>")
	Dim btn1 As UOENowHTML
	btn1.Initialize("btninsert1","button").SetText("Insert Specific")
	body.Append(btn1.HTML)
	Dim btnSelect1 As UOENowHTML
	btnSelect1.Initialize("btnselect1","button").SetText("Select Specific")
	body.Append(btnSelect1.HTML)
	Dim btnDelete1 As UOENowHTML
	btnDelete1.Initialize("btndelete1","button").SetText("Delete Specific")
	body.Append(btnDelete1.HTML)
	Dim btnUpdate1 As UOENowHTML
	btnUpdate1.Initialize("btnupdate1","button").SetText("Update Specific")
	body.Append(btnUpdate1.HTML)
	
	'add events to the buttons
	BANano.GetElement("#btninserts").HandleEvents("click", Me, "inserts")
	BANano.GetElement("#btnselect").HandleEvents("click", Me, "selects")
	BANano.GetElement("#btnupdate").HandleEvents("click", Me, "updates")
	BANano.GetElement("#btndelete").HandleEvents("click", Me, "deletes")
	'
	BANano.GetElement("#btninsert1").HandleEvents("click", Me, "insert1")
	BANano.GetElement("#btnselect1").HandleEvents("click", Me, "select1")
	BANano.GetElement("#btndelete1").HandleEvents("click", Me, "delete1")
	BANano.GetElement("#btnupdate1").HandleEvents("click", Me, "update1")
		
	'
	elNotif = BANano.GetElement("#notify")
	elCommand = BANano.GetElement("#command")
	elArgs = BANano.GetElement("#args")
End Sub

Sub update1
	ClearFirst
	'initialize bananosqlite
	mysql.Initialize()
	'define field types
	mysql.AddStrings(Array("id","parentid"))
	'generate random data
	dummy.Initialize
	Dim parentid As String = dummy.Rand_Company_Name
	'define query data & execute
	Dim sql As String = mysql.UpdateWhere("items", CreateMap("parentid":parentid), CreateMap("id":"A"))
	Dim res As String = BANano.CallInlinePHPWait("BANanoMySQL", CreateMap("data": sql))
	'get the result
	Dim rs As ResultSet = mysql.GetResultSet(sql,res)
	'
	elCommand.SetText("Command: " & rs.query)
	elArgs.SetText("Arguements: " & BANano.ToJson(rs.args))
	elNotif.SetText("Result: " & BANano.ToJson(rs.result))
	
End Sub


Sub insert1
	ClearFirst
	'initialize bananosqlite
	mysql.Initialize()
	'create a record
	Dim rec As Map = CreateMap()
	rec.Put("id", "A")
	rec.Put("jsoncontent", "B")
	rec.Put("tabindex", 1)
	rec.put("parentid", "form")
	'indicate field data types
	mysql.AddStrings(Array("id"))
	mysql.AddIntegers(Array("tabindex"))
	'execute the insert
	Dim sql As String = mysql.Insert("items", rec)
	Dim res As String = BANano.CallInlinePHPWait("BANanoMySQL", CreateMap("data": sql))
	'return the resultset
	Dim rs As ResultSet = mysql.GetResultSet(sql,res)
	'
	elCommand.SetText("Command: " & rs.query)
	elArgs.SetText("Arguements: " & BANano.ToJson(rs.args))
	elNotif.SetText("Result: " & BANano.ToJson(rs.result) & " rowid!")
End Sub

Sub Select1
	ClearFirst
	'initialize bananosqlite
	mysql.Initialize()
	'indicate field data types
	mysql.AddStrings(Array("id"))
	'execute select where
	Dim sql As String = mysql.SelectWhere("items", Array("*"), CreateMap("id":"A"), Array("id"))
	Dim res As String = BANano.CallInlinePHPWait("BANanoMySQL", CreateMap("data": sql))
	'get the result
	Dim rs As ResultSet = mysql.GetResultSet(sql,res)
	'
	elCommand.SetText("Command: " & rs.query)
	elArgs.SetText("Arguements: " & BANano.ToJson(rs.args))
	elNotif.SetText("Result: " & BANano.ToJson(rs.result))
End Sub

Sub Delete1
	ClearFirst
	'initialize bananosqlite
	mysql.Initialize()
	'define field types
	mysql.AddStrings(Array("id"))
	'define query data & execute
	Dim sql As String = mysql.DeleteWhere("items", CreateMap("id":"A"))
	Dim res As String = BANano.CallInlinePHPWait("BANanoMySQL", CreateMap("data": sql))
	'get the result
	Dim rs As ResultSet = mysql.GetResultSet(sql,res)
	
	elCommand.SetText("Command: " & rs.query)
	elArgs.SetText("Arguements: ")
	elNotif.SetText("Result: " & BANano.ToJson(rs.result))
End Sub


''update all
Sub updates
	ClearFirst
	mysql.Initialize() 
	mysql.AddStrings(Array("parentid"))
	dummy.Initialize
	Dim parentid As String = dummy.Rand_Company_Name
	'
	Dim sql As String = mysql.UpdateAll("items", CreateMap("parentid":parentid))
	Dim res As String = BANano.CallInlinePHPWait("BANanoMySQL", CreateMap("data": sql))
	Dim rs As ResultSet = mysql.GetResultSet(sql,res)
	Log(rs)
	 
	'
	elCommand.SetText("Command: " & rs.query)
	elArgs.SetText("Arguements: " & BANano.ToJson(rs.args))
	elNotif.SetText("Result: " & BANano.ToJson(rs.result))
	
End Sub
'
''delete all records
Sub Deletes
	ClearFirst
	mysql.Initialize() 
	Dim sql As String = mysql.DeleteAll("items")
	Dim res As String = BANano.CallInlinePHPWait("BANanoMySQL", CreateMap("data": sql))
	Dim rs As ResultSet = mysql.GetResultSet(sql,res)
	
	elCommand.SetText("Command: " & rs.query)
	elArgs.SetText("Arguements: ")
	elNotif.SetText("Result: " & BANano.ToJson(rs.result))
End Sub
'
'select all records
Sub Selects
	ClearFirst
	'build the select statement
	mysql.Initialize() 
	Dim sql As String = mysql.SelectAll("items", Array("*"), Array("id"))
	Dim res As String = BANano.CallInlinePHPWait("BANanoMySQL", CreateMap("data": sql))
	Dim rs As ResultSet = mysql.GetResultSet(sql,res)
	'
	elCommand.SetText("Command: " & rs.query)
	elArgs.SetText("Arguements: " & BANano.ToJson(rs.args))
	elNotif.SetText("Result: " & BANano.ToJson(rs.result))
End Sub
'
'insert dummy records to the db
Sub Inserts
	ClearFirst
	'initialize dummy data generator
	dummy.Initialize
	'define structure
	Dim structure As Map = CreateMap()
	structure.Put("id", dummy.DT_FIRST_NAME)
	structure.Put("jsoncontent", dummy.DT_FULL_NAME)
	structure.Put("tabindex", dummy.DT_NUMBER)
	structure.put("parentid", "form")
	'
	Dim records As List
	records = dummy.GetRecordsWithStructure(structure, 1)
	Dim struct As Map = records.Get(0)
	'
	'initialize sqlite helper
	mysql.Initialize()
	'ensure you specify the field types , rest are strings
	mysql.AddStrings(Array("id"))
	mysql.AddIntegers(Array("tabindex"))
	'define the field types
	Dim sql As String = mysql.Insert("items", struct)
	Dim res As String = BANano.CallInlinePHPWait("BANanoMySQL", CreateMap("data": sql))
	Dim rs As ResultSet = mysql.GetResultSet(sql,res)
	'
	elCommand.SetText("Command: " & rs.query)
	elArgs.SetText("Arguements: " & BANano.ToJson(rs.args))
	elNotif.SetText("Result: " & BANano.ToJson(rs.result) & " rowid!")
End Sub
'
'
Sub ClearFirst
	elCommand.SetText("Command: ")
	elArgs.SetText("Arguements: ")
	elNotif.SetText("Result: ")
End Sub