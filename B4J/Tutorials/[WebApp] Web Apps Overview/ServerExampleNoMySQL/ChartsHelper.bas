B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=4
@EndOfDesignText@
'Class module
Sub Class_Globals
	
End Sub

Public Sub Initialize

End Sub

Public Sub Handle(req As ServletRequest, resp As ServletResponse)
	resp.ContentType = "application/json"
	Dim cols As List
	cols.Initialize
	Dim rows As List
	rows.Initialize
	Dim options As Map
	options.Initialize
	Select req.GetParameter("type")
		Case "pie"
			CreatePieChartData(cols, rows)
			CreatePieChartOptions(options)
		Case "bar"
			CreateBarChartData(cols, rows)
			CreateBarChartOptions(options)
		Case "line"
			CreateLineChartData(cols, rows)
			CreateLineChartOptions(options)
		Case "geo"
			CreateGeoChartData(cols, rows)
	End Select
	Dim jg As JSONGenerator
	jg.Initialize(CreateMap("data": CreateMap ("cols": cols, "rows": rows), _
		"options": options))
	resp.Write(jg.ToString)
End Sub

Private Sub CreateColumn(id As String, Label As String, dataType As String) As Map
	Return CreateMap("id": id, "label": Label, "type": dataType)
End Sub

Private Sub CreateRow(Values As List) As Map
	Dim vr As List
	vr.Initialize
	For Each o As Object In Values
		vr.Add(CreateMap("v": o))
	Next
	Return CreateMap("c": vr)
End Sub

Private Sub CreatePieChartData(cols As List, rows As List)
	cols.Add(CreateColumn("", "Topping", "string"))
	cols.Add(CreateColumn("", "Slices", "number"))
	rows.Add(CreateRow(Array As Object("Mushrooms", 3)))
	rows.Add(CreateRow(Array As Object("Onions", 1)))
	rows.Add(CreateRow(Array As Object("Olives", 1)))
	rows.Add(CreateRow(Array As Object("Zucchini", 1)))
	rows.Add(CreateRow(Array As Object("Pepperoni", 2)))
End Sub

Private Sub CreatePieChartOptions (options As Map)
	options.Put("title", "Pizza")
	options.Put("is3D", True)
	options.Put("width", 500)
	options.Put("height", 300)
End Sub

Private Sub CreateBarChartData (cols As List, rows As List)
	cols.Add(CreateColumn("", "Year", "string"))
	cols.Add(CreateColumn("", "Sales", "number"))
	cols.Add(CreateColumn("", "Expenses", "number"))
	rows.Add(CreateRow(Array As Object("2004", 1000, 400)))
	rows.Add(CreateRow(Array As Object("2005", 1170, 460)))
	rows.Add(CreateRow(Array As Object("2006", 660, 1120)))
	rows.Add(CreateRow(Array As Object("2007", 1030, 540)))
End Sub

Private Sub CreateBarChartOptions (options As Map)
	options.Put("title", "Company Performance")
	Dim m As Map
	m.Initialize
	m.Put("title", "Year")
	Dim c As Map
	c.Initialize
	c.Put("color", "red")
	m.Put("titleTextStyle", c)
	options.Put("vAxis", m)
End Sub

Private Sub CreateLineChartData (cols As List, rows As List)
	cols.Add(CreateColumn("", "Year", "string"))
	cols.Add(CreateColumn("", "Sales", "number"))
	cols.Add(CreateColumn("", "Expenses", "number"))
	rows.Add(CreateRow(Array As Object("2004", 1000, 400)))
	rows.Add(CreateRow(Array As Object("2005", 1170, 460)))
	rows.Add(CreateRow(Array As Object("2006", 660, 1120)))
	rows.Add(CreateRow(Array As Object("2007", 1030, 540)))
End Sub

Private Sub CreateLineChartOptions (options As Map)
	options.Put("title", "Company Performance")
End Sub

Private Sub CreateGeoChartData (cols As List, rows As List)
	cols.Add(CreateColumn("", "Country", "string"))
	cols.Add(CreateColumn("", "Popularity", "number"))
	rows.Add(CreateRow(Array As Object("Germany", 200)))
	rows.Add(CreateRow(Array As Object("United States", 300)))
	rows.Add(CreateRow(Array As Object("Brazil", 400)))
	rows.Add(CreateRow(Array As Object("Canada", 500)))
	rows.Add(CreateRow(Array As Object("France", 600)))
	rows.Add(CreateRow(Array As Object("RU", 700)))
End Sub