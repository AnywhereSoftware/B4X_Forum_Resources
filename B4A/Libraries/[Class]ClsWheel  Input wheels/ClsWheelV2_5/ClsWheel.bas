Type=Class
Version=6.8
ModulesStructureVersion=1
B4A=true
@EndOfDesignText@
'Class module ClsWheel version 2.5
'Written by Klaus CHRISTL (klaus)
'V2.5		2017.03.30  Separated wheel font size and title font size 
'V2.4		2017.03.28	Amended error + / - with numbers
'V2.3		2015.09.22	Amended error in date selection
'V2.2		2015.08.13	Amended error declaring a variable
'V2.1		2015.05.10	Added one timer for each wheel instead of a unique timer
'V2.0		2015.04.29	Added a Tag property
'V1.9		2014.09.09	Amanded day scrolling problem
'V1.8		2013.09.29	Added INTEGER, INTEGER_POS, NUMBER and NUMBER_POS entry modes for numbers
'                   requested by Chris Meier (Mr23) with a code sample
'V1.7		2014.04.21	Amended OutOfMemory error happening sometimes
'V1.6		2013.09.14	Added min year and number of years to diplay
'V1.5		2013.08.08	Added StartScroll and EndScroll events
'V1.4		2013.06.14	Modified event from OK to Closed
'										Amended the screen color problem
'V1.3		2013.06.12	Mofied property routines.
'										Added Show2 for raising an event when clicking the OK button
'										Added optional continus scrolling 
'V1.2		2013.05.28	Amended a bug.
'V1.1		2012.12.15	Amended some bugs.
'V1.0		2012.12.14

Sub Class_Globals
	Public WheelType As Int
	Public DATE = 0			As Int				
	Public TIME_HM = 1		As Int	
	Public TIME_HMS = 2		As Int	
	Public DATE_TIME = 3	As Int
	Public CUSTOM = 4		As Int
	Public INTEGER = 5		As Int
	Public INTEGER_POS = 6		As Int
	Public NUMBER = 7 As Int
	Public NUMBER_POS = 8 As Int
	
	Private pnlScreen, pnlMain, pnlBackGround, pnlTop, pnlMiddle, pnlBottom As Panel
	Private btnOK, btnCancel As Button
	Private lblTitle As Label
	Private Callback As Object
	Private CallbackView As Object
	Private scvWheel() As ScrollView
	Private objWheel() As Reflector
	Private bmpDummy As Bitmap
	Private cvsDummy, cvsTop, cvsMiddle, cvsBottom As Canvas
	Private rectMiddle As Rect
	Private cVerticalScrollBar = False As Boolean
	Private EventName, Title As String
	Private EventEnabled As Boolean
	
	Private ColWidths() As Int
	Private TotalColWidths() As Int
	Private WheelNb As Int		
	Private FontSize, TitleFontSize As Float
	Private lblHeight, WheelTop, btnHeight, btnWidth, pnlMainWidth, pnlMainHeight As Int
	Private pnlBackGroundHeight, pnlBackGroundOffset, btnSpace As Int
	Public Left As Int
	Public Top As Int
	Public Width As Int
	Public Height As Int
	
	Private cFirstYear = 2000 As Int
	Private cNbYears = 31 As Int
	
	Private cDigitsToTheRight = 0 As Int
	Private cIsFixedFormat = False As Boolean
	Private cLeadingZeros = False As Boolean
	
	Private TimerWheel() As Timer
	
	Private WheelContent() As List
	Private WheelContentNb() As Int
	Private WheelContinus = 0 As Int
	
	Private ItemNb = 5 As Int
