B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
'Ctrl + click to export as zip: ide://run?File=%ADDITIONAL%\ZipperWm.jar&Args=|target|%PROJECT_NAME%_%YYYY%-%MM%-%DD%.zip|exclude|%ADDITIONAL%\zipperwmexclusions.txt|movedown|includemodules|explorerwine|/usr/bin/nemo

#Region Changes
'CHANGES:
'========
' - 2023-08-19: bug fix in handling of filter columns and sort columns (see "This next line added 2023-08-19:" for the changes)
#End Region ' Changes

Sub Class_Globals

	Private fx As JFX
	Private xui As XUI

	Private sql1 As SQL
	Private sqlReservedWords As String = "|ABORT|ACTION|ADD|AFTER|ALL|ALTER|ANALYZE|AND|AS|ASC|ATTACH|AUTOINCREMENT|BEFORE|BEGIN|BETWEEN|BY|CASCADE|CASE|CAST|CHECK|COLLATE|COLUMN|COMMIT|CONFLICT|CONSTRAINT|CREATE|CROSS|CURRENT_DATE|CURRENT_TIME|CURRENT_TIMESTAMP|DATABASE|DEFAULT|DEFERRABLE|DEFERRED|DELETE|DESC|DETACH|DISTINCT|DROP|EACH|ELSE|END|ESCAPE|EXCEPT|EXCLUSIVE|EXISTS|EXPLAIN|FAIL|FOR|FOREIGN|FROM|FULL|GLOB|GROUP|HAVING|IF|IGNORE|IMMEDIATE|IN|INDEX|INDEXED|INITIALLY|INNER|INSERT|INSTEAD|INTERSECT|INTO|IS|ISNULL|JOIN|KEY|LEFT|LIKE|LIMIT|MATCH|NATURAL|NO|NOT|NOTNULL|NULL|OF|OFFSET|ON|OR|ORDER|OUTER|PLAN|PRAGMA|PRIMARY|QUERY|RAISE|RECURSIVE|REFERENCES|REGEXP|REINDEX|RELEASE|RENAME|REPLACE|RESTRICT|RIGHT|ROLLBACK|ROW|SAVEPOINT|SELECT|SET|TABLE|TEMP|TEMPORARY|THEN|TO|TRANSACTION|TRIGGER|UNION|UNIQUE|UPDATE|USING|VACUUM|VALUES|VIEW|VIRTUAL|WHEN|WHERE|WITH|WITHOUT|"
	Private myCaller As Object
	Private myCompletionEvent As String
	Private myShowOpenButton As Boolean
	Private myShowSaveButton As Boolean
	Private myRightClickMsgBox As Boolean
	Private myInternalDbPath As String
	Private frm As Form
	Private tgtPane As Pane
	Private myTitle As String = ""
	Private fnt14 As B4XFont

	Private dbversion As Int = 1 ' Version number for the internal database layout

	' After initialising the class, you can localise these strings by
	' replacing the map's values. Empty values will be replaced by their key.
	' Notice that a map's keys are case sensitive, so use the exact same keys!
	Public localisationMap As Map = CreateMap( _
											"Add new": "", _
											"Build": "", _
											"Cancel": "", _
											"Click a table's node to handle its details": "", _
											"Column": "", _
											"Column aliases": "", _
											"Column in linked table": "", _
											"Column in this table": "", _
											"Contains": "", _
											"Ends with": "", _
											"Filter columns": "", _
											"Help": "", _
											"HelpCROSSJOIN": "- CROSS JOIN: for each row of table1, produce a set of rows that combines that row with all rows of table2 (all columns from both tables)", _
											"HelpJOIN": "- JOIN: rows from either table appear in the result if and only if the key column values are present in both tables", _
											"HelpLEFTJOIN": "- LEFT JOIN: takes all rows from table1 and adds all columns from table2 where the key columns match; if there is no match in table2, NULL values are used", _
											"Ignore case": "", _
											"Invalid column name": "", _
											"Invalid file": "", _
											"Invalid table name": "", _
											"JOIN type": "", _
											"Link to table": "", _
											"No data found": "", _
											"Number of qualifying rows found": "", _
											"OK": "", _
											"Open": "", _
											"Operator": "", _
											"Order": "", _
											"Relationships": "", _
											"Restart": "", _
											"Save": "", _
											"Select columns": "", _
											"Select one or more tables from the list": "", _
											"Select the output file": "", _
											"Select the saved file to open": "", _
											"Sort": "", _
											"Starts with": "", _
											"Table aliases": "", _
											"Tables": "", _
											"Test": "", _
											"This name already exists as an alias": "", _
											"This name already exists for a table": "", _
											"TooltipBuild": "Build your SELECT statement", _
											"TooltipOpen": "Open a file you saved with the 'Save' button", _
											"TooltipSave": "Save your choices to a file", _
											"TooltipTables": "Show the chart with the selected tables", _
											"TooltipTest": "Test your SELECT statement by running the query", _
											"Value": "", _
											"Warning: there should be only one top-level table": "", _
											"You haven't entered any data here yet": "", _
											"Your data have been saved": "" _
											)

	Private initialising As Boolean = True
	Private firstDraw As Boolean = True
	Private fillingDetailsViews As Boolean = False
	Private initialisingListViewSQLSBtables As Boolean = False
	Private selectedTable As String = ""
	Private selectedTables As List
	Private deleteId As Int = 0
	Private newMaxId As Int = 0
	Type wmSQLSBdeleteButtonTag(tv As TableView, id As Int)
	Type wmSQLSBaliasTextFieldTag(cb As ChoiceBox, tf As TextField, id As Int) ' The tag will be used in the Process...Alias methods
	Type wmSQLSBcolumnAliasDetails(tblName As String, colName As String)

	Private sqlInMemory As SQL
	Private sqlInMemoryTablesOrder As List

	''''''''''''''''''''''''''''''''''''''''''''''''''''
	' Designer views in layout wmSQLiteSelectBuilder.bjl
	''''''''''''''''''''''''''''''''''''''''''''''''''''

	Private LabelSQLSBtitle As Label

	Private ButtonSQLSBrestart As Button
	Private ButtonSQLSBbuild As Button
	Private ButtonSQLSBtest As Button
	Private ButtonSQLSBtables As Button
	Private ButtonSQLSBtableAliases As Button
	Private ButtonSQLSBcolumnAliases As Button
	Private ButtonSQLSBopen As Button
	Private ButtonSQLSBsave As Button

	Private PaneSQLSBtables As Pane
	Private ListViewSQLSBtables As ListView
	Private LabelSQLSBselectTables As Label
	Private PaneSQLSBtablesWilNetChart As Pane
	Private wmWiLNetChartSQLSB As wmWiLNetChartInPane

	Private PaneSQLSBdetails As Pane
	Private RadioButtonSQLSBselectColumns As RadioButton
	Private RadioButtonSQLSBfilterColumns As RadioButton
	Private RadioButtonSQLSBsort As RadioButton
	Private RadioButtonSQLSBrelationships As RadioButton

	Private PaneSQLSBtableAliases As Pane
	Private ButtonSQLSBtableAliasesAdd As Button
	Private TableViewSQLSBtableAliases As TableView

	Private PaneSQLSBcolumnAliases As Pane
	Private ButtonSQLSBcolumnAliasesAdd As Button
	Private TableViewSQLSBcolumnAliases As TableView

	Private PaneSQLSBselectColumns As Pane
	Private ListSelectionViewSQLSBselectColumns As ListSelectionView

	Private PaneSQLSBfilterColumns As Pane
	Private ButtonSQLSBfilterColumnsAdd As Button
	Private TableViewSQLSBfilterColumns As TableView

	Private PaneSQLSBsort As Pane
	Private ButtonSQLSBsortAdd As Button
	Private TableViewSQLSBsort As TableView

	Private PaneSQLSBrelationships As Pane
	Private ButtonSQLSBrelationshipsAdd As Button
	Private ButtonSQLSBrelationshipsJoinTypeHelp As Button
	Private TableViewSQLSBrelationships As TableView

	Private PaneSQLSBtest As Pane
	Private TableViewSQLSBtest As TableView
	Private LabelSQLSBtestNumRows As Label

	Private TextAreaSQLSBoutput As TextArea

	Private ButtonSQLSBok As Button
	Private ButtonSQLSBcancel As Button

End Sub

'Initialises the class. Parameters:
'- caller: the calling module
'- completionEvent: the method to call in the calling module when the user clicks 'OK' or 'Cancel'; signature is e.g. "SQLSB_complete(result As String)"
'- callersForm: a Form, e.g. the one that's active in the calling module; used for Msgbox and dialogs
'- targetPane: the pane in which to show the builder's layout
'- title: a title to show at the top of the builder
'- sqliteDb: the SQLlite database with which to use the builder; if sqliteDb is Null or not initialised, sqliteDbDir and sqliteDbFile are used
'- sqliteDBDir and sqliteDbFile: directory and filename of the SQLlite database with which to use the builder; if sqliteDb is initialised, it takes precedence
'- showOpenButton: if True, the 'Open' button will be visible; it enables the user to open a file that was previously saved with the 'Save' button
'- showSaveButton: if True, the 'Save' button will be visible; it enables the user to save their selections to a file that can later be opened with the 'Open' button
'- rightClickMsgBoxInsteadOfToast: if True, right-clicking a table's node shows all its relationships in a Msgbox instead of a 'toast-like' notification
'- internalDbPath: the path of the file (which will be overwritten) to be used as internal SQLite database, which can be useful for debugging; an empty string means 'use an in-memory database'
Public Sub Initialize(caller As Object, completionEvent As String, callersForm As Form, targetPane As Pane, title As String, _
					sqliteDb As SQL, sqliteDbDir As String, sqliteDbFile As String, _
					showOpenButton As Boolean, showSaveButton As Boolean, rightClickMsgBoxInsteadOfToast As Boolean, _
					internalDbPath As String)

	frm = callersForm
	myCaller = caller
	myTitle = title
	myCompletionEvent = completionEvent
	myShowOpenButton = showOpenButton
	myShowSaveButton = showSaveButton
	myRightClickMsgBox = rightClickMsgBoxInsteadOfToast
	myInternalDbPath = internalDbPath
	tgtPane = targetPane
	fnt14 = xui.CreateDefaultFont(14)

	If (sqliteDb <> Null) And sqliteDb.IsInitialized Then
		sql1 = sqliteDb
	Else
		sql1.InitializeSQLite(sqliteDbDir, sqliteDbFile, False)
	End If

	sqlReservedWords = sqlReservedWords.ToUpperCase ' Just making sure that mixed case in the value won't cause issues later on

	InitSqlInMemory(False)

End Sub

Private Sub InitSqlInMemory(forLoad As Boolean)

	If sqlInMemory.IsInitialized Then sqlInMemory.Close

	' sqlInMemoryTablesOrder is used in methods LoadFile and SaveUserDataToSqlInMemory to process data
	' in the correct order, so that the below foreign key constraints won't produce violations.
	sqlInMemoryTablesOrder.Initialize2(Array As String("Meta", "TablesAndAliases", "ColumnsAndAliases", "SelectedTables", "SelectedColumns", "FilterColumns", "SortColumns", "Relationships"))

	If myInternalDbPath = "" Then
		sqlInMemory.InitializeSQLite("", ":memory:", True)
	Else
		File.Delete(myInternalDbPath, "")
		sqlInMemory.InitializeSQLite(myInternalDbPath, "", True)
	End If

	InitSqliteDb(sqlInMemory, forLoad)

End Sub

Private Sub InitSqliteDb(db As SQL, forSaveOrLoad As Boolean)

	db.ExecNonQuery("PRAGMA foreign_keys = ON")

	db.BeginTransaction

	' Meta data; at the moment, it only contains a version number
	db.ExecNonQuery("CREATE TABLE Meta(PropertyName TEXT, PropertyValue TEXT, " & _
							"PRIMARY KEY(PropertyName)" & _
							")")
	If forSaveOrLoad = False Then db.ExecNonQuery2("INSERT INTO [Meta] ([PropertyName], [PropertyValue]) VALUES (?, ?)", Array("version", dbversion))

	' Top tier table TablesAndAliases contains all tables from the db that's being processed, and all defined table aliases
	' For actual (i.e. not aliased) tables, 'IsAliasFor' will be set to the same value as 'TblName'
	db.ExecNonQuery("CREATE TABLE TablesAndAliases(TblName TEXT, IsAliasFor TEXT, Id INT, " & _
							"PRIMARY KEY(TblName)" & _
							")")
	If forSaveOrLoad = False Then
		For Each oneTable As String In SQLiteGetTables(sql1)
			InsertIntoAndIncreaseId("[TablesAndAliases]", "[TblName], [IsAliasFor]", "?, ?", Array As String(oneTable, oneTable))
		Next
	End If

	' Top tier table ColumnsAndAliases contains all columns from all tables (including the table aliases) in the db that's
	' being processed, and all defined column aliases
	' For actual (i.e. not aliased) columns, 'IsAliasFor' will be set to the same value as 'ColName'
	db.ExecNonQuery("CREATE TABLE ColumnsAndAliases(TblName TEXT, ColName TEXT, IsAliasFor TEXT, Id INT, " & _
							"PRIMARY KEY(TblName, ColName), " & _
							"CONSTRAINT fk_Tables FOREIGN KEY(TblName) REFERENCES TablesAndAliases(TblName) ON UPDATE CASCADE ON DELETE CASCADE" & _
							")")
	If forSaveOrLoad = False Then
		For Each oneTable As String In SQLiteGetTables(sql1)
			For Each oneColumn As String In SQLiteGetTableColumnNames2(sql1, oneTable, True)
				InsertIntoAndIncreaseId("[ColumnsAndAliases]", "[TblName], [ColName], [IsAliasFor]", "?, ?, ?", Array As String(oneTable, oneColumn, oneColumn))
			Next
		Next
	End If

	' Table SelectedTables contains all the tables (actual ones, and aliases) that have been selected by the user
	db.ExecNonQuery("CREATE TABLE SelectedTables(TblName TEXT, IsChild INT, Id INT, " & _
							"PRIMARY KEY(TblName)" & _
							"CONSTRAINT fk_Tables FOREIGN KEY(TblName) REFERENCES TablesAndAliases(TblName) ON UPDATE CASCADE ON DELETE CASCADE" & _
							")")

	' This table contains all the columns (actual ones, and aliases) that have been selected by the user
	' one way or another: to be reported, filtered on, sorted on, or used in a relationship
	db.ExecNonQuery("CREATE TABLE SelectedColumns(TblName TEXT, ColName TEXT, Id INT, " & _
							"PRIMARY KEY(TblName, ColName), " & _
							"CONSTRAINT fk_Tables FOREIGN KEY(TblName) REFERENCES SelectedTables(TblName) ON UPDATE CASCADE ON DELETE CASCADE " & _
							"CONSTRAINT fk_Columns FOREIGN KEY(TblName, ColName) REFERENCES ColumnsAndAliases(TblName, ColName) ON UPDATE CASCADE ON DELETE CASCADE" & _
							")")

	' Table FilterColumns - it's all in the name
	db.ExecNonQuery("CREATE TABLE FilterColumns(TblName TEXT, ColName TEXT, FilterOperator TEXT, FilterValue TEXT, FilterNoCase INT, " & _
							"PRIMARY KEY(TblName, ColName, FilterOperator, FilterValue), " & _
							"CONSTRAINT fk_Columns FOREIGN KEY(TblName, ColName) REFERENCES ColumnsAndAliases(TblName, ColName) ON UPDATE CASCADE ON DELETE CASCADE" & _
							")")

	' Table SortColumns - it's all in the name
	db.ExecNonQuery("CREATE TABLE SortColumns(TblName TEXT, ColName TEXT, SortOrder TEXT, SortNoCase INT, " & _
							"PRIMARY KEY(TblName, ColName), " & _
							"CONSTRAINT fk_Columns FOREIGN KEY(TblName, ColName) REFERENCES ColumnsAndAliases(TblName, ColName) ON UPDATE CASCADE ON DELETE CASCADE" & _
							")")

	' Table Relationships - it's all in the name
	db.ExecNonQuery("CREATE TABLE Relationships(TblNameParent TEXT, ColNameParent TEXT, TblNameChild TEXT, ColNameChild TEXT, JoinType TEXT, " & _
							"PRIMARY KEY(TblNameParent, ColNameParent, TblNameChild, ColNameChild), " & _
							"CONSTRAINT fk_Tables1 FOREIGN KEY(TblNameParent) REFERENCES SelectedTables(TblName) ON UPDATE CASCADE ON DELETE CASCADE " & _
							"CONSTRAINT fk_Tables2 FOREIGN KEY(TblNameChild) REFERENCES SelectedTables(TblName) ON UPDATE CASCADE ON DELETE CASCADE " & _
							"CONSTRAINT fk_Columns1 FOREIGN KEY(TblNameParent, ColNameParent) REFERENCES ColumnsAndAliases(TblName, ColName) ON UPDATE CASCADE ON DELETE CASCADE " & _
							"CONSTRAINT fk_Columns2 FOREIGN KEY(TblNameChild, ColNameChild) REFERENCES ColumnsAndAliases(TblName, ColName) ON UPDATE CASCADE ON DELETE CASCADE" & _
							")")

	db.TransactionSuccessful

