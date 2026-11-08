B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Dim mysqlite As SQL	
End Sub

Public Sub Initialize
	mysqlite.InitializeSQLite(File.DirApp & "\www", "database.db", False)
End Sub

Public Sub FindByID(id As String) As List
	Dim kq As List
	kq.Initialize
	
	Dim Cursor As ResultSet
	Cursor = mysqlite.ExecQuery("SELECT * FROM organizations")
	Do While Cursor.NextRow
		Dim rs As infoData
		rs.Initialize		
		rs.Name = Cursor.GetString("Name")
		rs.xemail = Cursor.GetString("Website")
		
		kq.Add(rs)
	Loop
	
	Return kq
End Sub