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
	
	Private SQL1 As SQL
	Private MyFolder As String	= "test"
	Private DBFileName As String = "test.db"
	Private DBFilePath As String
	Private DBTableName As String="fts_table"
	Private filename As String="words.txt"
	Private strQuery As String
	Private  l As List
	Private B4XFloatTextField1 As B4XFloatTextField
	Private Dialog As B4XDialog
	#if B4A
		Private IME As IME
	#End If
	
	Private Button1 As B4XView	
	Private SearchList As List
	Private clv2 As CustomListView
	Type MyData (t As String)
	Private Label1 As B4XView
	Private FoundRows As Boolean
End Sub

Public Sub Initialize
	l.Initialize
	#if B4A
	IME.Initialize("IME")
	#End If
	SearchList.Initialize
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	Button1.Color =xui.Color_Red
	Dialog.Initialize (Root)
	Dialog.Title = "Search Results"
	xui.SetDataFolder(MyFolder)
	#if B4A 
	DBFilePath = xui.DefaultFolder & "/" & MyFolder
	File.MakeDir(DBFilePath,"")
	SQL1.Initialize(DBFilePath, DBFileName, True)
	#else if B4J
	SQL1.InitializeSQLite(xui.DefaultFolder, DBFileName, True)
	#end if

	CreateTable  'create table if not exist
		
	ImportCSV
		 
End Sub

Sub CreateTable
	#if B4J 
'	for some reason in B4J I had to drop the table each time for it to work.
'	see this link for possible Erel's explanation
'	https://www.b4x.com/android/forum/threads/sqlite-full-text-search-table-creation-works-in-b4a-but-not-b4j.133486/#post-843784

'	IMPORTANT: I downloaded sqlite-jdbc-3.36.0.1.jar, the latest jar from here: https://github.com/xerial/sqlite-jdbc/releases
'	to the B4J LibraryAdditional subfolder, then made a reference in Main: #AdditionalJar: sqlite-jdbc-3.36.0.1.jar
'	to replace the old reference. Then the syntax: CREATE VIRTUAL TABLE IF NOT EXISTS started working in B4J.
'	Therefore conclused: driver #AdditionalJar: sqlite-jdbc-3.7.2 did not support IF NOT EXIST in syntax, but
'	sqlite-jdbc-3.36.0.1.jar did. However, I went back to the old reference for compatability with B4J installation.
'	If I eventually upgrade to the latest jar, I would modify the below lines so I do noy have to drop the table every time,
'	and there will be no need for conditional compilation in this part of the code. The B4A part will suffice.


		strQuery=$"DROP TABLE If EXISTS ${DBTableName}"$
		SQL1.ExecNonQuery(strQuery)
		strQuery="CREATE VIRTUAL TABLE " & DBTableName & " USING fts4(content TEXT)"  'works. Notice different from B4A line below
		SQL1.ExecNonQuery(strQuery)
	#else
'		strQuery=$"DROP TABLE If EXISTS ${DBTableName}"$
'		SQL1.ExecNonQuery(strQuery)
		strQuery="CREATE VIRTUAL TABLE IF NOT EXISTS " & DBTableName & " USING fts4(content TEXT)"    
		SQL1.ExecNonQuery(strQuery)	
	#end if	
End Sub

Sub ImportCSV  	
	Dim MyQuery As String =$"SELECT count(*) from ${DBTableName}"$
	Dim records As Int =SQL1.ExecQuerySingleResult(MyQuery)
	If records = 0 Then
		#if B4A
		ProgressDialogShow("Populating database for first time")
		#end if
		Dim startTime As Long = DateTime.Now
		Dim su As StringUtils
		l=su.LoadCSV(File.DirAssets,filename,"")  'I also tried to use: File.ReadList(File.DirAssets,filename), no difference
		Try
			For i=0 To l.Size-1
				Dim row() As String= l.Get(i)
				SQL1.AddNonQueryToBatch("INSERT INTO " & DBTableName & " VALUES (?)", Array As String(row(0)))
			Next
		Catch
		Log(LastException.Message)
		End Try
		Dim SenderFilter As Object = SQL1.ExecNonQueryBatch("SQL")
		Wait For (SenderFilter) SQL_NonQueryComplete (Success As Boolean)
		Log("Insert success was: " & Success)
		Log("Insert time = " & (DateTime.Now - startTime))
		#if B4A
		ProgressDialogHide	
		#end if	
	End If
