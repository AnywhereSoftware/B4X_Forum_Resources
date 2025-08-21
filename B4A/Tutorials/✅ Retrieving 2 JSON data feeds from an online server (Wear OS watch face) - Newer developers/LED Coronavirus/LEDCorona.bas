B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=9.8
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
#End Region

#Extends: de.amberhome.wearwrapper.WatchFaceService

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

	Public Country As String
	Public TodayCases As Int
	Public TodayDeaths As Int
	
	Private TimeDots As Boolean
	
	Public KVS2 As KeyValueStore
	Public AppSettings As String = "DSAppSettings"
	Private JavaObject As JavaObject	
	
	Private JSONResults As GetJSONResults
	Private LEDWFManager As WFManager
	Private CustomFont As Typeface = Typeface.LoadFromAssets("LED_Font.ttf")
End Sub

Sub Service_Create
	'This is the program entry point.
	'This is a good place to load resources that are not specific to a single activity.

	JSONResults.Initialize
	JavaObject.InitializeContext
	
	KVS2.Initialize(File.DirInternal, AppSettings)
	SetAppSettings
	Country = KVS2.Get("Country")
	
'	KVS2.DeleteAll
'	For Each k As String In KVS2.ListKeys
'		Log(k)
'	Next

	Wait For (CallSub2(JSONResults, "ParseJSONCountry", Country)) Complete (Completed As Boolean)
	LEDWFManager.Initialize("WF", 1000)
	
	' Make sure the B4A DateTime object gets time change events
	DateTime.ListenToExternalTimeChanges
End Sub

Sub Service_Start(StartingIntent As Intent)
	'CallSub(Me, UpdateUI)
End Sub

Sub Service_TaskRemoved
	'This event will be raised when the user removes the app from the recent apps list.
End Sub

'Return true to allow the OS default exceptions handler to handle the uncaught exception.
Sub Application_Error(Error As Exception, StackTrace As String) As Boolean
	Return True
End Sub

Sub Service_Destroy
End Sub

#Region WatchFace Events
' This sub is called once the Engine is created and the Manager is initialized.

' To optimize speed and battery you should initialize Drawing objects (ABPaint) here.
' Be aware that at this time the width and height of the WatchFace is not knwon. (Engine.Width and Engine.Height are not set)

' You can store the ABPaint objects int the Tag property of the Engine. Using process_global variables for them should work, too
' but is not recommended.

Sub WF_Created(Engine As WFEngine)
	LogColor("WF_Created", Colors.Blue)
	' Set the initial style of the watchface here. Setting the properties will not change the WatchFace immediately. You have
	' to call SetWatchFaceStyle to change the properties.
	Engine.ShowSystemUiTime = False
	Engine.AcceptsTapEvents = True
	Engine.StatusBarGravity = Gravity.TOP + Gravity.CENTER_HORIZONTAL
	Engine.ViewProtectionMode = Engine.PROTECT_STATUS_BAR
	Engine.AmbientPeekMode = Engine.AMBIENT_PEEK_MODE_VISIBLE
	Engine.CardPeekMode = Engine.PEEK_MODE_SHORT
	Engine.SetWatchFaceStyle
End Sub

' When the WatchFace changes between Ambient and Interactive Mode, this event is called.
' This is used for example to set antialias mode to your drawing objects.
Sub WF_AmbientModeChanged (Engine As WFEngine, AmbientMode As Boolean)
	LogColor("WF_AmbientModeChanged", Colors.Blue)
End Sub

' This event is called whenever the watchface should redraw.
' Be aware that the Canvas still contains the old drawings so if you want to update everything you have to clear it.
Sub WF_Draw(Engine As WFEngine, Canvas As Canvas, Bounds As Rect)
	'LogColor("WF_Draw", Colors.Blue)

	'Clear Canvas
	Canvas.DrawColor(0xFF000000)

