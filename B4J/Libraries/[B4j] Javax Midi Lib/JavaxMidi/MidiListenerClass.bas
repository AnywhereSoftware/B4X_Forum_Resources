B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.51
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
	Private mCallback As Object
	Private mEventName As String
End Sub


Public Sub Initialize(Callback As Object, EventName As String)
	mCallback = Callback
	mEventName = EventName
End Sub

Public Sub getCallback As Object
	Return mCallback
End Sub

Public Sub setCallback(Callback As Object)
	mCallback = Callback
End Sub

Public Sub getEventName As String
	Return mEventName
End Sub

Public Sub setEventName(EventName As String)
	mEventName = EventName
End Sub