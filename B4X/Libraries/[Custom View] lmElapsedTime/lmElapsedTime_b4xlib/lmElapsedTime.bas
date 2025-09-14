B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.13
@EndOfDesignText@
#Event: ElapsedTimeChanged(ElapsedTime As Long)
#Event: StateChanged(Paused As Boolean, ElapsedTime As Long)
#Event: Click(ElapsedTime As Long)

#Region DESIGNER PROPERTIES 
#DesignerProperty: Key: BGColor, DisplayName: Background color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: You can use the built-in color picker to find the color values.
#DesignerProperty: Key: BorderColor, DisplayName: Border color, FieldType: Color, DefaultValue: 0xFF0000FF, Description: You can use the built-in color picker to find the color values.
#DesignerProperty: Key: BorderWidth, DisplayName: Border width, FieldType: Int, DefaultValue: 1
#DesignerProperty: Key: CornerRadius, DisplayName: Corner radius, FieldType: Int, DefaultValue: 10
#DesignerProperty: Key: FontSize, DisplayName: Font Size, FieldType: Float, DefaultValue: 18
#DesignerProperty: Key: ShowMilliseconds, DisplayName: Show Milliseconds, FieldType: Boolean, DefaultValue: False
#DesignerProperty: Key: ShowHours, DisplayName: Show hours, FieldType: Boolean, DefaultValue: False
#DesignerProperty: Key: ActOnClick, DisplayName: Activate on click, FieldType: Boolean, DefaultValue: False, Description: Whether if start/pause counter on click/tap.
#End Region

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView
	Private xui As XUI

	' Variables for properties.
	Private mBGColor As Int
	Private mBorderColor As Int
	Private mBorderWidth As Int
	Private mCornerRadius As Int
	Private mTextColor As Int
	Private mFontSize As Float
	Private mShowMilliseconds As Boolean
	Private mShowHours As Boolean
	
	Private mLabelFont As B4XFont
    
	Private mLabels As List
	' Label for each digit.
	Private lblHourTens, lblHourUnits As Label
	Private lblColon1 As Label
	Private lblMinTens, lblMinUnits As Label
	Private lblColon2 As Label
	Private lblSecTens, lblSecUnits As Label
	Private lblColon3 As Label
	Private lblMilliHundreds As Label
	Private lblMilliTens As Label
	Private lblMilliUnits As Label
	
	Private pnlForClick As B4XView

	Private mInitialTime As Long    ' Start time in milliseconds.
	Private mRunning As Boolean     ' Flag To indicate whether the counter Is running.
	Private mPaused As Boolean
	Private mPausedElapsed As Long
	Private TotalTime As Long		' This hold the long of the eventual different start time
	
	Private mActivateOnClick As Boolean
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

Public Sub DesignerCreateView (Base As Object, lbl As Label, Props As Map)
	mBase = Base
	
	mBGColor =xui.PaintOrColorToColor(Props.Get("BGColor"))
	mBorderColor =xui.PaintOrColorToColor(Props.Get("BorderColor"))
	mBorderWidth = Props.Get("BorderWidth")
	mCornerRadius = Props.Get("CornerRadius")
	mFontSize = Props.Get("FontSize")
	mLabelFont = xui.CreateFontAwesome(mFontSize)
	mTextColor = xui.PaintOrColorToColor(lbl.TextColor)

	mShowMilliseconds = Props.Get("ShowMilliseconds")
	mShowHours = Props.Get("ShowHours")
	
	mActivateOnClick = Props.Get("ActOnClick")

	mBase.SetColorAndBorder(mBGColor, mBorderWidth, mBorderColor, mCornerRadius)
	
	mLabels.Initialize
	CreateLayout
End Sub

#Region PROPERTIES 

Public Sub setShowHours(Show As Boolean)
	mShowHours = Show
	CreateLayout
End Sub
Public Sub getShowHours As Boolean
	Return mShowHours
End Sub

Public Sub setShowMS(Show As Boolean)
	mShowMilliseconds = Show
	CreateLayout
