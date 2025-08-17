B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.47
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
	Private mCallBack As Object
	Private mEventName As String
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(pCallBack As Object,pEventName As String)
	mCallBack = pCallBack
	mEventName = pEventName
End Sub

Public Sub getCallBack As Object
	Return mCallBack
End Sub
Public Sub getEventName As String
	Return mEventName
End Sub