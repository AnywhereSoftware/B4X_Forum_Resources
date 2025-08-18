B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.01
@EndOfDesignText@
Private Sub Class_Globals
	Private StartYear As Int = 1970
	Private EndYear As Int = 2030
	Private cd As CustomDialog2
	Private pnl As Panel
	Private spinDays As Spinner
	Private spinMonths As Spinner
	Private SpinYears As Spinner
	Private MonthNames() As String = Array As String("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jly", "Aug", "Sep", "Oct", "Nov", "Dec")
	Private MonthDays() As String = Array As String("31", "28", "31", "30", "31", "30", "31", "31", "30", "31", "30", "31")
End Sub

'Initializes the DateDialog2 object. The time Is always in 24 hour format.
'The Day, Month and Year properties can be set with initial values before showing the dialog.
'The TimeDialog2 may be shown modally with Show or non-modally with ShowAsync.
'Returns a DialogResponse with the Day, Month and Year properties set to the user entered values.
'When shown modally the day count is always 31 as the dialog cannot be altered once shown.
'When shown non-modally the day count adapts to the month and year taking account of leap years.
'Note that event raised by ShowAsyncComplete is 'Complete' not 'Dialog_result'
Public Sub Initialize(FirstYear As Int, LastYear As Int)
	pnl.Initialize("pnl")
	cd.AddView(pnl, 300dip, 100dip) 
	spinDays.Initialize("")
	spinDays.TextSize = 24
	For i = 1 To 31
		spinDays.Add(NumberFormat(i, 2, 0))
	Next
	spinMonths.Initialize("SpinMonths")
	
	spinMonths.TextSize = 24
	For i = 0 To 11
		spinMonths.Add(MonthNames(i))
	Next
	
	StartYear = FirstYear
	EndYear = LastYear
	SpinYears.Initialize("SpinYears")
	SpinYears.TextSize = 24
	For i = StartYear To EndYear
		SpinYears.Add(i)
	Next
	
	Dim lbl1 As Label
	lbl1.Initialize("")
	lbl1.Text = "Day"
	
	Dim lbl2 As Label
	lbl2.Initialize("")
	lbl2.Text = "Month"
	
	Dim lbl3 As Label	
	lbl3.Initialize("")
	lbl3.Text = "Year"	
	
	Dim w As Int = pnl.Width
	
	pnl.AddView(lbl1, w*0.5/11, 20dip, w/5, 40dip)
	pnl.AddView(lbl2, w*3.5/11, 20dip, w/5, 40dip)
	pnl.AddView(lbl3, w*7.5/11, 20dip, w/5, 40dip)
	
	pnl.AddView(spinDays, 0, 50dip, w/3, 50dip)
	pnl.AddView(spinMonths, w*3 /11, 50dip, w/2.5, 50dip)
	pnl.AddView(SpinYears, w*7/11, 50dip, w/2.5, 50dip)
End Sub

Public Sub Show(Title As String, Positive As String, Cancel As String, Negative As String, icon As Bitmap) As Int
	Dim ret As Int = cd.Show(Title, Positive, Cancel, Negative, icon) 'ignore
	Return ret
End Sub

Public Sub ShowAsyncComplete(Title As String, Positive As String, Cancel As String, Negative As String, Icon As Bitmap, Cancelable As Boolean) As ResumableSub
	SpinYears_ItemClick (0 ,0) ' ShowAsync allows events so we reset the number of days in the month
	Dim fda As Object = cd.ShowAsync(Title, Positive, Cancel, Negative, Icon, Cancelable) 'ignore
	Wait For (fda) Dialog_Result(ret As Int)
	Return ret
End Sub

Public Sub getDay As Int
	Return spinDays.Selecteditem
End Sub

Public Sub setDay(Day As Int)
	spinDays.SelectedIndex = Day - 1
End Sub

Public Sub getMonth As Int
	Return spinMonths.SelectedIndex + 1
End Sub

Public Sub setMonth(Month As Int)
	spinMonths.SelectedIndex = Month - 1
End Sub

Public Sub getYear As Int
	Return SpinYears.Selecteditem
End Sub

Public Sub setYear(Year As Int)
	SpinYears.SelectedIndex = Year - StartYear
End Sub

Public Sub getStartYear  As Int
	Return StartYear	
End Sub

Public Sub getEndYear As Int
	Return EndYear
End Sub


' These events only trigger in Async mode events

Private Sub SpinMonths_ItemClick (Position As Int, Value As Object)
	Dim days As Int = MonthDays(Position)
	Dim year As Int = SpinYears.Selecteditem
	If year Mod 4 = 0 And spinMonths.SelectedIndex = 1 Then days = days + 1
	spinDays.Clear
	For i = 1 To days
		spinDays.Add(NumberFormat(i, 2, 0))
	Next
End Sub
	
Private	Sub SpinYears_ItemClick (Position As Int, Value As Object)
	Dim days As Int = MonthDays(spinMonths.SelectedIndex)
	Dim year As Int = SpinYears.Selecteditem
	If year Mod 4 = 0 And spinMonths.SelectedIndex = 1 Then ' year divisible by 4 and
		If Not(year Mod 100 = 0 And year Mod 400 <> 0 ) Then	 ' century year whose not divisible by 400.
			days = days + 1
		End If
	End If
	spinDays.Clear
	For i = 1 To days
		spinDays.Add(NumberFormat(i, 2, 0))
	Next
End Sub


