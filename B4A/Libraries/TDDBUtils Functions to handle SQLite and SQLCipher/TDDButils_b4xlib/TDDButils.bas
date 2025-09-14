B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=11.2
@EndOfDesignText@
' ###############################################
' Code Module - b4xlib library
' Database Management for SQlite/SQliteCipher  DB
'-----------------------------------------------
' Name:			TDDButils
' Version:		1.8-WIP- -EA-	
' Depend Libs:	SQL, SQLCipher, B4XEncrypt
' Depend Mod.:	-
' Depend Class:	-
' Layout:		-
' Files:		-
' Other:		-
' Last changes:
' added sql error handling
'-----------------------------------------------
' (C) TECHDOC G. Becker
'###############################################

Sub Process_Globals
	Private xui As XUI
	Type TColInfo (CID As Int,Name As String, _
		Typ As String, NotNull As Boolean, PK As Boolean)
	Public SQLite As SQL
	Public sqLCipher As SQLCipher
	Public lastSQLError As String
	Private strSQL As String
	Private tableNames As List
	Private columnInfo As Map
	Private rs As ResultSet
	Private su As StringUtils
	Private  NumberOFMatches As Int
End Sub

'OVERVIEW OF FUNCTIONS
'--------------------
'OpenDB				Copies DB To accessable Directory And opens checkExists
'CloseDB			Closes the DB
'startTransaction	start a batch operation
'commitTransaction  Do all actions And close batch operation
'setDBcompactMode	set the Compact Mode
'compactDB			Do shrinking
'tableNames			get the table names
'ColumnsInfo		get Info of all columns
'findColumnInfo		get info of a named column
'importCSV			import CSV File Data into DB table
'exportCSV			export DB Table data To CSV File	
'insert				insert new record
'update				update a record
'delete				delete a record
'save				insert record or update record If it exists
'select1			simple Select
'select2			Select over joined  tables
'select3			Select from/til a date
'select4			report Max/Min/SUm/count value of a select
'dateDifference		Select between To dates
'checkDBNull		check If a column value is Null
'checkExists		check If a record exists
'EncryptText		encrypt a string
'DecryptText		decrypt a string
'clearViews			clearViews of a Form
'Views2Columns		Transfer Views values of a form to data Columns
'ColumnstViews		transfer data columns value to form views values

'###############################################

#region database
' #### Open and initialize Database Access
' #### Returns True if initialized, false if error
public Sub OpenDB(DBName As String, Password As String,DeleteDB As Boolean) As Boolean
	Try
		lastSQLError = ""
		' copy databasefile to writable folder
		If File.Exists(File.DirAssets,DBName) Then
			If File.Exists(File.DirInternal,DBName) = False Then
				File.Copy(File.DirAssets,DBName,File.dirinternal,DBName	)
			Else
				If DeleteDB Then
					File.Delete(File.DirInternal,DBName)
					File.Copy(File.DirAssets,DBName,File.dirinternal,DBName	)
				End If
			End If
		Else
			lastSQLError = "Database File not found!"
			Return False
		End If
		If Password <> "" Then
			sqLCipher.Initialize(File.DirInternal,DBName,False,Password,"")
			Return sqLCipher.IsInitialized
		Else
			SQLite.Initialize(File.dirinternal,DBName,False)
			Return SQLite.IsInitialized
		End If
	Catch
		Log(LastException)
		getSQLError(LastException)
		Return False
	End Try
End Sub

' #### Close the database
' #### Returns true if closed, false if error
public Sub CloseDB As Boolean
	Try
		lastSQLError=""
		If sqLCipher.IsInitialized Then
			sqLCipher.Close
			Return True
		else if SQLite.IsInitialized Then
			SQLite.close
			Return True
		Else
			Return False
		End If
	Catch
		Log(LastException)
		getSQLError(LastException)
		Return False
	End Try
End Sub

