B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
'https://github.com/tanersener/mobile-ffmpeg
'v1.0
#IgnoreWarnings: 12
Sub Class_Globals
	Private joFFMPEG As JavaObject
	Private joConfig As JavaObject
	Private joLogMessage As JavaObject
	Private theCaller As Object, eventName As String
End Sub

Public Sub Initialize(caller As Object, eventSub As String)
	theCaller=caller
	eventName=eventSub
	joFFMPEG.InitializeStatic("com.arthenica.mobileffmpeg.FFmpeg")
	joConfig.InitializeStatic("com.arthenica.mobileffmpeg.Config")
	joLogMessage.InitializeStatic("com.arthenica.mobileffmpeg.LogMessage")
End Sub

'returns a code indicating the success or not of executing the command
Sub Execute(cmd() As String) As Int
	Return joFFMPEG.RunMethod("execute", Array(cmd))
End Sub

'returns execution id
Sub ExecuteAsync(cmd() As String ) As Long
	Dim callbackO As Object = joFFMPEG.CreateEvent("com.arthenica.mobileffmpeg.ExecuteCallback", "executeAsyncCallback", Null)
	Return joFFMPEG.RunMethod("executeAsync", Array(cmd, callbackO))
End Sub

Sub Cancel(id As Long)
	joFFMPEG.RunMethod("cancel", Array(id))
End Sub

Sub ExecuteAsyncCallback_Event(MethodName As String, Args() As Object)
	CallSubDelayed3(theCaller, eventName & "_Event", Args(0), Args(1))
End Sub

Sub GetAbi As String
	Dim jo As JavaObject
	jo.InitializeStatic("com.arthenica.mobileffmpeg.AbiDetect")
	Return jo.RunMethod("getAbi", Null)
End Sub

Sub GetLastCommandOutput As String
	Return joConfig.RunMethod("getLastCommandOutput", Null)
End Sub

Sub EnableStatisticsCallback
	Dim callbackO As Object = joFFMPEG.CreateEvent("com.arthenica.mobileffmpeg.StatisticsCallback", "StatisticsCallback", Null)
	joConfig.RunMethod("enableStatisticsCallback", Array(callbackO))
End Sub

Sub StatisticsCallback_Event(MethodName As String, Args() As Object)
	Dim jo As JavaObject=Args(0)
	Dim msg As String=jo.RunMethod("toString",Null)
	CallSubDelayed2(theCaller, eventName & "_Statistics", msg)
End Sub

Sub SetLogLevelByValue(level As Int)
	Dim joLevels As JavaObject
	joLevels.InitializeStatic("com.arthenica.mobileffmpeg.Level")
	Dim oLevel As Object=joLevels.RunMethod("from", Array(level))
	joConfig.RunMethod("setLogLevel", Array(oLevel))
End Sub

Sub setLogLevelByConstant(level As String)
	Dim joLevels As JavaObject
	joLevels.InitializeStatic("com.arthenica.mobileffmpeg.Level")
	Dim oLevel As Object=joLevels.RunMethod("valueOf", Array(level))
	joConfig.RunMethod("setLogLevel", Array(oLevel))
End Sub

Sub GetLogLevels As Object()
	Dim joLevels As JavaObject
	joLevels.InitializeStatic("com.arthenica.mobileffmpeg.Level")
	Return joLevels.RunMethod("values", Null)
End Sub

Sub EnableLogCallback
	Dim callbackO As Object = joFFMPEG.CreateEvent("com.arthenica.mobileffmpeg.LogCallback", "LogCallback", Null)
	joConfig.RunMethod("enableLogCallback", Array(callbackO))
End Sub

Sub LogCallback_Event(MethodName As String, Args() As Object)
	Dim jo As JavaObject=Args(0)
	Dim msg As String=jo.RunMethod("getText",Null)
	CallSubDelayed2(theCaller, eventName & "_Log", msg)
End Sub