'	Public ItemNb = 7 As Int
	Private ItemNb_2 As Int		
		ItemNb_2 = Floor(ItemNb / 2)
	Private lineWidth = 4dip							As Int
	Private colBackGround  = Colors.Blue	As Int
	Private colShadow  = Colors.Black			As Int
	Private colWindowLine  = Colors.Red		As Int
	Private colWindow  = Colors.ARGB(96, 255, 0, 0)	As Int
	Private colScreen = Colors.ARGB(196, 0, 0, 0) As Int
	Private ScrollPos() As Int 
	Private x0, y0, y1 As Int 
	Private t1 As Long
	Private speed As Double
	Private CurrentDayIndex As Int
	Dim SepText = " "											As String
	
	Private DaysPerMonth() As Int
		DaysPerMonth = Array As Int (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
End Sub

'Initialize the Wheel.
'CallbackModule = calling module mostly Me
'Parent = parent view Activity
'cTitle = title for the wheels, enter "" and empty string for no title
'cWheelNb = number of wheels
'cWheelContent0() = array of Lists with the content for each wheel
'cFontSize = text size for all wheels and the title
'cWheelType =
'						0 = DATE					DATE, the returned DATE has the current DATE format
'						1 = TIME_HM  			time in hours and minutes
'           2 = TIME_HMS 			time in hours, minutes and seconds
'						3 = DATE_TIME  		date and time in hours and minutes
'						4 = CUSTOM   			any texts in different wheels, when using numbers they must be conveted into strings !
'      			5 = INTEGER  			positive and negative integers
'						6 = INTEGER_POS  only positive integers
'						7 = NUMBER  			positive and negative numbers
'						8 = NUMBER_POS		only positive numbers
'cWheelNb  number wheels, max 5 for custom and max 10 for integer and number
'cContinusScrolling = True continus scrolling
'Example:
'<code>Dim DateWheel As ClsWheel
'DateWheel.Initialize (Me, Activity, "DateWheel", "Enter the date", 10dip, 10dip, 3, Null, 16, 0, True)</code>
Public Sub Initialize(CallbackModule As Object, Parent As Object, cTitle As String, cWheelNb As Int, cWheelContent() As List, cFontSize As Float, cWheelType As Int, cContinusScrolling As Boolean)
	Dim i, j As Int
	Callback = CallbackModule
	Title = cTitle
	WheelType = cWheelType
	If cWheelNb = 0 Then
	 cWheelNb = 1
	End If
	Select WheelType
	Case INTEGER, NUMBER
		WheelNb = cWheelNb + 1
	Case Else
		WheelNb = cWheelNb
	End Select
	FontSize = cFontSize
	
	If cContinusScrolling = False Then
		WheelContinus = 0
	Else
		WheelContinus = 2
	End If
	
	btnHeight = 50dip
	btnWidth = 100dip
	btnSpace = 6dip
	
	Select WheelType
	Case DATE
		InitializeDate
	Case TIME_HM
		InitializeTime_HM
	Case TIME_HMS
		InitializeTime_HMS
	Case DATE_TIME
		InitializeDateTime
	Case CUSTOM
		If WheelNb > 5 Then
			WheelNb = 5
			ToastMessageShow("Number of wheels too big, max 5", False)
		End If
		InitializeCustom(cWheelContent)
	Case INTEGER, INTEGER_POS, NUMBER, NUMBER_POS
		InitializeNumbers
	End Select
	
	Dim TimerWheel(WheelNb) As Timer
	For i = 0 To TimerWheel.Length - 1
		TimerWheel(i).Initialize("TimerWheel", 200)
	Next 
	
	pnlMainWidth = 10000
	pnlMainHeight = 10000
	bmpDummy.InitializeMutable(2dip, 2dip)
	cvsDummy.Initialize2(bmpDummy)
	Do Until pnlMainWidth <= 100%x And pnlMainHeight <= 100%y
		lblHeight = cvsDummy.MeasureStringHeight("Ag", Typeface.DEFAULT, FontSize) + DipToCurrent(FontSize / 2)

		pnlBackGroundHeight = ItemNb * lblHeight 
		If Title = "" Then
			pnlMainHeight = pnlBackGroundHeight + btnHeight + 2 * btnSpace
			WheelTop = 0
		Else
			pnlMainHeight = pnlBackGroundHeight + btnHeight + 2 * btnSpace + lblHeight
			WheelTop = lblHeight
		End If
		Dim ColWidths(WheelNb) As Int
		Dim TotalColWidths(WheelNb + 1) As Int
		TotalColWidths(0) = lineWidth 
		For i = 0 To WheelNb - 1
			ColWidths(i) = 0
			For j = 0 To WheelContent(i).Size -1
				ColWidths(i) = Max(ColWidths(i), cvsDummy.MeasureStringWidth(WheelContent(i).get(j), Typeface.DEFAULT, FontSize))
			Next 
			ColWidths(i) = ColWidths(i) + 20dip
			If WheelType = DATE_TIME And i = 2 Then
				TotalColWidths(i + 1) = TotalColWidths(i) + ColWidths(i) + 2 * lineWidth
			Else
				TotalColWidths(i + 1) = TotalColWidths(i) + ColWidths(i) + lineWidth
			End If
		Next
		
		pnlMainWidth = TotalColWidths(WheelNb)
		
		If pnlMainWidth > 100%x Then
			FontSize = Floor(FontSize * 100%x / pnlMainWidth)
		End If
		
		TitleFontSize = FontSize
		
		pnlMainWidth = Max(2 * btnWidth + 4 * btnSpace, cvsDummy.MeasureStringWidth(Title, Typeface.DEFAULT, TitleFontSize))

		If pnlMainWidth > 100%x Then
			TitleFontSize = Floor(TitleFontSize * 100%x / pnlMainWidth)
			pnlMainWidth = Max(2 * btnWidth + 4 * btnSpace, cvsDummy.MeasureStringWidth(Title, Typeface.DEFAULT, TitleFontSize))
		End If
		
		If pnlMainWidth > TotalColWidths(WheelNb) Then		
			pnlBackGroundOffset = (pnlMainWidth - TotalColWidths(WheelNb)) / 2
		Else
			pnlMainWidth = TotalColWidths(WheelNb)
			pnlBackGroundOffset = 0
		End If
		
		If pnlMainHeight > 100%y Then
			FontSize = Floor(FontSize * (100%y - btnHeight - 2 * btnSpace) / (pnlMainHeight - btnHeight - 2 * btnSpace))
		End If	
	Loop

	Left = 50%x - pnlMainWidth / 2
	Top = 50%y - pnlMainHeight / 2
	
	pnlScreen.Initialize("pnlScreen")
	If Parent Is Activity Then
		Dim act As Activity
		act = Parent
		act.AddView(pnlScreen, 0, 0, 100%x, 100%y)
		DoEvents
		pnlScreen.Color = colScreen
		pnlScreen.Visible = False
	Else
		ToastMessageShow("Parent must be an activity.", False)
		Return
	End If
	
	pnlMain.Initialize("pnlMain")
	pnlScreen.AddView(pnlMain, Left, Top, pnlMainWidth, pnlMainHeight)
	pnlMain.Color = Colors.Black
	
	btnOK.Initialize("btnOK")
	btnOK.Text = "O K"
	pnlMain.AddView(btnOK, pnlMain.Width / 2 - btnSpace - btnWidth, pnlMain.Height - btnHeight - btnSpace, btnWidth, btnHeight)

	btnCancel.Initialize("btnCancel")
	btnCancel.Text = "Cancel"
	pnlMain.AddView(btnCancel, pnlMain.Width / 2 + btnSpace, pnlMain.Height - btnHeight - btnSpace, btnWidth, btnHeight)

	pnlBackGround.Initialize("pnlBackGround")
	pnlBackGround.Color = colBackGround
	pnlMain.AddView(pnlBackGround, pnlBackGroundOffset, WheelTop, TotalColWidths(WheelNb), pnlBackGroundHeight)
	
	If Title <> "" Then
		lblTitle.Initialize("")
		pnlMain.AddView(lblTitle, 0, 0, pnlMainWidth, lblHeight)
		lblTitle.Color = colShadow
		lblTitle.TextSize = TitleFontSize
		lblTitle.Gravity = Bit.Or(Gravity.CENTER_HORIZONTAL, Gravity.BOTTOM)
		lblTitle.Text = Title
	End If
	pnlBackGround.Color = colBackGround
	
	Dim scvWheel(WheelNb) As ScrollView
	Dim objWheel(WheelNb) As Reflector
'	Dim cvsWheel As Canvas
'	Dim x1, x2, y2 As Float
	For i = 0 To WheelNb - 1
		scvWheel(i).Initialize2(lblHeight * (WheelContent(i).Size + ItemNb - 1), "scv")
		pnlBackGround.AddView(scvWheel(i), TotalColWidths(i), 0, ColWidths(i), pnlBackGroundHeight)
		scvWheel(i).Tag = i
		objWheel(i).Target = scvWheel(i)
		
		scvWheel(i).Panel.Color = Colors.White
		
		objWheel(i).SetOnTouchListener("scv_Touch")
		objWheel(i).RunMethod2("setSmoothScrollingEnabled", False, "java.lang.boolean")
'		objWheel(i).RunMethod2("setSmoothScrollingEnabled", True, "java.lang.boolean")
		objWheel(i).RunMethod2("setVerticalScrollBarEnabled", False, "java.lang.boolean")
		For j = 0 To WheelContent(i).Size + ItemNb
			Dim lbl As Label
			lbl.Initialize("")
			scvWheel(i).Panel.AddView(lbl, 0, j * lblHeight, ColWidths(i), lblHeight)
			lbl.Gravity = Gravity.CENTER_HORIZONTAL + Gravity.CENTER_VERTICAL
			lbl.Color = Colors.Transparent
			lbl.TextColor = Colors.Black
			lbl.TextSize = FontSize
			If j >= ItemNb_2 And j <= WheelContent(i).Size + ItemNb_2 - 1 Then
				lbl.Text = WheelContent(i).get(j - ItemNb_2)
			Else
				lbl.Text = ""
			End If
		Next
' test code, I left it here for memory.
'		scvWheel(i).Panel.Width = scvWheel(i).Width
'		cvsWheel.Initialize(scvWheel(i).Panel)
'		x1 = 0
'		x2 = x1 + scvWheel(i).Panel.Width
'		y2 = lblHeight * WheelContentNb(i)
'		cvsWheel.DrawLine(x1, y2, x2, y2, Colors.Green, lineWidth)
'		y2 = lblHeight * 2 * WheelContentNb(i)
'		cvsWheel.DrawLine(x1, y2, x2, y2, Colors.Green, lineWidth)
	Next
	
	pnlTop.Initialize("")
	pnlBackGround.AddView(pnlTop, 0, 0, TotalColWidths(WheelNb), ItemNb_2 * lblHeight)

	pnlMiddle.Initialize("")
	pnlBackGround.AddView(pnlMiddle, lineWidth, 0 + ItemNb_2 * lblHeight, TotalColWidths(WheelNb) - 2 * lineWidth, lblHeight)
	cvsMiddle.Initialize(pnlMiddle)
	rectMiddle.Initialize(0, 0, pnlMiddle.Width, pnlMiddle.Height)
	
	pnlBottom.Initialize("")
	pnlBackGround.AddView(pnlBottom, 0, 0 + (ItemNb_2 + 1) * lblHeight, TotalColWidths(WheelNb), ItemNb_2 * lblHeight)

	setShadowColor(colShadow)
	setWindowColor(colWindow)
	setWindowLineColor(colWindowLine)
	
	Width = pnlBackGround.Width
	Height = pnlBackGround.Height
End Sub

'Show the wheel panel
'cCallbackView = view where the result is shown an EditText or a Label
'DefaultValue = the wheels will be set to this value
'Enter "" for now (for DATE, TIME_HM. TIME_HMS and DATE_TIME
'The returned Date and Time values are in the format defined in the main code
'Example:
'<code>TimeHMWheel.Show (lblDeparture, "")</code>
Public Sub Show(cCallbackView As Object, DefaulValue As String)
	CallbackView = cCallbackView
	EventEnabled = False
	InitDefaultValues(DefaulValue)
End Sub

'Show the wheel panel
'cEventName = EventName for the _Closed event
'DefaultValue = the wheels will be set to this value
'Enter "" for now (for DATE, TIME_HM. TIME_HMS and DATE_TIME
'Example:
'<code>TimeHMWheel.Show2 ("TimeHMWheel", "")</code>
Public Sub Show2(cEventName As String, DefaulValue As String)
	
	EventName = cEventName
	
	If SubExists(Callback, EventName & "_Closed") = False Then
		ToastMessageShow("There is no " & EventName & "_Closed", False)
		Return
	End If
	
	EventEnabled = True

	InitDefaultValues(DefaulValue)
End Sub

'Initialize the wheel positions according to the default values given in the Show methods. used internally
Private Sub InitDefaultValues(DefaulValue As String)
	Dim i As Int
	Dim Ticks As Long

	Select WheelType
	Case DATE
		If DefaulValue = "" Then
			Ticks = DateTime.Now
		Else
			Ticks = DateTime.DateParse(DefaulValue)
		End If
		ScrollPos(0) = lblHeight * (DateTime.GetYear(Ticks) - cFirstYear + WheelContentNb(0))
		ScrollPos(1) = lblHeight * (DateTime.GetMonth(Ticks) - 1 + WheelContentNb(1))
		i = DateTime.GetMonth(DateTime.Now) - 1
		CurrentDayIndex = DateTime.GetDayOfMonth(Ticks) - 1
		If WheelContentNb(2) <> DaysPerMonth(i) Then
			UpdateDaysWheel(DaysPerMonth(i))
		End If
'		CurrentDayIndex = DateTime.GetDayOfMonth(Ticks) - 1
		ScrollPos(2) = lblHeight * (CurrentDayIndex + WheelContentNb(2))
	Case TIME_HM
		Dim Hour, Minute As Int
		If DefaulValue = "" Then
			Hour = DateTime.GetHour(DateTime.Now)
			Minute = DateTime.GetMinute(DateTime.Now)
		Else
			Dim TimeFormat As String
			TimeFormat = DateTime.TimeFormat
			DateTime.TimeFormat = "HH:mm"
			Hour = DateTime.GetHour(DateTime.TimeParse(DefaulValue))
			Minute = DateTime.GetMinute(DateTime.TimeParse(DefaulValue))
			DateTime.TimeFormat = TimeFormat
		End If
		ScrollPos(0) = lblHeight * (Hour + WheelContentNb(0))
		ScrollPos(1) = lblHeight * (Minute + WheelContentNb(1))
	Case TIME_HMS
		Dim Hour, Minute, Second As Int
		If DefaulValue = "" Then
			Hour = DateTime.GetHour(DateTime.Now)
			Minute = DateTime.GetMinute(DateTime.Now)
			Second = DateTime.GetSecond(DateTime.Now)
		Else
			Dim TimeFormat As String
			TimeFormat = DateTime.TimeFormat
			DateTime.TimeFormat = "HH:mm:ss"
			Hour = DateTime.GetHour(DateTime.TimeParse(DefaulValue))
			Minute = DateTime.GetMinute(DateTime.TimeParse(DefaulValue))
			Second = DateTime.GetSecond(DateTime.TimeParse(DefaulValue))
			DateTime.TimeFormat = TimeFormat
		End If
		ScrollPos(0) = lblHeight * (Hour + WheelContentNb(0))
		ScrollPos(1) = lblHeight * (Minute + WheelContentNb(1))
		ScrollPos(2) = lblHeight * (Second + WheelContentNb(2))
	Case DATE_TIME
		If DefaulValue = "" Then
			Ticks = DateTime.Now
		Else
			Dim DateFormat As String
			DateFormat = DateTime.DateFormat
			DateTime.DateFormat = DateTime.DateFormat & " " & "HH:mm"
			Ticks = DateTime.DateParse(DefaulValue)
			DateTime.DateFormat = DateFormat
		End If
		
		ScrollPos(0) = lblHeight * (DateTime.GetYear(Ticks) - cFirstYear + WheelContentNb(0))
		i = DateTime.GetMonth(DateTime.Now) - 1
		ScrollPos(1) = lblHeight * (DateTime.GetMonth(Ticks) - 1 + WheelContentNb(1))
		If WheelContentNb(2) <> DaysPerMonth(i) Then
			UpdateDaysWheel(DaysPerMonth(i))
		End If
		ScrollPos(2) = lblHeight * (DateTime.GetDayOfMonth(Ticks) - 1 + WheelContentNb(2))
		ScrollPos(3) = lblHeight * (DateTime.GetHour(Ticks) + WheelContentNb(3))
		ScrollPos(4) = lblHeight * (DateTime.GetMinute(Ticks) + WheelContentNb(4))
	Case CUSTOM
		If DefaulValue = "" Then
			For i = 0 To WheelNb - 1
				ScrollPos(i) = lblHeight * WheelContentNb(i)
			Next
		Else 
			Dim txt(WheelNb) As String
			If DefaulValue.Contains(SepText) = True Or WheelNb = 1 Then
				If WheelNb = 1 Then
					ScrollPos(0) = lblHeight *(WheelContent(0).IndexOf(DefaulValue) + WheelContentNb(i))
				Else
					txt = Regex.Split(SepText, DefaulValue)
					For i = 0 To WheelNb - 1
						ScrollPos(i) = lblHeight *(WheelContent(i).IndexOf(txt(i)) + WheelContentNb(i))
					Next
				End If
			Else
				ToastMessageShow("Wrong separation text !", False)
				For i = 0 To WheelNb - 1
					ScrollPos(i) = WheelContentNb(i)
				Next
			End If
		End If
	Case INTEGER, INTEGER_POS, NUMBER, NUMBER_POS
		If DefaulValue = "" Then
			For i = 0 To WheelNb - 1
				ScrollPos(i) = lblHeight * WheelContentNb(i)
			Next
		Else
			If IsNumber(DefaulValue) = False Then
				ToastMessageShow("The given value is not a number", False)
				Return
			End If
			
			Dim FirstWheel = 0 As Int
			Select WheelType
			Case INTEGER, NUMBER
				FirstWheel = 1	' adds a wheel for the + - signs
			End Select
			
			If DefaulValue.Contains("-") Then
				DefaulValue = DefaulValue.Replace("-", "")
				ScrollPos(0) = lblHeight 
			Else
				ScrollPos(0) = 0 
			End If
			
			If DefaulValue.Contains(".") Then
				Select WheelType
				Case NUMBER, NUMBER_POS
					If cIsFixedFormat = False Then
						cDigitsToTheRight = DefaulValue.Length - DefaulValue.IndexOf(".") - 1
					Else
						DefaulValue = NumberFormat2(DefaulValue, WheelNb - cDigitsToTheRight, cDigitsToTheRight, cDigitsToTheRight, False)
					End If
					DefaulValue = DefaulValue.Replace(".", "")
				Case Else
					DefaulValue = Floor(DefaulValue)
				End Select
			Else
				If cIsFixedFormat = False Then
					cDigitsToTheRight = 0
				Else
					For i = 0 To cDigitsToTheRight - 1
						DefaulValue = DefaulValue & "0"
					Next
				End If
			End If
			
			' add leading zeros
			Dim n0 = "" As String
			For i = 0 To WheelNb - DefaulValue.Length - 1
				n0 = n0 & "0"
			Next
			
			DefaulValue = n0 & DefaulValue
			
			Dim posI As Int
			Dim posT As String
			For i = FirstWheel To WheelNb - 1
				posT = DefaulValue.CharAt(i)
				posI = posT
				ScrollPos(i) = lblHeight * (posI + WheelContentNb(i))
			Next
			If WheelType = NUMBER Or WheelType = NUMBER_POS Then
				DrawDecimalPoint(cDigitsToTheRight)
			End If
		End If
	End Select

	pnlScreen.BringToFront
	pnlScreen.Visible = True
	For i = 0 To WheelNb - 1
		objWheel(i).RunMethod3("scrollTo", 0, "java.lang.int", ScrollPos(i), "java.lang.int")
		DoEvents
		objWheel(i).RunMethod3("scrollTo", 0, "java.lang.int", ScrollPos(i), "java.lang.int")
		DoEvents
	Next
End Sub

'Draws the decimal point onto the central window, used internally
Private Sub DrawDecimalPoint(DPoint As Int)
	Dim x, y As Int
	Dim r As Float
	
	r = 0.15 * pnlMiddle.Height
	y = 0.85 * pnlMiddle.Height
	setWindowColor(colWindow)
	
	cDigitsToTheRight = DPoint
	
	If cDigitsToTheRight > 0 Then
		x = pnlMiddle.Width * (1 - cDigitsToTheRight / WheelNb)
		x = (pnlMiddle.Width + lineWidth) * (1 - cDigitsToTheRight / WheelNb) - lineWidth / 2
		cvsMiddle.DrawCircle(x, y, r, Colors.Black, True, 1)
	End If
	pnlMiddle.Invalidate
End Sub

'Initialize the DATE wheels, used inernally
Private Sub InitializeDate
	Dim i,j As Int
	
	WheelNb = 3
	
	Dim WheelContent(WheelNb) As List
	Dim WheelContentNb(WheelNb) As Int
	Dim ScrollPos(WheelNb) As Int
	
	WheelContent(0).Initialize
	WheelContentNb(0) = cNbYears
	For j = 0 To WheelContinus
		For i = 0 To cNbYears - 1
			WheelContent(0).Add(cFirstYear + i)
		Next
	Next
	
	Dim DateFormat As String
	DateFormat = DateTime.DateFormat
	WheelContent(1).Initialize
	WheelContentNb(1) = 12
	For j = 0 To WheelContinus
		For i = 1 To 12
			Dim txt As String
			Dim dat As Long
			DateTime.DateFormat = "dd/MM/yyyy"
			txt = "01/" & i & "/2012"
			dat = DateTime.DateParse(txt)
			DateTime.DateFormat = "MMMM"
			txt = DateTime.DATE(dat)
			txt = txt.Replace(".", "")
			WheelContent(1).Add(txt)
		Next
	Next
	DateTime.DateFormat = DateFormat
	
	WheelContent(2).Initialize
	WheelContentNb(2) = 31
	For j = 0 To WheelContinus
		For i = 1 To 31
			WheelContent(2).Add(i)
		Next
	Next
	
	If WheelContinus = 0 Then
		For i = 0 To WheelNb - 1
			WheelContentNb(i) = 0
		Next
	End If
End Sub

'Initialize the TIME_HM wheels, used inernally
Private Sub InitializeTime_HM
	Dim i, j As Int
	
	WheelNb = 2
	
	Dim WheelContent(WheelNb) As List
	Dim WheelContentNb(WheelNb) As Int
	Dim ScrollPos(WheelNb) As Int
	
	WheelContent(0).Initialize
	WheelContentNb(0) = 24
	For j = 0 To WheelContinus
		For i = 0 To 23
			WheelContent(0).Add(i)
		Next
	Next
	
	WheelContent(1).Initialize
	WheelContentNb(1) = 60
	For j = 0 To WheelContinus
		For i = 0 To 59
			WheelContent(1).Add(NumberFormat(i, 2, 0))
		Next
	Next

	If WheelContinus = 0 Then
		For i = 0 To WheelNb - 1
			WheelContentNb(i) = 0
		Next
	End If
End Sub

'Initialize the TIME_HMS wheels, used inernally
Private Sub InitializeTime_HMS
	Dim i, j As Int
	
	WheelNb = 3
	
	Dim WheelContent(WheelNb) As List
	Dim WheelContentNb(WheelNb) As Int
	Dim ScrollPos(WheelNb) As Int
	
	WheelContent(0).Initialize
	WheelContentNb(0) = 24
	For j = 0 To WheelContinus
		For i = 0 To 23
			WheelContent(0).Add(i)
		Next
	Next
	
	WheelContent(1).Initialize
	WheelContent(2).Initialize
	WheelContentNb(1) = 60
	WheelContentNb(2) = 60
	For j = 0 To WheelContinus
		For i = 0 To 59
			WheelContent(1).Add(NumberFormat(i, 2, 0))
			WheelContent(2).Add(NumberFormat(i, 2, 0))
		Next
	Next

	If WheelContinus = 0 Then
		For i = 0 To WheelNb - 1
			WheelContentNb(i) = 0
		Next
	End If
End Sub

'Initialize the DATE_TIME wheels, used inernally
Private Sub InitializeDateTime
	Dim i, j As Int
	
	WheelNb = 5
	
	Dim WheelContent(WheelNb) As List
	Dim WheelContentNb(WheelNb) As Int
	Dim ScrollPos(WheelNb) As Int
	
	WheelContent(0).Initialize
	WheelContentNb(0) = cNbYears
	For j = 0 To WheelContinus
		For i = 0 To cNbYears - 1
			WheelContent(0).Add(cFirstYear + i)
		Next
	Next
	
	Dim DateFormat As String
	DateFormat = DateTime.DateFormat
	WheelContent(1).Initialize
	WheelContentNb(1) = 12
	For j = 0 To WheelContinus
		For i = 1 To 12
			Dim txt As String
			Dim dat As Long
			DateTime.DateFormat = "dd/MM/yyyy"
			txt = "01/" & i & "/2012"
			dat = DateTime.DateParse(txt)
			DateTime.DateFormat = "MMMM"
			txt = DateTime.DATE(dat)
			txt = txt.Replace(".", "")
			WheelContent(1).Add(txt)
		Next
	Next
	DateTime.DateFormat = DateFormat
	
	WheelContent(2).Initialize
	WheelContentNb(2) = 31
	For j = 0 To WheelContinus
		For i = 1 To 31
			WheelContent(2).Add(i)
		Next
	Next
	
	WheelContent(3).Initialize
	WheelContentNb(3) = 24
	For j = 0 To WheelContinus
		For i = 0 To 23
			WheelContent(3).Add(i)
		Next
	Next
	
	WheelContent(4).Initialize
	WheelContentNb(4) = 60
	For j = 0 To WheelContinus
		For i = 0 To 59
			WheelContent(4).Add(i)
		Next
	Next

	If WheelContinus = 0 Then
		For i = 0 To WheelNb - 1
			WheelContentNb(i) = 0
		Next
	End If
End Sub

'Initialize the Custom wheels, used inernally
Private Sub InitializeCustom(lst() As List)
	Dim i, j, k As Int
	Dim WheelContent(WheelNb) As List
	Dim WheelContentNb(WheelNb) As Int
	Dim ScrollPos(WheelNb) As Int
	
	
	For k = 0 To WheelNb - 1
		WheelContent(k).Initialize
		WheelContentNb(k) = lst(k).Size
		For j = 0 To WheelContinus
			For i = 0 To lst(k).Size - 1
				WheelContent(k).Add(lst(k).get(i))
			Next
		Next
	Next

	If WheelContinus = 0 Then
		For i = 0 To WheelNb - 1
			WheelContentNb(i) = 0
		Next
	End If
End Sub

'Initialize the Number wheels, used inernally
Private Sub InitializeNumbers
	Dim i, j, k As Int
	Dim WheelContent(WheelNb) As List
	Dim WheelContentNb(WheelNb) As Int
	Dim ScrollPos(WheelNb) As Int
	
	Dim FirstWheel = 0 As Int
	If WheelType = INTEGER Or WheelType = NUMBER Then
		WheelContent(0).Initialize
		WheelContentNb(0) = 0
		WheelContent(0).Add("+")
		WheelContent(0).Add("-")
		FirstWheel = 1
	End If
	For k = FirstWheel To WheelNb - 1
		WheelContent(k).Initialize
		WheelContentNb(k) = 10
		For j = 0 To WheelContinus
			For i = 0 To 9
				Dim s As String = i
				WheelContent(k).Add(s)
			Next
		Next
	Next

	If WheelContinus = 0 Then
		For i = 0 To WheelNb - 1
			WheelContentNb(i) = 0
		Next
	End If
End Sub

'Sets the number of years to display
'valid only for Date and DateTime wheels
'returns -1 for none date wheels
'default value 31
Public Sub setNumberOfYears(NumberOfYears As Int)
	Select WheelType 
	Case 0, 3
		cNbYears = NumberOfYears
		UpdateWheel(0)
	End Select
End Sub

Public Sub getNumberOfYears As Int
	Select WheelType 
	Case 0, 3
		Return cNbYears
	Case Else
		Return -1
	End Select
End Sub

'Sets the number of years to display
'valid only for Date and DateTime wheels
'returns -1 for none date wheels
'default value = 2000
Public Sub setFirstYear(FirstYear As Int)
	Select WheelType 
	Case 0, 3
		cFirstYear = FirstYear
		UpdateWheel(0)
	End Select
End Sub

Public Sub getFirstYear As Int
	Select WheelType 
	Case 0, 3
		Return cFirstYear
	Case Else
		Return -1
	End Select
End Sub

'Sets or gets the background color equivalent to the line color
Public Sub setBackgroundColor(col As Int)
	colBackGround = col
	pnlBackGround.Color = colBackGround
End Sub

Public Sub getBackgroundColor As Int
	Return colBackGround
End Sub

'Sets or gets the shadow color, default color = black
Public Sub setShadowColor(col As Int)
	colShadow = col
	Dim gdw As GradientDrawable
	Dim cols(2) As Int
	cols(0) = colShadow
	cols(1) = Colors.Transparent
	gdw.Initialize("TOP_BOTTOM", cols)
	gdw.CornerRadius = 0
	pnlTop.Background = gdw

	Dim gdw As GradientDrawable
	gdw.Initialize("BOTTOM_TOP", cols)
	gdw.CornerRadius = 0
	pnlBottom.Background = gdw
End Sub

Public Sub getShadowColor As Int
	Return colShadow
End Sub

'Sets or gets the central window color.
'If the alpha part is greater than 128 the program limits it to 128
Public Sub setWindowColor(col As Int)
	Dim argb() As Int
	argb = GetARGB(col)
	If argb(0) > 128 Then
		argb(0) = 128
		colWindow = Colors.argb(argb(0), argb(1), argb(2), argb(3))
	Else
		colWindow = col
	End If
	cvsMiddle.DrawRect(rectMiddle, Colors.Transparent, True, 1)
	cvsMiddle.DrawRect(rectMiddle, colWindow, True, 1)
End Sub

Public Sub getWindowColor As Int
	Return colWindow
End Sub

'Sets or gets the central window frame line color
Public Sub setWindowLineColor(col As Int)
	colWindowLine = col
	cvsTop.Initialize(pnlTop)
	cvsTop.DrawLine(lineWidth, pnlTop.Height - lineWidth / 2, TotalColWidths(WheelNb) - lineWidth, pnlTop.Height - lineWidth / 2, colWindowLine, lineWidth)

	cvsBottom.Initialize(pnlBottom)
	cvsBottom.DrawLine(lineWidth, lineWidth / 2, TotalColWidths(WheelNb) - lineWidth, lineWidth / 2, colWindowLine, lineWidth)
End Sub

Public Sub getWindowLineColor As Int
	Return colWindowLine
End Sub

'Sets or gets the Tag property
Public Sub getTag As Object
	Return pnlScreen.Tag
End Sub

Public Sub setTag(Tag As Object)
	pnlScreen.Tag = Tag
End Sub

'Sets a fixed format
'DigitsToTheRight = number of fractions, trailing zeros are added if necessary
'IsFixedFormat if False removes the FixedFormat mode
'LeadingZeros = True leading zeros are added if necessary
Public Sub SetFixedFormat(DigitsToTheRight As Int, IsFixedFormat As Boolean, LeadingZeros As Boolean)
	cDigitsToTheRight = DigitsToTheRight
	cIsFixedFormat = IsFixedFormat
	cLeadingZeros = LeadingZeros
End Sub

Private Sub scv_Touch(ViewTag As Object, Action As Int, X As Float, Y As Float, MotionEvent As Object) As Boolean
	Dim dt As Long
	Dim tt As Int
	
	Select Action
	Case 0	' ACTION_DOWN
		t1 = DateTime.Now
		x0 = X
		y0 = Y
		y1 = Y
		If SubExists(Callback, EventName & "_StartScroll") = True Then
			CallSub(Callback, EventName & "_StartScroll")
		End If
	Case 1	' ACTION_UP
		Dim Index As Int
		Dim sv As ScrollView
		sv = Sender
		Index = sv.Tag
		tt = Max(10, -Logarithm(1 / speed, cE) * 110)
		TimerWheel(Index).Interval = tt * 1.5
		TimerWheel(Index).Enabled = True
		If (WheelType = NUMBER Or WheelType = NUMBER_POS) And cIsFixedFormat = False And ViewTag <> 0 And Abs(X - x0) < 10dip And Abs(Y - y0) < 10dip Then
			Dim i As Int
			i = WheelNb - ViewTag
			If X > scvWheel(0).Width / 2 Then
				i = i - 1
			End If
			DrawDecimalPoint(i)
		End If
	Case 2	' ACTION_MOVE
		dt = (DateTime.Now - t1)
		speed = Abs((Y - y1) / dt * 250)
		y1 = Y
		t1 = DateTime.Now
	End Select
	
	Return False
End Sub

Private Sub ScrollFinish(S As ScrollView, Pos As Int)
	Dim i, IndexMonth, Year, Days, PosNew As Int

	i = S.Tag

	If Pos < WheelContentNb(i) * lblHeight Then
		PosNew = Pos + WheelContentNb(i) * lblHeight
	Else If Pos > 2 * WheelContentNb(i) * lblHeight Then
		PosNew = Pos - WheelContentNb(i) * lblHeight
	Else
		PosNew = Pos
	End If
	If PosNew <> Pos Then
		objWheel(i).RunMethod2("setSmoothScrollingEnabled", False, "java.lang.boolean")
		DoEvents
		DoEvents
		objWheel(i).RunMethod3("scrollTo", 0, "java.lang.int", PosNew, "java.lang.int")
		DoEvents
		DoEvents
		objWheel(i).RunMethod3("scrollTo", 0, "java.lang.int", PosNew, "java.lang.int")
		DoEvents
		DoEvents
		objWheel(i).RunMethod2("setSmoothScrollingEnabled", True, "java.lang.boolean")
		DoEvents
	End If
	
	PosNew = Floor(PosNew/lblHeight + .5)
	PosNew = PosNew * lblHeight
	objWheel(i).RunMethod3("smoothScrollTo", 0, "java.lang.int", PosNew, "java.lang.int")
	DoEvents

	If (WheelType = DATE Or WheelType = DATE_TIME) And (S = scvWheel(0) Or S = scvWheel(1)) Then
		Year = Floor(scvWheel(0).ScrollPosition / lblHeight + 0.5) - WheelContentNb(0) + cFirstYear
		IndexMonth = Floor(scvWheel(1).ScrollPosition / lblHeight + 0.5) - WheelContentNb(1)
		
		IndexMonth = Max(0, IndexMonth)
		IndexMonth = Min(11, IndexMonth)
		Days = DaysPerMonth(IndexMonth)

		If IndexMonth = 1 And (Year Mod 4 = 0) And Not(Year Mod 100 = 0) Then
			Days = 29
		End If
		
		If WheelContentNb(2) <> Days Then
			UpdateDaysWheel(Days)
		End If
	Else If (WheelType = DATE Or WheelType = DATE_TIME) And S = scvWheel(2) Then
'		CurrentDayIndex = Floor(scvWheel(1).ScrollPosition / lblHeight + 0.5) - WheelContentNb(1)
		CurrentDayIndex = Floor(scvWheel(2).ScrollPosition / lblHeight + 0.5) - WheelContentNb(2)
	End If
	
	If SubExists(Callback, EventName & "_EndScroll") = True Then
		CallSub(Callback, EventName & "_EndScroll")
	End If
End Sub

Private Sub UpdateDaysWheel(NewNbDays As Int)
	Dim i, j As Int
	
	WheelContentNb(2) = NewNbDays
	WheelContent(2).Clear
	For j = 0 To WheelContinus
		For i = 1 To NewNbDays
			WheelContent(2).Add(i)
		Next
	Next
			
	scvWheel(2).Panel.RemoveAllViews
	For j = 0 To WheelContent(2).Size + ItemNb
		Dim lbl As Label
		lbl.Initialize("")
		scvWheel(2).Panel.AddView(lbl, 0, j * lblHeight, ColWidths(2), lblHeight)
		lbl.Gravity = Gravity.CENTER_HORIZONTAL + Gravity.CENTER_VERTICAL
		lbl.Color = Colors.White
		lbl.TextColor = Colors.Black
		lbl.TextSize = FontSize
		If j >= ItemNb_2 And j <= WheelContent(2).Size + ItemNb_2 - 1 Then
			lbl.Text = WheelContent(2).get(j - ItemNb_2)
		Else
			lbl.Text = ""
		End If
	Next
	
	scvWheel(2).Panel.Height = (WheelContent(2).Size + ItemNb - 1)* lblHeight
	ScrollPos(2) = lblHeight * (CurrentDayIndex + WheelContentNb(2))
	objWheel(2).RunMethod3("scrollTo", 0, "java.lang.int", ScrollPos(2), "java.lang.int")
	DoEvents
End Sub

Private Sub TimerWheel_Tick
	Dim tw As Timer
	Dim i As Int
	
	tw = Sender
	
	For i = 0 To TimerWheel.Length - 1
		If tw = TimerWheel(i) Then
			TimerWheel(i).Enabled = False
			Exit
		End If
	Next
	ScrollFinish(scvWheel(i), scvWheel(i).ScrollPosition)
End Sub

'Get the color components, returns an array with the four component values
Private Sub GetARGB(Color As Int) As Int()
	Dim cols(4) As Int
	cols(0) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff000000), 24)
	cols(1) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)
	cols(2) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)
	cols(3) = Bit.And(Color, 0xff)
	Return cols