' #### start Transaction
' #### Returns true if closed, false if error
public Sub startTransaction As Boolean
	Try
		lastSQLError=""
		If SQLite.IsInitialized Then
			SQLite.BeginTransaction
			Return True
		else if sqLCipher.IsInitialized Then
			sqLCipher.BeginTransaction
			Return True
			
		Else
			Return False
		End If
	Catch
		Log(LastException)
		getSQLError(LastException)
		Return False
	End Try
End Sub

' #### commit and end Transaction
' #### Return True if Ok, fakse if error
public Sub commitTransaction As Boolean
	Try
		lastSQLError=""
		If SQLite.IsInitialized Then
			SQLite.TransactionSuccessful
			SQLite.EndTransaction
			Return True
		else if sqLCipher.IsInitialized Then
			sqLCipher.TransactionSuccessful
			sqLCipher.EndTransaction
			Return True
		Else
			Return False
		End If
	Catch
		Log(LastException)
		getSQLError(LastException)
		Return False
	End Try
End Sub

' #### set Database compact mode
' #### Action =  NONE, AUTO, INC FULL
public Sub setDBcompactMode(Action As String) As Boolean
	Try
		lastSQLError=""
		Select Action.ToLowerCase
			Case "none"
				strSQL = "PRAGMA auto_vacuum = 0"
			Case "inc"
				strSQL = "PRAGMA auto_vacuum = 1"
			Case "full"
				strSQL = "PRAGMA auto_vacuum = 2"
			Case Else
				strSQL=""
		End Select
		If strSQL <> "" Then
			If SQLite.IsInitialized Then
				SQLite.ExecNonQuery(strSQL)
				Return True
			else If sqLCipher.IsInitialized Then
				sqLCipher.ExecNonQuery(strSQL)
				Return True
			Else
				Return False
			End If
		Else
			lastSQLError = "Wrong Action Number!"
			Return False
		End If
	Catch
		Log(LastException)
		getSQLError(LastException)
		Return False
	End Try
End Sub

' #### compact Database
' #### Returns true if clompacted, false if error
public Sub compactDB As Boolean
	Try
		lastSQLError=""
		Dim strSQL As String = "VACUUM"
		If SQLite.IsInitialized Then
			SQLite.ExecNonQuery(strSQL)
			Return True
		else if sqLCipher.IsInitialized Then
			sqLCipher.ExecNonQuery(strSQL)
			Return True
		Else
			Return False
		End If
	Catch
		Log(LastException)
		getSQLError(LastException)
		Return False
	End Try
End Sub

' #### get table names
' #### returns values in a list 
' #### return Null if error
public Sub getTableNames As List
	Try
		lastSQLError=""
		' initialize list	
		tableNames.Initialize
		' set values to variables
		' create SQL string
		Dim strSQL As String = " SELECT name FROM sqlite_master WHERE type='table'"
		' load result set
		If SQLite.isinitialized Then
			rs = SQLite.ExecQuery(strSQL)
		else If sqLCipher.IsInitialized Then
			rs = sqLCipher.ExecQuery(strSQL)
		End If
		' load table name into list
		Do While rs.NextRow
			tableNames.Add(rs.GetString("name"))
		Loop
		Return tableNames
	Catch
		Log(LastException)
		getSQLError(LastException)
		Return Null
	End Try
End Sub

