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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=B4XTableB4XLocalizator.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	
	Private B4XTable1 As B4XTable
	Private txtKey As B4XFloatTextField
	Private WebView1 As WebView
	Private js As jSoup
	Private fc As FileChooser
	Private sqlBackup As SQL
	Private ExisteDbBackup As Boolean = False
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	xui.SetDataFolder("B4XTableB4XLocalizator")
	B4XPages.SetTitle(Me, "B4XTable - B4XLocalizator")
	InicializarSQLBackUp
	CreateTable
	LoadData
	fc.Initialize
End Sub

Private Sub CreateTable
	B4XTable1.AddColumn("key", B4XTable1.COLUMN_TYPE_TEXT)
	Dim langs As List = Array As String("es", "ca", "en", "fr", "de", "it", "pt", "nl", "eu","gl", "zh-CN")
	For Each lang As String In langs
		B4XTable1.AddColumn(lang, B4XTable1.COLUMN_TYPE_TEXT)
	Next					
End Sub

Private Sub InicializarSQLBackUp
	ExisteDbBackup = File.Exists(xui.DefaultFolder, "backup.db")
	sqlBackup.InitializeSQLite(xui.DefaultFolder, "backup.db", True) 'La crea sino existe
End Sub

Private Sub LoadData As ResumableSub
	Dim data As List
	If File.Exists(xui.DefaultFolder, "backup.db") And ExisteDbBackup Then
		data = DBUtils.ExecuteMemoryTable(sqlBackup, "SELECT * FROM data", Null, 0)
	Else
		data.Initialize
	End If
	Wait For (B4XTable1.SetData(data)) Complete (Unused As Boolean)
	Return Unused
End Sub

Private Sub B4XTable1_CellClicked (ColumnId As String, RowId As Long)
	If ColumnId <> "key" Then
		Dim RowData As Map = B4XTable1.GetRow(RowId)
		Dim key As String = RowData.Get("key")
		
		Dim valorTraducido As String = key
		Dim idB4XTable As String = B4XTable1.GetColumn(ColumnId).SQLID
'		Log(idB4XTable)		
		If ColumnId <> "es" Then
			Wait For(Traduccion(key, "es", ColumnId)) Complete(res As String)
			If res <> "" Then
'				Log("Parseando resultado")
				valorTraducido = 	ParsearHTML(res) 'Actualiza con el traductor
'				Log(valorTraducido)
			Else
				Log("respuesta vacia")
			End If			
		End If
		Dim row() As String = Array As String(valorTraducido, RowId)
		B4XTable1.sql1.ExecNonQuery2($"UPDATE data SET ${idB4XTable} = ?  WHERE rowid = ?"$, row)
		B4XTable1.Refresh		
	End If
End Sub

