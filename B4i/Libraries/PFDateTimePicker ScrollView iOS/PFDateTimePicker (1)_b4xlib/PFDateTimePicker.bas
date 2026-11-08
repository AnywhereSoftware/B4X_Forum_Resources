B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.1
@EndOfDesignText@
'#DesignerProperty: Key: BooleanExample, DisplayName: Show Seconds, FieldType: Boolean, DefaultValue: True
#Event: SelectedDateChanged(Date as Long)
#DesignerProperty: Key: ThemeColor, DisplayName: Theme Color, FieldType: Color, DefaultValue: #FF2EC5DD, Description: Spinner Theme color

#DesignerProperty: Key: BackgroundColor, DisplayName: Background Color, FieldType: Color, DefaultValue: 0xFFE4E4E4, Description: Text color
#DesignerProperty: Key: MinYear, DisplayName: Min Year, FieldType: Int, DefaultValue: 2020, MinRange: 2020, MaxRange: 2050, Description: Note that MinRange and MaxRange are optional.
#DesignerProperty: Key: MaxYear, DisplayName: Max Year, FieldType: Int, DefaultValue: 2050, MinRange: 2020, MaxRange: 2050, Description: Note that MinRange and MaxRange are optional.
#DesignerProperty: Key: Mode, DisplayName: Mode, FieldType: String, DefaultValue: Date, List: Date|Date & Time|Time
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Private llbl As Label
	Private mProps As Map
	Public const MODE_DATE As String="Date"
	Public const MODE_DATETIME As String="Date & Time"
	Public const MODE_TIME As String="Time"
	'-----------
	Private Const DefaultColorConstant As Int = -984833 'ignore
	Private mDateFormat As String = ""
	Private mDefaultDateFormat As String = "MM/dd/yyyy"
	Private pkrDate As Picker
	Private pkrTime As Picker
	Private pkrMinit As Picker
	Private dlg As CustomLayoutDialog
	Private selectedDate As String
	Private selectedDateTicks As Long
	
	Private  mMinYear As Int=2021
	Private  mMaxYear As Int=2050
	Private  mBackgroundColor As Int
	Private  mMode As String
	'Private mThemeColor As Color
	Private btnDateTime As Button
	Private pnldate As Panel
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
'	Log("C1 " & Base.As(Panel).Color)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
	mProps = Props
	llbl =Lbl
	mBase.LoadLayout("2")
	
	If mProps.Get("Mode") = "Date" Then
		mDateFormat = "MMM-dd-yyyy"		
	else If mProps.Get("Mode") = "Time" Then
		mDateFormat = "HH:mm"		
	Else
		mDateFormat = "MMM-dd-yyyy HH:mm"
	End If
	
	DateTime.DateFormat = mDateFormat
	btnDateTime.Text = DateTime.Date( DateTime.Now)
	DateTime.DateFormat = mDefaultDateFormat
	initDialoge
End Sub

Private Sub setBtnColor
	Dim ButtonText As Int =llbl.TextColor 	'Dim ButtonColor As Int = Colors.Blue
	btnDateTime.CustomLabel.TextColor = llbl.TextColor 'TextColor = xui.PaintOrColorToColor(mProps.Get("TextColor"))
	btnDateTime.CustomLabel.Font = llbl.Font
	btnDateTime.CustomLabel.AdjustFontSizeToFit =llbl.AdjustFontSizeToFit
	btnDateTime.Color =  xui.PaintOrColorToColor(mProps.Get("BackgroundColor"))	''
	btnDateTime.CustomLabel.TextAlignment = llbl.TextAlignment
	'state: 0 = normal, 1 = pressed, 2 = disabled
	Dim no As NativeObject = btnDateTime
	no.RunMethod("setTitleColor:forState:", Array(no.ColorToUIColor(ButtonText), 0))
	no.RunMethod("setTitleColor:forState:", Array(no.ColorToUIColor(Colors.Blue), 1))
	no.RunMethod("setTitleColor:forState:", Array(no.ColorToUIColor(Colors.Gray), 2))