End Sub

' Show the layout; savedFileToLoad is the path of a file that was created with the 'Save' button, or "".
' Returns a string containing the built SELECT statement, or "" if the user cancelled.
Public Sub Show(savedFileToLoad As String)

	tgtPane.LoadLayout("wmSQLiteSelectBuilder")

	LabelSQLSBtitle.Text = myTitle

	UpdatePanesVisibility("Tables")

	ButtonSQLSBrestart.Text = GetLocalisedString("Restart")
	ButtonSQLSBcolumnAliases.Text = GetLocalisedString("Column aliases")
	ButtonSQLSBtableAliases.Text = GetLocalisedString("Table aliases")
	ButtonSQLSBopen.Text = GetLocalisedString("Open")
	ButtonSQLSBopen.TooltipText = GetLocalisedString("TooltipOpen")
	ButtonSQLSBopen.Visible = myShowOpenButton
	ButtonSQLSBsave.Text = GetLocalisedString("Save")
	ButtonSQLSBsave.TooltipText = GetLocalisedString("TooltipSave")
	ButtonSQLSBsave.Visible = myShowSaveButton
	RadioButtonSQLSBselectColumns.Text = GetLocalisedString("Select columns")
	RadioButtonSQLSBfilterColumns.Text = GetLocalisedString("Filter columns")
	RadioButtonSQLSBsort.Text = GetLocalisedString("Sort")
	RadioButtonSQLSBrelationships.Text = GetLocalisedString("Relationships")
	ButtonSQLSBok.Text = GetLocalisedString("OK")
	ButtonSQLSBcancel.Text = GetLocalisedString("Cancel")
	ButtonSQLSBtableAliasesAdd.ToolTipText = GetLocalisedString("Add new")
	ButtonSQLSBcolumnAliasesAdd.ToolTipText = GetLocalisedString("Add new")
	ButtonSQLSBfilterColumnsAdd.ToolTipText = GetLocalisedString("Add new")
	ButtonSQLSBsortAdd.ToolTipText = GetLocalisedString("Add new")
	ButtonSQLSBrelationshipsAdd.ToolTipText = GetLocalisedString("Add new")
	ButtonSQLSBrelationshipsJoinTypeHelp.ToolTipText = GetLocalisedString("Help")
	ButtonSQLSBbuild.ToolTipText = GetLocalisedString("TooltipBuild")
	ButtonSQLSBtest.ToolTipText = GetLocalisedString("TooltipTest")
	ButtonSQLSBtables.ToolTipText = GetLocalisedString("TooltipTables")
	LabelSQLSBselectTables.Text = GetLocalisedString("Select one or more tables from the list")

	ListSelectionViewSQLSBselectColumns.SourceTitle = ""
	ListSelectionViewSQLSBselectColumns.TargetTitle = ""
	ListSelectionViewSQLSBselectColumns.SourceItems.Clear
	ListSelectionViewSQLSBselectColumns.TargetItems.Clear

	SetTableViewPlaceHolderText(TableViewSQLSBtableAliases, GetLocalisedString("You haven't entered any data here yet"))
	TableViewSQLSBtableAliases.Items.Initialize
	TableViewSQLSBtableAliases.SetColumns(Array As String("", GetLocalisedString("Table"), GetLocalisedString("Alias")))
	TableViewSQLSBtableAliases.SetColumnSortable(0, False)
	TableViewSQLSBtableAliases.SetColumnSortable(1, False)
	TableViewSQLSBtableAliases.SetColumnSortable(2, False)

	SetTableViewPlaceHolderText(TableViewSQLSBcolumnAliases, GetLocalisedString("You haven't entered any data here yet"))
	TableViewSQLSBcolumnAliases.Items.Initialize
	TableViewSQLSBcolumnAliases.SetColumns(Array As String("", GetLocalisedString("Column"), GetLocalisedString("Alias")))
	TableViewSQLSBcolumnAliases.SetColumnSortable(0, False)
	TableViewSQLSBcolumnAliases.SetColumnSortable(1, False)
	TableViewSQLSBcolumnAliases.SetColumnSortable(2, False)

	SetTableViewPlaceHolderText(TableViewSQLSBfilterColumns, GetLocalisedString("You haven't entered any data here yet"))
	TableViewSQLSBfilterColumns.Items.Initialize
	TableViewSQLSBfilterColumns.SetColumns(Array As String("", GetLocalisedString("Column"), GetLocalisedString("Operator"), GetLocalisedString("Value"), GetLocalisedString("Ignore case")))
	TableViewSQLSBfilterColumns.SetColumnSortable(0, False)
	TableViewSQLSBfilterColumns.SetColumnSortable(1, False)
	TableViewSQLSBfilterColumns.SetColumnSortable(2, False)
	TableViewSQLSBfilterColumns.SetColumnSortable(3, False)
	TableViewSQLSBfilterColumns.SetColumnSortable(4, False)

	SetTableViewPlaceHolderText(TableViewSQLSBsort, GetLocalisedString("You haven't entered any data here yet"))
	TableViewSQLSBsort.Items.Initialize
	TableViewSQLSBsort.SetColumns(Array As String("", GetLocalisedString("Column"), GetLocalisedString("Order"), GetLocalisedString("Ignore case")))
	TableViewSQLSBsort.SetColumnSortable(0, False)
	TableViewSQLSBsort.SetColumnSortable(1, False)
	TableViewSQLSBsort.SetColumnSortable(2, False)
	TableViewSQLSBsort.SetColumnSortable(3, False)

	SetTableViewPlaceHolderText(TableViewSQLSBrelationships, GetLocalisedString("You haven't entered any data here yet"))
	TableViewSQLSBrelationships.Items.Initialize
	TableViewSQLSBrelationships.SetColumns(Array As String("", GetLocalisedString("Column in this table"), GetLocalisedString("Link to table"), GetLocalisedString("Column in linked table"), GetLocalisedString("JOIN type")))
	TableViewSQLSBrelationships.SetColumnSortable(0, False)
	TableViewSQLSBrelationships.SetColumnSortable(1, False)
	TableViewSQLSBrelationships.SetColumnSortable(2, False)
	TableViewSQLSBrelationships.SetColumnSortable(3, False)
	TableViewSQLSBrelationships.SetColumnSortable(4, False)
	ButtonSQLSBrelationshipsJoinTypeHelp.Text = "? " & GetLocalisedString("JOIN type") & " ?"

	SetTableViewPlaceHolderText(TableViewSQLSBtest, GetLocalisedString("You haven't entered any data here yet"))
	TableViewSQLSBtest.Items.Initialize
	ButtonSQLSBbuild.Text = GetLocalisedString("Build")
	ButtonSQLSBtest.Text = GetLocalisedString("Test")
	ButtonSQLSBtables.Text = GetLocalisedString("Tables")

	TextAreaSQLSBoutput.Text = ""

	LoadFile(savedFileToLoad)

	' Code based on https://www.b4x.com/android/forum/threads/listselectionview-add-event-when-an-item-on-list-source-or-target-is-clicked-selected.103090/
	Dim jo As JavaObject = ListSelectionViewSQLSBselectColumns
	Dim event As Object = jo.CreateEventFromUI("javafx.collections.ListChangeListener", "ListSelectionViewSQLSBselectColumns", Null)
	jo.RunMethodJO("getSourceItems", Null).RunMethod("addListener", Array(event))

	InitListViewSQLSBtables ' In case LoadFile returned without doing any processing

	ButtonSQLSBok.Visible = False
	ButtonSQLSBtest.Visible = False
	TableViewSQLSBtest.Visible = False
	LabelSQLSBtestNumRows.Visible = False

End Sub

' Call this after resizing the calling form
Public Sub Resize

	' Only the chart needs redrawing; all other views are anchored and will be resized automatically
	If ButtonSQLSBtables.Visible = False Then DrawWmWiLNetChartSQLSB

End Sub

' Fill ListViewSQLSBtables with the table names and the user-defined table aliases
Private Sub InitListViewSQLSBtables

	Dim selectedItems As List
	Dim selectedIndices As List
	Dim i As Int
	Dim rs As ResultSet = sqlInMemory.ExecQuery("SELECT [TblName] FROM [SelectedTables]")

	If initialisingListViewSQLSBtables Then Return
	initialisingListViewSQLSBtables = True

	initialising = True
	selectedTable = ""

	' Save the selected items
	selectedItems.Initialize
	For Each idx As Int In ListViewSQLSBtables.GetSelectedIndices
		selectedItems.Add(ListViewSQLSBtables.Items.Get(idx))
	Next
	Do While rs.NextRow
		If selectedItems.IndexOf(rs.GetString("TblName")) < 0 Then selectedItems.Add(rs.GetString("TblName"))
	Loop
	rs.Close

	' Re-populate the listview
	ListViewSQLSBtables.Items.Clear
	ListViewSQLSBtables.Items.Addall(GetTablesAndAliasesListFromSqlInMemory)

	' Re-select the originally selected items
	selectedIndices.Initialize
	For Each tblName As String In selectedItems
		i = ListViewSQLSBtables.Items.IndexOf(tblName)
		If i >= 0 Then selectedIndices.Add(i)
	Next
	ListViewSQLSBtables.SetSelectedIndices(selectedIndices)

	Sleep(0) ' To avoid 'ListViewSQLSBtables_SelectedIndexChanged' events getting queued up and firing after the next statement, causing weird situations
	initialising = False
	initialisingListViewSQLSBtables = False

End Sub

' Save the data entered by the user for later reuse with the 'Open' button.
Public Sub Save(dirName As String, fileName As String)

	Dim saveSqlite As SQL
	Dim i As Int
	Dim rs As ResultSet
	Dim insertColumnNames As String
	Dim insertColumnPlaceholders As String
	Dim insertColumnValues As List

	If File.Exists(dirName, fileName) Then File.Delete(dirName, fileName)
	saveSqlite.InitializeSQLite(dirName, fileName, True)
	InitSqliteDb(saveSqlite, True)

	' Note: VACUUM is not used as it doesn't work with in-memory databases.

	saveSqlite.BeginTransaction

	For Each sqlInMemoryTable As String In sqlInMemoryTablesOrder
		rs = sqlInMemory.ExecQuery("SELECT * FROM [" & sqlInMemoryTable & "]")
		insertColumnNames = ""
		insertColumnPlaceholders = ""
		For i = 0 To (rs.ColumnCount - 1)
			If i > 0 Then
				insertColumnNames = insertColumnNames & ", "
				insertColumnPlaceholders = insertColumnPlaceholders & ", "
			End If
			insertColumnNames = insertColumnNames & "[" & rs.GetColumnName(i) & "]"
			insertColumnPlaceholders = insertColumnPlaceholders & "?"
		Next
		Do While rs.NextRow
			insertColumnValues.Initialize
			For i = 0 To (rs.ColumnCount - 1)
				insertColumnValues.Add(rs.GetString2(i))
			Next
			saveSqlite.ExecNonQuery2("INSERT INTO [" & sqlInMemoryTable & "] (" & insertColumnNames & ") VALUES (" & insertColumnPlaceholders & ")", insertColumnValues)
		Loop
		rs.Close
	Next

	saveSqlite.TransactionSuccessful
	saveSqlite.Close

	fx.Msgbox(frm, GetLocalisedString("Your data have been saved"), myTitle)

End Sub

Private Sub ButtonSQLSBok_Click

	If sqlInMemory.IsInitialized Then sqlInMemory.Close
	CallSubDelayed2(myCaller, myCompletionEvent, TextAreaSQLSBoutput.Text)

End Sub

Private Sub ButtonSQLSBcancel_Click

	If sqlInMemory.IsInitialized Then sqlInMemory.Close
	CallSubDelayed2(myCaller, myCompletionEvent, "")

End Sub

Private Sub ListSelectionViewSQLSBselectColumns_Event(MethodName As String, Args() As Object) As Object

	' Code based on https://www.b4x.com/android/forum/threads/listselectionview-add-event-when-an-item-on-list-source-or-target-is-clicked-selected.103090/

	If initialising Then Return Null

	If MethodName = "onChanged" Then SaveUserDataToSqlInMemory(1)

	Return Null

End Sub

Private Sub ButtonSQLSBrestart_Click

	initialising = True
	firstDraw = True
	ListViewSQLSBtables.SelectedIndex = -1
	initialising = False
	InitSqlInMemory(False)
	selectedTable = ""
	PaneSQLSBdetails.Visible = False
	PaneSQLSBtablesWilNetChart.RemoveAllNodes
	TableViewSQLSBtableAliases.Items.Clear
	TableViewSQLSBcolumnAliases.Items.Clear
	Sleep(0)
	UpdatePanesVisibility("Tables")

End Sub

Private Sub ButtonSQLSBsave_Click

	Dim path As String
	Dim fc As FileChooser

	fc.Initialize
	fc.Title = GetLocalisedString("Select the output file")
	path = fc.ShowSave(frm)
	If path = "" Then Return

	SaveUserDataToSqlInMemory(2)

	Save(path, "")

End Sub

Private Sub ButtonSQLSBopen_Click

	Dim path As String
	Dim fc As FileChooser

	fc.Initialize
	fc.Title = GetLocalisedString("Select the saved file to open")
	path = fc.ShowOpen(frm)

	LoadFile(path)

End Sub

