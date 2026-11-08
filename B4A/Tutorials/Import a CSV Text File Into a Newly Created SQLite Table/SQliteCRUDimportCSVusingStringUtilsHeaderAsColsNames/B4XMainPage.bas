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
	Private Root As B4XView 'ignore
	Private xui As XUI
	Private strQuery As String
	Private SQL As SQL
	Private Const filename As String = "cities.csv"
	Private Const DBfilename As String = "test.db"
	Private MyList, Header As List
End Sub

Public Sub Initialize
	xui.SetDataFolder("sql example") 'required in B4J
	If File.Exists(xui.DefaultFolder, filename) = False Then
		File.Copy(File.DirAssets, filename, xui.DefaultFolder, filename)
	End If
	#if B4J
	'B4J SQL object can access many types of databases (same as B4A JdbcSQL).
	SQL.InitializeSQLite(xui.DefaultFolder, DBfilename, True)
	#else
	SQL.Initialize(xui.DefaultFolder, DBfilename, True)
	#End If
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	MyList.Initialize
	Header.Initialize
	
	Dim su As StringUtils  'stringutils lib checked
	MyList =  su.LoadCSV2(File.dirassets, filename, ";", Header)
'	Log(Header.Get(0))
'	Log(Header.Get(1))
	CreateTable
	InsertRecords
	DisplayRecs	
End Sub

Sub CreateTable
	strQuery="DROP TABLE IF EXISTS data"   'You don't have to drop the table every time. This is just for testing
	SQL.ExecNonQuery(strQuery)
	strQuery=$"CREATE TABLE IF NOT EXISTS  data ( ${Header.Get(0)} INTEGER PRIMARY KEY, ${Header.Get(1)} TEXT, ${Header.Get(2)} TEXT, ${Header.Get(3)} REAL, ${Header.Get(4)} REAL) "$
	SQL.ExecNonQuery(strQuery)
End Sub

Sub InsertRecords
	Dim rs As ResultSet = SQL.ExecQuery("SELECT Country FROM data LIMIT 1")
	If Not(rs.NextRow) Then   'if no recs in table, then insert list data
		SQL.BeginTransaction
		Try	
			strQuery="INSERT OR IGNORE INTO data VALUES(?, ?, ?, ?, ?)"
			For Each s() As String In MyList
				SQL.ExecNonQuery2(strQuery, s)
			Next
			SQL.TransactionSuccessful
		Catch
			Log(LastException.Message) 'no changes will be made
		End Try
		#if B4A
			SQL.EndTransaction
		#end if
		Log("Table was empty, so I populated it")
	End If	
	rs.Close
End Sub

Sub DisplayRecs
	Dim rs As ResultSet
	rs=SQL.ExecQuery("SELECT * FROM data ORDER BY Country COLLATE NOCASE, City ")
	Do While rs.NextRow
		Log($"${rs.GetString("Country")} ${TAB} ${rs.getstring("City")}${TAB}${rs.GetDouble("Longitude")} ${TAB} ${rs.GetDouble("Latitude")}"$)
	Loop
	rs.Close

End Sub