' #### get info for all columns
' #### returns values in a MAP
' #### Key=ColumnName, Value=Col Info as type TColInfo
' #### returns Null if error
public Sub getColumnsInfo(TabName As String) As Map
	Try
		lastSQLError=""
		' initialize
		columnInfo.Initialize
		' set values to variables
		' create SQL string
		strSQL = "PRAGMA table_info(" & TabName & ")"
		' load result set
		If SQLite.isinitialized  Then
			rs = SQLite.ExecQuery(strSQL)
		else If sqLCipher.IsInitialized Then
			rs = sqLCipher.ExecQuery(strSQL)
		End If
		' load col info into map
		If rs.RowCount = 1 Then
			rs.Position=0
			Dim ColInfo As TColInfo
			ColInfo.CID = rs.Getstring("cid")
			ColInfo.Name = rs.GetString("name")
			ColInfo.Typ = rs.GetString("type").ToLowerCase
			If rs.Getint("notnull") = 1 Then
				ColInfo.NotNull = True
			Else
				ColInfo.NotNull = False
			End If
			If rs.Getint("pk") = 1 Then
				ColInfo.PK = True
			Else
				ColInfo.PK = False
			End If
			columnInfo.Put(ColInfo.Name,ColInfo)
		Else
			
			For x = 0 To rs.RowCount-1
				rs.Position = x
				Dim ColInfo As TColInfo
				ColInfo.CID = rs.Getstring("cid")
				ColInfo.Name = rs.GetString("name")
				ColInfo.Typ = rs.GetString("type")
				If rs.Getint("notnull") = 1 Then
					ColInfo.NotNull = True
				Else
					ColInfo.NotNull = False
				End If
				If rs.Getint("pk") = 1 Then
					ColInfo.PK = True
				Else
					ColInfo.PK = False
				End If
				columnInfo.Put(ColInfo.Name,ColInfo)
			Next
		End If
		Return columnInfo
	Catch
		Log(LastException)
		Return Null
	End Try
End Sub

' #### find column info
' #### Returns type TcolInfo
public Sub findColumnInfo(TableName As String,ColName As String) As TColInfo
	Try
		If columnInfo.IsInitialized = False Then
			getColumnsInfo(TableName)
		End If
		Dim ci As TColInfo
		For x = 0 To columnInfo.Size-1
			If columnInfo.GetKeyAt(x) = ColName Then
				ci = columnInfo.GetValueAt(x)
				rs.close
				Return ci
			End If
		Next
		Return Null
	Catch
		Log(LastException)
		Return Null
	End Try
End Sub

' #### return sql error code and string parsed or full
private Sub getSQLError(Exception As String) As String
	Try
		If Exception.Contains("android.database") Then
			If Exception.Contains("CantOpenDatabaseException") Then
				lastSQLError = "14|CantOpenDatabaseException!"
			else if Exception.Contains("no such table") Then
				lastSQLError = "01|Table(name) not found!"
			else if Exception.Contains("no such column") Then
				lastSQLError = "01|Column(name) not found!"
			else if Exception.Contains("NOT NULL constraint failed") Then
				lastSQLError = "1299|NOT NULL constraint failed"
			else if Exception.Contains("UNIQUE constraint failed") Then
				lastSQLError = "1555|UNIQUE constraint failed"
			Else
				lastSQLError=Exception
			End If
			Return lastSQLError
		Else
			Return ""
		End If
	Catch
		Log(LastException)
		Return Null
	End Try
End Sub

#end region

'###############################################

#region insert/update/delete
' #### insert new record in database table
' #### return true if OK, false if error
public Sub insert(TabName As String,Columns As Map) As Boolean
	Try
		lastSQLError=""
		' build Columns and values part
		strSQL = ""
		Dim a , b As String
		Dim args As List:args.initialize
		For x = 0 To Columns.Size-1
			a = a & Columns.GetKeyAt(x)
			b= b & "?"
			args.Add(Columns.GetValueAt(x))
			If x < Columns.Size-1 Then
				a= a & ","
				b = b & ","
			End If
		Next
		strSQL = " (" & a & ") VALUES(" & b & ")"
		' build sql string
		strSQL= "INSERT INTO " & TabName & strSQL
		If SQLite.IsInitialized Then
			SQLite.ExecNonQuery2(strSQL,args)
			Return True
		else if sqLCipher.IsInitialized Then
			sqLCipher.ExecNonQuery2(strSQL,args)
			Return True
		Else
			Return False
		End If
	Catch
		Log(LastException)
		getSQLError(LastException)
		Return False
	End Try
End Sub