Private Sub LoadFile(path As String)

	Dim didRemove As Boolean
	Dim i As Int
	Dim sqliteLoading As SQL
	Dim rs As ResultSet
	Dim insertColumnNames As String
	Dim insertColumnPlaceholders As String
	Dim insertColumnValues As List
	Dim didRemove As Boolean
	Dim selectedIndices As List

	If path = "" Then Return
	If File.Exists(path, "") = False Then Return

	Try
		sqliteLoading.InitializeSQLite(path, "", False)
	Catch
		Log("LoadFile: " & LastException)
		fx.Msgbox(frm, GetLocalisedString("Invalid file"), myTitle)
		Return
	End Try

	For Each expectedSqlInMemoryTable As String In SQLiteGetTables(sqlInMemory)
		'*******************************************************************
		' NOTE: if new tables have been added to sqlInMemory in this version
		' of this class, this here check needs to be tweaked so that when
		' loading a file from an older version, it isn't de facto invalid!
		'*******************************************************************
		If SQLiteTableExists(sqliteLoading, expectedSqlInMemoryTable) = False Then
			fx.Msgbox(frm, GetLocalisedString("Invalid file"), myTitle)
			Return
		End If
	Next

	selectedTable = ""
	firstDraw = True
	PaneSQLSBtablesWilNetChart.RemoveAllNodes
	InitSqlInMemory(True)

	For Each expectedSqlInMemoryTable As String In sqlInMemoryTablesOrder
		'**********************************************************************
		' NOTE: the below INSERT handling may need to be refined in case
		' sqlInMemory table layouts have changed in this version of this class.
		'**********************************************************************
		rs = sqliteLoading.ExecQuery("SELECT * FROM [" & expectedSqlInMemoryTable & "]")
		insertColumnNames = ""
		insertColumnPlaceholders = ""
		For i = 0 To (rs.ColumnCount - 1)
			If i > 0 Then
				insertColumnNames = insertColumnNames & ", "
				insertColumnPlaceholders = insertColumnPlaceholders & ", "
			End If
			insertColumnNames = insertColumnNames & "[" & rs.GetColumnName(i) & "]"
			insertColumnPlaceholders = insertColumnPlaceholders & "?"
		Next
		Do While rs.NextRow
			insertColumnValues.Initialize
			For i = 0 To (rs.ColumnCount - 1)
				insertColumnValues.Add(rs.GetString2(i))
			Next
			sqlInMemory.ExecNonQuery2("INSERT INTO [" & expectedSqlInMemoryTable & "] (" & insertColumnNames & ") VALUES (" & insertColumnPlaceholders & ")", insertColumnValues)
		Loop
		rs.Close
	Next

	sqliteLoading.Close

	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	' Check for inconsistencies: tables/columns that don't exist
	' because the db has changed after the data had been saved.
	' Remove such inconsistencies.
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	didRemove = True
	Do While didRemove
		didRemove = False
		rs = sqlInMemory.ExecQuery("SELECT * FROM [TablesAndAliases]")
		Do While rs.NextRow
			If SQLiteTableExists(sql1, rs.GetString("IsAliasFor")) = False Then
				sqlInMemory.ExecNonQuery2("DELETE FROM [TablesAndAliases] WHERE [IsAliasFor] = ?", Array As String(rs.GetString("IsAliasFor")))
				didRemove = True
				Exit
			End If
		Loop
		rs.Close
	Loop

	didRemove = True
	Do While didRemove
		didRemove = False
		rs = sqlInMemory.ExecQuery("SELECT * FROM [ColumnsAndAliases]")
		Do While rs.NextRow
			If SQLiteColumnExists(sql1, GetActualTableFromSqlInMemory(rs.GetString("TblName")), rs.GetString("IsAliasFor")) = False Then
				sqlInMemory.ExecNonQuery2("DELETE FROM [ColumnsAndAliases] WHERE ([TblName] = ? AND [IsAliasFor] = ?)", Array As String(rs.GetString("TblName"), rs.GetString("IsAliasFor")))
				didRemove = True
				Exit
			End If
		Loop
		rs.Close
	Loop

	'''''''''''''''''''''''''''''''''''''''''''''''
	' Set the selected items in ListViewSQLSBtables
	'''''''''''''''''''''''''''''''''''''''''''''''

	InitListViewSQLSBtables
	initialisingListViewSQLSBtables = True
	selectedTables.Initialize
	selectedTables.Clear
	selectedIndices.Initialize
	rs = sqlInMemory.ExecQuery("SELECT [TblName] FROM [SelectedTables]")
	Do While rs.NextRow
		i = ListViewSQLSBtables.Items.IndexOf(rs.GetString("TblName"))
		If i >= 0 Then
			selectedIndices.Add(i)
			selectedTables.Add(rs.GetString("TblName"))
		End If
	Loop
	rs.Close
	selectedTables.SortCaseInsensitive(True)
	ListViewSQLSBtables.SetSelectedIndices(selectedIndices)
	Sleep(0) ' To avoid 'ListViewSQLSBtables_SelectedIndexChanged' events getting queued up and firing after the next statement, causing weird situations
	initialisingListViewSQLSBtables = False

	'''''''''''''''''''''''''''''''''''''''''''''''''''''
	' Determine the highest 'Id' value and set 'newMaxId'
	'''''''''''''''''''''''''''''''''''''''''''''''''''''

	newMaxId = 0
	For Each expectedSqlInMemoryTable As String In sqlInMemoryTablesOrder
		If SQLiteColumnExists(sqlInMemory, expectedSqlInMemoryTable, "Id") Then
			newMaxId = Max(newMaxId, sqlInMemory.ExecQuerySingleResult("SELECT MAX(Id) FROM [" & expectedSqlInMemoryTable & "]"))
		End If
	Next

	UpdatePanesVisibility("Tables")

End Sub

' Catch 'deselecting' an item this way
Private Sub ListViewSQLSBtables_MouseClicked(EventData As MouseEvent)

	ListViewSQLSBtables_SelectedIndexChanged(-1)

End Sub

' User [de]selected (a) table(s)
Private Sub ListViewSQLSBtables_SelectedIndexChanged(Index As Int)

	Dim didRemove As Boolean
	Dim rs As ResultSet

	If initialising Then Return
	If initialisingListViewSQLSBtables Then Return

	selectedTables.Initialize
	selectedTables.Clear

	' Ensure all selected table names are present in sqlInMemory.SelectedTables
	For Each idx As Int In ListViewSQLSBtables.GetSelectedIndices
		Dim tblName1 As String = ListViewSQLSBtables.Items.Get(idx).As(String)
		selectedTables.Add(tblName1)
		If NullToEmptyString(sqlInMemory.ExecQuerySingleResult2("SELECT [TblName] FROM [SelectedTables] WHERE [TblName] = ?", Array As String(tblName1)).As(String)) = "" Then
			InsertIntoAndIncreaseId("[SelectedTables]", "[TblName], [IsChild]", "?, ?", Array(tblName1, 0))
		End If
	Next
	selectedTables.SortCaseInsensitive(True)

	' Remove actual table names in sqlInMemory that aren't selected
	didRemove = True
	Do While didRemove
		didRemove = False
		rs = sqlInMemory.ExecQuery("SELECT [TblName] FROM [SelectedTables]")
		Do While rs.NextRow
			If selectedTables.IndexOf(rs.GetString("TblName")) < 0 Then
				' Delete the table's row and all its children
				sqlInMemory.ExecNonQuery2("DELETE FROM [SelectedTables] WHERE [TblName] = ?", Array As String(rs.GetString("TblName")))
				didRemove = True
				Exit
			End If
		Loop
		rs.Close
	Loop

	' Update the chart
	DrawWmWiLNetChartSQLSB

End Sub

Private Sub ButtonSQLSBtables_Click

	If selectedTable <> "" Then SaveUserDataToSqlInMemory(3)

	LabelSQLSBtitle.Text = myTitle
	selectedTable = ""
	UpdatePanesVisibility("Tables")

End Sub

Private Sub ButtonSQLSBcolumnAliases_Click

	If selectedTable <> "" Then SaveUserDataToSqlInMemory(4)
	selectedTable = ""

	Dim rs As ResultSet = sqlInMemory.ExecQuery("SELECT * FROM [ColumnsAndAliases] WHERE [ColName] <> [IsAliasFor]")

	UpdatePanesVisibility("Column aliases")

	TableViewSQLSBcolumnAliases.SetColumnWidth(0, 20dip)
	TableViewSQLSBcolumnAliases.SetColumnWidth(1, (PaneSQLSBcolumnAliases.Width - 60dip) / 2)
	TableViewSQLSBcolumnAliases.SetColumnWidth(2, (PaneSQLSBcolumnAliases.Width - 60dip) / 2)
	TableView_SetColumnResizePolicy(TableViewSQLSBcolumnAliases, False)
	TableViewSQLSBcolumnAliases.Items.Clear

	Do While rs.NextRow
		' Setup all views and the TableView row
		Dim cbColumn As ChoiceBox
		cbColumn.Initialize("cbColumnAlias")
		cbColumn.As(B4XView).Width = TableViewSQLSBcolumnAliases.GetColumnWidth(1)
		Dim tfColumnAlias As TextField
		tfColumnAlias.Initialize("tfColumnAlias")
		tfColumnAlias.As(B4XView).Width = TableViewSQLSBcolumnAliases.GetColumnWidth(2)
		Dim recordcolumnaliases(3) As Object
		recordcolumnaliases(0) = CreateLblDelete(TableViewSQLSBcolumnAliases)
		recordcolumnaliases(1) = cbColumn
		recordcolumnaliases(2) = tfColumnAlias
		TableViewSQLSBcolumnAliases.Items.Add(recordcolumnaliases)
		' Fill the data
		cbColumn.Items.AddAll(GetAllColumnsForAliasesFromSqlInMemory)
		cbColumn.SelectedIndex = cbColumn.Items.IndexOf(EncloseInSquareBrackets(rs.GetString("TblName")) & "." & EncloseInSquareBrackets(rs.GetString("IsAliasFor")))
		tfColumnAlias.Text = rs.GetString("ColName")
		' Set the tags; they will be used in the Process...Alias method
		cbColumn.Tag = CreateWmSQLSBaliasTextFieldTag(cbColumn, tfColumnAlias, rs.GetInt("Id")) ' The tag will be used in the Process...Alias method
		tfColumnAlias.Tag = CreateWmSQLSBaliasTextFieldTag(cbColumn, tfColumnAlias, rs.GetInt("Id")) ' The tag will be used in the Process...Alias method
	Loop
	rs.Close

End Sub

Private Sub ButtonSQLSBtableAliases_Click

	If selectedTable <> "" Then SaveUserDataToSqlInMemory(5)
	selectedTable = ""

	Dim rs As ResultSet = sqlInMemory.ExecQuery("SELECT * FROM [TablesAndAliases] WHERE [TblName] <> [IsAliasFor]")

	UpdatePanesVisibility("Table aliases")

	TableViewSQLSBtableAliases.SetColumnWidth(0, 20dip)
	TableViewSQLSBtableAliases.SetColumnWidth(1, (PaneSQLSBtableAliases.Width - 60dip) / 2)
	TableViewSQLSBtableAliases.SetColumnWidth(2, (PaneSQLSBtableAliases.Width - 60dip) / 2)
	TableView_SetColumnResizePolicy(TableViewSQLSBtableAliases, False)
	TableViewSQLSBtableAliases.Items.Clear

	Do While rs.NextRow
		' Setup all views and the TableView row
		Dim cbTable As ChoiceBox
		cbTable.Initialize("cbTableAlias")
		cbTable.As(B4XView).Width = TableViewSQLSBtableAliases.GetColumnWidth(1)
		Dim tfTableAlias As TextField
		tfTableAlias.Initialize("tfTableAlias")
		tfTableAlias.As(B4XView).Width = TableViewSQLSBtableAliases.GetColumnWidth(2)
		Dim recordTableAliases(3) As Object
		recordTableAliases(0) = CreateLblDelete(TableViewSQLSBtableAliases)
		recordTableAliases(1) = cbTable
		recordTableAliases(2) = tfTableAlias
		TableViewSQLSBtableAliases.Items.Add(recordTableAliases)
		' Fill the data
		cbTable.Items.AddAll(SQLiteGetTables(sql1))
		cbTable.SelectedIndex = cbTable.Items.IndexOf(rs.GetString("IsAliasFor"))
		tfTableAlias.Text = rs.GetString("TblName")
		' Set the tags; they will be used in the Process...Alias method
		cbTable.Tag = CreateWmSQLSBaliasTextFieldTag(cbTable, tfTableAlias, rs.GetInt("Id"))
		tfTableAlias.Tag = CreateWmSQLSBaliasTextFieldTag(cbTable, tfTableAlias, rs.GetInt("Id"))
	Loop
	rs.Close

End Sub

'Draw the chart
Private Sub DrawWmWiLNetChartSQLSB

	Dim rs As ResultSet
	Dim netString As String = ""
	Dim foundData As Boolean = False
	Dim topNodesList As List
	Dim numColsList As List
	Dim numRowsList As List
	Dim numRows As Int = 0
	Dim numCols As Int = 0
	Dim nextTopTableColumn As Int = 0
	Dim colWidth As Double
	Dim rowHeight As Double = 75dip
	Dim rootInfo As String = ""
	Dim i As Int
	Dim debugThis As Boolean = False ' Set this to True to activate the Log statements in this method

	LabelSQLSBselectTables.Visible = False

	If debugThis Then
		LogColor("================================= wmSQLiteSelectBuilder.DrawWmWiLNetChartSQLSB", xui.Color_Magenta)
		Log("::::::::::")
	End If

	' Determine the chart's required number of rows and columns
	topNodesList.Initialize
	numColsList.Initialize
	numRowsList.Initialize
	rs = sqlInMemory.ExecQuery("SELECT * FROM [SelectedTables] WHERE [IsChild] = 0 ORDER BY [TblName] ASC")
	Do While rs.NextRow
		Dim tblName As String = rs.GetString("TblName")
		Dim enclosedTblName As String = EncloseInSquareBrackets(tblName)
		foundData = True
		If debugThis Then Log("top level tblname found: " & enclosedTblName)
		topNodesList.Add(tblName)
		numColsList.Add(1)
		numRowsList.Add(1)
		CalcNumRowsAndCols(numColsList, numRowsList, tblName, debugThis)
	Loop
	rs.Close
	For i = 0 To (numRowsList.Size - 1)
		numCols = numCols + numColsList.Get(i).As(Int)
		numRows = Max(numRowsList.Get(i).As(Int), numRows)
	Next

	colWidth = IIf(numCols < 1, 100dip, PaneSQLSBtablesWilNetChart.Width / numCols / 1.25)

	netString = "Root^Center," & (rowHeight * 1.5) & "," & colWidth & "," & rowHeight & "^SELECT..."
	rs = sqlInMemory.ExecQuery("SELECT * FROM [SelectedTables] WHERE [IsChild] = 0 ORDER BY [TblName] ASC")
	Do While rs.NextRow
		Dim tblName As String = rs.GetString("TblName")
		foundData = True
		If debugThis Then Log("top level tblname found: " & tblName)
		netString = netString & CRLF & tblName & "^" & (nextTopTableColumn * colWidth * 1.5) & "," & (rowHeight * 2 * 1.5) & "," & colWidth & "," & rowHeight & "^"
		netString = AddDescendantsToNetString(netString, nextTopTableColumn, numColsList, numRowsList, colWidth, rowHeight, 2,tblName, debugThis)
		i = topNodesList.IndexOf(tblName)
		nextTopTableColumn = nextTopTableColumn + numColsList.Get(i).As(Int)
		If rootInfo = "" Then
			rootInfo = "Root="
		Else
			rootInfo = rootInfo & ","
		End If
		rootInfo = rootInfo & tblName
	Loop
	rs.Close
	netString = netString & CRLF & rootInfo

	If debugThis Then
		Log("::::::::::")
		Log("netString=" & netString)
	End If

	If firstDraw Then ' Don't remove all nodes as LabelSQLSBselectTables needs to remain present in case no data have been entered yet
		firstDraw = False
	Else
		PaneSQLSBtablesWilNetChart.RemoveAllNodes
	End If

	If foundData = False Then
		LabelSQLSBselectTables.Visible = True
		Return
	End If

	wmWiLNetChartSQLSB.Initialize(Me, PaneSQLSBtablesWilNetChart, "wmWiLNetChartSQLSB", 12, True)
	wmWiLNetChartSQLSB.wrapText = True
	wmWiLNetChartSQLSB.useFsFactorForLabels = False
	wmWiLNetChartSQLSB.fromNetString(netString, 0, 0)
	wmWiLNetChartSQLSB.renderNetChart
	Sleep(0) ' Let the UI update

	If foundData Then
		Dim lbl As Label
		lbl.Initialize("")
		lbl.Font = fx.CreateFont("DEFAULT", 15, False, False)
		lbl.TextSize = 15
		lbl.TextColor = fx.Colors.Red
		lbl.Text = GetLocalisedString("Click a table's node to handle its details")
		lbl.Visible = True
		lbl.Alignment = "CENTER"
		PaneSQLSBtablesWilNetChart.AddNode(lbl, 0, 0, PaneSQLSBtablesWilNetChart.Width, 30dip)
		BringToFront(lbl)
	End If

End Sub