End Sub

'Get the result of the selection as a string
'For DATE, TIME_HM, TIME_HMS and DATE_TIME
'Returns a String with the defined DateFormat and TimeFormat
Public Sub getSelection As String
	Dim i, j As Int
	Dim Sel(WheelNb) As String
	Dim Selection As String
	
	Selection = ""
	For i = 0 To WheelNb - 1
		Dim lbl As Label
		j = Floor(scvWheel(i).ScrollPosition / lblHeight + 0.5) + ItemNb_2
		lbl = scvWheel(i).Panel.GetView(j)
		Sel(i) = lbl.Text
	Next 

	Select WheelType
	Case DATE
		Selection = Sel(0) & " " & Sel(1) & " " & Sel(2)
		Selection = GetDate(Selection)
	Case TIME_HM
		Selection = Sel(0) & ":" & Sel(1)
		Selection = GetTimeHM(Selection)
	Case TIME_HMS
		Selection = Sel(0) & ":" & Sel(1) & ":" & Sel(2)
		Selection = GetTimeHMS(Selection)
	Case DATE_TIME
		Selection = GetDate(Sel(0) & " " & Sel(1) & " " & Sel(2)) & " / " & GetTimeHM(Sel(3) & ":" & Sel(4))
	Case CUSTOM
		Dim i As Int
		Selection = Sel(0)
		If WheelNb > 1 Then
			For i = 1 To WheelNb -1
				Selection = Selection & SepText & Sel(i)
			Next
		End If
	Case INTEGER, INTEGER_POS, NUMBER, NUMBER_POS
		Dim i As Int
		Selection = Sel(0)
		If WheelNb > 1 Then
			For i = 1 To WheelNb - 1
				Selection = Selection & Sel(i)
			Next
		End If
		Select WheelType
		Case NUMBER, NUMBER_POS
			Selection = Selection / Power(10, cDigitsToTheRight)
			If cIsFixedFormat = True Then
				If cLeadingZeros = True Then
					Selection = NumberFormat2(Selection, WheelNb - cDigitsToTheRight, cDigitsToTheRight, cDigitsToTheRight, False)
				Else
					Selection = NumberFormat2(Selection, 1, cDigitsToTheRight, cDigitsToTheRight, False)
				End If
			End If
		End Select
	End Select

	Return Selection
