B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
'Parent class using duck typing for CaptureRaw and CaptureToFile so the two can be switched,
'If you only want to use one method, you can access it directly.

Sub Class_Globals
	Private mCallBack As Object
	Private mEventName As String
	Private Method As Object
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(CapMethod As String,CallBack As Object,EventName As String,Threaded As Boolean)
	mCallBack = CallBack
	mEventName = EventName
	
	If CapMethod = Capture_Static.CAPTURE_FILE Then
		If Threaded Then
			Dim CFT As CaptureToFile_TH
			CFT.Initialize(mCallBack,mEventName)
			Method = CFT
		Else
			Dim CF As CaptureToFile
			CF.Initialize(mCallBack,mEventName)
			Method = CF
		End If
	Else
		If Threaded Then
			Dim CRT As CaptureRaw_TH
			CRT.Initialize(mCallBack,mEventName)
			Method = CRT
		Else
			Dim CR As CaptureRaw
			CR.Initialize(mCallBack,mEventName)
			Method = CR
		End If
	End If
	
End Sub

Public Sub Start(DataLine1 As TargetDataLineWrapper, FilePath As String)
	CallSub3(Method,"Start",DataLine1,FilePath)
End Sub

'Only really required for the demo project, but may be useful if using both capture methods
Public Sub CaptureType As String
	Return CallSub(Method,"CaptureType")
End Sub

'Return the recorded data buffer as a byte array
Public Sub GetBuffer As Byte()
	Return CallSub(Method,"GetBuffer")
End Sub

'Stop recording
Public Sub Stop
	CallSub(Method,"Stop")
End Sub


'Is this method currently recording
Public Sub IsRecording As Boolean
	Return CallSub(Method,"IsRecording")
End Sub

'Add a listener for the amplitude calculation to be returned to the calling class or module
Public Sub AddAmplitudeListener(CallBack As Object, EventName As String)
	CallSub3(Method,"AddAmplitudeListener",CallBack,EventName)
End Sub