' #### update existing record in database table
' #### return true if OK, false if error
public Sub update(TabName As String, columns As Map, condition As String) As Boolean
	Try
		lastSQLError=""
		' build Columns and values part
		strSQL = ""
		Dim a As String
		Dim args As List:args.initialize
		For x = 0 To columns.Size-1
			a = a & columns.GetKeyAt(x) & "= ?"
			args.Add(columns.GetValueAt(x))
			If x < columns.Size-1 Then
				a= a & ","
			End If
		Next
		' build sql string
		strSQL= "UPDATE " & TabName & " SET " & a
		If condition <> "" Then
			strSQL = strSQL & " WHERE " & condition
		End If
		If SQLite.IsInitialized Then
			SQLite.ExecNonQuery2(strSQL,args)
			Return True
		else if sqLCipher.IsInitialized Then
			sqLCipher.ExecNonQuery2(strSQL,args)
			Return True
		Else
			Return False
		End If
	Catch
		Log(LastException)
		getSQLError(LastException)
		Return False
	End Try
End Sub

' #### save Data to Table
' #### if record is saved then update it
' #### if not insert it
' #### set Condition to unique column
' #### return true if OK, false if error
public Sub save(TabName As String, columns As Map, Condition As String) As Boolean
	Try
		lastSQLError=""
		If check(TabName,Condition) = True Then
			If NumberOFMatches = 0 Then
				Return insert(TabName,columns)
			Else
				Return update(TabName,columns,Condition)
			End If
		Else
			Return False
		End If
	Catch
		Log(LastException)
		getSQLError(LastException)
		Return False
	End Try
End Sub

' #### delete existing record
' #### there is no confirmation request!
' #### return true if OK, false if error
public Sub delete(TabName As String,Condition As String) As Boolean
	Try
		lastSQLError=""
		strSQL = "DELETE FROM " & TabName & " WHERE " & Condition
		If SQLite.IsInitialized Then
			SQLite.ExecNonQuery(strSQL)
			Return True
		else if sqLCipher.IsInitialized Then
			sqLCipher.ExecNonQuery(strSQL)
			Return True
		Else
			Return False
		End If
	Catch
		Log(LastException)
		getSQLError(LastException)
		Return False
	End Try
End Sub

' #### check if a record exists (internal Helper function)
' #### returns 1 if found, 0 if not found, -2 if error
private Sub check(TabName As String, condition As String) As Boolean
	Try
		lastSQLError=""
		strSQL = "SELECT count(*) FROM " & TabName & " WHERE " & condition
		NumberOFMatches=0
		If SQLite.IsInitialized Then
			NumberOFMatches = SQLite.ExecQuerysingleresult(strSQL)
			Return True
		else if sqLCipher.IsInitialized Then
			NumberOFMatches = sqLCipher.ExecQuerysingleresult(strSQL)
			Return True
		Else
			Return False
		End If
	Catch
		Log(LastException)
		getSQLError(LastException)
		Return False
	End Try
	
End Sub
#end region

'###############################################

#region select

'##### find record by value
'##### TabName = TableName, rs = resultset to search
'##### Columname = ColumnName to search, Value= Value to search
'##### return cursor position in rs or -1 if not found or error
'##### Column type text, int, integer,long, real,double,decimal allowed
'checked
public Sub FindRecord(TabName As String,rsSearch As ResultSet, ColumnName As String, Value As Object) As Long
	Try
		Dim Recpos As Long
		If rsSearch.RowCount = 1 Then
			Recpos= 0
		else if rsSearch.RowCount > 1 Then
			Dim tcol As TColInfo
			Dim t As String
			rsSearch.Position = 0
			Do While rsSearch.NextRow
				tcol = findColumnInfo(TabName,ColumnName)
				t = tcol.typ.ToLowerCase
				If t.Contains("text") Then
					t="text"
				Else if t.Contains("real") Then
					t="real"
				Else if t.Contains("decimal") Then
					t="decimal"
				End If
				Select t
					Case "text"
						t = Value
						t=t.Replace("'","")
						If rsSearch.GetString(ColumnName) = t Then
							Return rsSearch.Position
						End If
					Case "int","integer"
						If rsSearch.Getint(ColumnName) = Value Then
							Return rsSearch.Position
						End If
					Case "long"
						If rsSearch.Getlong(ColumnName) = Value Then
							Return rsSearch.Position
						End If
					Case "real","double","decimal"
						If rsSearch.Getdouble(ColumnName) = Value Then
							Return rsSearch.Position
						End If
					Case Else
						Recpos= -1
				End Select
			Loop
		Else
			Recpos=-1
		End If
		Return Recpos
	Catch
		Log(LastException)
		getSQLError(LastException)
		Return -1
	End Try
