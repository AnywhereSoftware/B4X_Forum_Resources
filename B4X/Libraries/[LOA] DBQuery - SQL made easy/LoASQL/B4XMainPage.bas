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

#Macro: Title, Export B4XPages, ide://run?File=%B4X%\Zipper.jar&Args=DB_Example.zip
Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private db As DBQuery
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	xui.SetDataFolder("LoaSQL")
	Dim DBFile As String = "db.db"
	'delete db for testing
	For Each f As String In File.ListFiles(xui.DefaultFolder)
		If f.StartsWith(DBFile) Then File.Delete(xui.DefaultFolder, f) 'there could be several files, depending on the journal mode.
	Next

	'initialize the SQL connection
	Dim sql1 As SQL
	#if B4J
	sql1.InitializeSQLite(xui.DefaultFolder, DBFile, True)
	#else if B4A or B4i
	sql1.Initialize(xui.DefaultFolder, DBFile, True)
	#End if
	db.Initialize(sql1)
	'initialize
	If db.ExecQuerySingleResult($"SELECT count(*) FROM sqlite_master WHERE type='table' AND name=?"$, Array("table1"), 0) = 0 Then 'ignore
		CreateTableAndFillData
	End If
Dim All As ListOfArrays = db.ExecQuery($"SELECT * FROM table1"$, Null)
Log(All.ToString(10)) 'print first 10 rows
Dim res As ListOfArrays = db.ExecQuery($"SELECT name, age FROM table1 WHERE age > ?"$, Array(17))
Log("Age > 17")
Log(res.ToString(0)) 'print all row
	For Each row() As Object In res.IterateRows
		Dim name As String = row(0)
		Dim age As Int = row(res.ColumnIndexToOrdinal("age")) 'or 1
		Log($"${name}: ${age}"$)
	Next
	'group all results by age:
	Dim om As B4XOrderedMap = All.GroupBy("age")
	'get all rows where age = 12
	If om.ContainsKey(12) Then
		Dim Age12 As ListOfArrays = om.Get(12)
		Log(Age12.ToString(5))
	End If
	'get the blob of row with id = 10
	Dim b() As Byte = All.GetValue(All.GetRowIndexByValue("id", 10), "data_blob")
	Log("blob: " & BytesToString(b, 0, b.Length, "utf8"))
	'A safer approach if we are not sure that the row exists:
	Dim age As Int = All.GetValueDefault(All.GetRowIndexByValue("id", 111111), "age", 0)
	Log("age: " & age)
End Sub

Private Sub CreateTableAndFillData
	Log("Creating table and filling data")
	db.ExecNonQuery($"CREATE TABLE table1 (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,                 
    age INTEGER,           
    price REAL,               
    created_at INTEGER,         
    data_blob blob          
)"$, Null)
	db.BeginTransaction
	Try
		
		For i = 1 To 100
			Dim name As String = "name " & i
			Dim age As Int = Rnd(10, 20)
			Dim price As Double = Rnd(0, 1000) / 100.0
			Dim CreatedAt As Long = DateUtils.SetDate(2030, Rnd(1, 13), 1)
			Dim blob() As Byte = name.GetBytes("utf8")
			db.ExecNonQuery("INSERT INTO table1 (name, age, price, created_at, data_blob) VALUES (?, ?, ?, ?, ?)", _
				Array(name, age, price, CreatedAt, blob))
		Next
		db.TransactionSuccessful
	Catch
		Log(LastException)
		db.Rollback
	End Try
End Sub
