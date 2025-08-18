B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.9
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=B4XPagesSQLiteLight2.zip

'Notes:
'1) http://ucanaccess.sourceforge.net/site.html states that V5.0.0 and up require Java 1.8. Older version require 1.6. Since
'	Android's implementation is based on 1.7 we're sticking with the latest 4.x.x release, which as of 2020/08/24 is 4.0.4
'2) http://hsqldb.org/doc/2.0/changelist_2_0.txt states that as of 2.4.0 HSQLDB requires Java 1.8. The 4.0.4 bundle comes with
'   2.3.1, which is not the latest 2.3.x version, but will run with it first.
'3) The UCanAccess zip file seems to contain all necessary support files: commons-lang-2.6.jar, commmons-logging-1.1.3.jar, hsqldb.jar,
'   and jackcess-1.1.11.jar
'4) The above jars (including ucanaccess-4.0.4.jar) are copied into the additional libraries folder. The hsqldb.jar has been renamed
'   to hsqldb-2.3.1.jar



Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	
	Public MP As B4XMainPage
	Public Edit As PageEdit
	Public Filter As PageFilter

#If B4J	
	Public SQL1 As SQL
#Else If B4A
	Public SQL1 As JdbcSQL
#End If
	Public CurrentIndex = -1 As Int		' index of the current entry
	Public RowIDList As List					'list containing the rowids of the database
	
	Private bxtTable As B4XTable
	Private ToastMessage As BCToast
	
	Private btnAdd, btnEdit, btnFilter, btnSetFilter As B4XView
	Private lblSelectedItem As B4XView
End Sub

'You can add more parameters here.
Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	
	'load the layout to Root
	Root.LoadLayout("Main")
	MP = B4XPages.MainPage
	
	'inialize the two pages
	Edit.Initialize
	B4XPages.AddPage("Edit", Edit)
	Filter.Initialize
	B4XPages.AddPage("Filter", Filter)
	
	#If B4J
	xui.SetDataFolder("B4XPagesUCanAccessLight2")
	#End If
	
	'copy the default DB
	If File.Exists(xui.DefaultFolder, "persons.accdb") = False Then
		File.Copy(File.DirAssets, "persons.accdb", xui.DefaultFolder, "persons.accdb")
	End If
	
	'initialize the database
	SQL1.Initialize("net.ucanaccess.jdbc.UcanaccessDriver", $"jdbc:ucanaccess://${File.Combine(xui.DefaultFolder,"persons.accdb")}"$)
	
	'iniatilize the ToastMessage class
	ToastMessage.Initialize(Root)
	
	InitTable
End Sub

Private Sub B4XPage_Appear
	ShowTable	
End Sub

Private Sub B4XPage_CloseRequest As ResumableSub
	Dim sf As Object = xui.Msgbox2Async("Do you want to quit ?", "Quit", "Yes", "Cancel", "No", Null)
	Wait For (sf) Msgbox_Result (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		Return True
	End If
	Return False
End Sub

'Shows the database in a table in a B4XTable
Public Sub ShowTable
	Private Query As String

	ReadDataBaseRowIDs
	
	Query = "SELECT FirstName, LastName, City FROM persons"
	'depending if the filter is active or not we add the filter query at the end of the query
	'the filter query is defined in the Filter Activity
	If Filter.flagFilterActive = False Then
		btnFilter.Text = "Filter"
	Else
		btnFilter.Text = "UnFilter"
		Query = Query & Filter.Query
	End If

	Dim Data As List
	Data.Initialize
#If B4J
	Dim rs As ResultSet = SQL1.ExecQuery(Query)
#Else If B4A
	Dim rs As JdbcResultSet = SQL1.ExecQuery(Query)
#End If
	Do While rs.NextRow
		Dim row(3) As Object
		row(0) = rs.GetString("FirstName")
		row(1) = rs.GetString("LastName")
		row(2) = rs.GetString("City")
		Data.Add(row)
	Loop
	rs.Close
	bxtTable.SetData(Data)
	bxtTable.RefreshNow
	
	UpdateSelectedEntryDisplay
End Sub

Private Sub InitTable
	bxtTable.AddColumn("First name", bxtTable.COLUMN_TYPE_TEXT)
	bxtTable.AddColumn("Last name", bxtTable.COLUMN_TYPE_TEXT)
	bxtTable.AddColumn("City", bxtTable.COLUMN_TYPE_TEXT)
End Sub

Public Sub UpdateSelectedEntryDisplay
	If CurrentIndex > -1 Then
		Private Query As String
#If B4J
		Private ResultSet1 As ResultSet
#Else If B4A
		Private ResultSet1 As JdbcResultSet
#End If
	
		Query = "SELECT FirstName, LastName FROM persons WHERE rowid = " & RowIDList.Get(CurrentIndex)
		ResultSet1 = SQL1.ExecQuery(Query)
		ResultSet1.NextRow
		lblSelectedItem.Text = ResultSet1.GetString("FirstName") & " " & ResultSet1.GetString("LastName")
		ResultSet1.Close
	Else
		lblSelectedItem.Text = ""
	End If
End Sub

'Reads the database rowids in RowIDList
Private Sub ReadDataBaseRowIDs
#If B4J
	Private ResultSet1 As ResultSet
#Else If B4A
	Private ResultSet1 As JdbcResultSet
#End If
	
	If Filter.flagFilterActive = False Then
		ResultSet1 = SQL1.ExecQuery("SELECT rowid FROM persons")
	Else
		ResultSet1 = SQL1.ExecQuery("SELECT rowid FROM persons"  & Filter.Query)
	End If
	
	'We read only the rowid column and put them in the IDList
	RowIDList.Initialize				'initialize the ID list
	Do While ResultSet1.NextRow
		RowIDList.Add(ResultSet1.GetInt2(0))		'add the ID's to the ID list
	Loop
	
	If RowIDList.Size > 0 Then
		If CurrentIndex = -1 Or CurrentIndex > RowIDList.Size - 1 Then
			CurrentIndex = 0			'set the current index to 0
		End If
	Else
		CurrentIndex = -1			'set the current index to -1, no selected item
		ToastMessage.Show("No items found")
	End If
	ResultSet1.Close							'close the ResultSet, we don't need it anymore
End Sub

Private Sub btnAdd_Click
	Edit.Mode = "Add"
	B4XPages.ShowPage("Edit")
End Sub

Private Sub btnEdit_Click
	Edit.Mode = "Edit"
	B4XPages.ShowPage("Edit")
End Sub

Private Sub btnFilter_Click
	Filter.flagFilterActive = Not(Filter.flagFilterActive)
	ShowTable
End Sub

Private Sub btnSetFilter_Click
	B4XPages.ShowPage("Filter")
End Sub

Private Sub bxtTable_CellClicked (ColumnId As String, RowId As Long)
	CurrentIndex = RowId - 1
	UpdateSelectedEntryDisplay
End Sub

