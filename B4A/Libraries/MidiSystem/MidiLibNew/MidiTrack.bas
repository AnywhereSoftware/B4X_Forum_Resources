B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.3
@EndOfDesignText@
'Class module

#IgnoreWarnings: 12

Sub Class_Globals
	Private mEventList As List
	Private EventMap As Map
	Private mReadError As String
	Private EOTEvent As MidiEvent
	Private mEventLock As Lock
	Dim EOT As MidiMessage
End Sub

'Initializes the object.
Public Sub Initialize
	mEventList.Initialize
	EventMap.Initialize
	mEventLock.Initialize(False)
	EOT.Initialize
	EOT.setMetaMessage(MidiMessage_Static.META_EOT,Array As Byte(),0)
	EOTEvent.Initialize(EOT,0)
	mEventList.Add(EOTEvent)

End Sub
Sub Add(Event As MidiEvent) As Boolean
	
	If EventMap.ContainsKey(Event) Then Return False

	mEventLock.Wait
	
	
	Dim EventsCount As Int = mEventList.Size
	Dim LastEvent As MidiEvent
	If EventsCount > 0 Then
		 LastEvent = mEventList.Get(EventsCount - 1)
	End If
	'Sanity check that we have a correct end-of-track
	If Not(LastEvent.IsInitialized) OR LastEvent <> EOTEvent Then
		If EventsCount > 0 Then
			EOTEvent.Tick = LastEvent.Tick
		Else
			EOTEvent.Tick = 0
		End If
		mEventList.Add(EOTEvent)
		EventsCount = mEventList.Size
	End If
'	Log("____________________________")
'	Log("MT EM " & Event.Message.Message(1) & " " & MidiUtils.IsMetaEndOfTrack(Event.Message))
	If MidiUtils.IsMetaEndOfTrack(Event.Message) Then
		'Since End of track Event Is useful
		'For delays at the End of a track, we want To keep
		'the tick value requested here If it Is greater
		'than the one on the EOT we are maintaining.
		'Otherwise, we only want a single EOT Event, so ignore.
		If Event.Tick > EOTEvent.Tick Then EOTEvent.Tick = Event.Tick
		mEventLock.Unlock
		Return True
	End If
	
	EventMap.Put(Event,"")
	
	'insert Event such that events Is sorted In increasing
	'tick order
	For i = EventsCount -1 To 0 Step -1
		Dim Evt As MidiEvent = mEventList.Get(i)
		If Event.Tick >= Evt.Tick Then Exit
	Next
	
	If i = EventsCount - 1 Then
		'We're adding an event after the
        'tick value of our EOT, so push the EOT out.
        'Always Add at the End For better performance when possible:
		mEventList.Set(EventsCount -1,Event)
		If EOTEvent.Tick < Event.Tick Then EOTEvent.Tick = Event.Tick
		mEventList.Add(EOTEvent)
	Else
		mEventList.InsertAt(i + 1,Event)
	End If
	
	mEventLock.Unlock

	Return True
End Sub
Sub Remove(Event As MidiEvent) As Boolean
	
	If EventMap.Remove(Event) = Null Then Return False
	
	mEventLock.Wait
	Dim Pos As Int = mEventList.IndexOf(Event)
	If Pos > -1 Then
		mEventList.RemoveAt(Pos)
		If mEventList.Size > 1 Then
			Dim Evt As MidiEvent = mEventList.Get(mEventList.Size - 2)
			EOTEvent.Tick = Evt.Tick
		Else
			EOTEvent.Tick = 0
		End If
		mEventLock.Unlock
		Return True
	End If
	
	MidiLibUtils.ThrowException("Track Remove : Event in Set but not in list")
	mEventLock.Unlock
	Return False
End Sub
'Get an event idetified by its order index
Sub Get(Index As Int) As MidiEvent
	Return mEventList.Get(Index)
End Sub
'Get the number events in this track.
Sub getSize As Int
	Return mEventList.Size
End Sub
'Get the length of the track in MIDI ticks.
Sub getTicks As Long
	If mEventList.Size > 0 Then
		Dim Event As MidiEvent = mEventList.Get(mEventList.Size-1)
		Return Event.Tick
	Else
		Return 0
	End If
End Sub
'@SLHide
Sub setReadError (ReadError As String)
	mReadError = ReadError
End Sub
'@SLHide
Sub getReadError As String
	Return mReadError
End Sub
Sub getEventList As List
	Return mEventList
End Sub
'@SLHide
Sub getEventLock As Lock
	Return mEventLock
End Sub