'	'TEMP CENTRE RED LINE
'	Canvas.DrawLine(Bounds.CenterX, Bounds.CenterY - 100dip, Bounds.CenterX, Bounds.CenterY + 100dip, Colors.Red,1)
'
'	'TEMP LOCATION RED BOX FOR FIGURING OUR TAP POSITIONS
'	Dim RectTempBox As Rect
'		RectTempBox.Initialize(Bounds.CenterX - 52dip, Bounds.CenterY + 25dip, Bounds.CenterX + 52dip, Bounds.CenterY + 60dip)
'	Canvas.DrawRect(RectTempBox, Colors.ARGB(100, 255, 0, 0), True, 1)

	'Is screen dimmed (Ambient mode)
	Dim FontColor As Int	
	If Engine.IsAmbientMode Then
		Canvas.AntiAlias = False
		FontColor = Colors.ARGB(192, 128, 128, 128)
	Else
		Canvas.AntiAlias = True
		FontColor = Colors.ARGB(255, KVS2.Get("LEDR"), KVS2.Get("LEDG"), KVS2.Get("LEDB"))

		'Outer Border
		If KVS2.Get("Border") = True Then
			If Engine.IsRound Then
				'Round Border
				Canvas.DrawCircle(Bounds.CenterX, Bounds.CenterY, Bounds.Width / 2, Colors.RGB(KVS2.Get("BordR"), KVS2.Get("BordG"), KVS2.Get("BordB")), False, 4dip)

				'Chin Line
				'Dim ChinSize As Int = 30 / GetDeviceLayoutValues.Scale
				'If ChinSize > 0dip Then
				If Engine.ChinSize > 0dip Then
					'Log($"ChinSize = ${Engine.ChinSize}"$)
					Dim Chin As Rect
						Chin.Initialize(Bounds.Left, Bounds.Bottom - Engine.ChinSize - 1dip, Bounds.Right, Bounds.Bottom)
					Canvas.DrawRect(Chin, Colors.Black, True, 1dip)
					Canvas.DrawLine(Bounds.Left, Bounds.Bottom - Engine.ChinSize - 1dip, Bounds.Right, Bounds.Bottom - Engine.ChinSize - 1dip, Colors.RGB(KVS2.Get("BordR"), KVS2.Get("BordG"), KVS2.Get("BordB")), 2dip)
				End If
			Else
				'Square Border
				'Outer Square
				Dim OuterEdge As ColorDrawable
					OuterEdge.Initialize(Colors.RGB(KVS2.Get("BordR"), KVS2.Get("BordG"), KVS2.Get("BordB")), 5dip)
				Dim OuterBorder As Rect
					OuterBorder.Initialize(Bounds.Left, Bounds.Top, Bounds.Right, Bounds.Bottom)
				Canvas.DrawDrawable(OuterEdge, OuterBorder)

				'Inner Square
				Dim InnerEdge As ColorDrawable
					InnerEdge.Initialize(Colors.Black, 5dip)
				Dim InnerBorder As Rect
					InnerBorder.Initialize(Bounds.Left + 2dip, Bounds.Top + 2dip, Bounds.Right - 2dip, Bounds.Bottom - 2dip)
				Canvas.DrawDrawable(InnerEdge, InnerBorder)
			End If
		End If
		
		'Drawer onto the display
		'Battery Percent
		Dim BatteryLevel As Int = JavaObject.RunMethod("BatteryLevel", Null)
		Canvas.DrawText($"${BatteryLevel}%"$, Bounds.CenterX, Bounds.CenterY + 16dip - 75dip, CustomFont, 14, FontColor, "CENTER")		
		
		'Date
		DateTime.DateFormat = "dd MM yy" ' DateTime.DeviceDefaultDateFormat
		Canvas.DrawText(DateTime.Date(DateTime.Now), Bounds.CenterX, Bounds.CenterY - 38dip, CustomFont, 14, FontColor, "CENTER")
		
		'Confirmed
		Canvas.DrawText($"Cases = ${TodayCases}"$, Bounds.CenterX, Bounds.CenterY + 38dip, CustomFont, 12, FontColor, "CENTER")

		'Deaths
		Canvas.DrawText($"Deaths = ${TodayDeaths}"$, Bounds.CenterX, Bounds.CenterY + 57dip, CustomFont, 12, FontColor, "CENTER")			
	End If

	'Drawer onto the display
	'Display Time
	DateTime.TimeFormat = "HH:mm" 'DateTime.TimeFormat = "h:mm"'
	Canvas.DrawText(DateTime.Time(DateTime.Now), Bounds.CenterX, Bounds.CenterY + 12dip, CustomFont, 34, FontColor, "CENTER")	

