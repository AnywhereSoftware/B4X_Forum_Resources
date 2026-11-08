B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.3
@EndOfDesignText@
'#ExcludeFromDebugger: True
#IgnoreWarnings: 12
'Class module
'@SLHideClass
Sub Class_Globals
	Dim EventList As List	
	Dim TH As Thread										'Ignore
	Type MidiEventInfo(Event As MidiEvent,Listeners As List)
End Sub

'Initializes the object.
'@SLHide
Public Sub Initialize
	EventList.Initialize
	TH.Initialise("Despatch")
End Sub
'@SLHide
Private Sub Start
	If Not(TH.Running) Then TH.Start(Me,"Dispatch",Null)
End Sub
'@SLHide
Private Sub Dispatch
	Dim TimeOut As Long = 20000
	Dim LastTime As Long = DateTime.Now
	Do While DateTime.Now - LastTime < TimeOut
	
		If EventList.Size > 0 Then
			Dim EventInf As MidiEventInfo = EventList.get(0)
			EventList.RemoveAt(0)
			ProcessEvent(EventInf)
			LastTime = DateTime.Now
		End If
	Loop
End Sub
'@SLHide
Private Sub ProcessEvent(EventInf As MidiEventInfo)

	Dim Count As Int = EventInf.Listeners.Size
	
	'Process a Meta Message
	If EventInf.Event.Message.MessageType = MidiMessage_Static.TYPE_METAMESSAGE Then
		For i = 0 To Count - 1
			Dim Listener As MidiMetaEventListener = EventInf.Listeners.Get(i)
			TH.RunOnGuiThread("SendMessage",Array As Object(Listener,EventInf.Event))
		Next
		Return
	End If

	If EventInf.Event.Message.MessageType = MidiMessage_Static.TYPE_SHORTMESSAGE Then
		Dim Status As Int = EventInf.Event.Message.Status
		If Bit.And(Status,0xF0) = 0xB0 Then
			For i = 0 To Count - 1
				Dim CListener As MidiControllerEventListener = EventInf.Listeners.Get(i)
				TH.RunOnGuiThread("SendControllerMessage",Array As Object(CListener,EventInf.Event))
			Next
		End If
	End If
End Sub
'@SLHide
Sub SendAudioEvents(Event As MidiEvent,Listeners As List)
	Dim EventInf As MidiEventInfo
	EventInf.Event = Event
	EventInf.Listeners = Listeners
	Start
	PostEvents(EventInf)
End Sub
'@SLHide
Private Sub PostEvents(Event As MidiEventInfo)
	EventList.Add(Event)
End Sub
'@SLHide
Private Sub SendMessage(Listener As MidiMetaEventListener,Event As MidiEvent)
	Listener.SendMessage(Event)
End Sub
'@SLHide
Private Sub SendControllerMessage(Listener As MidiControllerEventListener,Event As MidiEvent)
	Listener.SendMessage(Event)
End Sub