End Sub
' #### select records from one table by condition
' #### return result set
' #### return null if error
public Sub select1(TabName As String, Columns As String, _
		Condition As String, _
		Group As String, Order As String) As ResultSet
	Try
		lastSQLError=""
		strSQL = "SELECT "
		If Columns <> "" Then
			strSQL = strSQL & Columns
		Else
			strSQL = strSQL & "*,rowid "
			
		End If
		strSQL=strSQL & " FROM " & TabName
		If Condition <> "" Then strSQL=strSQL & " WHERE " & Condition
		If Group <> "" Then strSQL = strSQL & " GROUP BY " & Group
		If Order <> "" Then strSQL=strSQL & " ORDER BY " & Order
		If SQLite.IsInitialized Then
			Return SQLite.ExecQuery(strSQL)
		else if sqLCipher.IsInitialized Then
			Return sqLCipher.ExecQuery(strSQL)
		Else
			Return Null
		End If
	Catch
		Log(LastException)
		getSQLError(LastException)
		Return Null
	End Try
End Sub

' #### select records from 2 joined tables by condition
' #### return result set
' #### return null if error
public Sub select2(TabName1 As String, ColName1 As String, _
		TABName2 As String, ColName2 As String, _
		Condition As String, _
		Group As String, Order As String) As ResultSet
	Try
		lastSQLError=""
		strSQL = "SELECT * FROM " & TabName1 & " INNER JOIN " & TABName2 & _
			" ON " & TabName1 & "." & ColName1 & _
			" = " & TABName2 & "." & ColName2
		If Condition <> "" Then
			strSQL = strSQL & " WHERE " & Condition
		End If
		If SQLite.IsInitialized Then
			Return SQLite.ExecQuery(strSQL)
		else if sqLCipher.IsInitialized Then
			Return sqLCipher.ExecQuery(strSQL)
		Else
			Return Null
		End If
	Catch
		Log(LastException)
		getSQLError(LastException)
		Return Null
	End Try
End Sub

' #### select records between 2 dates
' #### returns resultset
' #### returns Null if error
Public Sub dateDifference( _
		TabName As String, ColName As String, _
		startDate As String, endDate As String, _
		Condition As String, _
		Group As String, Order As String) As ResultSet
	Try
		lastSQLError=""
		Dim strSQL As String
		If ColName <> "" Then
			strSQL= "SELECT *,rowid FROM " & TabName _
				& " WHERE " & ColName & " BETWEEN date('" & _
				startDate & "') AND date('" & endDate & "')"
			If Condition <> "" Then
				strSQL = strSQL & " AND " & Condition
			End If
			If SQLite.IsInitialized Then
				Return SQLite.ExecQuery(strSQL)
			else If sqLCipher.IsInitialized Then
				Return sqLCipher.ExecQuery(strSQL)
			Else
				Return Null
			End If
		End If
		Return Null
	Catch
		Log(LastException)
		getSQLError(LastException)
		Return Null
	End Try
End Sub

