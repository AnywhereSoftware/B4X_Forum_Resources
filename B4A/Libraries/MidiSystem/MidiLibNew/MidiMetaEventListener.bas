B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.3
@EndOfDesignText@
'Class module
#Event: MetaEvent(Event As MidiEvent)
Sub Class_Globals
	Private mModule As Object
	Private mEventName As String


End Sub

'Initializes the object.
Public Sub Initialize(Module As Object,EventName As String)
	mModule = Module
	mEventName = EventName

End Sub
Sub SendMessage(Event As MidiEvent)
	If SubExists(mModule,mEventName & "_MetaEvent") Then CallSub2(mModule,mEventName & "_MetaEvent",Event)
End Sub
