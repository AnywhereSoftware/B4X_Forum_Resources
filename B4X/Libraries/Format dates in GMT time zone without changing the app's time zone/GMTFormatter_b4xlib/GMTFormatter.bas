B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.9
@EndOfDesignText@
Sub Class_Globals
	#if B4A or B4J
	Private SimpleDateFormat As JavaObject
	#Else If B4i
	Private SimpleDateFormat As NativeObject
	Private IDateTime As NativeObject
	#End If
End Sub

#if B4A or B4J
Public Sub Initialize (DateFormat As String)
	Dim locale As JavaObject
	locale = locale.InitializeStatic("java.util.Locale").GetField("US")
	SimpleDateFormat.InitializeNewInstance("java.text.SimpleDateFormat", Array(DateFormat, locale))
	Dim TimeZone As JavaObject
	TimeZone.InitializeNewInstance("java.util.SimpleTimeZone", Array(0, "gmt"))
	SimpleDateFormat.RunMethod("setTimeZone", Array(TimeZone))
End Sub

Public Sub Format (Ticks As Long) As String
	Dim dt As JavaObject
	dt.InitializeNewInstance("java.util.Date", Array(Ticks))
	Return SimpleDateFormat.RunMethod("format", Array(dt))
End Sub
#else if B4i
Public Sub Initialize (DateFormat As String)
	Dim locale As NativeObject
	locale = locale.Initialize("NSLocale").RunMethod("alloc", Null).RunMethod("initWithLocaleIdentifier:", Array("en_US_POSIX"))
	SimpleDateFormat = SimpleDateFormat.Initialize("NSDateFormatter").RunMethod("new", Null)
	SimpleDateFormat.SetField("dateFormat", DateFormat)
	SimpleDateFormat.SetField("lenient", False)
	SimpleDateFormat.SetField("locale", locale)
	Dim TimeZone As NativeObject
	SimpleDateFormat.SetField("timeZone", TimeZone.Initialize("NSTimeZone").RunMethod("timeZoneForSecondsFromGMT:", Array(0)))
	IDateTime = IDateTime.Initialize("B4ICommon").RunMethod("new", Null).RunMethod("DateTime", Null)
End Sub

Public Sub Format (Ticks As Long) As String
	Return SimpleDateFormat.RunMethod("stringFromDate:", Array(IDateTime.RunMethod("TicksToNSDate:", Array(Ticks)))).AsString
End Sub
#end if