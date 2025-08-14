B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.3
@EndOfDesignText@
'Class module
'@SLHideClass
Sub Class_Globals
	Private mReceiver As MidiReceiver
	Private mMidiDeviceInfo As MidiDeviceInfo

End Sub

'Initializes the object.
'@SLHide
Public Sub Initialize(MDI As MidiDeviceInfo)

End Sub
'@SLHide
Sub setFriendlyName(Name As String)
	mMidiDeviceInfo.FriendlyName = Name
End Sub
'@SLHide
Sub getFriendlyName As String
	Return mMidiDeviceInfo.FriendlyName
End Sub
'@SLHide
Sub getReceiver As MidiReceiver
	Return mReceiver
End Sub