'	Dim TimeWidth As String = DateTime.Time(DateTime.Now)
'	Log($"Time width = ${Canvas.MeasureStringWidth(TimeWidth, CustomFont, 34)}"$)

	'Blink Seconds Dots
	If Not(Engine.IsAmbientMode) Then
		If TimeDots = False Then
			Dim RectDots As Rect
				RectDots.Initialize(Bounds.CenterX - 7dip, Bounds.CenterY - 22dip, Bounds.CenterX - 7dip + 14dip, Bounds.CenterY + 22dip)
			Canvas.DrawRect(RectDots, Colors.Black, True, 1)
		End If
		TimeDots = Not(TimeDots)
	End If
End Sub

' This event is called when the user taps on the display.
Sub WF_TapCommand(Engine As WFEngine, TapType As Int, XPos As Int, YPos As Int, EventTime As Long)
	LogColor("TappCommand", Colors.Blue)

	Select TapType
		Case Engine.TAPTYPE_TAP
			'Log("Tapped: " & XPos & ":" & YPos)
			Select True 'Tap text to update cronavirus figures
				Case XPos > (Engine.Width / 2) - 52dip And XPos < (Engine.Width / 2) + 52dip And YPos > (Engine.Height / 2) + 25dip And YPos < (Engine.Height / 2) + 60dip 'Weather Conditions Tapped
					Wait For (CallSub2(JSONResults, "ParseJSONCountry", Country)) Complete (Completed As Boolean)
					ToastMessageShow($"${Country} updated"$, False)
			End Select
		Case Engine.TAPTYPE_TOUCH
			'Log("Touched: " & XPos & ":" & YPos)
		Case Engine.TAPTYPE_TOUCH_CANCEL
			'Log("Touch Canceled")
		Case Else
			'Log("Unknown TapType")
	End Select
End Sub

' This event is called when the engine is destroyed so you can free any resources that you have allocated in the
' Created event.
Sub WF_EngineDestroyed(Engine As WFEngine)
	LogColor("WF_EngineDestroyed", Colors.Blue)
	Engine.Tag = Null
End Sub

#End Region

'DATE TIME CHANGE
Sub DateTime_TimeChanged
	LogColor("Time updated", Colors.Red)
End Sub

'LOAD SETTINGS FROM THE DATASTORE
Public Sub SetAppSettings
	If KVS2.Get("LEDR") = Null Then
		KVS2.Put("LEDR", 255)
		KVS2.Put("LEDG", 0)
		KVS2.Put("LEDB", 0)

		KVS2.Put("BordR", 124)
		KVS2.Put("BordG", 215)
		KVS2.Put("BordB", 167)
		KVS2.Put("Border", True)
		
		KVS2.Put("Country", "USA")
		
		'Add a blank bitmap to the list
		Dim BmpTemp As Bitmap
			BmpTemp.InitializeMutable(100dip, 60dip)
		KVS2.PutBitmap("Flag", BmpTemp)
	End If
End Sub

'Read device bettery level
#If JAVA

import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;

public String BatteryLevel() 
{
	float retVal = 0;
    IntentFilter iFilter = new IntentFilter(Intent.ACTION_BATTERY_CHANGED);
    Intent batteryStatus = registerReceiver(null, iFilter);
    retVal = batteryStatus.getIntExtra(BatteryManager.EXTRA_LEVEL, -1);
    return Integer.toString(Math.round(retVal));
}

//import android.os.Vibrator;
//
//Public void Vibrate()
//{
//	Vibrator Vibrate = (Vibrator) getSystemService(VIBRATOR_SERVICE);
//	// Vibrate For 100 milliseconds
//	Vibrate.vibrate(100);
//}

#End If
