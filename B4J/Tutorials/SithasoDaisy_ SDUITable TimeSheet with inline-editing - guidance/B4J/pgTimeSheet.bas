B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'***** DO NOT DELETE OR CHANGE THIS FILE *****
#IgnoreWarnings:12, 9
Sub Process_Globals
	'this is the name of the page
	Public name As String = "timesheet"
	Public title As String = "TimeSheet"
	Public icon As String = "fa-solid fa-swatchbook"
	'this variable holds the page controller
	Public page As SDUIPage
	'this variable holds reference to the app
	'usually for constants and other things
	Public app As SDUIApp
	'the variable referencing banano lib
	Private banano As BANano		'ignore
	Private mdlConfirm As SDUIModal
	Private mdltimesheet As SDUIModal
	Private pbtimesheet As SDUITable
	Private SDUICol1 As SDUICol
	Private SDUIRow1 As SDUIRow
	Private tbltimesheet As SDUITable
End Sub

'sub to show the page
Sub Show(duiapp As SDUIApp)			'ignore
	'get the reference to the app
	app = duiapp
	'build the page, via code or loadlayouts
	BuildPage
End Sub


Sub getName As String
	Return name
End Sub

Sub getIcon As String
	Return icon
End Sub

Sub getTitle As String
	Return title
End Sub

'start building the page
private Sub BuildPage
	banano.LoadLayout(app.PageViewer, "timesheetlayout")
	tbltimesheet.AddColumn("time", "Time")
	tbltimesheet.AddColumnTextBox("mon", "Monday", False)
	tbltimesheet.AddColumnTextBox("tue", "Tuesday", False)
	tbltimesheet.AddColumnTextBox("wed", "Wednesday",False)
	tbltimesheet.AddColumnTextBox("thu", "Thursday",False)
	tbltimesheet.AddColumnTextBox("fri", "Friday",False)
	tbltimesheet.AddColumnTextBox("sat", "Saturday",False)
	tbltimesheet.AddColumnTextBox("sun", "Sunday",False)
	'tbltimesheet.AddColumnTime("total", "Total")
	tbltimesheet.AddColumnEdit("primary")
	'
	tbltimesheet.ClearRows
	tbltimesheet.AddRow(CreateMap("id":"06", "time":"06:00", "mon":1,"tue":2,"wed":3,"thu":4, "fri":5, "sat":6, "sun":10))
	tbltimesheet.AddRow(CreateMap("id":"07", "time":"07:00", "mon":1,"tue":2,"wed":3,"thu":4, "fri":5, "sat":6, "sun":10))
	tbltimesheet.AddRow(CreateMap("id":"08", "time":"08:00", "mon":1,"tue":2,"wed":3,"thu":4, "fri":5, "sat":6, "sun":10))
	tbltimesheet.AddRow(CreateMap("id":"09", "time":"09:00", "mon":1,"tue":2,"wed":3,"thu":4, "fri":5, "sat":6, "sun":10))
	tbltimesheet.AddRow(CreateMap("id":"10", "time":"10:00", "mon":1,"tue":2,"wed":3,"thu":4, "fri":5, "sat":6, "sun":10))
	tbltimesheet.AddRow(CreateMap("id":"11", "time":"11:00", "mon":1,"tue":2,"wed":3,"thu":4, "fri":5, "sat":6, "sun":10))
	tbltimesheet.AddRow(CreateMap("id":"12", "time":"12:00", "mon":1,"tue":2,"wed":3,"thu":4, "fri":5, "sat":6, "sun":10))
	tbltimesheet.AddRow(CreateMap("id":"13", "time":"13:00", "mon":1,"tue":2,"wed":3,"thu":4, "fri":5, "sat":6, "sun":10))
	tbltimesheet.AddRow(CreateMap("id":"14", "time":"14:00", "mon":1,"tue":2,"wed":3,"thu":4, "fri":5, "sat":6, "sun":10))
	tbltimesheet.AddRow(CreateMap("id":"15", "time":"15:00", "mon":1,"tue":2,"wed":3,"thu":4, "fri":5, "sat":6, "sun":10))
	tbltimesheet.AddRow(CreateMap("id":"16", "time":"16:00", "mon":1,"tue":2,"wed":3,"thu":4, "fri":5, "sat":6, "sun":10))
	tbltimesheet.AddRow(CreateMap("id":"17", "time":"17:00", "mon":1,"tue":2,"wed":3,"thu":4, "fri":5, "sat":6, "sun":10))
	tbltimesheet.AddRow(CreateMap("id":"18", "time":"18:00", "mon":1,"tue":2,"wed":3,"thu":4, "fri":5, "sat":6, "sun":10))
	tbltimesheet.AddRow(CreateMap("id":"19", "time":"19:00", "mon":1,"tue":2,"wed":3,"thu":4, "fri":5, "sat":6, "sun":10))
	tbltimesheet.AddRow(CreateMap("id":"20", "time":"20:00", "mon":1,"tue":2,"wed":3,"thu":4, "fri":5, "sat":6, "sun":10))
	'
	app.PageResume
End Sub


Private Sub tbltimesheet_EditRow (Row As Int, item As Map)
	Log(item)
End Sub

Private Sub tbltimesheet_Refresh (e As BANanoEvent)
	
End Sub

Private Sub mdltimesheet_Yes_Click (e As BANanoEvent)
	
End Sub

Private Sub mdltimesheet_No_Click (e As BANanoEvent)
	
End Sub

Private Sub mdlConfirm_Yes_Click (e As BANanoEvent)
	
End Sub

Private Sub mdlConfirm_No_Click (e As BANanoEvent)
	
End Sub

Private Sub tbltimesheet_ChangeRow (Row As Int, Value As Object, Column As String, item As Map)
	'
	Log(Row)
	Log(item)
	'
End Sub