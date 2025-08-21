B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=6.5
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	
#End Region

#Extends: de.amberhome.wearwrapper.WatchFaceService

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Private AnalogWFManager As WFManager
End Sub

Sub Service_Create
	
	' Initialize the WatchFace Manager object.
	'
	' We want smooth seconds here so we update 10 times a second.
	AnalogWFManager.Initialize("WF", 50)

	' Make sure the B4A DateTime object gets time change events
	DateTime.ListenToExternalTimeChanges
End Sub

Sub Service_Start (StartingIntent As Intent)

End Sub

Sub Service_Destroy

End Sub

#Region WatchFace Events
' This sub is called once the Engine is created and the Manager is initialized.
'
' To optimize speed and battery you should initialize Drawing objects (ABPaint) here.
' Be aware that at this time the width and height of the WatchFace is not knwon. (Engine.Width and Engine.Height are not set)
'
' You can store the ABPaint objects int the Tag property of the Engine. Using process_global variables for them should work, too
' but is not recommended.
Sub WF_Created (Engine As WFEngine)
	LogColor("WF_Created", Colors.Blue)
	
	Dim TagObject As Map
	
	TagObject.Initialize

	' Set the initial style of the watchface here. Setting the properties will not change the WatchFace immediately. You have
	' to call SetWatchFaceStyle to change the properties.
	Engine.ShowSystemUiTime = False
	Engine.AcceptsTapEvents = True
	Engine.StatusBarGravity = Gravity.TOP + Gravity.CENTER_HORIZONTAL
	Engine.ViewProtectionMode = Engine.PROTECT_STATUS_BAR
	Engine.AmbientPeekMode = Engine.AMBIENT_PEEK_MODE_VISIBLE
	Engine.CardPeekMode = Engine.PEEK_MODE_SHORT
	Engine.SetWatchFaceStyle

	'Create Paint Objects
	Dim HourPaint, MinutePaint, SecondPaint, TicksPaint As ABPaint

	'The ticks
	TicksPaint.Initialize
	TicksPaint.SetStrokeWidth(3.0f)
	TicksPaint.SetAntiAlias(True)
	TicksPaint.SetColor(Colors.LightGray)
	TicksPaint.SetStrokeCap(TicksPaint.Cap_BUTT)
	TicksPaint.SetStyle(TicksPaint.Style_STROKE)

	TagObject.Put("TicksPaint", TicksPaint)

	'The hour handle	
	HourPaint.Initialize
	HourPaint.SetARGB(255, 200, 200, 200)
	HourPaint.SetStrokeWidth(5.0f)
	HourPaint.SetAntiAlias(True)
	HourPaint.SetStrokeCap(HourPaint.Cap_ROUND)
	TagObject.Put("HourPaint", HourPaint)

	'The minute handle
	MinutePaint.Initialize
	MinutePaint.SetARGB(255, 200, 200, 200)
	MinutePaint.SetStrokeWidth(4.0f)
	MinutePaint.SetAntiAlias(True)
	MinutePaint.SetStrokeCap(MinutePaint.Cap_ROUND)
	TagObject.Put("MinutePaint", MinutePaint)
	
	'The second handle
	SecondPaint.Initialize
	SecondPaint.SetColor(Colors.Blue)
	SecondPaint.SetStrokeWidth(3.0f)
	SecondPaint.SetAntiAlias(True)
	SecondPaint.SetStrokeCap(SecondPaint.Cap_ROUND)
	TagObject.Put("SecondPaint", SecondPaint)
	
	Engine.Tag = TagObject
	
End Sub

' When the WatchFace changes between Ambient and Interactive Mode, this event is called.
' This is used for example to set antialias mode to your drawing objects.
Sub WF_AmbientModeChanged (Engine As WFEngine, AmbientMode As Boolean)
	LogColor("WF_AmbientModeChanged", Colors.Blue)
	
	Dim TagObject As Map
	Dim HourPaint, MinutePaint, SecondPaint, TicksPaint As ABPaint
	TagObject = Engine.Tag
	HourPaint = TagObject.Get("HourPaint")
	MinutePaint = TagObject.Get("MinutePaint")
	SecondPaint = TagObject.Get("SecondPaint")
	TicksPaint = TagObject.Get("TicksPaint")

	If Engine.LowBitAmbient Then
		Dim Antialias As Boolean
		
		Antialias = Not(AmbientMode)
		TicksPaint.SetAntiAlias(Antialias)
		HourPaint.SetAntiAlias(Antialias)
		MinutePaint.SetAntiAlias(Antialias)
		SecondPaint.SetAntiAlias(Antialias)
	End If
End Sub