End Sub
Public Sub getShowMS As Boolean
	Return mShowMilliseconds
End Sub

Public Sub setLabelFont(xFont As B4XFont)
	mLabelFont = xFont
	CreateLayout
End Sub
Public Sub getLabelFont As B4XFont
	Return mLabelFont
End Sub

Public Sub getPaused As Boolean
	Return mPaused
End Sub

Public Sub setActOnClick(Activate As Boolean)
	mActivateOnClick = Activate
End Sub
Public Sub getActOnClick As Boolean
	Return mActivateOnClick
End Sub

' Returns the elapsed time in milliseconds.
Public Sub getElapsedTime As Long
	Return DateTime.Now - mInitialTime
End Sub

' Returns the elapsed time as a formatted string.
Public Sub getElapsedTimeString As String
	Dim elapsedMillis As Long = DateTime.Now - mInitialTime
	Return FormatElapsedTime(elapsedMillis)
End Sub

'Sets the initial counter. The time format must be: "HH:mm:ss".
Public Sub setCounterByString(InitialCounter As String)
	Dim parts() As String
	parts = Regex.Split(":", InitialCounter)
	Dim ms As Int = 1000
	For x = 2 To 0 Step -1
		TotalTime = TotalTime + (parts(x) * ms)
		ms = ms * 60
	Next
	UpdateLabels(TotalTime)
End Sub

'Sets the initial counter.
Public Sub setCounterByLong(InitialCounter As Long)
	TotalTime = InitialCounter
	UpdateLabels(InitialCounter)
End Sub

#End Region

#Region PUBLIC METHODS 

' Starts the counter.
Public Sub StartCounter
	mInitialTime = DateTime.Now
	mRunning = True
	UpdateTimer
End Sub

' Stops the counter.
Public Sub StopCounter
	mRunning = False
End Sub

' Pauses the counter.
Public Sub PauseCounter
	If mRunning = False Or mPaused Then Return ' If already stopped or paused, exit.
	' Saves the time already spent.
	mPausedElapsed = DateTime.Now - mInitialTime
	mPaused = True
	mRunning = False ' Stops the timer.
End Sub

' Resumes the counter after a pause.
Public Sub ResumeCounter
	If mPaused = False Then Return ' If it's not on pause, it exits.
	' Update the startTime so that the elapsed time continues from where it was paused.
	mInitialTime = DateTime.Now - mPausedElapsed
	mPaused = False
	mRunning = True
	UpdateTimer ' Resumes display refresh.
End Sub

'Starts the counter from the InitialCounter passed. The time format must be: "HH:mm:ss".
Public Sub StartCounterFromString(InitialCounter As String)
	setCounterByString(InitialCounter)
	StartCounter
End Sub

'Starts the counter from the InitialCounter passed.
Public Sub StartCounterFromLong(InitialCounter As Long)
	setCounterByLong(InitialCounter)
	StartCounter
End Sub

#End Region

#Region PRIVATE METHODS 