End Sub

Sub DisplayRecords
'	strQuery=$"SELECT * FROM ${DBTableName}  WHERE content MATCH '${B4XFloatTextField1.text}*' ORDER BY content COLLATE NOCASE"$
'	Dim RS As ResultSet =SQL1.ExecQuery(strQuery)
'	strQuery=$"SELECT * FROM ${DBTableName}  WHERE ${DBTableName} MATCH ? ORDER BY content COLLATE NOCASE"$  'can use table name instead of col name
	
	'below misc examples only:
'	strQuery=$"SELECT * FROM ${DBTableName}  WHERE content MATCH 'water' ORDER BY content COLLATE NOCASE"$ 'works
'	strQuery=$"SELECT * FROM ${DBTableName}  WHERE content MATCH 'water OR cooler' ORDER BY content COLLATE NOCASE"$ 'works
'	strQuery=$"SELECT * FROM ${DBTableName}  WHERE content MATCH 'wa* AND coo*' ORDER BY content COLLATE NOCASE"$ 'works
'	strQuery=$"SELECT * FROM ${DBTableName}  WHERE content MATCH 'seduce* OR seduct*' ORDER BY content COLLATE NOCASE"$ 'works

	strQuery=$"SELECT * FROM ${DBTableName}  WHERE content MATCH ? ORDER BY content COLLATE NOCASE"$
	Dim RS As ResultSet =SQL1.ExecQuery2(strQuery, Array As String ($"${B4XFloatTextField1.text}*"$))
	SearchList.Initialize
	If RS.NextRow = True Then
		Do While RS.NextRow
			SearchList.Add(RS.GetString("content")& CRLF)
		Loop
		FoundRows =True
	End If
	RS.Close
End Sub

Private Sub Button1_Click
	#if B4A
	IME.HideKeyboard
	#End if
	Dim t As Long =DateTime.Now
	clv2.Clear
	
	DisplayRecords
	
	If FoundRows = True Then
		For i= 0 To SearchList.Size -1
			Dim md As MyData
			md.Initialize
			md = CreateMyData(SearchList.Get(i))
			clv2.Add(CreateMyItems, md)
		Next
		clv2.JumpToItem(0)
		Log($"Found  ${SearchList.Size} records for ${B4XFloatTextField1.Text} in: ${NumberFormat((DateTime.Now - t)/1000,0,2)} secs"$)
		B4XPages.SetTitle(Me, $"${SearchList.Size} records found"$)
	Else
		#if B4A
			MsgboxAsync($"No records were found for ${B4XFloatTextField1.Text} or search box empty"$, "No record match")
		#end if
	End If
	FoundRows = False
End Sub

Sub CreateMyItems As B4XView
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0,0,0,clv2.AsView.Width,80dip)
	Return p
End Sub

Sub Clv2_VisibleRangeChanged (FirstIndex As Int, LastIndex As Int)
	Dim ExtraSize As Int = 20
	For i = Max(0, FirstIndex - ExtraSize) To Min(LastIndex + ExtraSize, clv2.Size - 1) 'Loop for adding/removing your items layout to or from the list
		Dim Pnl As B4XView = clv2.GetPanel(i)
		If i > FirstIndex - ExtraSize And i < LastIndex + ExtraSize Then 'Add a new item to the list
			If Pnl.NumberOfViews = 0 Then '
				Dim md  As MyData =clv2.GetValue(i)
				Pnl.LoadLayout("item")
				Label1.Text= md.t
				Pnl.Color=xui.Color_RGB(Rnd(200,256),Rnd(200,256),Rnd(200,256))  'Different light background colors
			End If
		Else
			If Pnl.NumberOfViews > 0 Then
				Pnl.RemoveAllViews 'Remove none visible item from the main xCLV layout
			End If
		End If
	Next
End Sub

Sub clv2_ItemClick (Index As Int, Value As Object)
	Dim v As MyData =Value
	#if B4A
	MsgboxAsync( $"I clicked on: ${v.t}"$,"this text")
	#else
	Log($"I clicked on: ${v.t}"$)
	#end if
End Sub

Public Sub CreateMyData (t As String) As MyData
	Dim t1 As MyData
	t1.Initialize
	t1.t = t
	Return t1
End Sub

Sub B4XFloatTextField1_TextChanged (Old As String, New As String)
	If New.Length=0 Then
		B4XFloatTextField1.RequestFocusAndShowKeyboard
	End If
End Sub