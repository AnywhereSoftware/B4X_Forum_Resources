B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7.3
@EndOfDesignText@
'Code module
'Subs in this code module will be accessible from all modules.

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Private mRTS As MidiRealTimeSequencer
	Private mInitialized As Boolean
End Sub
'@SLHide
'Initialize the Sequencer Receiver
Public Sub Initialize(RTS As MidiRealTimeSequencer)
	mRTS = RTS
	mInitialized = False
End Sub
'For use when recording to a sequence by the SequenceReceiver or user developed transmitters
Sub Send(Message As MidiMessage, TimeStamp As Long)
	If mRTS.IsRecording Then
		Dim TickPos As Long
		
		If TimeStamp < 0 Then
			TickPos = mRTS.GetTickPosition
		Else
			TickPos = MidiUtils.Microsecond2Tick(mRTS.GetSequence,TimeStamp)
		End If
		
		Dim T As MidiTrack
		If Message.Length > 1 Then
			'do not record real-time events
			If Message.MessageType = MidiMessage_Static.TYPE_SHORTMESSAGE Then
				'all real-time messages have 0xF in the high nibble of the status byte
				If Bit.AND(Message.Status,0xF0) <> 0XF0 Then
					T = MidiRecordingTrack_Static.getTrack(mRTS.RecordingTracks,Message.ShortMessageChannel)
				End If
			Else
				T = MidiRecordingTrack_Static.getTrack(mRTS.RecordingTracks,-1)
			End If
			If T.IsInitialized Then
				If Message.MessageType = MidiMessage_Static.TYPE_SHORTMESSAGE Then
					Dim M As MidiMessage
					M.Initialize
					M.FASTShortMessage(Message.getMessage)
				Else
					Dim M As MidiMessage = Message.Clone
				End If
				Dim MEvt As MidiEvent
				MEvt.Initialize(M,TickPos)
				T.Add(MEvt)
			Else
				Log("Recording Track not found for channel " & Message.ShortMessageChannel)
			End If
		End If
	End If
End Sub
'@SLHide
Sub IsInitialized As Boolean
	Return mInitialized
End Sub