End Sub

'Get the result of the selection as a string array
'The componants of the array are the selections of each wheel
'This is not really useful with the INTEGER, INTEGER_POS, NUMBER and NUMBER_POS modes
Public Sub getSelection2 As String()
	Dim i, j As Int
	Dim Sel(WheelNb) As String
	
	For i = 0 To WheelNb - 1
		Dim lbl As Label
		j = Floor(scvWheel(i).ScrollPosition / lblHeight + 0.5) + ItemNb_2
		lbl = scvWheel(i).Panel.GetView(j)
		Sel(i) = lbl.Text
	Next 

	Return Sel
End Sub

'Set the separation text for custom wheels
'Default is a blanc character " "
Public Sub setSeparationText(txt As String)
	SepText = txt
End Sub

'Get the separation text for custom wheels
Public Sub getSeparationText As String
	Return SepText
End Sub

'Sets the vertical scrollbar
'or gets if the vertical scrollbar is enabled
Public Sub setVerticalScrollBar(VScrollBar As Boolean)
	If cVerticalScrollBar <> VScrollBar Then
		cVerticalScrollBar = VScrollBar
		Dim objWheel(WheelNb) As Reflector
		Dim i As Int
		For i = 0 To WheelNb - 1
			objWheel(i).Target = scvWheel(i)
			objWheel(i).RunMethod2("setVerticalScrollBarEnabled", cVerticalScrollBar, "java.lang.boolean")
		Next
	End If