' #### select records from/til startdate
' #### Parameter: Operand  like >= and +/- nDays,nMonth,nYears
' #### returns resultset
' #### returns Null if error
Public Sub select3( _
		TabName As String, ColName As String, _
		startDate As String, _
		Operand As String, _
		nDays As Int,nMonth As Int, nyears As Int, _
		Group As String, Order As String) As ResultSet
	Try
		lastSQLError=""
		Dim strSQL As String
		If ColName <> "" And Operand <>"" Then	 
			If nDays=0 And nMonth=0 And nyears=0 Then
				strSQL= "SELECT *,rowid FROM " & TabName _
					 & " WHERE " & ColName _
					 & Operand & " date('" & startDate & "')"
			else if nDays <> 0 Then
				strSQL = "SELECT *, rowid FROM  " & TabName _
					& " WHERE " & ColName _
					& Operand & " date('" & startDate & "','" & nDays & " days')"
			else if nMonth <> 0 Then
				strSQL = "SELECT *, rowid FROM  " & TabName _
					& " WHERE " & ColName & " " _
					& Operand & " date('" & startDate & "','" & nMonth & " month')"
			else if nyears <> 0 Then
				strSQL = "SELECT *, rowid FROM  " & TabName _
					& " WHERE " & ColName  _
					& Operand & " date('" & startDate & "','" & nyears & " years')"
			End If
			If SQLite.IsInitialized Then
				Return SQLite.ExecQuery(strSQL)
			Else If sqLCipher.IsInitialized Then
				Return sqLCipher.ExecQuery(strSQL)
			Else
				Return Null
			End If
		End If
		Return Null
	Catch
		Log(LastException)
		getSQLError(LastException)
		Return Null
	End Try
End Sub

' #### report a value
' #### Action: max,min,avg,sum,count
' #### returns value or Null if error
public Sub select4(Action As String,TabName As String, _
		ColumnName As String, Condition As String, Group As String ) As Double
	Try
		lastSQLError=""
		Dim strSQL As String
		strSQL = "SELECT " & Action & "(" & ColumnName & ") FROM " & TabName 
		If Condition <> "" Then
			strSQL=strSQL & " WHERE " & Condition
		End If
		If SQLite.IsInitialized Then
			Return SQLite.ExecQuerySingleResult(strSQL)
		else If sqLCipher.IsInitialized Then
			Return sqLCipher.ExecQuerySingleResult(strSQL)
		Else
			Return Null
		End If
	Catch
		Log(LastException)
		getSQLError(LastException)
		Return Null
	End Try
End Sub

' #### check if record exists
' #### Returns >=1 if yes, 0 if not
' #### Returns -1 if error
public Sub checkExists(TabName As String,Condition As String) As Boolean
	Try
		lastSQLError=""
		NumberOFMatches=0
		Dim strSQL As String
		strSQL= "SELECT count(*) FROM " & TabName _
			& " WHERE" & Condition
		If SQLite.IsInitialized Then
			NumberOFMatches= SQLite.ExecQuerySingleresult(strSQL)
			Return True
		else if sqLCipher.IsInitialized Then
			NumberOFMatches= sqLCipher.ExecQuerySingleresult(strSQL)
			Return True
		Else
			Return False
		End If
	Catch
		Log(LastException)
		getSQLError(LastException)
		Return False
	End Try
End Sub
#end region

'###############################################

#region encrypt
' #### encrypt 
' #### text = string to  encrypt UTF-8
' #### passwor = password for encryption
' #### Return Byte Array#
' #### to store use a blob column
public Sub EncryptText(text As String, password As String) As Byte()
	Dim c As B4XCipher
	Return c.Encrypt(text.GetBytes("utf8"), password)
End Sub

' decrypt
' #### encrypteddata as byte array
' #### passwor = password for encryption
' #### Return clear text
public Sub DecryptText(encryptedData() As Byte, password As String) As String
	Dim c As B4XCipher
	Dim b() As Byte = c.Decrypt(encryptedData, password)
	Return BytesToString(b, 0, b.Length, "utf8")
End Sub
#end region

'###############################################

#region layout and Views
'## Notice:
'## To  use these features you have to create a panel and the views as childs inside.
'## the functions are using only child views with the columnname in the tag value all
'## akk other vies are ommited,
'## Rach databound view's tag must include the data column name as only value or as
'## the first value. If you like to use the tag also for other values than
'## put at first the column name and separate it with the pipe symbol | from the
'## the rest of sth tag value. Example tag = ColumnName|2nd tag value