' Determine the maximum number of rows and columns needed for a top level table
Private Sub CalcNumRowsAndCols(numColsList As List, numRowsList As List, tblName As String, debugThis As Boolean)

	numRowsList.Set(numRowsList.Size - 1, numRowsList.Get(numRowsList.Size - 1).As(Int) + 1)

	Dim numChildren As Int = sqlInMemory.ExecQuerySingleResult2("SELECT count([TblNameChild]) FROM [Relationships] WHERE [TblNameParent]=? COLLATE NOCASE", Array As String(tblName)).As(Int)
	If numColsList.Get(numColsList.Size - 1).As(Int) < numChildren Then numColsList.Set(numColsList.Size - 1, numChildren)

	Dim rs2 As ResultSet = sqlInMemory.ExecQuery2("SELECT * FROM [Relationships] WHERE [TblNameParent] = ? ORDER BY [TblNameChild] ASC", Array As String(tblName))
	Do While rs2.NextRow
		CalcNumRowsAndCols(numColsList, numRowsList, rs2.GetString("TblNameChild"), debugThis)
	Loop
	rs2.Close

End Sub

Private Sub AddDescendantsToNetString(netString As String, topTableColumn As Int, numColsList As List, numRowsList As List, colWidth As Double, rowHeight As Double, depth As Int, parentTblName As String, debugThis As Boolean) As String

	Dim thisTablesInfo As String = ""
	Dim colDisplacement As Int = topTableColumn
	Dim rs2 As ResultSet = sqlInMemory.ExecQuery2("SELECT * FROM [Relationships] WHERE [TblNameParent] = ? ORDER BY [TblNameChild] ASC", Array As String(parentTblName))

	depth = depth + 1

	Do While rs2.NextRow
		If debugThis Then Log("     linkedTableName found: " & rs2.GetString("TblNameChild"))
		netString = netString & CRLF & rs2.GetString("TblNameChild") & "^" & (colDisplacement * colWidth * 1.5) & "," & (rowHeight * depth * 1.5) & "," & colWidth & "," & rowHeight & "^"
		netString = AddDescendantsToNetString(netString, topTableColumn, numColsList, numRowsList, colWidth, rowHeight, depth, rs2.GetString("TblNameChild"), debugThis)
		If thisTablesInfo = "" Then
			thisTablesInfo = parentTblName & "="
		Else
			thisTablesInfo = thisTablesInfo & ","
		End If
		thisTablesInfo = thisTablesInfo & rs2.GetString("TblNameChild")
		colDisplacement = colDisplacement + 1
	Loop
	rs2.Close

	Return netString & CRLF & thisTablesInfo

End Sub

Private Sub AddDescendantsToConnections(contentMap As Map, connectionsMap As Map, tblName As String, enclosedTblName As String, debugThis As Boolean)

	Dim rs2 As ResultSet = sqlInMemory.ExecQuery2("SELECT * FROM [Relationships] WHERE [TblNameParent] = ? ORDER BY [TblNameChild] ASC", Array As String(tblName))
	Do While rs2.NextRow
		Dim linkedTableName As String = EncloseInSquareBrackets(rs2.GetString("TblNameChild"))
		If debugThis Then Log("     linkedTableName found: " & linkedTableName)
		contentMap.Put(linkedTableName, "")
		AddToConnectionsMap(connectionsMap, enclosedTblName, linkedTableName, debugThis)
		' Get grandchildren and deeper descendants
		Dim tblNameChild As String = rs2.GetString("TblNameChild")
		AddDescendantsToConnections(contentMap, connectionsMap, tblNameChild, EncloseInSquareBrackets(tblNameChild), debugThis)
	Loop
	rs2.Close

End Sub

Private Sub AddToConnectionsMap(connectionsMap As Map, key As String, val As String, debugThis As Boolean)

	If debugThis Then Log("adding to connectionsMap: key=" & key & "; val=" & val)

	If connectionsMap.ContainsKey(key) = False Then
		connectionsMap.Put(key, val)
	Else
		connectionsMap.Put(key, connectionsMap.Get(key).As(String) & "," & val)
	End If

End Sub

Private Sub wmWiLNetChartSQLSB_RightClick(partName As String, ev As MouseEvent)

	Dim rs As ResultSet
	Dim msg As String = ""
	Dim firstRow As Boolean = True

	rs = sqlInMemory.ExecQuery2("SELECT * FROM [Relationships] WHERE [TblNameChild] = ? ORDER BY [TblNameParent] ASC", Array As String(RemoveSquareBrackets(partName)))
	Do While rs.NextRow
		msg = rs.GetString("JoinType") & ": " & _
				EncloseInSquareBrackets(rs.GetString("TblNameParent")) & "." & _
				EncloseInSquareBrackets(rs.GetString("ColNameParent")) & " -> " & _
				EncloseInSquareBrackets(rs.GetString("TblNameChild")) & "." & _
				EncloseInSquareBrackets(rs.GetString("ColNameChild"))
		Exit ' A table can only be child to one parent
	Loop
	rs.Close

	If msg = "" Then firstRow = False

	rs = sqlInMemory.ExecQuery2("SELECT * FROM [Relationships] WHERE [TblNameParent] = ? ORDER BY [TblNameChild] ASC", Array As String(RemoveSquareBrackets(partName)))
	Do While rs.NextRow
		If msg <> "" Then
			If firstRow Then
				msg = msg & CRLF & CRLF
				firstRow = False
			Else
				msg = msg & CRLF
			End If
		End If
		msg = msg & rs.GetString("JoinType") & ": " & _
					EncloseInSquareBrackets(rs.GetString("TblNameParent")) & "." & _
					EncloseInSquareBrackets(rs.GetString("ColNameParent")) & " -> " & _
					EncloseInSquareBrackets(rs.GetString("TblNameChild")) & "." & _
					EncloseInSquareBrackets(rs.GetString("ColNameChild"))
	Loop
	rs.Close

	If msg <> "" Then
		If myRightClickMsgBox Then
			Wait For(MsgBoxLongText2(frm, msg, partName, GetLocalisedString("OK"), "", "", fx.MSGBOX_INFORMATION, 0, 0, xui.Color_Black)) Complete (MsgBoxLongText2Result As Int)
		Else
			Dim cu As ControlsUtils
			cu.ShowNotification3(partName, msg, cu.ICON_INFORMATION, frm, "CENTER", 3000) ' Show the notification for 3 seconds
		End If
	End If

End Sub

Private Sub wmWiLNetChartSQLSB_Click(partName As String, coords() As Object)

	Dim part As NetPart = wmWiLNetChartSQLSB.register.Get(partName)
	Dim actualTable As String ' Will be set to 'selectedTable', or to the actual table for which 'selectedTable' is an alias
	Dim rs As ResultSet

	'''''''
	' Inits
	'''''''

	If part.isNode = False Then Return
	If partName = "Root" Then Return

	If selectedTable <> "" Then SaveUserDataToSqlInMemory(6) ' Save all panes' data for the current table before switching to the new one
	selectedTable = RemoveSquareBrackets(partName)
	actualTable = GetActualTableFromSqlInMemory(selectedTable)

	LabelSQLSBtitle.Text = myTitle & " (" & partName & ")"
	PaneSQLSBdetails.Visible = True
	PaneSQLSBtables.Visible = False
	PaneSQLSBselectColumns.Visible = True
	ButtonSQLSBtables.Visible = True

	initialising = True
	fillingDetailsViews = True

	ListSelectionViewSQLSBselectColumns.SourceItems.Clear
	ListSelectionViewSQLSBselectColumns.TargetItems.Clear
	TableViewSQLSBfilterColumns.Items.Clear
	TableViewSQLSBsort.Items.Clear
	TableViewSQLSBrelationships.Items.Clear

	''''''''''''''''''
	' Selected columns
	''''''''''''''''''

	rs = sqlInMemory.ExecQuery2("SELECT * FROM [SelectedColumns] WHERE [TblName] = ?", Array As String(selectedTable))
	Do While rs.NextRow
		ListSelectionViewSQLSBselectColumns.TargetItems.Add(rs.GetString("ColName"))
	Loop
	rs.Close

	For Each oneColumnName In GetTableColumnsAndAliasesFromSqlInMemory(selectedTable)
		If ListSelectionViewSQLSBselectColumns.TargetItems.IndexOf(oneColumnName) < 0 Then
			' Column was not selected, but is available for selection
			ListSelectionViewSQLSBselectColumns.SourceItems.Add(oneColumnName)
		End If
	Next

	If (ListSelectionViewSQLSBselectColumns.SourceItems.Size < 1) And _
		(ListSelectionViewSQLSBselectColumns.SourceItems.Size < 1) Then
		' No data found, so all columns are available for selection
		ListSelectionViewSQLSBselectColumns.SourceItems.AddAll(GetTableColumnsAndAliasesFromSqlInMemory(actualTable))
	End If

	''''''''''''''''
	' Filter columns
	''''''''''''''''

	TableViewSQLSBfilterColumns.SetColumnWidth(0, 20dip)
	TableViewSQLSBfilterColumns.SetColumnWidth(1, (PaneSQLSBfilterColumns.Width - 360dip) / 2)
	TableViewSQLSBfilterColumns.SetColumnWidth(2, 150dip)
	TableViewSQLSBfilterColumns.SetColumnWidth(3, (PaneSQLSBfilterColumns.Width - 360dip) / 2)
	TableViewSQLSBfilterColumns.SetColumnWidth(4, 150dip)
	TableView_SetColumnResizePolicy(TableViewSQLSBfilterColumns, False)

	rs = sqlInMemory.ExecQuery2("SELECT * FROM [FilterColumns] WHERE [TblName] = ?", Array As String(selectedTable))
	Do While rs.NextRow
		' Setup all views and the TableView row
		Dim cbFilterColumn As ChoiceBox
		cbFilterColumn.Initialize("ChoiceBoxGeneric")
		cbFilterColumn.As(B4XView).Width = TableViewSQLSBfilterColumns.GetColumnWidth(1)
		Dim cbOperator As ChoiceBox
		cbOperator.Initialize("ChoiceBoxGeneric")
		cbOperator.As(B4XView).Width = TableViewSQLSBfilterColumns.GetColumnWidth(2)
		Dim tfValue As TextField
		tfValue.Initialize("TextFieldGeneric")
		tfValue.As(B4XView).Width = TableViewSQLSBfilterColumns.GetColumnWidth(3)
		Dim cbFilterNocase As CheckBox
		cbFilterNocase.Initialize("CheckBoxGeneric")
		cbFilterNocase.As(B4XView).Width = TableViewSQLSBfilterColumns.GetColumnWidth(4)
		Dim recordFilterColumns(5) As Object
		recordFilterColumns(0) = CreateLblDelete(TableViewSQLSBfilterColumns)
		recordFilterColumns(1) = cbFilterColumn
		recordFilterColumns(2) = cbOperator
		recordFilterColumns(3) = tfValue
		recordFilterColumns(4) = cbFilterNocase
		TableViewSQLSBfilterColumns.Items.Add(recordFilterColumns)
		' Fill the data
		cbFilterColumn.Items.AddAll(GetTableColumnsAndAliasesFromSqlInMemory(selectedTable))
		cbFilterColumn.SelectedIndex = cbFilterColumn.Items.IndexOf(rs.GetString("ColName"))
		cbOperator.Items.AddAll(Array As String("=", "<>", ">", ">=", "<", "<=", GetLocalisedString("Starts with"), GetLocalisedString("Contains"), GetLocalisedString("Ends with")))
		cbOperator.SelectedIndex = cbOperator.Items.IndexOf(GetLocalisedString(rs.GetString("FilterOperator")))
		tfValue.Text = rs.GetString("FilterValue")
		cbFilterNocase.Checked = (rs.GetInt("FilterNoCase") = 1)
	Loop
	rs.Close

	''''''
	' Sort
	''''''

	TableViewSQLSBsort.SetColumnWidth(0, 20dip)
	TableViewSQLSBsort.SetColumnWidth(1, PaneSQLSBsort.Width - 360dip)
	TableViewSQLSBsort.SetColumnWidth(2, 150dip)
	TableViewSQLSBsort.SetColumnWidth(3, 150dip)
	TableView_SetColumnResizePolicy(TableViewSQLSBsort, False)

	rs = sqlInMemory.ExecQuery2("SELECT * FROM [SortColumns] WHERE [TblName] = ?", Array As String(selectedTable))
	Do While rs.NextRow
		' Setup all views and the TableView row
		Dim cbSortColumn As ChoiceBox
		cbSortColumn.Initialize("ChoiceBoxGeneric")
		cbSortColumn.As(B4XView).Width = TableViewSQLSBsort.GetColumnWidth(1)
		Dim cbOrder As ChoiceBox
		cbOrder.Initialize("ChoiceBoxGeneric")
		cbOrder.As(B4XView).Width = TableViewSQLSBsort.GetColumnWidth(2)
		Dim cbSortNocase As CheckBox
		cbSortNocase.Initialize("CheckBoxGeneric")
		cbSortNocase.As(B4XView).Width = TableViewSQLSBsort.GetColumnWidth(3)
		Dim recordSort(4) As Object
		recordSort(0) = CreateLblDelete(TableViewSQLSBsort)
		recordSort(1) = cbSortColumn
		recordSort(2) = cbOrder
		recordSort(3) = cbSortNocase
		TableViewSQLSBsort.Items.Add(recordSort)
		' Fill the data
		cbSortColumn.Items.AddAll(GetTableColumnsAndAliasesFromSqlInMemory(selectedTable))
		cbSortColumn.SelectedIndex = cbSortColumn.Items.IndexOf(rs.GetString("ColName"))
		cbOrder.Items.AddAll(Array As String("ASC", "DESC"))
		cbOrder.SelectedIndex = cbOrder.Items.IndexOf(rs.GetString("SortOrder"))
		cbSortNocase.Checked = (rs.GetInt("SortNoCase") = 1)
	Loop
	rs.Close

	'''''''''''''''
	' Relationships
	'''''''''''''''

	TableViewSQLSBrelationships.SetColumnWidth(0, 20dip)
	TableViewSQLSBrelationships.SetColumnWidth(1, (PaneSQLSBrelationships.Width - 160dip) / 3)
	TableViewSQLSBrelationships.SetColumnWidth(2, (PaneSQLSBrelationships.Width - 160dip) / 3)
	TableViewSQLSBrelationships.SetColumnWidth(3, (PaneSQLSBrelationships.Width - 160dip) / 3)
	TableViewSQLSBrelationships.SetColumnWidth(4, 100dip)
	TableView_SetColumnResizePolicy(TableViewSQLSBrelationships, False)

	rs = sqlInMemory.ExecQuery2("SELECT * FROM [Relationships] WHERE [TblNameParent] = ?", Array As String(selectedTable))
	Do While rs.NextRow
		' Setup all views and the TableView row
		Dim cbRelationshipColumn As ChoiceBox
		cbRelationshipColumn.Initialize("ChoiceBoxGeneric")
		cbRelationshipColumn.As(B4XView).Width = TableViewSQLSBrelationships.GetColumnWidth(1)
		Dim cbLinkedTable As ChoiceBox
		cbLinkedTable.Initialize("cbLinkedTable")
		cbLinkedTable.As(B4XView).Width = TableViewSQLSBrelationships.GetColumnWidth(2)
		Dim cbLinkedColumn As ChoiceBox
		cbLinkedColumn.Initialize("ChoiceBoxGeneric")
		cbLinkedColumn.As(B4XView).Width = TableViewSQLSBrelationships.GetColumnWidth(3)
		Dim cbJoinType As ChoiceBox
		cbJoinType.Initialize("ChoiceBoxGeneric")
		cbJoinType.As(B4XView).Width = TableViewSQLSBrelationships.GetColumnWidth(4)
		Dim recordRelationships(5) As Object
		recordRelationships(0) = CreateLblDelete(TableViewSQLSBrelationships)
		recordRelationships(1) = cbRelationshipColumn
		recordRelationships(2) = cbLinkedTable
		recordRelationships(3) = cbLinkedColumn
		recordRelationships(4) = cbJoinType
		TableViewSQLSBrelationships.Items.Add(recordRelationships)
		TableViewSQLSBrelationships.SelectedRow = TableViewSQLSBrelationships.Items.Size - 1
		' Fill the data
		cbRelationshipColumn.Items.AddAll(GetTableColumnsAndAliasesFromSqlInMemory(selectedTable))
		cbRelationshipColumn.SelectedIndex = cbRelationshipColumn.Items.IndexOf(rs.GetString("ColNameParent"))
		cbLinkedTable.Items.AddAll(GetSelectedTablesSubsetFromSqlInMemory)
		cbLinkedTable.SelectedIndex = cbLinkedTable.Items.IndexOf(rs.GetString("TblNameChild"))
		If cbLinkedTable.SelectedIndex >= 0 Then
			cbLinkedColumn.Items.AddAll(GetTableColumnsAndAliasesFromSqlInMemory(rs.GetString("TblNameChild")))
			cbLinkedColumn.SelectedIndex = cbLinkedColumn.Items.IndexOf(rs.GetString("ColNameChild"))
		End If
		cbJoinType.Items.AddAll(Array As String("JOIN", "CROSS JOIN", "LEFT JOIN"))
		cbJoinType.SelectedIndex = cbJoinType.Items.IndexOf(rs.GetString("JoinType"))
	Loop
	rs.Close

	''''''''
	' Finish
	''''''''

	RadioButtonSQLSBselectColumns.Selected = True

	Sleep(0) ' Without this, a bunch of 'ListViewSQLSBtables_SelectedIndexChanged' events would be queued up and would fire after the next statement, causing weird situations
	fillingDetailsViews = False
	initialising = False

