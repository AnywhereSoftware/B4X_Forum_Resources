Type=Class
Version=7.3
ModulesStructureVersion=1
B4A=true
@EndOfDesignText@
#Event: TaskCancelled(ValueReached as Long)
#Event: TaskComplete(ValueReached as Long)
#Event: TaskProgress(PercentProgress as Int)

Sub Class_Globals
	Private mAsyncTask As AsyncTask
	Private mEventName As String
	Private mParent As Object
End Sub

public Sub Cancel(MayInterruptIfRunning As Boolean)
	mAsyncTask.Cancel(MayInterruptIfRunning)
End Sub

Public Sub Initialize(Parent As Object, EventName As String)
	mAsyncTask.Initialize("mAsyncTask")
	mEventName=EventName
	mParent=Parent
End Sub

'	execute the async task, start counting from zero up to the Target value
public Sub Execute(Target As Long, PublishProgress As Boolean)
	mAsyncTask.Execute(Array As Object(Target, PublishProgress))
End Sub

private Sub mAsyncTask_Cancelled(Result As Object)
	'	this sub is called on the Main UI thread
	'	adding this callback sub is optional
	Log("mAsyncTask_Cancelled")
	
	Dim ValueReached As Long=Result
	RaiseEvent("TaskCancelled", ValueReached)
End Sub

private Sub mAsyncTask_DoInBackground(Params() As Object) As Object
	'	this sub is called on a background thread
	'	any other methods called from this method will execute in the same background thread
	'	do not attempt to update the UI from this sub
	'	adding this callback sub is NOT optional
	Log("mAsyncTask_DoInBackground")
	
	Dim PercentProgress As Int=0
	Dim PublishProgress As Boolean=Params(1)
	Dim Start As Long=0
	Dim Stop As Long=Params(0)
	
	Do While Start<Stop And Not(mAsyncTask.IsCancelled)
		Start=Start+1
		Dim NewPercentProgress As Int=(Start/Stop)*100
		If PublishProgress And PercentProgress<>NewPercentProgress Then
			'	publish periodical progress
			PercentProgress=NewPercentProgress
			mAsyncTask.PublishProgress(Array As Object(PercentProgress))
		End If
	Loop
	
	Dim Result As Object=Start
	Return Result
End Sub

private Sub mAsyncTask_PostExecute(Result As Object)
	'	this sub is called on the Main UI thread
	'	adding this callback sub is optional
	Log("mAsyncTask_PostExecute")
	
	'	the AsyncTask library is compatible with android API 13+
	'	if you are targetting older versions of the API then apply this (commented out) workaround before executing any further code in this sub:
	
'	If mAsyncTask.IsCancelled Then
'		mAsyncTask_Cancelled(Result)
'		Return
'	End If
	
	Dim ValueReached As Long=Result
	RaiseEvent("TaskComplete", ValueReached)
End Sub

private Sub mAsyncTask_PreExecute
	'	this sub is called on the Main UI thread
	'	adding this callback sub is optional
	Log("mAsyncTask_PreExecute")
End Sub

private Sub mAsyncTask_ProgressUpdate(Progress() As Object)
	'	this sub is called on the Main UI thread
	'	adding this callback sub is optional
	Log("mAsyncTask_ProgressUpdate")
	
	Dim PercentProgress As Int=Progress(0)
	RaiseEvent("TaskProgress", PercentProgress)
End Sub

private Sub RaiseEvent(Event As String, Value As Object)
	Dim EventName As String=mEventName&"_"&Event
	If SubExists(mParent, EventName) Then
		CallSub2(mParent, EventName, Value)
	Else
		Log("Ignoring event "&EventName&" as no callback sub SubExists")
	End If
End Sub