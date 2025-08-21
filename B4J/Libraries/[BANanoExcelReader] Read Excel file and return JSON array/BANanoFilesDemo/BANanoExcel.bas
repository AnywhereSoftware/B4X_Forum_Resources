B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.1
@EndOfDesignText@
Sub Class_Globals
	Public XLSX As BANanoObject
	Private BANano As BANano
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	BANano.DependsOnAsset("jszip.min.js")
	BANano.DependsOnAsset("xlsx.full.min.js")
	XLSX.initialize("XLSX")
End Sub

Sub ReadFile(data As String) As List
	Dim opt As Map = CreateMap()
	opt.put("type", "binary")
	'get the workbook
	Dim workBook As BANanoObject = XLSX.RunMethod("read", Array(data, opt))
	'get the worksheet names
	Dim sheetNames As List = workBook.getfield("SheetNames").Result
	'fetch the name of first Sheet.
	Dim firstSheet As String = sheetNames.get(0)
	'get the sheets object
	Dim sheets As List = workBook.getfield("Sheets").Result
	'get the sheet objetc by name
	Dim sheet As BANanoObject = sheets.Get(firstSheet)
	'Read all rows from first sheet into an JSON Array.
	Dim excelRows As List = XLSX.getfield("utils").RunMethod("sheet_to_row_object_array", Array(sheet))
	Return excelRows
End Sub