End Sub

Public Sub getVerticalScrollBar As Boolean
	Return cVerticalScrollBar
End Sub

'Change the Date from the internal format to the default format
Private Sub GetDate(Date1 As String) As String
	Dim DateFormat, Date2 As String
	Dim DateTicks As Long
	
	DateFormat = DateTime.DateFormat
	DateTime.DateFormat = "yyyy MMMM dd"
	
	DateTicks = DateTime.DateParse(Date1)
	DateTime.DateFormat = DateFormat
	Date2 = DateTime.DATE(DateTicks)
	Return Date2
End Sub

'Change the Time HH:mm from the internal format to the default format
Private Sub GetTimeHM(Time1 As String) As String
	Dim TimeFormat, Time2 As String
	Dim TimeTicks As Long
	
	TimeFormat = DateTime.TimeFormat
	DateTime.TimeFormat = "HH:mm"
	
	TimeTicks = DateTime.TimeParse(Time1)
	DateTime.TimeFormat = TimeFormat
	Time2 = DateTime.TIME(TimeTicks)
	Return Time2
End Sub

'Change the Time HH:mm:ss from the internal format to the default format
Private Sub GetTimeHMS(Time1 As String) As String
	Dim TimeFormat, Time2 As String
	Dim TimeTicks As Long
	
	TimeFormat = DateTime.TimeFormat
	DateTime.TimeFormat = "HH:mm:ss"
	
	TimeTicks = DateTime.TimeParse(Time1)
	DateTime.TimeFormat = TimeFormat
	Time2 = DateTime.TIME(TimeTicks)
	Return Time2
