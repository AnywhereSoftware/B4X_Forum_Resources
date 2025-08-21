B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
	
	Dim clock1 As JavaObject
	Public SKIN_CLOCK As String = "CLOCK"
	Public SKIN_YOTA2 As String = "YOTA2"
	Public SKIN_LCD As String = "LCD"
	Public SKIN_PEAR As String = "PEAR"
	Public SKIN_PLAIN As String = "PLAIN"
	Public SKIN_DB As String = "DB"
	Public SKIN_FAT As String = "FAT"
	Public SKIN_ROUND_LCD As String = "ROUND_LCD"
	Public SKIN_SLIM As String = "SLIM"
	Public SKIN_MINIMAL As String = "MINIMAL"
	Public SKIN_DIGITAL As String = "DIGITAL"
	Public SKIN_TEXT As String = "TEXT"
	Public SKIN_DESIGN As String = "DESIGN"
	Public SKIN_INDUSTRIAL As String = "INDUSTRIAL"
	Public SKIN_TILE As String = "TILE"
	Public SKIN_DIGI As String = "DIGI"
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
	clock1.InitializeNewInstance("eu.hansolo.medusa.Clock", Null)
	
End Sub

public Sub setSkin (skin As String)
	'CLOCK, YOTA2, LCD, PEAR, PLAIN, DB, FAT, ROUND_LCD, SLIM, MINIMAL, DIGITAL, TEXT, DESIGN, INDUSTRIAL, TILE, DIGI
	Dim skintype As JavaObject
	skintype = skintype.InitializeStatic("eu.hansolo.medusa.Clock.ClockSkinType")
	clock1.RunMethod("setSkinType", Array(skintype.GetField(skin)))
	
End Sub

public Sub setHourTickMarkColor(color As Paint)
	
	clock1.RunMethod("setHourTickMarkColor", Array(color))
	
End Sub

public Sub setMinuteTickMarkColor(color As Paint)
	
	clock1.RunMethod("setMinuteTickMarkColor", Array(color))
	
End Sub

public Sub setMinuteHandColor(color As Paint)
	
	clock1.RunMethod("setMinuteColor", Array(color))
	
End Sub

public Sub setHourHandColor(color As Paint)
	
	clock1.RunMethod("setHourColor", Array(color))
	
End Sub

public Sub setSecondHandColor(color As Paint)
	
	clock1.RunMethod("setSecondColor", Array(color))
	
End Sub

public Sub setClockBackgroundColor(color As Paint)
	clock1.RunMethod("setBackgroundPaint", Array(color))
End Sub

public Sub setSecondsVisible (visible As Boolean)
	clock1.RunMethod("setSecondsVisible", Array(visible))
End Sub

Public Sub setDateVisible(visible As Boolean)
	clock1.RunMethod("setDateVisible", Array(visible))
End Sub

Public Sub setDayVisible(visible As Boolean)
	clock1.RunMethod("setDayVisible", Array(visible))
End Sub

Public Sub setTickLabelsVisible(visible As Boolean)
	clock1.RunMethod("setTickLabelsVisible", Array(visible))
End Sub

Public Sub setNightMode(mode As Boolean)
	clock1.RunMethod("setNightMode", Array(mode))
End Sub

public Sub setTickLabelColor(color As Paint)
	clock1.RunMethod("setTickLabelColor", Array(color))
End Sub

public Sub setKnobColor(color As Paint)
	clock1.RunMethod("setKnobColor", Array(color))
End Sub

Public Sub setAutoNightMode(mode As Boolean)
	clock1.RunMethod("setAutoNightMode", Array(mode))
End Sub

Public Sub setTitle(title As String)
	clock1.RunMethod("setTitle", Array(title))
End Sub

Public Sub setTitleVisible(visible As Boolean)
	clock1.RunMethod("setTitleVisible", Array(visible))
End Sub

public Sub setTitleColor(color As Paint)
	clock1.RunMethod("setTitleColor", Array(color))
End Sub

Public Sub setTextVisible(visible As Boolean)
	clock1.RunMethod("setTextVisible", Array(visible))
End Sub

public Sub setTextColor(color As Paint)
	clock1.RunMethod("setTextColor", Array(color))
End Sub

public Sub setDateColor(color As Paint)
	clock1.RunMethod("setDateColor", Array(color))
End Sub

Public Sub setRunning(running As Boolean)
	clock1.RunMethod("setRunning", Array(running))