End Sub
Private Sub Base_Resize (Width As Double, Height As Double)
	setBtnColor
End Sub

Private Sub initDialoge
	Dim p As Panel
	p.Initialize("")
	p.LoadLayout("datePicker")
	p.SetLayoutAnimated(0, 1, 0, 0, 325dip , p.GetView(0).Height+30)
	
	dlg.Initialize(p)
	dlg.Style = dlg.STYLE_CUSTOM
	dlg.CustomColor =   xui.PaintOrColorToColor(mProps.Get("ThemeColor")) 'Colors.RGB(46,197,221) '
	dlg.CustomIcon =LoadBitmap(File.DirAssets, "timer-icon.png")
	If mProps.Get("Mode") = "Date" Then		
		pkrTime.Visible = False
		pkrMinit.Visible = False
	else If mProps.Get("Mode") = "Time" Then		
		pkrDate.Visible = False	
	End If
	initdtp
	initTime
End Sub

Private Sub initTime
	Dim s As  AttributedString
	Dim timeList As List
	Dim mnitList As List
	timeList.Initialize
	mnitList.Initialize
	For  i = 0 To 23
		Dim hr As String = "00"&i
		hr = hr.SubString (hr.Length-2)
		s.Initialize(hr, Font.CreateNew(20),Colors.Black)
		timeList.Add(s)
	Next
	pkrTime.SetColumnsWidths(Array(50dip))
	pkrTime.SetItems(0,timeList)
	For  i = 0 To 59
		Dim mnt As String = "00"&i
		mnt = mnt.SubString (mnt.Length-2)
		s.Initialize(mnt, Font.CreateNew(20),Colors.Black)
		mnitList.Add(s)
	Next
	pkrMinit.SetColumnsWidths(Array(50dip))
	pkrMinit.SetItems(0,mnitList)
End Sub

Private Sub initdtp
	Dim s As  AttributedString
	Dim monthArray As List=Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")
	Dim datelist1 As List
	Dim datelist2 As List
	datelist1.Initialize
	datelist2.Initialize
	For  i = 0 To monthArray.Size-1
		s.Initialize(monthArray.Get(i), Font.CreateNew(20),Colors.Black)
		datelist1.Add(s)
	Next
	For i = 1 To 31
		s.Initialize(i, Font.CreateNew(20),Colors.Black)
		datelist2.Add(s)
	Next
	pkrDate.SetColumnsWidths(Array(60,30,65))
	pkrDate.SetItems(0,datelist1)
	pkrDate.SetItems(1,datelist2)
	fillYear
	
End Sub

Private Sub fillYear
	Dim s As  AttributedString
	Dim yearList As List
	yearList.Initialize
	For i = mMinYear To mMaxYear
		s.Initialize(i, Font.CreateNew(20),Colors.Black)
		yearList.Add(s)
	Next
	pkrDate.SetItems(2,yearList)
End Sub

Private Sub fillmonth(days As Int )
	Dim s As  AttributedString
	Dim datelist2 As List
	datelist2.Initialize
	For i = 1 To days
		s.Initialize(i, Font.CreateNew(20),Colors.Black)
		datelist2.Add(s)
	Next
	Dim index As Int
	Try
		index = pkrDate.GetSelectedItem(1)
	Catch
		index=0
	End Try
	pkrDate.SetItems(1,datelist2)
	If days-1 < index Then index =  days
	pkrDate.SelectRow(1,index-1,False)
End Sub

Public Sub getDateTimeTicks As Long
	DateTime.DateFormat = mDateFormat
	selectedDateTicks= DateTime.DateParse(btnDateTime.Text)
	DateTime.DateFormat=mDefaultDateFormat
	Return selectedDateTicks
End Sub

Public Sub SetDateNow
	DateTime.DateFormat = mDateFormat
	btnDateTime.Text = DateTime.Date( DateTime.Now)
	DateTime.DateFormat =mDefaultDateFormat
End Sub

Public Sub SetDate(Ticks As Long)
	Try
		DateTime.DateFormat = mDateFormat
		btnDateTime.Text = DateTime.Date( Ticks)
		DateTime.DateFormat = mDefaultDateFormat
	Catch
		Log(LastException)
	End Try	