' #### Clear al views tied to a database column
' #### view type EditText, Label, CheckBox, RadioButton
' #### Panel = Panel holding the views
' #### Return True if cleared, false if error
'checked
public Sub clearViews(Panel As Panel) As Boolean
	Try
		For Each v As View In Panel.GetAllViewsRecursive
			Dim T As String = v.tag
			If T <> "" Then
				' The Tag has more than one values
				' The values are piped by |
				' The 1st Value must be the column name
				If T.contains("|") Then
					Dim T1() As String = Regex.Split("\|",T)
					T = T1(0)
				End If
				' clear the view
				' to clear other viewtypes modify the if clause
				Dim temp As B4XView
				If v Is EditText Or v Is Label Then
					temp = v
					temp.Text =""
					v = temp
				else if v Is CheckBox Or v Is RadioButton Then
					temp=v
					temp.Checked=False
					v=temp
				End If
			End If
		Next
		Return True
	Catch
		Log(LastException)
		Return False
	End Try
End Sub

' #### --------------------------------------------------------
'Database Info this columntypes are supported.
' --------------------------------------------
'INTEGER, TEXT, BLOB, DOUBLE,REAL
'DATE, TIME, DATETIME
'BOOL

'Notice! If you like to use other affiniates please
'modify/enhance the correspondent functions.

'View Information this view types are supported:
'EditText, Label, RadioButton,CheckBox,ImageView

'Notice! If you like to use other viewtypes please
'modify/enhance the correspondent functions.
' #### --------------------------------------------------------

' #### get the Views value to save it in the database
' #### Panel = Panel holding the views
' #### Return a Map, Key = columnname - value= value object
' #### if a view has a Date or Time value you have to
' #### specify DateTime Format before calling this function!
' #### viewtypes: EditText, Label, RadioButton, CheckBox, ImageView
public Sub Views2Columns(Panel As Panel,TabName As String) As Map
	Try
		Dim result As Map 
		result.initialize
		Dim temp As B4XView
		Dim dt As Long = 0
		Dim dtf(2) As String
		dtf(0) = DateTime.DateFormat
		dtf(1) = DateTime.timeformat
		For Each v As View In Panel.GetAllViewsRecursive
			Dim T As String = v.Tag
			temp=v
			If T <> "" Then
				temp = v
				' The Tag has more than one values
				' The values are piped by |
				' The 1st Value must be the column name
				If T.contains("|") Then
					Dim T1() As String = Regex.Split("\|",T)
					T = T1(0)
				End If
				' get the columns type
				Dim coltype As TColInfo = findColumnInfo(TabName,T)
				Dim CT As String =coltype.Typ.ToLowerCase
				If CT.Contains("text") Then 
					CT = "text"
				else if CT.Contains("real") Then
					CT = "real"
				End If
				' get the columns value
				' to use other viewtypes modify the if clause
				' to use other columntypes modify the select clause
				If v Is EditText Or v Is Label Then
					temp = v
					Dim tx As String = temp.text
					If tx.Length > 0 Then
						Try
							Select CT
								Case "date"
									dt = DateTime.DateParse(temp.Text)
									result.Put(coltype.Name,dt)
								Case "time"
									dt = DateTime.timeParse(temp.Text)
									result.Put(coltype.Name,dt)
								Case "datetime"
									Dim temp1() As String = Regex.Split("\ ",temp.Text)
									dt = DateTime.DateTimeParse(temp1(0),temp1(1))
									result.Put(coltype.Name,dt)
								Case "text","int","double","real","integer","long"
									result.Put(coltype.Name,temp.Text)
							End Select
						Catch
							' show error message wrong format
							xui.MsgboxAsync("Datum/Zeitformat unzulässig!","Eingabefehler! Datum/Zeit")
						End Try
					End If
				else if v Is RadioButton Or v Is CheckBox And _
					(coltype.Typ.ToLowerCase = "bool" Or coltype.Typ.ToLowerCase="integer") Then
					temp = v
					If temp.checked = True Then
						result.Put(coltype.Name,1)
					Else 
						result.Put(coltype.Name,0)
					End If
				else if v Is ImageView And temp.GetBitmap.IsInitialized Then
					' convert image to bytes
					Dim bmp As Bitmap = temp.GetBitmap
					Dim OutputStream1 As OutputStream
					OutputStream1.InitializeToBytesArray(1000)
					bmp.WriteToStream(OutputStream1, 90, "JPEG")
					Dim Buffer() As Byte = OutputStream1.ToBytesArray
					result.Put(coltype.Name,Buffer)				
				End If
			End If
		Next
		Return result
	Catch
		Log(LastException)
		Return result
	End Try