End Sub

Private Sub ButtonSQLSBrelationshipsJoinTypeHelp_Click

	Dim msg As String = GetLocalisedString("HelpJOIN") & CRLF & CRLF & GetLocalisedString("HelpCROSSJOIN") & CRLF & CRLF & GetLocalisedString("HelpLEFTJOIN")
	Wait For(MsgBoxLongText2(frm, msg, GetLocalisedString("JOIN type"), GetLocalisedString("OK"), "", "", fx.MSGBOX_INFORMATION, 0, 0, xui.Color_Black)) Complete (MsgBoxLongText2Result As Int)

End Sub

' Save the details for the aliases, and for the currently selected table to userData
' 'calledFrom' was used for debugging.
Private Sub SaveUserDataToSqlInMemory(calledFrom As Int)

	LogDebug("SaveUserDataToSqlInMemory; calledFrom=" & calledFrom)

	Dim i As Int
	Dim savedRelationshipColumnsList As List
	Dim rs As ResultSet

	If fillingDetailsViews Then Return
	If selectedTable = "" Then Return

	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	' Get ready: 'sqlInMemory' data will be rebuilt from scratch for the selected table
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	' Save relationships and columns data where the selected table is the child
	' (Foreign key constraints will cause these rows to be deleted, we'll need to restore them)
	sqlInMemory.ExecNonQuery("DROP TABLE IF EXISTS [TmpRelationships]")
	sqlInMemory.ExecNonQuery2("CREATE TABLE [TmpRelationships] AS SELECT * FROM [Relationships] WHERE [TblNameChild] = ?", Array As String(selectedTable))

	' Save Columns data for tables/columns with which the selected table is in a relationship
	' (Foreign key constraints will cause these rows to be deleted, we'll need to restore them)
	savedRelationshipColumnsList.Initialize
	rs = sqlInMemory.ExecQuery2("SELECT [SelectedColumns].[TblName], [SelectedColumns].[ColName], [SelectedColumns].[Id], " & _
										"[Relationships].[TblNameParent], [Relationships].[TblNameChild], [Relationships].[ColNameParent], [Relationships].[ColNameChild] " & _
										"FROM [SelectedColumns] JOIN [Relationships] ON " & _
											"([SelectedColumns].[ColName] = [Relationships].[ColNameParent] Or [SelectedColumns].[ColName] = [Relationships].[ColNameChild]) " & _
										"WHERE ([Relationships].[TblNameParent] = ? OR [Relationships].[TblNameChild] = ?)", Array As String(selectedTable, selectedTable))
	Do While rs.NextRow
		Dim m As Map
		m.Initialize
		m.Put("TblName", rs.GetString("TblName"))
		m.Put("ColName", rs.GetString("ColName"))
		m.Put("Id", rs.GetInt("Id"))
		savedRelationshipColumnsList.Add(m)
	Loop
	rs.Close

	' Delete (to ensure all related data is deleted via the foreign key constraints) and re-create the SelectedTables data
	sqlInMemory.ExecNonQuery2("DELETE FROM [SelectedTables] WHERE [TblName] = ?", Array As String(selectedTable)) ' Because of cascading deletes, this will delete all related data too
	InsertIntoAndIncreaseId("[SelectedTables]", "[TblName], [IsChild]", "?, ?", Array(selectedTable, 0)) ' Re-establish the table's row

	' Restore the SelectedColumns data
	For Each m As Map In savedRelationshipColumnsList
		Try ' Because some rows may still exist, let's let the SQLite engine and Try/Catch handle it instead of further complicating the code
			sqlInMemory.ExecNonQuery2("INSERT INTO [SelectedColumns]([TblName], [ColName], [Id]) VALUES (?, ?, ?)", Array(m.Get("TblName").As(String), m.Get("ColName").As(String), m.Get("Id").As(Int)))
		Catch
			Log("")
		End Try
	Next

	' Restore the Relationships data
	sqlInMemory.ExecNonQuery("INSERT INTO [Relationships]([TblNameParent], [ColNameParent], [TblNameChild], [ColNameChild], [JoinType]) SELECT [TblNameParent], [ColNameParent], [TblNameChild], [ColNameChild], [JoinType] FROM [TmpRelationships]") ' Re-create saved relationships where the selected table is a child
	sqlInMemory.ExecNonQuery("DROP TABLE [TmpRelationships]")

	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	' Process the different datasets in the correct order (see method
	' InitSqlInMemory) so that SQLite constraints aren't jeopardised
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	For Each oneColumnName As String In ListSelectionViewSQLSBselectColumns.TargetItems
		Try ' Because some rows may already exist
			InsertIntoAndIncreaseId("[SelectedColumns]", "[TblName], [ColName]", "?, ?", Array(selectedTable, oneColumnName))
		Catch
			Log("")
		End Try
	Next

	' This next line added 2023-08-19:
	sqlInMemory.ExecNonQuery2("DELETE FROM [FilterColumns] WHERE [TblName] = ?", Array As String(selectedTable)) ' Remove the current table's data from the database; we'll add them back in the For loop
	For i = 0 To (TableViewSQLSBfilterColumns.Items.Size - 1)
		Dim recordFilterColumns(5) As Object = TableViewSQLSBfilterColumns.Items.Get(i)
		Dim cbColumn As ChoiceBox = recordFilterColumns(1)
		Dim cbOperator As ChoiceBox = recordFilterColumns(2)
		Dim tfValue As TextField = recordFilterColumns(3)
		Dim cbNocase As CheckBox = recordFilterColumns(4)
		Dim operator As String = IIf(cbOperator.SelectedIndex < 0, "", cbOperator.Items.Get(cbOperator.SelectedIndex))
		Select Case operator
			Case GetLocalisedString("Starts with")
				operator = "Starts with"
			Case GetLocalisedString("Contains")
				operator = "Contains"
			Case GetLocalisedString("Ends with")
				operator = "Ends with"
		End Select
		If AllDetailsValuesArePresent(Array(cbColumn, cbOperator), False) Then
			' "OR IGNORE": to avoid errors when a primary key combination was used twice
			sqlInMemory.ExecNonQuery2("INSERT OR IGNORE INTO [FilterColumns] ([TblName], [ColName], [FilterOperator], [FilterValue], [FilterNoCase]) VALUES (?, ?, ?, ?, ?)", Array(selectedTable, cbColumn.Items.Get(cbColumn.SelectedIndex), operator, tfValue.Text, IIf(cbNocase.Checked, 1, 0)))
		End If
	Next

	' This next line added 2023-08-19:
	sqlInMemory.ExecNonQuery2("DELETE FROM [SortColumns] WHERE [TblName] = ?", Array As String(selectedTable)) ' Remove the current table's data from the database; we'll add them back in the For loop
	For i = 0 To (TableViewSQLSBsort.Items.Size - 1)
		Dim recordSort(4) As Object = TableViewSQLSBsort.Items.Get(i)
		Dim cbColumn As ChoiceBox = recordSort(1)
		Dim cbOrder As ChoiceBox = recordSort(2)
		Dim cbNocase As CheckBox = recordSort(3)
		If AllDetailsValuesArePresent(Array(cbColumn, cbOrder), False) Then
			' "OR IGNORE": to avoid errors when a primary key combination was used twice
			sqlInMemory.ExecNonQuery2("INSERT OR IGNORE INTO [SortColumns] ([TblName], [ColName], [SortOrder], [SortNoCase]) VALUES (?, ?, ?, ?)", Array(selectedTable, cbColumn.Items.Get(cbColumn.SelectedIndex), cbOrder.Items.Get(cbOrder.SelectedIndex), IIf(cbNocase.Checked, 1, 0)))
		End If
	Next

	For i = 0 To (TableViewSQLSBrelationships.Items.Size - 1)
		Dim recordRelationships(5) As Object = TableViewSQLSBrelationships.Items.Get(i)
		Dim cbColumn As ChoiceBox = recordRelationships(1)
		Dim cbLinkedTable As ChoiceBox = recordRelationships(2)
		Dim cbLinkedColumn As ChoiceBox = recordRelationships(3)
		Dim cbJoinType As ChoiceBox = recordRelationships(4)
		If AllDetailsValuesArePresent(Array(cbColumn, cbLinkedTable, cbLinkedColumn, cbJoinType), False) Then
			' Ensure the linked table and linked column are present or added first
			Try
				InsertIntoAndIncreaseId("[SelectedTables]", "[TblName], [IsChild]", "?, ?", Array(cbLinkedTable.Items.Get(cbLinkedTable.SelectedIndex), 1))
			Catch
				Log("")
			End Try
			Try
				InsertIntoAndIncreaseId("[SelectedColumns]", "[TblName], [ColName]", "?, ?", Array(cbLinkedTable.Items.Get(cbLinkedTable.SelectedIndex), cbLinkedColumn.Items.Get(cbLinkedColumn.SelectedIndex)))
			Catch
				Log("")
			End Try
			sqlInMemory.ExecNonQuery2("INSERT INTO [Relationships] ([TblNameParent], [ColNameParent], [TblNameChild], [ColNameChild], [JoinType]) VALUES (?, ?, ?, ?, ?)", Array(selectedTable, cbColumn.Items.Get(cbColumn.SelectedIndex), cbLinkedTable.Items.Get(cbLinkedTable.SelectedIndex), cbLinkedColumn.Items.Get(cbLinkedColumn.SelectedIndex), cbJoinType.Items.Get(cbJoinType.SelectedIndex)))
		End If
	Next

	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	' Flag the tables that are used as 'children' in relationships
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	sqlInMemory.ExecNonQuery("UPDATE [SelectedTables] SET [IsChild] = 0")
	sqlInMemory.ExecNonQuery("UPDATE [SelectedTables] SET [IsChild] = 1 WHERE [TblName] IN (SELECT [TblNameChild] FROM [Relationships])")

End Sub

Private Sub RadioButtonSQLSB_SelectedChange(Selected As Boolean)

	If Selected Then
		Dim rb As RadioButton = Sender
		UpdatePanesVisibility(rb.Tag.As(String))
	End If

End Sub

' Make the appropriate pane visible, and hide all others
Private Sub UpdatePanesVisibility(rbTag As String)

	PaneSQLSBtables.Visible = False
	PaneSQLSBtableAliases.Visible = False
	PaneSQLSBcolumnAliases.Visible = False
	PaneSQLSBselectColumns.Visible = False
	PaneSQLSBfilterColumns.Visible = False
	PaneSQLSBsort.Visible = False
	PaneSQLSBrelationships.Visible = False
	PaneSQLSBtest.Visible = False
	PaneSQLSBdetails.Visible = False
	ButtonSQLSBtables.Visible = True
	Sleep(0)

	Select Case rbTag
		Case "Column aliases", "Table aliases", "Test"
		Case Else
			If selectedTable = "" Then rbTag = "Tables"
	End Select

	Select Case rbTag
		Case ""
			Return
		Case "Column aliases" ' Note: this is not a value from one of the RadioButton tags!
			PaneSQLSBcolumnAliases.Visible = True
		Case "Table aliases" ' Note: this is not a value from one of the RadioButton tags!
			PaneSQLSBtableAliases.Visible = True
		Case "Tables" ' Note: this is not a value from one of the RadioButton tags!
			PaneSQLSBtables.Visible = True
			ButtonSQLSBtables.Visible = False
			InitListViewSQLSBtables
			DrawWmWiLNetChartSQLSB ' Save userData and update the chart
		Case "Test" ' Note: this is not a value from one of the RadioButton tags!
			PaneSQLSBtest.Visible = True
		Case GetLocalisedString("Select columns")
			PaneSQLSBselectColumns.Visible = True
			PaneSQLSBdetails.Visible = True
		Case GetLocalisedString("Filter columns")
			PaneSQLSBfilterColumns.Visible = True
			PaneSQLSBdetails.Visible = True
		Case GetLocalisedString("Sort")
			PaneSQLSBsort.Visible = True
			PaneSQLSBdetails.Visible = True
		Case GetLocalisedString("Relationships")
			PaneSQLSBrelationships.Visible = True
			PaneSQLSBdetails.Visible = True
		Case Else
			' This should not happen; if it does, it means something was overlooked in the code
			fx.Msgbox(frm, "Unexpected value in UpdatePanesVisibility: " & rbTag, "Coding error")
			Log("Unexpected value in UpdatePanesVisibility: " & rbTag)
			Return
	End Select

End Sub

