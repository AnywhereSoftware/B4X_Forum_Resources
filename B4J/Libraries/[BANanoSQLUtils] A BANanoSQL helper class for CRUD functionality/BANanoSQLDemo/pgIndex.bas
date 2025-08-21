B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7.51
@EndOfDesignText@
'Static code module
#IgnoreWarnings:12
Sub Process_Globals
	Private SQL As BANanoSQL
	Private body As BANanoElement
	Private BANano As BANano
	Private dummy As UOENowData
	Private elNotif As BANanoElement
	Private elCommand As BANanoElement
	Private elArgs As BANanoElement
	Private alasql As BANanoSQLUtils
End Sub

Sub Init
	'open the db
	SQL.OpenWait("tests","tests")
	'
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
	BANano.GetElement("#btninserts").HandleEvents("click", Me, "insertswait")
	BANano.GetElement("#btnselect").HandleEvents("click", Me, "selectswait")
	BANano.GetElement("#btnupdate").HandleEvents("click", Me, "updateswait")
	BANano.GetElement("#btndelete").HandleEvents("click", Me, "deleteswait")
	'
	BANano.GetElement("#btninsert1").HandleEvents("click", Me, "insert1wait")
	BANano.GetElement("#btnselect1").HandleEvents("click", Me, "select1wait")
	BANano.GetElement("#btndelete1").HandleEvents("click", Me, "delete1wait")
	BANano.GetElement("#btnupdate1").HandleEvents("click", Me, "update1wait")
		
	'
	elNotif = BANano.GetElement("#notify")
	elCommand = BANano.GetElement("#command")
	elArgs = BANano.GetElement("#args")
End Sub


Sub update1wait
	ClearFirst
	'initialize bananosqlite
	alasql.Initialize()
	'define field types
	alasql.AddStrings(Array("id","parentid"))
	'generate random data
	dummy.Initialize
	Dim parentid As String = dummy.Rand_Company_Name
	'define query data & execute
	Dim rs As ResultSet = alasql.UpdateWhere("items", CreateMap("parentid":parentid), CreateMap("id":"A"))
	rs.result = SQL.ExecuteWait(rs.query, rs.args)
	'
	elCommand.SetText("Command: " & rs.query)
	elArgs.SetText("Arguements: " & BANano.ToJson(rs.args))
	elNotif.SetText("Result: " & BANano.ToJson(rs.result))
	
End Sub


Sub insert1wait
	ClearFirst
	'initialize bananosqlite
	alasql.Initialize()
	'create a record
	Dim rec As Map = CreateMap()
	rec.Put("id", "A")
	rec.Put("jsoncontent", "B")
	rec.Put("tabindex", 1)
	rec.put("parentid", "form")
	'indicate field data types
	alasql.AddStrings(Array("id"))
	alasql.AddIntegers(Array("tabindex"))
	'execute the insert
	Dim rs As ResultSet = alasql.Insert("items", rec)
	rs.result = SQL.ExecuteWait(rs.query, rs.args)
	'
	elCommand.SetText("Command: " & rs.query)
	elArgs.SetText("Arguements: " & BANano.ToJson(rs.args))
	elNotif.SetText("Result: " & BANano.ToJson(rs.result) & " rowid!")
End Sub

Sub Select1wait
	ClearFirst
	'initialize bananosqlite
	alasql.Initialize()
	'indicate field data types
	alasql.AddStrings(Array("id"))
	'execute select where
	Dim rs As ResultSet = alasql.SelectWhere("items", Array("*"), CreateMap("id":"A"), Array("id"))
	rs.result = SQL.ExecuteWait(rs.query, rs.args)
	'
	elCommand.SetText("Command: " & rs.query)
	elArgs.SetText("Arguements: " & BANano.ToJson(rs.args))
	elNotif.SetText("Result: " & BANano.ToJson(rs.result))
End Sub

Sub Delete1wait
	ClearFirst
	'initialize bananosqlite
	alasql.Initialize()
	'define field types
	alasql.AddStrings(Array("id"))
	'define query data & execute
	Dim rs As ResultSet = alasql.DeleteWhere("items", CreateMap("id":"A"))
	rs.result = SQL.ExecuteWait(rs.query, rs.args)
	
	elCommand.SetText("Command: " & rs.query)
	elArgs.SetText("Arguements: ")
	elNotif.SetText("Result: " & BANano.ToJson(rs.result))
End Sub


'update all
Sub updateswait
	ClearFirst
	alasql.Initialize 
	dummy.Initialize
	Dim parentid As String = dummy.Rand_Company_Name
	Dim rs As ResultSet = alasql.UpdateAll("items", CreateMap("parentid":parentid))
	rs.result = SQL.ExecuteWait(rs.query, rs.args)
	
	elCommand.SetText("Command: " & rs.query)
	elArgs.SetText("Arguements: " & BANano.ToJson(rs.args))
	elNotif.SetText("Result: " & BANano.ToJson(rs.result))
End Sub

'delete all records
Sub Deleteswait
	ClearFirst
	alasql.Initialize 
	Dim rs As ResultSet = alasql.DeleteAll("items")
	rs.result = SQL.ExecuteWait(rs.query, rs.args)
	'
	elCommand.SetText("Command: " & rs.query)
	elArgs.SetText("Arguements: ")
	elNotif.SetText("Result: " & BANano.ToJson(rs.result))
End Sub

'select all records
Sub Selectswait
	ClearFirst
	alasql.Initialize 
	'build the select statement
	Dim rs As ResultSet = alasql.SelectAll("items", Array("*"), Array("id"))
	rs.result = SQL.ExecuteWait(rs.query, rs.args)
	
	elCommand.SetText("Command: " & rs.query)
	elArgs.SetText("Arguements: " & BANano.ToJson(rs.args))
	elNotif.SetText("Result: " & BANano.ToJson(rs.result))
End Sub

'insert 10 dummy records to the db
Sub Insertswait
	ClearFirst
	'initialize dummy data generator
	dummy.Initialize
	'define structure
	Dim structure As Map = CreateMap()
	structure.Put("id", dummy.DT_FIRST_NAME)
	structure.Put("jsoncontent", dummy.DT_FULL_NAME)
	structure.Put("tabindex", dummy.DT_NUMBER)
	structure.put("parentid", "form")
	Dim records As List
	records = dummy.GetRecordsWithStructure(structure, 10)
	'
	alasql.Initialize
	Dim rs As ResultSet = alasql.InsertList("items")
	rs.result = SQL.ExecuteWait(rs.query, Array(records))
	
	elCommand.SetText("Command: " & rs.query)
	elArgs.SetText("Arguements: " & BANano.ToJson(records))
	elNotif.SetText("Result: " & BANano.ToJson(rs.result) & " records inserted!")
End Sub


Sub ClearFirst
	elCommand.SetText("Command: ")
	elArgs.SetText("Arguements: ")
	elNotif.SetText("Result: ")
End Sub