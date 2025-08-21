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
	Private DigitalWFManager As WFManager
End Sub

Sub Service_Create
	DigitalWFManager.Initialize("WF", 1000)
	
	' Make sure the B4A DateTime object gets time change events
	DateTime.ListenToExternalTimeChanges
End Sub

Sub Service_Start (StartingIntent As Intent)

End Sub

Sub Service_Destroy

End Sub

#Region WatchFace Events
' This event is called when the WatchFace Engine is created.
' Do any initialization to your drawing objects here and store them in the tag property.
Sub WF_Created (Engine As WFEngine)
	LogColor("WF_Created", Colors.Blue)
	
	Dim TagObject As Map
	
	TagObject.Initialize

	' Set the initial style of the watchface here. Setting the properties will not change the WatchFace immediately. You have
	' to call SetWatchFaceStyle to change the properties.
	Engine.ShowSystemUiTime = False
	Engine.AcceptsTapEvents = True
	Engine.StatusBarGravity = Gravity.TOP + Gravity.CENTER_HORIZONTAL
	Engine.CardPeekMode = Engine.PEEK_MODE_SHORT
	Engine.HideHotwordIndicator = False
	Engine.HotwordIndicatorGravity = Gravity.CENTER_HORIZONTAL + Gravity.BOTTOM
	Engine.ShowUnreadCountIndicator = True
	Engine.SetWatchFaceStyle

	'Create Paint Objects
	'These Paint objects are stored in the Tag property of the engine so we can access them later
	'in the Draw() event.
	Dim TimePaint, SecondPaint, DatePaint As ABPaint

	'The hour/minute digits
	TimePaint.Initialize
	TimePaint.SetARGB(255, 200, 200, 200)
	TimePaint.SetAntiAlias(True)
	TimePaint.SetTextAlign(TimePaint.Align_CENTER)
	TimePaint.SetTextSize(100)
	TagObject.Put("TimePaint", TimePaint)

	'The second digits
	SecondPaint.Initialize
	SecondPaint.SetColor(Colors.Blue)
	SecondPaint.SetAntiAlias(True)
	SecondPaint.SetTextAlign(SecondPaint.Align_CENTER)
	SecondPaint.SetTextSize(48)
	TagObject.Put("SecondPaint", SecondPaint)
	
	'The date
	DatePaint.Initialize
	DatePaint.SetColor(Colors.Gray)
	DatePaint.SetAntiAlias(True)
	DatePaint.SetTextAlign(DatePaint.Align_CENTER)
	DatePaint.SetTextSize(32)
	TagObject.Put("DatePaint", DatePaint)
	
	Engine.Tag = TagObject
	
End Sub

' When the WatchFace changes between Ambient and Interactive Mode, this event is called.
' This is used for example to enable/disable antialias mode to your drawing objects.
Sub WF_AmbientModeChanged (Engine As WFEngine, AmbientMode As Boolean)
	LogColor("WF_AmbientModeChanged", Colors.Blue)
	
	Dim TagObject As Map
	Dim TimePaint, SecondPaint, DatePaint As ABPaint
	TagObject = Engine.Tag
	TimePaint = TagObject.Get("TimePaint")
	SecondPaint = TagObject.Get("SecondPaint")
	DatePaint = TagObject.Get("DatePaint")

	If Engine.LowBitAmbient Then
		Dim Antialias As Boolean
		
		Antialias = Not(AmbientMode)
		TimePaint.SetAntiAlias(Antialias)
		DatePaint.SetAntiAlias(Antialias)
		SecondPaint.SetAntiAlias(Antialias)
	End If
End Sub

' This sub is called once the internal layout of the watch face is set up.
' You have access to the complete resolution of the device. Additionally you can check if the
' device is round or square or get the chin size.
' If you use a background bitmap, you can scale it here to the correct size.
Sub WF_SizeChanged (Engine As WFEngine, Width As Int, Height As Int)
	LogColor("Size changed: " & Width & " : " & Height, Colors.Green)
	LogColor("IsRound: " & Engine.IsRound, Colors.Green)
	LogColor("Flat Tire: " & Engine.ChinSize, Colors.Green)
End Sub

' This sub will be called if the Watchface gets visible or invisible
Sub WF_VisibilityChanged (Engine As WFEngine, Visible As Boolean)
	If Visible Then
		LogColor("Watchface visible", Colors.Blue)
	Else
		LogColor("Watchface invisible", Colors.Blue)
	End If
End Sub

' React on Tap commands on the display.
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

' This event is called whenever the watchface should redraw.
'
' Be aware that the Canvas still contains the old drawings so if you want to update everything you have to clear it at first.
Sub WF_Draw (Engine As WFEngine, Canvas As Canvas, Bounds As Rect)
	'LogColor("WF_Draw", Colors.Blue)

	Dim TagObject As Map
	Dim TimePaint, SecondPaint, DatePaint As ABPaint
	Dim ExtDraw As ABExtDrawing
	
	' Clear the Background
	ExtDraw.drawColor(Canvas, Colors.Black)
	
	TagObject = Engine.Tag
	TimePaint = TagObject.Get("TimePaint")
	SecondPaint = TagObject.Get("SecondPaint")
	DatePaint = TagObject.Get("DatePaint")

	DateTime.TimeFormat = "HH:mm"
	DateTime.DateFormat = "EE dd. MMMM"
	ExtDraw.drawText(Canvas, DateTime.Time(DateTime.Now), Engine.OuterBounds.CenterX, Engine.OuterBounds.CenterY  + TimePaint.GetTextSize / 2, TimePaint)
	ExtDraw.drawText(Canvas, DateTime.Date(DateTime.Now), Engine.OuterBounds.CenterX, Engine.OuterBounds.CenterY / 2 + DatePaint.GetTextSize / 2, DatePaint)
	
	If Not(Engine.IsAmbientMode) Then
		ExtDraw.drawText(Canvas, NumberFormat(DateTime.GetSecond(DateTime.Now), 2, 0), Engine.OuterBounds.CenterX, Engine.Height - (Engine.OuterBounds.CenterY / 2) + SecondPaint.GetTextSize / 2, SecondPaint)
	End If

	' Draw rectangle behind peek card in ambient mode To improve readability.
	If (Engine.IsAmbientMode) Then
		Dim BgPaint As ABPaint
		BgPaint.Initialize
		BgPaint.SetColor(Colors.DarkGray)
	
		ExtDraw.drawRect(Canvas, Engine.PeekCardBounds, BgPaint)
	End If
End Sub

' This sub is called just before the engine is destroyed. You can free any globally allocated objects here.
Sub WF_EngineDestroyed (Engine As WFEngine)
	LogColor("Engine Destroyed", Colors.Blue)
End Sub
#End Region

Sub DateTime_TimeChanged
	LogColor("Time updated", Colors.Red)
End Sub