End Sub

' #### get the column value to the view
' #### Panel = Panel holding the views
' #### Tablen = Tablename
' #### Recordset = the Resultset holding  one Record at Position -0
' #### Return True if cleared, false if error
' checked
public Sub Columns2Views(Panel As Panel, TabName As String,  Pos As Long, Recordset As ResultSet) As Boolean
	Try
		For Each v As View In Panel.GetAllViewsRecursive
			Dim T As String = v.Tag
			Dim temp As B4XView
			Dim t1 As String
			If T <> "" Then
				' The Tag has more than one values
				' The values are piped by |
				' The 1st Value must be the column name
				If T.contains("|") Then
					Dim t2() As String = Regex.Split("\|",T)
					T = t2(0)
				End If
				' get the columns type
				Dim coltype As TColInfo = findColumnInfo(TabName,T)
				Dim CT As String =coltype.Typ.ToLowerCase
				If CT.Contains("text") Then
					CT = "text"
				else if CT.Contains("real") Then
					CT = "real"
				End If
				' position on 1st record
				Recordset.Position=Pos
				' get the columns value
				' to use other viewtypes modify the if clause
				' to use other columntypes modify the select clause
				'Log(coltype.Name & " " & T & " " & t1)
				If v Is EditText Or v Is Label Then
					temp = v
					Select CT
						Case "text"
							If Recordset.GetString(T).Length > 0 Then
								temp.Text = Recordset.GetString(T)
							Else
								temp.Text = ""
							End If
						Case "int","integer"
							If IsNumber(Recordset.Getint(T)) Then
								temp.Text = Recordset.Getint(T)
							Else
								temp.text = ""
							End If
						Case "double","real"
							temp.Text = Recordset.Getdouble(T)
						Case "long"
							If IsNumber(Recordset.Getlong(T)) Then
								temp.Text = Recordset.Getlong(T)
							Else
								temp.text = ""
							End If
						Case "date"
							If IsNumber(Recordset.Getlong(T)) Then
								temp.Text = DateTime.Date(Recordset.Getlong(T))
							End If
						Case "time"
							If IsNumber(Recordset.Getlong(T)) Then
								temp.Text = DateTime.time(Recordset.Getlong(T))
							End If
						Case "datetime"
							If IsNumber(Recordset.Getlong(T)) Then
								temp.Text = DateTime.date(Recordset.Getlong(T)) & " "
								temp.Text = temp.Text & DateTime.time(Recordset.Getlong(T))
							End If
					End Select
					v=temp
				else if v Is RadioButton Or v Is CheckBox And _
					(t1= "bool" Or t1 ="integer" Or t1="int") Then
					temp = v
					If IsNumber(Recordset.GetInt(T)) And  Recordset.GetInt(T)= 0 Then
						temp.Checked = False
					else if IsNumber(Recordset.GetInt(T)) And Recordset.GetInt(T) = 1 Then
						temp.Checked = True
					End If
					v=temp
				else if v Is ImageView And coltype.Typ.ToLowerCase = "blob" Then
					Dim Buffer() As Byte  = Recordset.GetBlob(T) 'res = ResultSet
					If Buffer.Length > 0 Then
						Dim InputStream1 As InputStream
						InputStream1.InitializeFromBytesArray(Buffer, 0, Buffer.Length)
						Dim Bmp As Bitmap
						Bmp.Initialize2(InputStream1)
						InputStream1.Close
						temp.SetBitmap(Bmp)
						v=temp
					End If
				End If
			End If
		Next
		Return True
	Catch
		Log(LastException)
		Return False
	End Try
End Sub
#end region

'-----------------------------------------------
' (C) TECHDOC G. Becker
'###############################################