Private Sub ButtonSQLSBbuild_Click

	Dim selectedColumns As List
	Dim whereClause As String = ""
	Dim orderClause As String = ""
	Dim joinClause As String = ""
	Dim firstTableName As String = ""
	Dim firstTableNameFinal As String
	Dim rs As ResultSet
	Dim rs2 As ResultSet
	Dim curTableName As String
	Dim finalColumnName As String
	Dim finalLinkedColumnName As String

	UpdatePanesVisibility("Tables")
	SaveUserDataToSqlInMemory(7)
	selectedColumns.Initialize

	If sqlInMemory.ExecQuerySingleResult("SELECT count([TblName]) FROM [SelectedTables] WHERE [IsChild]=0").As(Int) > 1 Then
		Wait For(MsgBoxLongText2(frm, GetLocalisedString("Warning: there should be only one top-level table"), myTitle, GetLocalisedString("OK"), "", "", fx.MSGBOX_WARNING, 0, 0, xui.Color_Black)) Complete (MsgBoxLongText2Result As Int)
	End If

	' Determine the first table, i.e. the one that will used in the SELECT's FROM clause
	rs = sqlInMemory.ExecQuery("SELECT * FROM [SelectedTables]")
	Do While rs.NextRow
		curTableName = rs.GetString("TblName")
		If sqlInMemory.ExecQuerySingleResult2("SELECT count([TblNameChild]) FROM [Relationships] WHERE [TblNameChild]=? COLLATE NOCASE", Array As String(rs.GetString("TblName"))).As(Int) < 1 Then
			firstTableName = curTableName
			Exit
		End If
		If firstTableName = "" Then firstTableName = curTableName
	Loop
	rs.Close

	rs = sqlInMemory.ExecQuery("SELECT * FROM [SelectedTables]")
	Do While rs.NextRow
		curTableName = rs.GetString("TblName")
		' Process the selected columns to include
		rs2 = sqlInMemory.ExecQuery2("SELECT * FROM [SelectedColumns] WHERE [TblName] = ?", Array As String(curTableName))
		Do While rs2.NextRow
			Dim actualColName As String = GetActualColumnFromSqlInMemory(rs2.GetString("TblName"), rs2.GetString("ColName"))
			If rs2.GetString("ColName") = actualColName Then
				selectedColumns.Add(CombineTableAndColumn(curTableName, rs2.GetString("ColName")))
			Else
				selectedColumns.Add(CombineTableAndColumn(curTableName, actualColName) & " AS [" & rs2.GetString("ColName") & "]")
			End If
		Loop
		rs2.Close
		' Process the filter columns
		rs2 = sqlInMemory.ExecQuery2("SELECT * FROM [FilterColumns] WHERE [TblName] = ?", Array As String(curTableName))
		Do While rs2.NextRow
			Dim oneColumnName As String = rs2.GetString("ColName")
			Dim operator As String = rs2.GetString("FilterOperator")
			Dim value As String = rs2.GetString("FilterValue").Replace("'", "''") ' Escape single quotes in the values
			Dim nocase As Boolean = (rs2.GetInt("FilterNoCase") = 1)
			If whereClause = "" Then
				whereClause = " WHERE ("
			Else
				whereClause = whereClause & " AND"
			End If
			finalColumnName = GetActualColumnFromSqlInMemory(curTableName, oneColumnName)
			If finalColumnName = oneColumnName Then
				finalColumnName = CombineTableAndColumn(curTableName, oneColumnName)
			Else ' oneColumnName is an alias; don't add the table name qualifier
				finalColumnName = EncloseInSquareBrackets(oneColumnName)
			End If
			Select Case operator
				Case "Starts with"
					whereClause = whereClause & " " & finalColumnName & " LIKE '" & value & "%'"
				Case "Contains"
					whereClause = whereClause & " " & finalColumnName & " LIKE '%" & value & "%'"
				Case "Ends with"
					whereClause = whereClause & " " & finalColumnName & " LIKE '%" & value & "'"
				Case Else
					whereClause = whereClause & " " & finalColumnName & operator & "'" & value & "'"
					If nocase Then whereClause = whereClause & " COLLATE NOCASE" ' Note: 'LIKE' is always case-insensitive
			End Select
		Loop
		rs2.Close
		' Process the sort columns
		rs2 = sqlInMemory.ExecQuery2("SELECT * FROM [SortColumns] WHERE [TblName] = ?", Array As String(curTableName))
		Do While rs2.NextRow
			Dim oneColumnName As String = rs2.GetString("ColName")
			Dim order As String = rs2.GetString("SortOrder")
			Dim nocase As Boolean = (rs2.GetInt("SortNoCase") = 1)
			If nocase Then order = "COLLATE NOCASE " & order
			If orderClause = "" Then
				orderClause = " ORDER BY"
			Else
				orderClause = orderClause & ","
			End If
			finalColumnName = GetActualColumnFromSqlInMemory(curTableName, oneColumnName)
			If finalColumnName = oneColumnName Then
				finalColumnName = CombineTableAndColumn(curTableName, oneColumnName)
			Else ' oneColumnName is an alias; don't add the table name qualifier
				finalColumnName = EncloseInSquareBrackets(oneColumnName)
			End If
			orderClause = orderClause & " " & finalColumnName & " " & order
		Loop
		rs2.Close
		' Process the relationships
		rs2 = sqlInMemory.ExecQuery2("SELECT * FROM [Relationships] WHERE [TblNameParent] = ?", Array As String(curTableName))
		Do While rs2.NextRow
			Dim oneColumnName As String = rs2.GetString("ColNameParent")
			Dim linkedTable As String = rs2.GetString("TblNameChild")
			Dim linkedColumn As String = rs2.GetString("ColNameChild")
			Dim joinType As String = rs2.GetString("JoinType")
			Dim linkedTableFinal As String = GetActualTableFromSqlInMemory(linkedTable)
			If linkedTableFinal = linkedTable Then
				linkedTableFinal = EncloseInSquareBrackets(linkedTable)
			Else
				linkedTableFinal = EncloseInSquareBrackets(linkedTableFinal) & " AS " & EncloseInSquareBrackets(linkedTable)
			End If
			Select Case joinType
				Case "JOIN", "LEFT JOIN"
					finalColumnName = GetActualColumnFromSqlInMemory(curTableName, oneColumnName)
					If finalColumnName = oneColumnName Then
						finalColumnName = CombineTableAndColumn(curTableName, oneColumnName)
					Else ' oneColumnName is an alias; don't add the table name qualifier
						finalColumnName = EncloseInSquareBrackets(oneColumnName)
					End If
					finalLinkedColumnName = GetActualColumnFromSqlInMemory(linkedTable, linkedColumn)
					If finalLinkedColumnName = oneColumnName Then
						finalLinkedColumnName = CombineTableAndColumn(linkedTable, linkedColumn)
					Else ' oneColumnName is an alias; don't add the table name qualifier
						finalLinkedColumnName = EncloseInSquareBrackets(linkedColumn)
					End If
					joinClause = joinClause & " " & joinType & " " & linkedTableFinal & _
								" ON " & finalColumnName & "=" & finalLinkedColumnName
				Case Else ' "CROSS JOIN"
					joinClause = joinClause & " CROSS JOIN " & linkedTableFinal
			End Select
		Loop
		rs2.Close
	Loop
	rs.Close
	If whereClause <> "" Then whereClause = whereClause & " )"

	' Compose the SELECT statement
	TextAreaSQLSBoutput.Visible = False
	selectedColumns.SortCaseInsensitive(True)
	TextAreaSQLSBoutput.Text = "SELECT "
	If selectedColumns.Size > 0 Then
		For Each oneColumnName As String In selectedColumns
			TextAreaSQLSBoutput.Text = TextAreaSQLSBoutput.Text & oneColumnName & ", "
		Next
		TextAreaSQLSBoutput.Text = TextAreaSQLSBoutput.Text.SubString2(0, TextAreaSQLSBoutput.Text.Length - 2) ' Remove the trailing comma and space
	End If

	firstTableNameFinal = GetActualTableFromSqlInMemory(firstTableName)
	If firstTableNameFinal = firstTableName Then
		firstTableNameFinal = EncloseInSquareBrackets(firstTableName)
	Else
		firstTableNameFinal = EncloseInSquareBrackets(firstTableNameFinal) & " AS " & EncloseInSquareBrackets(firstTableName)
	End If

	TextAreaSQLSBoutput.Text = TextAreaSQLSBoutput.Text & _
							" FROM " & firstTableNameFinal & _
							joinClause & whereClause & orderClause

	' A successful 'Build' was done
	ButtonSQLSBok.Visible = True
	ButtonSQLSBtest.Visible = True
	TextAreaSQLSBoutput.Visible = True

End Sub

Private Sub ButtonSQLSBtest_Click

	Dim rs As ResultSet
	Dim columnNames As List
	Dim i As Int
	Dim lastColumnBase0 As Int

	ButtonSQLSBtables.Visible = True

	Try
		rs = sql1.ExecQuery(TextAreaSQLSBoutput.Text)
		lastColumnBase0 = rs.ColumnCount - 1
	Catch
		Wait For (MsgBoxLongText2(frm, LastException, GetLocalisedString("Error"), "", GetLocalisedString("Cancel"), "", fx.MSGBOX_ERROR, 0, 0, xui.Color_Red)) Complete (MsgBoxLongText2Result As Int)
		Return
	End Try

	UpdatePanesVisibility("Test")
	TableViewSQLSBtest.Visible = False
	LabelSQLSBtestNumRows.Visible = False
	Sleep(0)

	SetTableViewPlaceHolderText(TableViewSQLSBtest, GetLocalisedString("No data found"))
	TableViewSQLSBtest.Items.Clear
	columnNames.Initialize
	For i = 0 To lastColumnBase0
		columnNames.Add(rs.GetColumnName(i))
	Next
	TableViewSQLSBtest.SetColumns(columnNames)
	For i = 0 To lastColumnBase0
		TableViewSQLSBtest.SetColumnSortable(i, True)
	Next

	Do While rs.NextRow
		Dim record(lastColumnBase0 + 1) As Object
		For i = 0 To lastColumnBase0
			record(i) = rs.GetString2(i)
			' Make the column widths fit the contents
			Dim dbl As Double = GetTextWidth(rs.GetString2(i), fx.DefaultFont(15)) ' For this to work properly, the specified font size must be the same as the TableView's in the Designer!
			If dbl > TableViewSQLSBtest.GetColumnWidth(i) Then TableViewSQLSBtest.SetColumnWidth(i, dbl)
		Next
		TableViewSQLSBtest.Items.Add(record)
	Loop
	rs.Close

	' Make the column widths fit the contents: take the headers into account
	Dim fnt15bold As Font = fx.CreateFont("DEFAULT", 15, True, False) ' For the following to work properly, the specified font size must be the same as the TableView's in the Designer!
	For i = 0 To lastColumnBase0
		Dim dbl As Double = GetTextWidth(TableViewSQLSBtest.GetColumnHeader(i), fnt15bold)
		If dbl > TableViewSQLSBtest.GetColumnWidth(i) Then TableViewSQLSBtest.SetColumnWidth(i, dbl)
	Next

	LabelSQLSBtestNumRows.Text = GetLocalisedString("Number of qualifying rows found") & ": " & TableViewSQLSBtest.Items.Size
	TableViewSQLSBtest.Visible = True
	LabelSQLSBtestNumRows.Visible = True

End Sub

#Region TableViews add/delete rows
Private Sub ButtonSQLSBcolumnAliasesAdd_Click

	' If there is an incomplete row, don't add a new one but select the incomplete one
	For i = 0 To (TableViewSQLSBcolumnAliases.Items.Size - 1)
		Dim recordcolumnAliases(3) As Object = TableViewSQLSBcolumnAliases.Items.Get(i)
		Dim cbColumn As ChoiceBox = recordcolumnAliases(1)
		Dim tfValue As TextField = recordcolumnAliases(2)
		If AllDetailsValuesArePresent(Array(cbColumn, tfValue), True) = False Then
			cbColumn.RequestFocus
			Return
		End If
	Next

	Dim cbColumn As ChoiceBox
	cbColumn.Initialize("cbColumnAlias")
	cbColumn.As(B4XView).Width = TableViewSQLSBcolumnAliases.GetColumnWidth(1)
	cbColumn.Items.AddAll(GetAllColumnsForAliasesFromSqlInMemory)
	cbColumn.SelectedIndex = -1

	Dim tfColumnAlias As TextField
	tfColumnAlias.Initialize("tfColumnAlias")
	tfColumnAlias.As(B4XView).Width = TableViewSQLSBcolumnAliases.GetColumnWidth(2)
	tfColumnAlias.Text = ""

	' Set the tags; they will be used in the Process...Alias method
	cbColumn.Tag = CreateWmSQLSBaliasTextFieldTag(cbColumn, tfColumnAlias, -1)
	tfColumnAlias.Tag = CreateWmSQLSBaliasTextFieldTag(cbColumn, tfColumnAlias, -1)

	Dim record(3) As Object
	record(0) = CreateLblDelete(TableViewSQLSBcolumnAliases)
	record(1) = cbColumn
	record(2) = tfColumnAlias

	TableViewSQLSBcolumnAliases.Items.Add(record)
	TableViewSQLSBcolumnAliases.SelectedRow = TableViewSQLSBcolumnAliases.Items.Size - 1

End Sub

Private Sub cbColumnAlias_SelectedIndexChanged(Index As Int, Value As Object)

	Dim cb As ChoiceBox = Sender
	Dim cbTag As wmSQLSBaliasTextFieldTag = cb.Tag
	ProcessColumnAlias(cb, cbTag.tf)

End Sub

Private Sub tfColumnAlias_FocusChanged(HasFocus As Boolean)

	Dim tf As TextField = Sender
	Dim tfTag As wmSQLSBaliasTextFieldTag = tf.Tag

	If HasFocus Then Return ' The validations must be done when the focus is lost

	tf.Text = tf.Text.Trim
	If tf.Text = "" Then Return

	If tf.Text <> MakeValidSQLiteName(tf.Text) Then ' Text contains invalid characters
		Wait For(MsgBoxLongText2(frm, GetLocalisedString("Invalid column name") & ": " & tf.Text, myTitle, GetLocalisedString("OK"), "", "", fx.MSGBOX_ERROR, 0, 0, xui.Color_Black)) Complete (MsgBoxLongText2Result As Int)
		tf.RequestFocus
		Return
	End If

	If NameAlreadyExistsAsAlias(tf.Text) Then
		Wait For(MsgBoxLongText2(frm, GetLocalisedString("This name already exists as an alias") & ": " & tf.Text, myTitle, GetLocalisedString("OK"), "", "", fx.MSGBOX_ERROR, 0, 0, xui.Color_Black)) Complete (MsgBoxLongText2Result As Int)
		tf.RequestFocus
		Return
	End If

	ProcessColumnAlias(tfTag.cb, tf)

End Sub

' Add/update the entry to/in sqlInMemory; as the aliases collection isn't related to one column, method
' SaveUserDataToSqlInMemory won't save them, which is why this separate method is needed
Private Sub ProcessColumnAlias(cb As ChoiceBox, tf As TextField)

	Dim tfTag As wmSQLSBaliasTextFieldTag = tf.Tag
	Dim cbTag As wmSQLSBaliasTextFieldTag = cb.Tag

	' Only process if both values are present
	If cb.SelectedIndex < 0 Then Return
	If tf.Text = "" Then Return

	Dim oneColumn As wmSQLSBcolumnAliasDetails = CreateWmSQLSBcolumnAliasDetails(cb.Items.Get(cb.SelectedIndex).As(String))

	' Ensure the table's row exists in TablesAndAliases
	Try
		InsertIntoAndIncreaseId("[TablesAndAliases]", "[TblName], [IsAliasFor]", "?, ?", Array(oneColumn.tblName, oneColumn.tblName))
	Catch
		Log("")
	End Try

	If tfTag.id < 0 Then
		InsertIntoAndIncreaseId("[ColumnsAndAliases]", "[TblName], [ColName], [IsAliasFor]", "?, ?, ?", Array(oneColumn.tblName, tf.Text, oneColumn.colName))
		tfTag.id = newMaxId
		tf.Tag = tfTag
		cbTag.id = newMaxId
		cb.Tag = cbTag
	Else
		sqlInMemory.ExecNonQuery2("UPDATE [ColumnsAndAliases] SET [ColName] = ?, [IsAliasFor] = ? WHERE [Id] = ?", Array As String(tf.Text, oneColumn.colName, tfTag.id))
	End If

End Sub

Private Sub ButtonSQLSBtableAliasesAdd_Click

	' If there is an incomplete row, don't add a new one but select the incomplete one
	For i = 0 To (TableViewSQLSBtableAliases.Items.Size - 1)
		Dim recordTableAliases(3) As Object = TableViewSQLSBtableAliases.Items.Get(i)
		Dim cbTable As ChoiceBox = recordTableAliases(1)
		Dim tfValue As TextField = recordTableAliases(2)
		If AllDetailsValuesArePresent(Array(cbTable, tfValue), True) = False Then
			cbTable.RequestFocus
			Return
		End If
	Next

	Dim cbTable As ChoiceBox
	cbTable.Initialize("cbTableAlias")
	cbTable.As(B4XView).Width = TableViewSQLSBtableAliases.GetColumnWidth(1)
	cbTable.Items.AddAll(SQLiteGetTables(sql1))
	cbTable.SelectedIndex = -1

	Dim tfTableAlias As TextField
	tfTableAlias.Initialize("tfTableAlias")
	tfTableAlias.As(B4XView).Width = TableViewSQLSBtableAliases.GetColumnWidth(2)
	tfTableAlias.Text = ""

	' Set the tags; they will be used in the Process...Alias method
	cbTable.Tag = CreateWmSQLSBaliasTextFieldTag(cbTable, tfTableAlias, -1)
	tfTableAlias.Tag = CreateWmSQLSBaliasTextFieldTag(cbTable, tfTableAlias, -1)

	Dim record(3) As Object
	record(0) = CreateLblDelete(TableViewSQLSBtableAliases)
	record(1) = cbTable
	record(2) = tfTableAlias

	TableViewSQLSBtableAliases.Items.Add(record)
	TableViewSQLSBtableAliases.SelectedRow = TableViewSQLSBtableAliases.Items.Size - 1