End Sub

Public Sub setAlarmsEnabled(enabled As Boolean)
	clock1.RunMethod("setAlarmsEnabled", Array(enabled))
End Sub

Public Sub setAlarmsVisible(visible As Boolean)
	clock1.RunMethod("setAlarmsVisible", Array(visible))
End Sub

public Sub setAlarmColor(color As Paint)
	clock1.RunMethod("setAlarmColor", Array(color))
End Sub



public Sub makeClock As JavaObject
		
	Dim repetition As JavaObject
	'ONCE, HALF_HOURLY, HOURLY, DAILY, WEEKLY
	repetition = repetition.InitializeStatic("eu.hansolo.medusa.Alarm.Repetition").GetField("DAILY")
	
	Dim zdt As JavaObject
	zdt.InitializeStatic("java.time.ZonedDateTime")
	Dim hournow As Int = zdt.RunMethodJO("now", Null).RunMethod("getHour", Null)
	Dim minutenow As Int = zdt.RunMethodJO("now", Null).RunMethod("getMinute", Null)
	Dim secondnow As Int = zdt.RunMethodJO("now", Null).RunMethod("getSecond", Null)

	Dim alarmtimehour As Long = 6           'time of day (hour) that the alarm should be triggered
	Dim alartimeminute As Long = 30
	Dim alarmtimesecond As Long = 0
	Dim alarmdaystoadd As Long = 0

	alartimeminute = minutenow - alartimeminute
	alarmtimesecond = secondnow - alarmtimesecond
	
	Dim alamhourfromnow As Long
	If hournow > alarmtimehour Then
		alamhourfromnow = 24 - hournow + alarmtimehour
	Else
		alamhourfromnow = alarmtimehour - hournow
	End If
	
	zdt = zdt.RunMethodJO("now", Null).RunMethodJO("plusHours", Array(alamhourfromnow)).RunMethodJO("minusMinutes", Array(alartimeminute)).RunMethodJO("minusSeconds", Array(alarmtimesecond)).RunMethod("plusDays", Array(alarmdaystoadd))
	Dim clockcolor As JavaObject
	clockcolor = clockcolor.InitializeStatic("eu.hansolo.medusa.Clock").GetField("DARK_COLOR")
	
	'initialize a new instance of the clock alarm
	Dim alarm As JavaObject
	alarm.InitializeNewInstance("eu.hansolo.medusa.Alarm", Array(repetition, zdt, True, "", Null, clockcolor))
	alarm.RunMethod("setText", Array("WAKE UP"))
	
'	clock1.RunMethod("setAlarmsEnabled", Array(True))
'	clock1.RunMethod("setAlarmsVisible", Array(True))
'	clock1.RunMethod("setAlarmColor", Array(fx.Colors.Green))
	clock1.RunMethod("addAlarm", Array(alarm))
	Log(clock1.RunMethod("getAlarms", Null))
	
	Dim wdth As Double = 10
	clock1.RunMethod("setBorderWidth", Array(wdth))
	Dim bc As Paint = fx.Colors.Gray
	clock1.RunMethod("setBorderPaint", Array(bc))
	
	Log(clock1.RunMethod("getTime", Null))
	Log(" ")
	Log(alarm.RunMethod("getTime", Null))
	Log(" ")


	'Create an event to be triggered when the clock reaches the alarm time
	Dim jo As JavaObject = clock1
	Dim e As Object = jo.CreateEvent("eu.hansolo.medusa.events.AlarmEventListener", "alarm", False)
	jo.RunMethod("setOnAlarm", Array As Object(e))
	
	'Create an event to be triggered when the clock reaches the alarm time
	'Defines a class that implements the Command interface and which execute()
	'method will be called when the alarm is triggered.
	Dim jo As JavaObject = alarm
	Dim e As Object = jo.CreateEvent("eu.hansolo.medusa.Command", "execute", False)
	jo.RunMethod("setCommand", Array As Object(e))
	
	Return clock1
End Sub

Sub alarm_Event (MethodName As String, Args() As Object) As Object
	Log(MethodName)
	Log("HERE - IN EVENT ALARM TRIGGERED")
	Log(Args.Length)
	For i = 0 To Args.Length - 1
		Log(Args(i))
	Next
	Return True
End Sub

Sub execute_Event (MethodName As String, Args() As Object) As Object
	Log(MethodName)
	Log("HERE - IN EVENT EXECUTE")
	Return True
End Sub

