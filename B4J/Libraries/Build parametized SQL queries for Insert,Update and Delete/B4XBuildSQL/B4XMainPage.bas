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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private fDB As SQL
	Private fBuildSQL As clBuildSQL
	Private Label1 As Label
End Sub

Public Sub Initialize
	'create the database if not exist
	xui.SetDataFolder("buildsql")
	If Not(File.Exists(xui.DefaultFolder,"test.sqlite3")) Then
		#if B4A
		fDB.Initialize(xui.DefaultFolder,"test.sqlite3",True)
		#end if
		#if B4J
		fDB.InitializeSQLite(xui.DefaultFolder,"test.sqlite3",True)
		#end if
		fDB.ExecNonQuery("CREATE TABLE t_persons(id INTEGER primary key,name text,age int)")
	Else
		#if B4A
		fDB.Initialize(xui.DefaultFolder,"test.sqlite3",False)
		#end if
		#if B4J
		fDB.InitializeSQLite(xui.DefaultFolder,"test.sqlite3",False)
		#end if
	End If
	fBuildSQL.Initialize
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

private Sub ShowRecords
	Dim r As ResultSet=fDB.ExecQuery("select * from t_persons")
	Do While r.NextRow
		Label1.Text=Label1.Text & "|"
		For c=0 To r.ColumnCount-1
			Label1.Text=Label1.Text & r.GetColumnName(c) & "=" & r.GetString2(c) & " | "
		Next
		Label1.Text=Label1.Text & CRLF
	Loop
	Label1.Text=Label1.Text & "==================================" & CRLF
End Sub

Private Sub Button1_Click
	Dim s As TSQLQuery=fBuildSQL.insertSQL("t_persons",CreateMap("name":"Alan","age":35))
	fDB.ExecNonQuery2(s.fSQL,s.fValues)
	ShowRecords
	
	Dim s As TSQLQuery=fBuildSQL.insertSQL("t_persons",CreateMap("name":"Mary","age":28))
	fDB.ExecNonQuery2(s.fSQL,s.fValues)
	ShowRecords

	Dim s As TSQLQuery=fBuildSQL.UpdateSQL("t_persons",CreateMap("age":30),CreateMap("name=":"Mary"))
	fDB.ExecNonQuery2(s.fSQL,s.fValues)
	ShowRecords

	Dim s As TSQLQuery=fBuildSQL.deleteSQL("t_persons",CreateMap("name=":"Alan","or age>":32))
	fDB.ExecNonQuery2(s.fSQL,s.fValues)
	ShowRecords

End Sub