End Sub

Private Sub cbTableAlias_SelectedIndexChanged(Index As Int, Value As Object)

	Dim cb As ChoiceBox = Sender
	Dim cbTag As wmSQLSBaliasTextFieldTag = cb.Tag
	ProcessTableAlias(cb, cbTag.tf)

End Sub

Private Sub tfTableAlias_FocusChanged(HasFocus As Boolean)

	Dim tf As TextField = Sender
	Dim tfTag As wmSQLSBaliasTextFieldTag = tf.Tag

	If HasFocus Then Return ' The validations must be done when the focus is lost

	tf.Text = tf.Text.Trim
	If tf.Text = "" Then Return

	If tf.Text <> MakeValidSQLiteName(tf.Text) Then ' Text contains invalid characters
		Wait For(MsgBoxLongText2(frm, GetLocalisedString("Invalid table name") & ": " & tf.Text, myTitle, GetLocalisedString("OK"), "", "", fx.MSGBOX_ERROR, 0, 0, xui.Color_Black)) Complete (MsgBoxLongText2Result As Int)
		tf.RequestFocus
		Return
	End If

	If SQLiteTableExists(sql1, tf.Text) Then
		Wait For(MsgBoxLongText2(frm, GetLocalisedString("This name already exists for a table") & ": " & tf.Text, myTitle, GetLocalisedString("OK"), "", "", fx.MSGBOX_ERROR, 0, 0, xui.Color_Black)) Complete (MsgBoxLongText2Result As Int)
		tf.RequestFocus
		Return
	End If

	If NameAlreadyExistsAsAlias(tf.Text) Then
		Wait For(MsgBoxLongText2(frm, GetLocalisedString("This name already exists as an alias") & ": " & tf.Text, myTitle, GetLocalisedString("OK"), "", "", fx.MSGBOX_ERROR, 0, 0, xui.Color_Black)) Complete (MsgBoxLongText2Result As Int)
		tf.RequestFocus
		Return
	End If

	ProcessTableAlias(tfTag.cb, tf)

End Sub

' Add/update the entry to/in sqlInMemory; as the aliases collection isn't related to one table, method
' SaveUserDataToSqlInMemory won't save them, which is why this separate method is needed
Private Sub ProcessTableAlias(cb As ChoiceBox, tf As TextField)

	Dim tfTag As wmSQLSBaliasTextFieldTag = tf.Tag
	Dim cbTag As wmSQLSBaliasTextFieldTag = cb.Tag

	' Only process if both values are present
	If cb.SelectedIndex < 0 Then Return
	If tf.Text = "" Then Return

	If tfTag.id < 0 Then
		Dim theTable As String = cb.Items.Get(cb.SelectedIndex).As(String)
		InsertIntoAndIncreaseId("[TablesAndAliases]", "[TblName], [IsAliasFor]", "?, ?", Array(tf.Text, theTable))
		tfTag.id = newMaxId
		tf.Tag = tfTag
		cbTag.id = newMaxId
		cb.Tag = cbTag
		For Each oneColumn As String In SQLiteGetTableColumnNames2(sql1, GetActualTableFromSqlInMemory(theTable), True)
			InsertIntoAndIncreaseId("[ColumnsAndAliases]", "[TblName], [ColName], [IsAliasFor]", "?, ?, ?", Array As String(tf.Text, oneColumn, oneColumn))
		Next
	Else
		sqlInMemory.ExecNonQuery2("UPDATE [TablesAndAliases] SET [TblName] = ?, [IsAliasFor] = ? WHERE [Id] = ?", Array As String(tf.Text, cb.Items.Get(cb.SelectedIndex).As(String), tfTag.id))
	End If

End Sub

Private Sub NameAlreadyExistsAsAlias(name As String) As Boolean

	Dim i As Int
	Dim numFound As Int = 0

	For i = 0 To (TableViewSQLSBtableAliases.Items.Size - 1)
		Dim recordTableAliases(3) As Object = TableViewSQLSBtableAliases.Items.Get(i)
		Dim tfTableAlias As TextField = recordTableAliases(2)
		If tfTableAlias.Text.Trim.EqualsIgnoreCase(name.Trim) Then
			numFound = numFound + 1
			If numFound > 1 Then Return True
		End If
	Next

	For i = 0 To (TableViewSQLSBcolumnAliases.Items.Size - 1)
		Dim recordColumnAliases(3) As Object = TableViewSQLSBcolumnAliases.Items.Get(i)
		Dim tfColumnAlias As TextField = recordColumnAliases(2)
		If tfColumnAlias.Text.Trim.EqualsIgnoreCase(name.Trim) Then
			numFound = numFound + 1
			If numFound > 1 Then Return True
		End If
	Next

	Return False

End Sub

Private Sub ButtonSQLSBfilterColumnsAdd_Click

	' If there is an incomplete row, don't add a new one but select the incomplete one
	For i = 0 To (TableViewSQLSBfilterColumns.Items.Size - 1)
		Dim recordFilterColumns(5) As Object = TableViewSQLSBfilterColumns.Items.Get(i)
		Dim cbColumn As ChoiceBox = recordFilterColumns(1)
		Dim cbOperator As ChoiceBox = recordFilterColumns(2)
		If AllDetailsValuesArePresent(Array(cbColumn, cbOperator), False) = False Then
			cbColumn.RequestFocus
			Return
		End If
	Next

	Dim cbColumn As ChoiceBox
	cbColumn.Initialize("ChoiceBoxGeneric")
	cbColumn.As(B4XView).Width = TableViewSQLSBfilterColumns.GetColumnWidth(1)
	cbColumn.Items.AddAll(GetTableColumnsAndAliasesFromSqlInMemory(selectedTable))
	cbColumn.SelectedIndex = -1

	Dim cbOperator As ChoiceBox
	cbOperator.Initialize("ChoiceBoxGeneric")
	cbOperator.As(B4XView).Width = TableViewSQLSBfilterColumns.GetColumnWidth(2)
	cbOperator.Items.AddAll(Array As String("=", "<>", ">", ">=", "<", "<=", GetLocalisedString("Starts with"), GetLocalisedString("Contains"), GetLocalisedString("Ends with")))
	cbOperator.SelectedIndex = -1

	Dim tfValue As TextField
	tfValue.Initialize("TextFieldGeneric")
	tfValue.As(B4XView).Width = TableViewSQLSBfilterColumns.GetColumnWidth(3)
	tfValue.Text = ""

	Dim cbNocase As CheckBox
	cbNocase.Initialize("CheckBoxGeneric")
	cbNocase.As(B4XView).Width = TableViewSQLSBfilterColumns.GetColumnWidth(4)

	Dim record(5) As Object
	record(0) = CreateLblDelete(TableViewSQLSBfilterColumns)
	record(1) = cbColumn
	record(2) = cbOperator
	record(3) = tfValue
	record(4) = cbNocase

	TableViewSQLSBfilterColumns.Items.Add(record)
	TableViewSQLSBfilterColumns.SelectedRow = TableViewSQLSBfilterColumns.Items.Size - 1

End Sub

Private Sub ButtonSQLSBsortAdd_Click

	' If there is an incomplete row, don't add a new one but select the incomplete one
	For i = 0 To (TableViewSQLSBsort.Items.Size - 1)
		Dim recordSort(4) As Object = TableViewSQLSBsort.Items.Get(i)
		Dim cbColumn As ChoiceBox = recordSort(1)
		Dim cbOrder As ChoiceBox = recordSort(2)
		If AllDetailsValuesArePresent(Array(cbColumn, cbOrder), False) = False Then
			cbColumn.RequestFocus
			Return
		End If
	Next

	Dim cbColumn As ChoiceBox
	cbColumn.Initialize("ChoiceBoxGeneric")
	cbColumn.As(B4XView).Width = TableViewSQLSBsort.GetColumnWidth(1)
	cbColumn.Items.AddAll(GetTableColumnsAndAliasesFromSqlInMemory(selectedTable))
	cbColumn.SelectedIndex = -1

	Dim cbOrder As ChoiceBox
	cbOrder.Initialize("ChoiceBoxGeneric")
	cbOrder.As(B4XView).Width = TableViewSQLSBsort.GetColumnWidth(2)
	cbOrder.Items.AddAll(Array As String("ASC", "DESC"))
	cbOrder.SelectedIndex = -1

	Dim cbNocase As CheckBox
	cbNocase.Initialize("CheckBoxGeneric")
	cbNocase.As(B4XView).Width = TableViewSQLSBsort.GetColumnWidth(3)

	Dim record(4) As Object
	record(0) = CreateLblDelete(TableViewSQLSBsort)
	record(1) = cbColumn
	record(2) = cbOrder
	record(3) = cbNocase

	TableViewSQLSBsort.Items.Add(record)
	TableViewSQLSBsort.SelectedRow = TableViewSQLSBsort.Items.Size - 1

End Sub

Private Sub ButtonSQLSBrelationshipsAdd_Click

	' If there is an incomplete row, don't add a new one but select the incomplete one
	For i = 0 To (TableViewSQLSBrelationships.Items.Size - 1)
		Dim recordRelationships(5) As Object = TableViewSQLSBrelationships.Items.Get(i)
		Dim cbColumn As ChoiceBox = recordRelationships(1)
		Dim cbLinkedTable As ChoiceBox = recordRelationships(2)
		Dim cbLinkedColumn As ChoiceBox = recordRelationships(3)
		Dim cbJoinType As ChoiceBox = recordRelationships(4)
		If AllDetailsValuesArePresent(Array(cbColumn, cbLinkedTable, cbLinkedColumn, cbJoinType), False) = False Then
			cbColumn.RequestFocus
			Return
		End If
	Next

	Dim cbColumn As ChoiceBox
	cbColumn.Initialize("ChoiceBoxGeneric")
	cbColumn.As(B4XView).Width = TableViewSQLSBrelationships.GetColumnWidth(1)
	cbColumn.Items.AddAll(GetTableColumnsAndAliasesFromSqlInMemory(selectedTable))
	cbColumn.SelectedIndex = -1

	Dim cbLinkedTable As ChoiceBox
	cbLinkedTable.Initialize("cbLinkedTable")
	cbLinkedTable.As(B4XView).Width = TableViewSQLSBrelationships.GetColumnWidth(2)
	cbLinkedTable.Items.AddAll(GetSelectedTablesSubsetFromSqlInMemory)
	cbLinkedTable.SelectedIndex = -1

	Dim cbLinkedColumn As ChoiceBox
	cbLinkedColumn.Initialize("ChoiceBoxGeneric")
	cbLinkedColumn.As(B4XView).Width = TableViewSQLSBrelationships.GetColumnWidth(3)
	cbLinkedColumn.SelectedIndex = -1

	Dim cbJoinType As ChoiceBox
	cbJoinType.Initialize("ChoiceBoxGeneric")
	cbJoinType.As(B4XView).Width = TableViewSQLSBrelationships.GetColumnWidth(4)
	cbJoinType.Items.AddAll(Array As String("JOIN", "CROSS JOIN", "LEFT JOIN"))
	cbJoinType.SelectedIndex = -1

	Dim record(5) As Object
	record(0) = CreateLblDelete(TableViewSQLSBrelationships)
	record(1) = cbColumn
	record(2) = cbLinkedTable
	record(3) = cbLinkedColumn
	record(4) = cbJoinType

	TableViewSQLSBrelationships.Items.Add(record)
	TableViewSQLSBrelationships.SelectedRow = TableViewSQLSBrelationships.Items.Size - 1

End Sub

Private Sub cbLinkedTable_SelectedIndexChanged(Index As Int, Value As Object)

	If fillingDetailsViews Then Return ' Don't process this event while filling the views with data from sqlInMemory

	Dim recordRelationships(5) As Object = TableViewSQLSBrelationships.Items.Get(TableViewSQLSBrelationships.SelectedRow)
	Dim cbLinkedColumn As ChoiceBox = recordRelationships(3)
	cbLinkedColumn.Items.Clear
	cbLinkedColumn.Items.AddAll(GetTableColumnsAndAliasesFromSqlInMemory(Value.As(String)))

	SaveUserDataToSqlInMemory(8)

End Sub

' Create a 'delete' label with a FontAwesome trashcan character for a TableView
Private Sub CreateLblDelete (tv As TableView) As Label

	Dim t1 As wmSQLSBdeleteButtonTag
	t1.Initialize
	t1.tv = tv
	deleteId = deleteId + 1
	t1.id = deleteId

	Dim lbl As Label
	lbl.Initialize("lblDelete")
	lbl.SetLayoutAnimated(0, 0, 0, tv.GetColumnWidth(0), tv.GetColumnWidth(0))
	lbl.TextColor = fx.Colors.Red
	lbl.Font = fx.CreateFontAwesome(12)
	lbl.Text = Chr(0xF014)
	lbl.Tag = t1

	Return lbl

End Sub

Private Sub lblDelete_MouseClicked(EventData As MouseEvent)

	Dim lbl As Label = Sender
	Dim clickedLblTag As wmSQLSBdeleteButtonTag = lbl.Tag
	Dim i As Int

	For i = 0 To (clickedLblTag.tv.Items.Size - 1)
		Dim tvRecord() As Object = clickedLblTag.tv.Items.Get(i)
		Dim tvLbl As Label = tvRecord(0)
		Dim tvLblTag As wmSQLSBdeleteButtonTag = tvLbl.Tag
		If tvLblTag.id = clickedLblTag.id Then
			Dim tvType As String = clickedLblTag.tv.Tag.As(String).ToLowerCase ' The TableView tags are set in Designer
			Select Case tvType ' When deleting a table or column alias, delete it from sqlInMemory too
				Case "columnaliases"
					Dim record(3) As Object = clickedLblTag.tv.Items.Get(i)
					Dim tfAlias As TextField = record(2)
					If tfAlias.Text <> "" Then sqlInMemory.ExecNonQuery2("DELETE FROM [ColumnsAndAliases] WHERE [ColName] = ?", Array As String(tfAlias.Text))
				Case "tablealiases"
					Dim record(3) As Object = clickedLblTag.tv.Items.Get(i)
					Dim tfAlias As TextField = record(2)
					If tfAlias.Text <> "" Then sqlInMemory.ExecNonQuery2("DELETE FROM [TablesAndAliases] WHERE [TblName] = ?", Array As String(tfAlias.Text))
			End Select
			clickedLblTag.tv.Items.RemoveAt(i)
			clickedLblTag.tv.SelectedRow = -1
			SaveUserDataToSqlInMemory(9)
			Exit
		End If
	Next

End Sub

Private Sub ChoiceBoxGeneric_SelectedIndexChanged(Index As Int, Value As Object)

	SaveUserDataToSqlInMemory(10)

End Sub

Private Sub CheckBoxGeneric_CheckedChange(Checked As Boolean)

	SaveUserDataToSqlInMemory(11)

End Sub

Private Sub TextFieldGeneric_FocusChanged(HasFocus As Boolean)

	If HasFocus = False Then SaveUserDataToSqlInMemory(12)

End Sub
#End Region ' TableViews add/delete rows

#Region Helper methods specifically created for this class
' Insert a row and increase variable 'newMaxId' which is then used for column 'Id' in the specified table
Private Sub InsertIntoAndIncreaseId(tblName As String, columnNames As String, placeHolders As String, values As List)

	newMaxId = newMaxId + 1
	Dim newValues As List
	newValues.Initialize
	newValues.AddAll(values)
	newValues.Add(newMaxId)
	sqlInMemory.ExecNonQuery2("INSERT INTO " & tblName & "(" & columnNames & ", [Id]) VALUES (" & placeHolders & ", ?)", newValues)

End Sub

