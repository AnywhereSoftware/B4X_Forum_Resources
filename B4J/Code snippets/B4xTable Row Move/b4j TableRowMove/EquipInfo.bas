B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.3
@EndOfDesignText@
'EQUIPMENT

Sub Process_Globals
End Sub

'Headers for the Equipment database are stored to the common area
Sub EquipmentHeaders
	'Log("Equipment Headers")
	Common.DBName = "EQUIPMENT"
	Common.TotColNumber=5
	Common.FrozenCols=0
	Common.FirstColCheck=True
	Common.ColNames(0) = "EQUIP"
	Common.ColNames(1) = "DESCR"
	Common.ColNames(2) = "COMMENT1"
	Common.ColNames(3) = "COMMENT2"
	Common.ColNames(4) = "COMMENT3"
		
	Common.ColDataTypes(0) = "TEXT"
	Common.ColDataTypes(1) = "TEXT"
	Common.ColDataTypes(2) = "TEXT"
	Common.ColDataTypes(3) = "TEXT"
	Common.ColDataTypes(4) = "TEXT"
End Sub

'Creates the  Database for the first time and adds some equipment
Sub CreateEquipDB
	'Log("Create Equipment SQL")
	CreateSQLTable(Common.SQL,Common.DBName, Common.TotColNumber)                'Creates the database

	'Insert some start values
	For i = 1 To 20
		Dim StartList As List
		StartList. Initialize
		Dim x As String = i
		StartList.Add("RP" & x )
		StartList.Add(x)
		StartList.Add(x)
		StartList.Add(x)
		StartList.Add(x)
		AddRowValues(Common.SQL,Common.DBName,Common.TotColNumber,StartList)
	Next
End Sub


' Generalised sub to Create a table in a DataBase
Sub CreateSQLTable(SQL As SQL,DBName As String, TotColNo As Int)
	'Log("CreateSQLDB")
	Private Query As String  = "CREATE TABLE " & DBName & "("
	For i = 0 To TotColNo-1
		If i > 0 Then
			Query = Query & ", "
		End If
		Query = Query & Common.ColNames(i) & " " & Common.ColDataTypes(i)
	Next
	Query = Query & ")"
	'Log(Query)
	SQL.ExecNonQuery(Query)
End Sub

'Generalised sub to Add a list to a Table
Sub AddRowValues (SQL As SQL,DBname As Object, TotColNo As Int, Values As List)
	'Log("Add a Row of Values to " & DBname)
	Dim Query As String = "INSERT INTO " & DBname & " VALUES ("
	For i = 0 To  TotColNo-1
		If i > 0 Then
			Query = Query & "?,"
		End If
	Next
	Query = Query & "?)"
	'Log(Query)
	SQL.ExecNonQuery2(Query,Values)
End Sub