' This event is called whenever the watchface should redraw.
'
' Be aware that the Canvas still contains the old drawings so if you want to update everything you have to clear it.
Sub WF_Draw (Engine As WFEngine, Canvas As Canvas, Bounds As Rect)
	'LogColor("WF_Draw", Colors.Blue)

	Dim TWO_PI As Float = cPI * 2.0f
	
	Dim TagObject As Map
	Dim HourPaint, MinutePaint, SecondPaint, TicksPaint As ABPaint
	Dim ExtDraw As ABExtDrawing
	
	' Clear the Background
	ExtDraw.drawColor(Canvas, Colors.Black)
	
	TagObject = Engine.Tag
	TicksPaint = TagObject.Get("TicksPaint")
	HourPaint = TagObject.Get("HourPaint")
	MinutePaint = TagObject.Get("MinutePaint")
	SecondPaint = TagObject.Get("SecondPaint")

	'Draw the ticks
	Dim tickPath As ABPath

	Dim r As Int = Engine.OuterBounds.CenterX

	Dim tickLen As Int = 10
	Dim medTickLen As Int = 18
	Dim longTickLen As Int = 30
	
	tickPath.Initialize

	Dim len As Int
	Dim x1, x2, y1, y2 As Double
	
	For i = 1 To 60
		
		len = tickLen
		If i Mod 15 == 0 Then
			len = longTickLen
		Else If i Mod 5 == 0 Then
			len = medTickLen
		End If

		Dim angleFrom12, angleFrom3 As Double
		angleFrom12 = i/60.0 * 2 * cPI
		angleFrom3 = cPI/2 - angleFrom12

		x1 = Engine.OuterBounds.CenterX + Cos(angleFrom3) * r
		y1 = Engine.OuterBounds.CenterY - Sin(angleFrom3) * r
		x2 = Engine.OuterBounds.CenterX + Cos(angleFrom3) * (r - len)
		y2 = Engine.OuterBounds.CenterY - Sin(angleFrom3) * (r-len)

		tickPath.moveTo(x1, y1)
		tickPath.lineTo(x2, y2)
	Next
	ExtDraw.drawPath(Canvas, tickPath, TicksPaint)

	Dim seconds As Float = DateTime.GetSecond(DateTime.Now) '+ (DateTime.Now Mod DateTime.TicksPerSecond) / 1000
	Dim secRot As Float = (seconds + Sin(DateTime.Now Mod DateTime.TicksPerSecond / 1000 * cPI / 2)) / 60 * TWO_PI
	Dim minutes As Float = DateTime.GetMinute(DateTime.Now) + seconds / 60
	Dim minRot As Float = minutes / 60 * TWO_PI
	Dim hours As Float = DateTime.GetHour(DateTime.Now) + minutes / 60
	Dim hrRot As Float = hours / 12 * TWO_PI
	
	Dim secLength As Float = Engine.OuterBounds.CenterX - 10dip
	Dim minLength As Float = Engine.OuterBounds.centerX - 15dip
	Dim hrLength As Float = Engine.OuterBounds.CenterX - 35dip
	
	If Not(Engine.IsAmbientMode) Then
		Dim secX As Float = Sin(secRot) * secLength
		Dim secY As Float = -Cos(secRot) * secLength
		ExtDraw.drawLine(Canvas, Engine.OuterBounds.CenterX, Engine.OuterBounds.CenterY, Engine.OuterBounds.CenterX + secX, Engine.OuterBounds.CenterY + secY, SecondPaint)
	End If
	
	Dim minX As Float = Sin(minRot) * minLength
	Dim minY As Float = -Cos(minRot) * minLength
	ExtDraw.drawLine(Canvas, Engine.OuterBounds.CenterX, Engine.OuterBounds.CenterY, Engine.OuterBounds.CenterX + minX, Engine.OuterBounds.CenterY + minY, MinutePaint)
	
	Dim hrX As Float = Sin(hrRot) * hrLength
	Dim hrY As Float = -Cos(hrRot) * hrLength
	ExtDraw.drawLine(Canvas, Engine.OuterBounds.CenterX, Engine.OuterBounds.CenterY, Engine.OuterBounds.CenterX + hrX, Engine.OuterBounds.CenterY + hrY, HourPaint)

	ExtDraw.drawCircle(Canvas, Engine.OuterBounds.CenterX, Engine.OuterBounds.CenterY, 5dip, HourPaint)

	' Draw rectangle behind peek card in ambient mode To improve readability.
	If (Engine.IsAmbientMode) Then
		Dim BgPaint As ABPaint
		BgPaint.Initialize
		BgPaint.SetColor(Colors.Black)
	
		ExtDraw.drawRect(Canvas, Engine.PeekCardBounds, BgPaint)
	End If
End Sub

' This event is called when the user taps on the display.
Sub WF_TapCommand (Engine As WFEngine, TapType As Int, XPos As Int, YPos As Int, EventTime As Long)
	LogColor("TappCommand", Colors.Blue)
	
	Select TapType
		Case Engine.TAPTYPE_TAP
			Log("Tapped: " & XPos & ":" & YPos)
		Case Engine.TAPTYPE_TOUCH
			Log("Touched: " & XPos & ":" & YPos)
		Case Engine.TAPTYPE_TOUCH_CANCEL
			Log("Touch Canceled")
		Case Else
			Log("Unknown TapType")
	End Select
End Sub

' This event is called when the engine is destroyed so you can free any resources that you have allocated in the
' Created event.
Sub WF_EngineDestroyed (Engine As WFEngine)
	LogColor("WF_EngineDestroyed", Colors.Blue)
	Engine.Tag = Null
End Sub
#End Region


Sub DateTime_TimeChanged
	LogColor("Time updated", Colors.Red)
End Sub