Private Sub B4XTable1_CellLongClicked (ColumnId As String, RowId As Long)
	Dim sf As Object = xui.Msgbox2Async("Do you want to edit it? or delete it?", "", "Yes", "Cancel", "Delete", Null)
	Wait For (sf) Msgbox_Result (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		Dim RowData As Map = B4XTable1.GetRow(RowId)
		Dim value As String = RowData.Get(ColumnId)
		Dim idB4XTable As String = B4XTable1.GetColumn(ColumnId).SQLID
		
		Dim input As B4XInputTemplate
		input.Initialize
		input.lblTitle.Text = value
		input.RegexPattern = "^[\w\s]{1,}$"
		input.Text = value
		Dim dialog As B4XDialog
		dialog.Initialize(Root)
		dialog.Title = "Editing..."
	
		Wait For (dialog.ShowTemplate(input, "OK", "", "CANCEL")) Complete (Result2 As Int)
		If Result2 = xui.DialogResponse_Positive Then
			Dim response As String = input.Text		
			Dim row() As String = Array As String(response, RowId)			
			B4XTable1.sql1.ExecNonQuery2($"UPDATE data SET ${idB4XTable} = ?  WHERE rowid = ?"$, row)
			B4XTable1.Refresh
		End If
	End If
	
	If Result = xui.DialogResponse_Negative Then
		Dim row() As String = Array As String(RowId)
		B4XTable1.sql1.ExecNonQuery2($"DELETE FROM data WHERE rowid = ?"$, row)
		B4XTable1.Refresh
	End If
End Sub

Private Sub btnAdd_Click
	if txtKey.Text = "" Then Return
	If CheckExistKey(txtKey.Text) Then
		xui.MsgboxAsync("The key exist", "")
		Return
	End If
	Dim row() As String = Array As String(txtKey.Text, "", "", "", "", "", "", "", "", "", "", "")
	B4XTable1.sql1.ExecNonQuery2($"INSERT INTO data VALUES(?, ?, ?,  ?,  ?, ?,  ?,  ?, ?, ?,  ?, ?)"$, row)
	B4XTable1.UpdateTableCounters
	txtKey.Text = ""
	txtKey.RequestFocusAndShowKeyboard
End Sub

Private Sub CheckExistKey(key As String) As Boolean
	Dim info As Map = DBUtils.ExecuteMap(B4XTable1.sql1, "SELECT count(c0) as cant FROM data WHERE c0 = ?", Array As String(key))
	If info.Size > 0 Then
		Return info.Get("cant") > 0
	End If
	Return False
	
End Sub

Private Sub Traduccion(strSourceText As String, strSourceLangCode As String, strTargetLangCode As String) As ResumableSub
	Dim strURL As String
	strURL = "https://translate.google.com/m?sl=" & strSourceLangCode & "&tl=" & strTargetLangCode & "&hl=es&ie=UTF-8&q=" & URLEncode(strSourceText)

	Dim job As HttpJob
	job.Initialize("", Me)
	job.Download(strURL)
	job.GetRequest.SetHeader("User-Agent", "Mozilla/5.0 (compatible;MSIE 6.0; Windows NT 10.0))")
	job.GetRequest.Timeout = 5 *DateTime.TicksPerSecond
	
	Wait For (job) JobDone(job As HttpJob)
	Dim conecto As String = job.Success
	Dim response As String = ""
	Log(conecto)
	If conecto Then
		response = job.GetString
		WebView1.LoadHtml(response)		
	End If
	job.Release
	Return	response
End Sub

Public Sub URLEncode(url As String) As String
	Dim su As StringUtils
	Dim encodedUrl As String
	encodedUrl = su.EncodeUrl(url, "UTF8")
	Return encodedUrl
End Sub

Private Sub ParsearHTML(html As String) As String
	Dim res As List = js.getElementsByClass(html,  "result-container")
	Dim divResult As String = res.Get(0)
	Dim result As String = js.selectorElementAttr(divResult, "div", "innerhtml").Get(0)
'	Log(result)
	Return result
End Sub

Private Sub B4XPage_Background
	Log("Creating backup...")
	Dim save As ResumableSub = CloneSQLite.CopySQLiteDB(B4XTable1.sql1, sqlBackup)
	Wait For(save) Complete(res As Boolean)
End Sub

Private Sub btnExportarParaLocalizator_Click
	Dim path As String = Browse("db", True)
	If path <> "" Then
		BuildDatabase(path)
	End If
End Sub

Private Sub Browse(extension As String, save As Boolean) As String
	fc.SetExtensionFilter(extension, Array($"*.${extension}"$))
	Dim path As String
	Dim Mainform As Form = B4XPages.GetNativeParent(Me)
	If save Then
		fc.InitialFileName = "languajes.db"
		path = fc.ShowSave(Mainform)
	Else
		path = fc.ShowOpen(Mainform)
	End If
'	If path <> "" Then tf.Text = path
	Return path
End Sub

Private Sub BuildDatabase (Output As String)
	Dim sql As SQL
	File.Delete(Output, "")
	sql.InitializeSQLite(Output, "", True)
	sql.BeginTransaction
	Try
		sql.ExecNonQuery("CREATE TABLE data (key TEXT, lang TEXT, value TEXT, PRIMARY KEY (lang, key))")
		Dim langs As List :	langs.Initialize
		
		For Each column As B4XTableColumn In B4XTable1.Columns
			Dim colId As String = column.Id
			If colId = "key" Then Continue
			langs.Add(colId)
		Next
		
		For i = 1 To B4XTable1.Size 'Recorre filas
			For Each column As B4XTableColumn In B4XTable1.Columns
				Dim colId As String = column.Id
						
				Dim CellTable As Object = B4XTable1.GetRow(i).Get(column.Title)
				If colId = "key" Then
					Dim key As String = CellTable
				Else
					sql.ExecNonQuery2("INSERT INTO data VALUES (?, ?, ?)", Array(key.ToLowerCase, colId, CellTable))
				End If
			Next
		Next
		sql.TransactionSuccessful
		LogMessage("Database created successfully!")
	Catch
		Log(LastException)
		sql.Rollback
		LogMessage("Error: " & LastException)
	End Try
	sql.Close
End Sub

Private Sub CrearTXT(Output As String)
	File.Delete(Output, "")
	
	Dim langs As List :	langs.Initialize
	For Each column As B4XTableColumn In B4XTable1.Columns
		Dim colId As String = column.Id
		If colId = "key" Then Continue
		langs.Add(colId)
	Next
	
	For i = 1 To B4XTable1.Size 'Recorre filas
		For Each column As B4XTableColumn In B4XTable1.Columns
			Dim colId As String = column.Id
		
			Dim CellTable As Object = B4XTable1.GetRow(i).Get(column.Title)
			If colId = "key" Then
				Dim key As String = CellTable
			Else
				AppendToTextFile(Output, "", key.ToLowerCase &" - "& colId&" - "&CellTable, True)
'				sql.ExecNonQuery2("INSERT INTO data VALUES (?, ?, ?)", Array(key.ToLowerCase, colId, CellTable))
			End If
		Next
	Next
	
	
	
'	For row0 = 1 To result.BottomRight.Row0Based
'		Dim key As String = result.Get(xl.AddressZero(0, row0))
'		For col0 = 1 To result.BottomRight.Col0Based
'			Dim lang As String = langs.Get(col0 - 1)
'			sql.ExecNonQuery2("INSERT INTO data VALUES (?, ?, ?)", Array (key.ToLowerCase, lang, result.Get(xl.AddressZero(col0, row0))))
'		Next
'	Next
	
	
	
End Sub

Private Sub AppendToTextFile(Dir As String, FileName As String, Text As String, NewLine As Boolean)
	If NewLine Then
		Text = CRLF & Text
	End If
	Dim out As OutputStream = File.OpenOutput(Dir, FileName, True)
	Dim b() As Byte = Text.GetBytes("utf8")
	out.WriteBytes(b, 0, b.Length)
	out.Close
End Sub

Private Sub LogMessage(msg As String)
	xui.MsgboxAsync(msg, "")
	Log(msg)
End Sub