B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=2.18
@EndOfDesignText@
'WebSocket class
Sub Class_Globals
	Private ws As WebSocket 'ignore
	Private DatePicker As JQueryElement 'ignore
	Private Dialog As JQueryElement
	Private Tabs, TabsTitle As JQueryElement
End Sub

Public Sub Initialize
	DateTime.DateFormat = "MM/dd/yy"
End Sub

Private Sub WebSocket_Connected (WebSocket1 As WebSocket)
	ws = WebSocket1
	'call the set date function we created
	DatePicker.SetVal(DateTime.Date(DateTime.Now))
	'configure the jQuery UI dialog element
	Dialog.RunMethod("dialog", Array As Object(CreateMap("autoOpen": False, "modal": True)))
End Sub

Sub DatePicker_Select(Params As Map)
	Dim fdate As Future = DatePicker.GetVal
	Dim chosenDate As Long = DateTime.DateParse(fdate.Value)
	'set the year to this year.
	chosenDate = DateUtils.SetDateAndTime(DateTime.GetYear(DateTime.Now), _
		DateTime.GetMonth(chosenDate), DateTime.GetDayOfMonth(chosenDate), 23, 59, 59)
	If chosenDate < DateTime.Now Then chosenDate = DateTime.Add(chosenDate, 1, 0, 0)
	'calculate the period between now and the chosen date
	Dim p As Period = DateUtils.PeriodBetween(DateTime.Now, chosenDate)
	ShowDialog("<b>Your next birthday is in</b>: <br/>" & p.Months & " months and " & p.Days & " days.", "Birthday")
End Sub

Sub ShowDialog(Message As String, Title As String)
	Dialog.SetHtml(Message)
	'set the title
	Dialog.RunMethod("dialog", Array As Object("option", "title", Title))
	'open the dialog
	Dialog.RunMethod("dialog", Array As Object("open"))
End Sub

Sub Tabs_TabChange(Params As Map)
	TabsTitle.SetText("Currently selected tab is: " & Params.Get("tab"))
End Sub

Private Sub WebSocket_Disconnected
End Sub