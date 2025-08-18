B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=2.18
@EndOfDesignText@
''Class module
Sub Class_Globals
	Private ws As WebSocket
	Private lstStudentsID As JQueryElement
	Private lblStudentName As JQueryElement
	Private lblBirthday As JQueryElement
	Private txtGrade As JQueryElement
	Private tblFailedTests As JQueryElement
	Private lstTests As JQueryElement
	Private tblStudents As JQueryElement
	Private students As List
End Sub
'
'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize

End Sub

Private Sub WebSocket_Connected (WebSocket1 As WebSocket)
	ws = WebSocket1
	FillSelectBox(lstStudentsID, Main.SQLite.ExecQuery("SELECT id FROM students"))
	'initialize the failed tests dataTable
	'The two tables are based on this plug-in: https://datatables.net/
	tblFailedTests.RunMethod("dataTable", Array As Object( _
		CreateMap("bFilter": False, "bPaginate": False, "sScrollY": "200px", "bSort": False)))
		
	students.Initialize
	'fetch the list of students
	DBUtils.ExecuteList(Main.SQLite, "SELECT id FROM students", Null, 0, students)
	'create the students table
	FillStudentsTable(tblStudents, Main.SQLite.ExecQuery("SELECT Id, [First Name], [Last Name], Birthday FROM Students"))
	
	lstStudentsId_Change(Null)
End Sub
'Create a SelectBox (similar to ComboBox or Spinner)
Sub FillSelectBox (jq As JQueryElement, rs As ResultSet)
	Dim sb As StringBuilder
	sb.Initialize
	Do While rs.NextRow
		Dim val As String = WebUtils.EscapeHtml(rs.GetString2(0))
		sb.Append("<option value='").Append(val).Append("'>").Append(val).Append("</option>")
	Loop
	rs.Close
	jq.SetHtml(sb.ToString)
End Sub

Sub FillStudentsTable(jq As JQueryElement, rs As ResultSet)
	DateTime.DateFormat = "yyyy/MM/dd" 'sortable format
	Dim data As List
	data.Initialize
	Do While rs.NextRow
		Dim row As List
		row.Initialize
		For c = 0 To rs.ColumnCount - 1
			Dim val As String = rs.GetString2(c)
			If c = 3 Then
				'convert the birthday ticks value to a date string
				val = DateTime.Date(val)
			End If
			row.Add(val)
		Next
		data.Add(row)
	Loop
	rs.Close
	jq.RunMethod("dataTable", Array As Object(CreateMap("aaData": data, "bFilter": False, _
		"bPaginate": True)))
	'bind the selection changed event to the students table
	ws.RunFunction("addSelectionToTable", Array As Object(tblStudents.Id, "TableView1_SelectedRowChanged"))
End Sub

Sub lstStudentsId_Change (Params As Map)
	Dim id As String = lstStudentsID.GetVal.Value
	SelectStudent(id)
	'Select the relevant row in the table.
	ws.RunFunction("setSelectedRow", Array As Object(tblStudents.id, students.IndexOf(id)))
End Sub

Sub SelectStudent(id As String)
	Dim m As Map = DBUtils.ExecuteMap(Main.SQLite, "SELECT Id, [First Name], [Last Name], Birthday FROM students WHERE id = ?", _
		Array As String(id))
	If m.IsInitialized = False Then
		lblStudentName.SetText("N/A")
		lblBirthday.SetText("")
	Else
		lblStudentName.SetText(m.Get("first name") & " " & m.Get("last name")) 'keys are lower cased!
		lblBirthday.SetText(DateTime.Date(m.Get("birthday")))
	End If
	'Get the tests for this specific student (currently it is all tests).
	FillSelectBox(lstTests, Main.SQLite.ExecQuery2("SELECT test FROM Grades WHERE id = ?", Array As String(id)))
	TestChange(id, "Test #01")
	FindFailedTests(id)
End Sub

Sub FindFailedTests(StudentId As String)
	'Find all tests of this student with grade lower than 55.
	DBUtils.FillTable(ws, tblFailedTests, _
		Main.SQLite.ExecQuery2("SELECT test , grade FROM Grades WHERE id = ? AND grade <= 55 ORDER BY test ASC", _
		Array As String(StudentId)))
End Sub



Sub lstTests_Change (Params As Map)
	Dim test As Future = lstTests.GetVal
	Dim student As Future = lstStudentsID.GetVal
	TestChange(student.Value, test.Value)
End Sub

Sub TestChange(id As String, test As String)
	Dim m As Map
	m = DBUtils.ExecuteMap(Main.SQLite, "SELECT Grade FROM Grades WHERE id = ? AND test = ?", _
		Array As String(id, test))
	If m.IsInitialized = False Then
		txtGrade.SetVal("N/A")
	Else
		txtGrade.SetVal(m.Get("grade"))
	End If
End Sub

Sub btnSetGrade_Click (Params As Map)
	'check that the value is valid
	'set the grade of the record with the correct id and test values.
	Dim id As Future = lstStudentsID.GetVal
	Dim test As Future = lstTests.GetVal
	Dim grade As Future = txtGrade.GetVal
	If IsNumber(grade.Value) = False OR grade.Value < 0 OR grade.Value > 100 Then
		ws.Alert("Invalid value: " & grade.Value)
	Else
		DBUtils.UpdateRecord(Main.SQLite, "Grades", "Grade", grade.Value, _
			CreateMap("id": id.Value, "test": test.Value))
		'Refresh the failed tests list
		FindFailedTests(id.Value)
	End If
End Sub

Sub TableView1_SelectedRowChanged(Params As Map)
	Dim index As Int = Params.Get("row")
	If index = -1 Then Return
	lstStudentsID.SetVal(students.Get(index))
	SelectStudent(students.Get(index))
End Sub