Private Sub CreateLayout
	' Creates labels for the numbers
	If mShowHours Then
		lblHourTens.Initialize("")
		lblHourUnits.Initialize("")
		lblColon1.Initialize("")
		lblColon1.Text = ":"
	End If
	lblMinTens.Initialize("")
	lblMinUnits.Initialize("")
	lblColon2.Initialize("")
	lblColon2.Text = ":"
	lblSecTens.Initialize("")
	lblSecUnits.Initialize("")
	If mShowMilliseconds Then
		lblColon3.Initialize("")
		lblColon3.Text = ":"
		lblMilliHundreds.Initialize("")
		lblMilliTens.Initialize("")
		lblMilliUnits.Initialize("")
	End If
    
	' Creates a list to easily manage the labels.
	mLabels.Clear
	If mShowHours Then
		mLabels.Add(lblHourTens)
		mLabels.Add(lblHourUnits)
		mLabels.Add(lblColon1)
	End If
	mLabels.Add(lblMinTens)
	mLabels.Add(lblMinUnits)
	mLabels.Add(lblColon2)
	mLabels.Add(lblSecTens)
	mLabels.Add(lblSecUnits)
	If mShowMilliseconds Then
		mLabels.Add(lblColon3)
		mLabels.Add(lblMilliHundreds)
		mLabels.Add(lblMilliTens)
		mLabels.Add(lblMilliUnits)
	End If

	mBase.RemoveAllViews
	For Each lblItem As B4XView In mLabels
		lblItem.SetTextAlignment("CENTER", "CENTER")
		lblItem.TextColor = mTextColor
		lblItem.Font = mLabelFont
		mBase.AddView(lblItem, 0, 0, 20dip, mBase.Height)
	Next

	' Arranges the labels horizontally.
	Dim totalElements As Int = mLabels.Size
	Dim labelWidth As Int = mBase.Width / (totalElements + 1)
	Dim LRPadding As Int
	LRPadding = labelWidth / 2

	For i = 0 To totalElements - 1
		mLabels.Get(i).As(B4XView).SetLayoutAnimated(0, LRPadding + i * labelWidth, 0, labelWidth, mBase.Height)
	Next
	
	If Not(pnlForClick.IsInitialized) Then
		pnlForClick = xui.CreatePanel("pnlClick")
		mBase.AddView(pnlForClick, 0, 0, mBase.Width, mBase.Height)
		pnlForClick.Color = xui.Color_Transparent
	End If

	UpdateLabels(0)
End Sub

' Updates the labels of the individual digits.
Private Sub UpdateLabels(elapsedMillis As Long)
	Dim timeStr As String = FormatElapsedTime(elapsedMillis)
	If mShowHours Then
		If mShowMilliseconds = False Then
			lblHourTens.Text = timeStr.SubString2(0, 1)
			lblHourUnits.Text = timeStr.SubString2(1, 2)
			lblColon1.Text = ":"
			lblMinTens.Text = timeStr.SubString2(3, 4)
			lblMinUnits.Text = timeStr.SubString2(4, 5)
			lblColon2.Text = ":"
			lblSecTens.Text = timeStr.SubString2(6, 7)
			lblSecUnits.Text = timeStr.SubString2(7, 8)
		Else
			lblHourTens.Text = timeStr.SubString2(0, 1)
			lblHourUnits.Text = timeStr.SubString2(1, 2)
			lblColon1.Text = ":"
			lblMinTens.Text = timeStr.SubString2(3, 4)
			lblMinUnits.Text = timeStr.SubString2(4, 5)
			lblColon2.Text = ":"
			lblSecTens.Text = timeStr.SubString2(6, 7)
			lblSecUnits.Text = timeStr.SubString2(7, 8)
			lblColon3.Text = ":"
			lblMilliHundreds.Text = timeStr.SubString2(9, 10)
			lblMilliTens.Text = timeStr.SubString2(10, 11)
			lblMilliUnits.Text = timeStr.SubString2(11, 12)
		End If
	Else
		If mShowMilliseconds = False Then
			lblMinTens.Text = timeStr.SubString2(0, 1)
			lblMinUnits.Text = timeStr.SubString2(1, 2)
			lblColon2.Text = ":"
			lblSecTens.Text = timeStr.SubString2(3, 4)
			lblSecUnits.Text = timeStr.SubString2(4, 5)
		Else
			lblMinTens.Text = timeStr.SubString2(0, 1)
			lblMinUnits.Text = timeStr.SubString2(1, 2)
			lblColon2.Text = ":"
			lblSecTens.Text = timeStr.SubString2(3, 4)
			lblSecUnits.Text = timeStr.SubString2(4, 5)
			lblColon3.Text = ":"
			lblMilliHundreds.Text = timeStr.SubString2(6, 7)
			lblMilliTens.Text = timeStr.SubString2(7, 8)
			lblMilliUnits.Text = timeStr.SubString2(8, 9)
		End If
	End If
	
	RaiseEventIfSubExists("ElapsedTimeChanged", Array(elapsedMillis))
End Sub

