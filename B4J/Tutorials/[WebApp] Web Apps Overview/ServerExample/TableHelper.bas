B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=2.18
@EndOfDesignText@
'Class module
Sub Class_Globals
End Sub

Public Sub Initialize
End Sub

Sub Handle(req As ServletRequest, resp As ServletResponse)
	Dim sq As SQL = DB.pool.GetConnection 'get a DB connection (change DB to Main)
	Dim rs As ResultSet = sq.ExecQuery("SELECT Name, ID, Population FROM countries ORDER BY name ASC")
	Dim countries As List
	countries.Initialize
	Do While rs.NextRow
		Dim country As List
		country.Initialize
		country.Add(rs.GetString("Name"))
		country.Add(rs.GetString("ID"))
		country.Add(rs.GetString("Population"))
		countries.Add(country)
	Loop
	sq.Close
	Select req.GetParameter("method")
		Case "show"
			'create a JSON response
			Dim m As Map
			m.Initialize
			m.Put("aaData", countries)
			Dim jg As JSONGenerator
			jg.Initialize(m)
			resp.ContentType = "application/json"
			resp.Write(jg.ToString)
		Case "exportCSV"
			ExportCSV(countries, resp)
		Case "exportExcel"
			ExportXLS(countries, resp)
	End Select
End Sub

Private Sub ExportCSV(Countries As List, resp As ServletResponse)
	Dim su As StringUtils
	Dim data As List
	data.Initialize
	'we need to convert each country from a list to an array.
	For Each country As List In Countries
		Dim countryArray(country.Size) As String
		For i = 0 To country.Size - 1
			countryArray(i) = country.Get(i)
		Next
		data.Add(countryArray)
	Next
	Dim fileName As String = "csv_" & Main.srvr.CurrentThreadIndex 'need to be sure that each thread gets its own temp file.
	su.SaveCSV2(File.DirTemp, fileName, ",", data, Array As String("Name", "ID", "Population"))
	resp.ContentType = "text/csv"
	resp.SetHeader("Content-Disposition", "attachment;filename=table.csv")
	Dim In As InputStream = File.OpenInput(File.DirTemp, fileName)
	File.Copy2(In, resp.OutputStream)
End Sub

Private Sub ExportXLS(Countries As List, resp As ServletResponse)
	Dim fileName As String = "xls_" & Main.srvr.CurrentThreadIndex
	Dim wb As WritableWorkbook
	wb.Initialize(File.DirTemp, fileName)
	wb.AddSheet("Countries", 0)
	Dim ws As WritableSheet = wb.GetSheet(0)
	ws.SetColumnWidth(0, 23)
	ws.SetColumnWidth(2, 15)
	Dim wf As WritableCellFormat
	wf.Initialize2(wf.FONT_ARIAL, 12, True, False, False, wf.COLOR_BLACK)
	wf.BackgroundColor = wf.COLOR_GREY_25_PERCENT
	wf.SetBorder(wf.BORDER_BOTTOM, wf.BORDER_STYLE_HAIR, wf.COLOR_BLACK)
	Dim wc As WritableCell
	Dim headers() As String = Array As String("Name", "ID", "Population")
	For i = 0 To headers.Length - 1
		wc.InitializeText(i, 1, headers(i))
		wc.SetCellFormat(wf)
		ws.AddCell(wc)
	Next
	For c = 0 To Countries.Size - 1
		Dim country As List = Countries.Get(c)
		For i = 0 To country.Size - 1
			Dim wc As WritableCell
			If i = 2 Then
				wc.InitializeNumber(i, c + 2, country.Get(i))
			Else
				wc.InitializeText(i, c + 2, country.Get(i))
			End If
			ws.AddCell(wc)
		Next
	Next
	wb.Write
	wb.Close
	resp.ContentType = "application/vnd.ms-excel"
	resp.SetHeader("Content-Disposition", "attachment;filename=table.xls")
	Dim In As InputStream = File.OpenInput(File.DirTemp, fileName)
	File.Copy2(In, resp.OutputStream)
End Sub