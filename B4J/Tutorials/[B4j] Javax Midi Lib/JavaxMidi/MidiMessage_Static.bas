B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=5.9
@EndOfDesignText@
'Static code module, Uses DuckTyping to access Midimessages of any type
Sub Process_Globals
	Private fx As JFX
End Sub

'Creates a new object of the same class and with the same contents as this object.
Public Sub Clone(Msg As JavaObject) As Object
	Return Msg.RunMethod("clone",Null)
End Sub
'Obtains the total length of the MIDI message in bytes.
Public Sub GetLength(Msg As JavaObject) As Int
	Return Msg.RunMethod("getLength",Null)
End Sub
'Obtains the MIDI message data.
Public Sub GetMessage(Msg As JavaObject) As Byte()
	Return Msg.RunMethod("getMessage",Null)
End Sub
'Obtains the status byte for the MIDI message.
Public Sub GetStatus(Msg As JavaObject) As Int
	Return Msg.RunMethod("getStatus",Null)
End Sub
'Sets the data for the MIDI message.
Public Sub SetMessage(Msg As JavaObject, bdata() As Byte, ThisLength As Int)
	Msg.RunMethod("setMessage",Array As Object(bdata, ThisLength))
End Sub
Public Sub GetTypeName(Msg As Object) As String
	If Msg Is MidiMessage Then

		If CallSub(Msg,"IsShortMessage") Then
			Dim SM As MidiShortMessage
			SM.Initialize
			SM.SetObject(Msg)
			Return MidiTypeNames_Static.Name(SM.GetStatus)
			
		else If CallSub(Msg,"IsMidiMetaMessage") Then
			Dim MM As MidiMetaMessage
			MM.Initialize
			MM.SetObject(Msg)
			Return MidiTypeNames_Static.Name(MM.GetMessage(1))

		Else If CallSub(Msg,"IsSysexMessage") Then
			Return MidiTypeNames_Static.Name(SM.GetStatus)
		End If
	
	else If Msg Is MidiShortMessage Then
		Dim SM As MidiShortMessage
		SM.Initialize
		SM.SetObject(Msg)
		Return MidiTypeNames_Static.Name(SM.GetStatus)
		
	Else If Msg Is MidiMetaMessage Then
		Return MidiTypeNames_Static.Name(MM.GetMessage(1))
		
	Else If Msg Is MidiSysexMessage Then
		Return MidiTypeNames_Static.Name(SM.GetStatus)
	End If
	
	Return ""
End Sub