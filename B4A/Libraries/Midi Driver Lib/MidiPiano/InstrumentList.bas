B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=4
@EndOfDesignText@
'Class module
Sub Class_Globals
	Private mLbl As Label
	Private pnlBG As Panel
	Private lvInstList As ListView
	Private mPno As Piano
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Act As Activity,Pno As Piano,Lbl As Label,Left As Int,Top As Int,Width As Int,Height As Int)
	mPno = Pno
	mLbl = Lbl
	Act.LoadLayout("InstList")
	pnlBG.SetLayout(Left,0,Width,Act.Height)
	
	'Set up the listview layout
	lvInstList.SetLayout(2Dip,2Dip,pnlBG.Width - 4,pnlBG.Height - 4)
	lvInstList.SingleLineLayout.Label.Height = 25Dip
	lvInstList.SingleLineLayout.Label.TextSize = 20

	'Initialize the GeneralMidi Code Module and load the patchnames to the ListView
	MidiGeneralMidi_Static.Initialize
	For Each key As String In MidiGeneralMidi_Static.GetPatchNames
		lvInstList.AddSingleLine2(key,MidiGeneralMidi_Static.GetProgNo(key))
	Next
	'Set the Current or default patch
	mLbl.Text = MidiGeneralMidi_Static.GetProgName(Main.Program)
	SendProgramChange(Main.Program)
End Sub
'Set
Private Sub lvInstList_ItemClick (Position As Int, Value As Object)
	
	'Set the Global in main so it can be remembered after a program pause
	Main.Program = Value
	
	'Send the patch change message for the selected patch to the midi driver
	SendProgramChange(Value)
	Hide

End Sub
Sub SendProgramChange(Value As Int)
	'Set the selected patchname in the label
	mLbl.Text = MidiGeneralMidi_Static.GetProgName(Value)
	Dim Msg() As Byte = Array As Byte(0xC0 + mPno.Channel,Value)
	mPno.Midi.SendMidi(Msg)
End Sub
'Show the instrument list
Sub Show
	pnlBG.Visible = True
	pnlBG.BringToFront
End Sub
'Hide the instrument list
Sub Hide
	pnlBG.Visible = False
End Sub
'Returns the current visibility of the Instrument List
Sub Visible As Boolean
	Return pnlBG.Visible
End Sub