End Sub
Private Sub setDilaugeDate(Ticks As Long)
	If mProps.Get("Mode") <> "Time" Then
		pkrDate.SelectRow(0,DateTime.GetMonth(Ticks)-1,False)
		pkrDate.SelectRow(1,DateTime.GetDayOfMonth(Ticks)-1,False)
		pkrDate.SelectRow(2,DateTime.GetYear(Ticks)-mMinYear,False)
	End If
	pkrTime.SelectRow(0,DateTime.GetHour(Ticks),False)
	pkrMinit.SelectRow(0,DateTime.GetMinute(Ticks),False)
	getDateTime
End Sub
'-------------------------------

Public Sub setMode(Mode As String)
	mMode = Mode
End Sub
Public Sub getMode  As String
	Return mMode
End Sub

Public Sub setBackgroundColor(Background_Color As Int)
	mBackgroundColor=Background_Color
End Sub
Public Sub getBackgroundColor  As Int
	Return mBackgroundColor
End Sub

Public Sub setMinYear(Min_Year As Int)
	mMinYear = Min_Year
	fillYear
End Sub

Public Sub getMinYear As Int
	Return mMinYear
End Sub

Public Sub setMaxYear(Max_Year As Int)
	mMaxYear = Max_Year
	fillYear
End Sub

Public Sub getMaxYear As Int
	Return mMaxYear
End Sub

Private Sub pkrDate_ItemSelected (Column As Int, Row As Int)
	Dim month As Int = pkrDate.GetSelectedRow(0) +1
	Dim year As Int = pkrDate.GetSelectedRow(2) +mMinYear
	If Column = 0 Or Column = 2 Then fillmonth(DateUtils.NumberOfDaysInMonth(month,year))
	getDateTime
End Sub

Private Sub pkrTime_ItemSelected (Column As Int, Row As Int)
	getDateTime
End Sub

Private Sub pkrMinit_ItemSelected (Column As Int, Row As Int)
	getDateTime
End Sub

Private Sub getDateTime
	Dim month As Int = pkrDate.GetSelectedRow(0) +1
	Dim day As Int = pkrDate.GetSelectedRow(1) +1
	Dim year As Int = pkrDate.GetSelectedRow(2) +mMinYear
	Dim hr As Int = pkrTime.GetSelectedRow(0)
	Dim mint As Int = pkrMinit.GetSelectedRow(0)
	If DateUtils.NumberOfDaysInMonth(month,year)< day Then  day = DateUtils.NumberOfDaysInMonth(month,year)
	DateTime.DateFormat = mDateFormat
	selectedDate = DateTime.Date(DateUtils.SetDateAndTime(year,month,day,hr,mint,0))
	selectedDateTicks = DateTime.DateParse(selectedDate)
	DateTime.DateFormat =mDefaultDateFormat
End Sub

Private Sub btnDateTime_Click
	initDialoge
	DateTime.DateFormat = mDateFormat
	'SetDate(DateTime.DateParse(btnDateTime.Text))
	setDilaugeDate(DateTime.DateParse(btnDateTime.Text))
	DateTime.DateFormat =mDefaultDateFormat
	Dim sf As Object = dlg.ShowAsync("", "OK", "CANCEL", "", False)
	Wait For (sf) Dialog_Result (Result As Int)
	If Result = dlg.RESULT_POSITIVE Then
		If btnDateTime.Text <> selectedDate Then
			If xui.SubExists(mCallBack, mEventName & "_SelectedDateChanged", 1) Then
				CallSub2(mCallBack, mEventName & "_SelectedDateChanged",selectedDateTicks)
			End If
		End If
		btnDateTime.Text = selectedDate
	End If
End Sub
Private Sub SelectedDateChanged(date As Long)
	If xui.SubExists(mCallBack, mEventName & "_SelectedDateChanged", 1) Then
		CallSub2(mCallBack, mEventName & "_SelectedDateChanged",date)
	End If
End Sub

