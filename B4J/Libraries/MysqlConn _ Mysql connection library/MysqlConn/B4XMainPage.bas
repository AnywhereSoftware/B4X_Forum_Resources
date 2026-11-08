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
	Dim mysql As MysqlConn
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	'Connecting to the mysql database
	mysql.Initialize("mysql",Me,"YOUR PHP URL (example.com/connection.php)","YOUR HOST HERE","YOUR DATABASE NAME HERE","YOUR USERNAME HERE","YOUR PASSWORD HERE")
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	'Make the query
	mysql.QueryResults("SELECT * FROM test") '<------ QUERY HERE
	'Waiting for the results
	Wait For mysql_QueryResultsDone(Result As List)
	'Line per line
	For i = 0 To Result.Size-1
		'Getting a string value : 
		Dim StringVal As String = mysql.GetString(Result,i,"YOUR STRING COLUMN HERE")
		'Getting a Double value : 
		Dim DoubleVal As Double = mysql.GetDouble(Result,i,"YOUR DOUBLE COLUMN HERE")
		'Getting a Int value : 
		Dim IntVal As Int = mysql.GetInt(Result,i,"YOUR INT COLUMN HERE")
		'Using the values : 
		Log("String : "&StringVal)
		Log("Double : "&DoubleVal)
		Log("Int : "&IntVal)
	Next
End Sub

Private Sub Button2_Click
	'Make the query
	mysql.QueryNoResults("CREATE TABLE test2 ( `col1` TEXT NOT NULL )")
	Wait For mysql_QueryNoResultsDone(Result As Boolean)
	'checking if the query is executed with success
	Log(Result)
	If Result=True Then
		Log("Query executed with success !")
	End If
End Sub