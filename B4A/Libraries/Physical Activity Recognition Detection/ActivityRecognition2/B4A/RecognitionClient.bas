B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.801
@EndOfDesignText@
'v4.00
Sub Class_Globals
	Private ctxt As JavaObject
	Private ActivityRecognition As JavaObject
	Private client As JavaObject
	Type TransitionEvent (ActivityType As String, ElapsedTime As Long, TransitionType As String)
	Private Activities_Types() As String = Array As String ("IN_VEHICLE", "ON_BICYCLE", "ON_FOOT", "STILL", "UNKNOWN", "TILTING", "", "WALKING", "RUNNING")
	Private PendingIntent As JavaObject
End Sub

Public Sub Initialize (ConnectClient As Boolean)
	ctxt.InitializeContext
	ActivityRecognition.InitializeStatic("com/google/android/gms/location/ActivityRecognition".Replace("/", "."))
	If ConnectClient Then
		client = ActivityRecognition.RunMethod("getClient", Array(ctxt))
	End If
End Sub

Public Sub RequestTransitionUpdates (Activities As List) As ResumableSub
	Dim jo As JavaObject = Me
	PendingIntent = jo.RunMethod("createPendingIntent", Null)
	Dim Task As JavaObject = client.RunMethod("requestActivityTransitionUpdates", Array(BuildRequest(Activities), PendingIntent))
	Do While Task.RunMethod("isComplete", Null) = False
		Sleep(500)
	Loop
	Dim res As Boolean = Task.RunMethod("isSuccessful", Null)
	If res = False Then
		Log(Task.RunMethod("getException", Null))
	End If
	Return res
End Sub


Public Sub RemoveTransitionUpdates As ResumableSub
	If PendingIntent.IsInitialized = False Then
		Log("No pending intent")
		Return False
	End If
	Dim Task As JavaObject = client.RunMethod("removeActivityTransitionUpdates", Array(PendingIntent))
	Do While Task.RunMethod("isComplete", Null) = False
		Sleep(500)
	Loop
	Dim res As Boolean = Task.RunMethod("isSuccessful", Null)
	If res = False Then
		Log(Task.RunMethod("getException", Null))
	End If
	Return res
End Sub

Public Sub GetTransitionEvents (StartingIntent As Intent) As List
	Dim TransiationResult As JavaObject
	TransiationResult.InitializeStatic("com/google/android/gms/location/ActivityTransitionResult".Replace("/", "."))
	Dim res As List
	res.Initialize
	If TransiationResult.RunMethod("hasResult", Array(StartingIntent)) = False Then Return res
	Dim list As List = TransiationResult.RunMethodJO("extractResult", Array(StartingIntent)).RunMethod("getTransitionEvents", Null)
	For Each e As JavaObject In list
		res.Add(CreateTransitionEvent(e.RunMethod("getActivityType", Null), e.RunMethod("getElapsedRealTimeNanos", Null), e.RunMethod("getTransitionType", Null)))
	Next
	Return res	
End Sub

Private Sub BuildRequest (Activities As List) As Object
	Dim DetectedActivity As JavaObject
	DetectedActivity.InitializeStatic("com/google/android/gms/location/DetectedActivity".Replace("/", "."))
	Dim ActivityTransition As JavaObject
	ActivityTransition.InitializeStatic("com/google/android/gms/location/ActivityTransition".Replace("/", "."))
	Dim transitions As List
	transitions.Initialize
	For Each activity As String In Activities
		For Each Transition In Array("ACTIVITY_TRANSITION_ENTER", "ACTIVITY_TRANSITION_EXIT")
			Dim builder As JavaObject
			builder.InitializeNewInstance("com/google/android/gms/location/ActivityTransition$Builder".Replace("/", "."), Null)
			builder.RunMethod("setActivityType", Array(DetectedActivity.GetField(activity)))
			builder.RunMethod("setActivityTransition", Array(ActivityTransition.GetField(Transition)))
			transitions.Add(builder.RunMethod("build", Null))
		Next
	Next
	Dim Request As JavaObject
	Return Request.InitializeNewInstance("com/google/android/gms/location/ActivityTransitionRequest".Replace("/", "."), Array(transitions))
End Sub

#if Java
import android.app.*;
import android.content.*;
import anywheresoftware.b4a.keywords.*;
public PendingIntent createPendingIntent() throws Exception {
	Intent in = new Intent(BA.applicationContext, Common.getComponentClass(null, "RecognitionReceiver", true));
	int flags = PendingIntent.FLAG_UPDATE_CURRENT;
		if (android.os.Build.VERSION.SDK_INT >= 31)
			flags |= 33554432; //FLAG_MUTABLE
	return PendingIntent.getBroadcast(BA.applicationContext, 1, in,
			flags);
}
#End If

Private Sub CreateTransitionEvent (ActivityType As Int, ElapsedTime As Long, TransitionType As Int) As TransitionEvent
	Dim t1 As TransitionEvent
	t1.Initialize
	t1.ActivityType = Activities_Types(ActivityType)
	t1.ElapsedTime = ElapsedTime
	If TransitionType = "0" Then t1.TransitionType = "ENTER" Else t1.TransitionType = "EXIT"
	Return t1
End Sub