' Create an instance of type 'wmSQLSBaliasTextFieldTag'
Private Sub CreateWmSQLSBaliasTextFieldTag(cb As ChoiceBox, tf As TextField, id As Int) As wmSQLSBaliasTextFieldTag

	Dim t1 As wmSQLSBaliasTextFieldTag
	t1.Initialize
	t1.cb = cb
	t1.tf = tf
	t1.id = id
	Return t1

End Sub

' Create an instance of type 'wmSQLSBcolumnAliasDetails'
Private Sub CreateWmSQLSBcolumnAliasDetails(combo As String) As wmSQLSBcolumnAliasDetails

	Dim splt() As String = Regex.Split("\]\.\[", combo) ' This now looks like: splt(0)= "[tablename", splt(1)="columnname]"
	Dim t1 As wmSQLSBcolumnAliasDetails
	t1.Initialize
	t1.tblName = splt(0).SubString(1)
	t1.colName = splt(1).SubString2(0, splt(1).Length - 1)
	Return t1

End Sub

' Return a list that contains items like "[table name].[column name]" or "[table alias name].[column name]".
' This is used to populate the choicebox with actual column names when editing column aliases.
Private Sub GetAllColumnsForAliasesFromSqlInMemory As List

	Dim allColumns As List
	allColumns.Initialize

	' Collect the names of all columns for all tables
	For Each oneTable As String In GetTablesAndAliasesListFromSqlInMemory
		For Each oneColumn As String In SQLiteGetTableColumnNames2(sql1, GetActualTableFromSqlInMemory(oneTable), True)
			allColumns.Add(EncloseInSquareBrackets(oneTable) & "." & EncloseInSquareBrackets(oneColumn))
		Next
	Next

	allColumns.SortCaseInsensitive(True)
	Return allColumns

End Sub

' Returns a list with the names of all the tables and aliases
Private Sub GetTablesAndAliasesListFromSqlInMemory As List

	Dim rs As ResultSet = sqlInMemory.ExecQuery("SELECT [TblName] FROM [TablesAndAliases]")
	Dim result As List

	result.Initialize
	Do While rs.NextRow
		result.Add(rs.GetString("TblName"))
	Loop
	rs.Close

	result.SortCaseInsensitive(True)
	Return result

End Sub

'Returns a list containing all column names in the specified table, AND any column aliases that have been defined.
'tblName can be a table's alias name too.
Private Sub GetTableColumnsAndAliasesFromSqlInMemory(tblName As String) As List

	Dim result As List
	Dim rs As ResultSet = sqlInMemory.ExecQuery2("SELECT [ColName] FROM [ColumnsAndAliases] WHERE [TblName] = ?", Array As String(tblName))

	result.Initialize
	Do While rs.NextRow
		result.Add(rs.GetString("ColName"))
	Loop
	rs.Close

	result.SortCaseInsensitive(True)
	Return result

End Sub

' Returns a list with the tables selected by the user, minus the table for which details are being filled,
' minus tables that are already used as 'child' in other tables' relationships; this is to avoid that such
' tables would show up as linked table for a relationship (an alias should be used in that case).
Private Sub GetSelectedTablesSubsetFromSqlInMemory As List

	Dim selectedTablesSubset As List
	Dim i As Int
	Dim rs As ResultSet = sqlInMemory.ExecQuery2("SELECT [TblNameChild] FROM [Relationships] WHERE [TblNameParent] <> ?", Array As String(selectedTable))

	selectedTablesSubset.Initialize
	selectedTablesSubset.AddAll(selectedTables)
	selectedTablesSubset.RemoveAt(selectedTablesSubset.IndexOf(selectedTable))

	Do While rs.NextRow
		i = selectedTablesSubset.IndexOf(rs.GetString("TblNameChild"))
		If i >= 0 Then selectedTablesSubset.RemoveAt(i)
	Loop
	rs.Close

	For i = 0 To (TableViewSQLSBrelationships.Items.Size - 1)
		Dim recordRelationships(5) As Object = TableViewSQLSBrelationships.Items.Get(i)
		Dim cbLinkedTable As ChoiceBox = recordRelationships(2)
		If cbLinkedTable.SelectedIndex >= 0 Then
			i = selectedTablesSubset.IndexOf(cbLinkedTable.Items.Get(cbLinkedTable.SelectedIndex).As(String))
			If i >= 0 Then selectedTablesSubset.RemoveAt(i)
		End If
	Next

	Return selectedTablesSubset

End Sub

' Return True if at least one view in the list contains data
Private Sub AllDetailsValuesArePresent(viewList As List, textFieldsMustContainValue As Boolean) As Boolean

	For Each element As Object In viewList
		If element Is ChoiceBox Then
			If element.As(ChoiceBox).SelectedIndex < 0 Then
				Return False
			End If
		Else If element Is CheckBox Then
			' Always ok
		Else If element Is TextField Then
			If textFieldsMustContainValue And (element.As(TextField).Text = "") Then Return False
		Else
			fx.Msgbox(frm, "Unexpected View type in method AllDetailsValuesArePresent", "Coding error")
			Log("Unexpected View type in method AllDetailsValuesArePresent")
			Return False
		End If
	Next
	Return True

End Sub

' If tblName is an alias, return the name of the table to which it refers.
' Otherwise, return tblName itself.
Private Sub GetActualTableFromSqlInMemory(tblName As String) As String

	Dim s As String = NullToEmptyString(sqlInMemory.ExecQuerySingleResult2("SELECT [IsAliasFor] FROM [TablesAndAliases] WHERE [TblName] = ?", Array As String(tblName)).As(String))
	Return IIf(s = "", tblName,	s)

End Sub

' If columnName is an alias for a column in tblName, return the name of the column to which it refers.
' Otherwise, returns columnName itself.
Private Sub GetActualColumnFromSqlInMemory(tblName As String, columnName As String) As String

	Dim s As String = NullToEmptyString(sqlInMemory.ExecQuerySingleResult2("SELECT [IsAliasFor] FROM [ColumnsAndAliases] WHERE ([TblName] = ? AND [ColName] = ?)", Array As String(tblName, columnName)).As(String))
	Return IIf(s = "", columnName,	s)

End Sub
#End Region ' Helper methods specifically created for this class

#Region Generic utility
' Get a string from localisationMap, which can be localised by the calling object after initialising this class
Private Sub GetLocalisedString(key As String) As String

	Dim s As String = localisationMap.GetDefault(key, key).As(String)
	Return IIf(s="", key, s)

End Sub

Private Sub SQLiteGetTables(theSQLdb As SQL) As List

	' Code based on https://www.b4x.com/android/forum/threads/b4x-sqlite-get-all-tables-column-names-and-definitions-of-a-db.85886/

	Dim TBName As String
	Dim RSDB As ResultSet=theSQLdb.ExecQuery("Select name FROM sqlite_master WHERE Type='table' ORDER BY name")
	Dim ReturnList As List
	ReturnList.Initialize
	Do While RSDB.NextRow
		TBName=RSDB.GetString2(0)
		If TBName.StartsWith("SQlite") = False Then ReturnList.Add(TBName)
	Loop
	ReturnList.SortCaseInsensitive(True)
	RSDB.Close
	Return ReturnList

End Sub

Private Sub SQLiteGetTableColumnNames2(theSQLdb As SQL, tblName As String, sortAsc As Boolean) As List

	Dim lst As List
	lst.Initialize

	Try
		Dim rs As ResultSet = theSQLdb.ExecQuery("PRAGMA table_info(" & tblName & ")")
		Do While rs.NextRow
			lst.Add(rs.GetString("name"))
		Loop
		rs.Close
		If sortAsc Then lst.SortCaseInsensitive(True)
		Return lst
	Catch
		Log("SQLiteGetTableColumnNames2 (" & tblName & "): " & LastException)
		Return lst
	End Try

End Sub

Private Sub TableView_SetColumnResizePolicy(tv As TableView, constrained As Boolean)

	' Code based on https://www.b4x.com/android/forum/threads/set-the-resize-policy-of-tableview-columns.67694/
	' Two options To set the resize policy of TableView columns:
	' - CONSTRAINED: Adjusts the Width of the columns if one column changes; starting from the column right to the one changed.
	' - UNCONSTRAINED: Shifts all other columns (right of the given column) further to the right (when the delta is positive) or to the left (when the delta is negative).

	Dim joTV As JavaObject = tv

	If constrained Then
		joTV.RunMethod("setColumnResizePolicy", Array(joTV.GetField("CONSTRAINED_RESIZE_POLICY")))
	Else
		joTV.RunMethod("setColumnResizePolicy", Array(joTV.GetField("UNCONSTRAINED_RESIZE_POLICY")))
	End If

End Sub

' Change (or hide) TableView "No content in table" text
Private Sub SetTableViewPlaceHolderText(TV As TableView,Text As String)

	' Code from https://www.b4x.com/android/forum/threads/tableview-replace-the-default-no-content-in-table-for-empty-table.82744/

	Dim TVJO As JavaObject = TV
	Dim L As Label
	L.Initialize("")
	L.Text = Text
	TVJO.RunMethod("setPlaceholder",Array(L))

End Sub

' Was created because at least OpenJDK Java 11 64bit on Linux truncates the MsgBox text (both fx and XUI) after 2 or 3 lines.
Private Sub MsgBoxLongText2(frm1 As Form, msg As String, title As String, positiveBtnText As String, cancelBtnText As String, negativeBtnText As String, style As Object, width As Int, height As Int, borderColour As Int) As ResumableSub

	If GetOS2 = "w" Then ' On Windows, just use fx.Msgbox2
		Return MsgBoxLongTextWindows(frm1, msg, title, positiveBtnText, negativeBtnText, cancelBtnText, style)
	End If

	Try
		Dim LongTextTemplate As B4XLongTextTemplate
		Dim dlg As B4XDialog

		dlg.Initialize(frm1.RootPane)
		dlg.BackgroundColor = xui.Color_LightGray
		dlg.BlurBackground = True
		dlg.BorderColor = borderColour
		dlg.ButtonsColor = xui.Color_White
		dlg.ButtonsFont = fnt14
		dlg.ButtonsTextColor = xui.Color_Black
		dlg.Title = title
		dlg.TitleBarColor = xui.Color_White
		dlg.TitleBarFont = fnt14
		dlg.TitleBarTextColor = xui.Color_Black

		LongTextTemplate.Initialize
		LongTextTemplate.Resize(IIf(width > 0, width, 500dip), IIf(height > 0, height, 300dip))
		LongTextTemplate.Text = msg

		Wait For (dlg.ShowTemplate(LongTextTemplate, positiveBtnText, negativeBtnText, cancelBtnText)) Complete (Result As Int)
		Return Result
	Catch
		Log("============================= MsgBoxLongText =============================" & CRLF & "MESSAGE: " & msg & CRLF & "EXCEPTION: " & LastException)
		Return fx.Msgbox2(frm1, msg, title, positiveBtnText, cancelBtnText, negativeBtnText, fx.MSGBOX_NONE)
	End Try

End Sub

Private Sub MsgBoxLongTextWindows(frm1 As Form, msg As String, title As String, positiveBtnText As String, negativeBtnText As String, cancelBtnText As String, style As Object) As Int

	If style = Null Then
		Dim pos As Boolean = (positiveBtnText <> "")
		Dim neg As Boolean = (negativeBtnText <> "")
		Dim can As Boolean = (cancelBtnText <> "")
		Dim numButtons As Int = 0
		If pos Then numButtons = numButtons + 1
		If neg Then numButtons = numButtons + 1
		If can Then numButtons = numButtons + 1
		If numButtons > 1 Then
			style = fx.MSGBOX_CONFIRMATION
		else if can Or neg Then
			style = fx.MSGBOX_ERROR
		Else
			style = fx.MSGBOX_INFORMATION
		End If
	End If

	Select Case fx.Msgbox2(frm1, msg, title, positiveBtnText,  cancelBtnText, negativeBtnText, style)
		Case fx.DialogResponse.POSITIVE
			Return xui.DialogResponse_Positive
		Case fx.DialogResponse.NEGATIVE
			Return xui.DialogResponse_Negative
		Case Else
			Return xui.DialogResponse_Cancel
	End Select

End Sub

' Returns 'w' for Windows, 'm' for Mac, 'l' for Linux, and 'x' for 'Linux running under Wine'
' 'x' is detected by the non-empty-string presence of environment variable 'WINEPREFIX'
Private Sub GetOS2 As String

	Dim os As String = GetSystemProperty("os.name", "").ToLowerCase
	If os.Contains("win") Then
		Return IIf(GetEnvironmentVariable("WINEPREFIX", "") = "", "w", "x")
	Else If os.Contains("mac") Then
		Return "m"
	Else
		Return "l"
	End If

End Sub

Private Sub SQLiteTableExists(theSQLdb As SQL, tableName As String) As Boolean

	' Code based on DBUTILS 2 : https://www.b4x.com/android/forum/threads/b4x-dbutils-2.81280/

	Dim count As Int = theSQLdb.ExecQuerySingleResult2("SELECT count(name) FROM sqlite_master WHERE type='table' AND name=? COLLATE NOCASE", Array As String(tableName))
	Return count > 0

End Sub

Private Sub CombineTableAndColumn(tableName As String, columnName As String) As String

	Return EncloseInSquareBrackets(tableName) & "." & EncloseInSquareBrackets(columnName)

End Sub

Private Sub EncloseInSquareBrackets(s As String) As String

	Return IIf(s.StartsWith("[") And s.EndsWith("]"), s, "[" & s & "]")

End Sub

Private Sub RemoveSquareBrackets(s As String) As String

	Return IIf(s.StartsWith("[") And s.EndsWith("]"), s.SubString2(1, s.Length - 1), s)

End Sub

Private Sub SQLiteColumnExists(theSQLdb As SQL, tableName As String, columnName As String) As Boolean

	If SQLiteTableExists(theSQLdb, tableName) = False Then Return False

	Dim rs As ResultSet = theSQLdb.ExecQuery("SELECT * FROM [" & tableName & "] LIMIT 1")
	Dim i As Int
	Dim exists As Boolean = False

	For i = 0 To (rs.ColumnCount - 1)
		If columnName.EqualsIgnoreCase(rs.GetColumnName(i)) Then
			exists = True
			Exit
		End If
	Next

	rs.Close
	Return exists

End Sub

Private Sub GetTextWidth(text As String, tFont As Font) As Double

	' Code based on https://www.b4x.com/android/forum/threads/measure-text.45750/

	Dim T As JavaObject
	T.InitializeNewInstance("javafx.scene.text.Text", Array(text))
	T.RunMethod("setFont", Array(tFont))
	Return T.RunMethod("prefWidth",Array(-1.0))

End Sub

Private Sub MakeValidSQLiteName(strIn As String) As String

	Dim strOut As String = ""
	Dim i As Int
	Dim s As String

	For i = 0 To (strIn.Length - 1)
		s = strIn.SubString2(i, i + 1)
		If s = "_" Then
			strOut = strOut & s
		Else If IsNumber(s) Then
			If i = 0 Then strOut = strOut & "_"
			strOut = strOut & s
		Else If (s.ToUpperCase.CompareTo("A") >= 0) And (s.ToUpperCase.CompareTo("Z") <= 0) Then
			strOut = strOut & s
		Else
			strOut = strOut & "_"
		End If
	Next

	If sqlReservedWords.Contains("|" & strOut.ToUpperCase & "|") Then strOut = "_" & strOut

	Do While strOut.Contains("__")
		strOut = strOut.Replace("__", "_")
	Loop

	Return strOut

End Sub

Private Sub NullToEmptyString(s As String) As String

	If s = Null Then
		Return ""
	Else If s.EqualsIgnoreCase("null") Then
		Return ""
	Else
		Return s
	End If

End Sub

Private Sub BringToFront(n As Node)

	' Code from https://www.b4x.com/android/forum/threads/pane-bringtofront.70149

	Dim joNode As JavaObject = n
	joNode.RunMethod("toFront", Null)

End Sub
#End Region ' Generic utility