End Sub

Private Sub btnCancel_Click
	If EventEnabled = True Then
		If SubExists(Callback, EventName & "_Closed") = True Then
			CallSub3(Callback, EventName & "_Closed", True, getSelection)
		End If
	End If
	pnlScreen.Visible = False
End Sub

Private Sub btnOK_Click
	If EventEnabled = True Then
		If SubExists(Callback, EventName & "_Closed") = True Then
			CallSub3(Callback, EventName & "_Closed", False, getSelection)
		End If
	Else
		If CallbackView <> "" Then
			Dim lbl As Label
			lbl = CallbackView
			lbl.Text = getSelection
		End If
	End If
	pnlScreen.Visible = False
End Sub

Private Sub pnlScreen_Click
	' empty to consume the events
End Sub

Private Sub pnlMain_Click
	' empty to consume the events
End Sub

Private Sub UpdateWheel(Index As Int)
	Dim i, j As Int
	
	WheelContent(Index).Clear
	WheelContentNb(Index) = cNbYears
	For j = 0 To WheelContinus
		For i = 0 To cNbYears - 1
			WheelContent(Index).Add(cFirstYear + i)
		Next
	Next

	scvWheel(0).Panel.RemoveAllViews
	For j = 0 To WheelContent(Index).Size + ItemNb
		Dim lbl As Label
		lbl.Initialize("")
		scvWheel(Index).Panel.AddView(lbl, 0, j * lblHeight, ColWidths(Index), lblHeight)
		lbl.Gravity = Gravity.CENTER_HORIZONTAL + Gravity.CENTER_VERTICAL
		lbl.Color = Colors.Transparent
		lbl.TextColor = Colors.Black
		lbl.TextSize = FontSize
		If j >= ItemNb_2 AND j <= WheelContent(Index).Size + ItemNb_2 - 1 Then
			lbl.Text = WheelContent(Index).get(j - ItemNb_2)
		Else
			lbl.Text = ""
		End If
	Next
	scvWheel(0).Panel.Height = (WheelContent(0).Size + ItemNb - 1)* lblHeight
End Sub