Private Sub UpdateTimer
	If mRunning = False Then Return
	Dim elapsedMillis As Long = TotalTime + DateTime.Now - mInitialTime
	If mShowMilliseconds = False Then
		Dim elapsedSeconds As Long = elapsedMillis / 1000
		If elapsedSeconds >= (24 * 3600 - 1) Then
			elapsedSeconds = 24 * 3600 - 1
			UpdateLabels(elapsedSeconds * 1000)
			StopCounter
			Return
		End If
	Else
		If elapsedMillis >= (24 * 3600 * 1000 - 1) Then
			elapsedMillis = 24 * 3600 * 1000 - 1
			UpdateLabels(elapsedMillis)
			StopCounter
			Return
		End If
	End If
	UpdateLabels(elapsedMillis)
	CallSubDelayed(Me, "UpdateTimer")
End Sub

' Formats the elapsed time.
Private Sub FormatElapsedTime(elapsedMillis As Long) As String
	Dim hours As Int
	Dim minutes As Int
	Dim seconds As Int
	Dim ms As Int
	
	Dim strElapsedTime As String
	Dim strHours As String
	
	If mShowMilliseconds = False Then
		Dim elapsedSeconds As Long = elapsedMillis / 1000
		If elapsedSeconds >= (24 * 3600 - 1) Then elapsedSeconds = 24 * 3600 - 1
		hours = elapsedSeconds / 3600
		minutes = (elapsedSeconds Mod 3600) / 60
		seconds = elapsedSeconds Mod 60
		If mShowHours Then
			strHours = NumberFormat(hours, 2, 0) & ":"
		End If
		strElapsedTime = strHours & NumberFormat(minutes, 2, 0) & ":" & NumberFormat(seconds, 2, 0)
	Else
		If elapsedMillis >= (24 * 3600 * 1000 - 1) Then elapsedMillis = 24 * 3600 * 1000 - 1
		hours = elapsedMillis / 3600000
		Dim rem As Long = elapsedMillis Mod 3600000
		minutes = rem / 60000
		rem = rem Mod 60000
		seconds = rem / 1000
		ms = rem Mod 1000
		If mShowHours Then
			strHours = NumberFormat(hours, 2, 0) & ":"
		End If
		strElapsedTime = strHours & NumberFormat(minutes, 2, 0) & ":" & NumberFormat(seconds, 2, 0) & ":" & Right("000" & ms, 3)
	End If
	
	Return strElapsedTime
End Sub

Private Sub Right(Value As Int, Length As Int) As String
	Dim strValue As String = Value
	Dim ZeroesToAdd As Int
	ZeroesToAdd = Length - strValue.Length
	If ZeroesToAdd > 0 Then
		Dim Zeroes As String
		For i = 1 To ZeroesToAdd
			Zeroes = Zeroes & "0"
		Next
		strValue = Zeroes & strValue
	End If
	Return strValue
End Sub

Private Sub RaiseEventIfSubExists(EventName As String, params As List)
	Dim FullSubName As String
	FullSubName = mEventName & "_" & EventName
	If xui.SubExists(mCallBack, FullSubName, params.Size) Then
		Select params.Size
			Case 0
				CallSub(mCallBack, FullSubName)
			Case 1
				CallSub2(mCallBack, FullSubName, params.Get(0))
			Case 2
				CallSub3(mCallBack, FullSubName, params.Get(0), params.Get(1))
		End Select
	End If
End Sub

#End Region

#Region VIEW'S EVENTS 

#IF B4J
Private Sub pnlClick_MouseClicked (EventData As MouseEvent)
	If EventData.SecondaryButtonDown Or EventData.SecondaryButtonPressed Then
		Return
	End If
#ELSE
Private Sub pnlClick_Click
#End If
	If mActivateOnClick Then
		If mRunning Then
			PauseCounter
		Else
			If mPaused Then
				ResumeCounter
			Else
				StartCounter
			End If
		End If
		RaiseEventIfSubExists("StateChanged", Array(mPaused, getElapsedTime))
	End If

	RaiseEventIfSubExists("Click", Array(getElapsedTime))
End Sub

#End Region