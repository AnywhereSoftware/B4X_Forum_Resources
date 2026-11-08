B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private Seq As MidiSequence
	Private Seqr As MidiSequencer
	Private btnStop As Button
	Private btnPlay As Button
	
	Private MidiMonitorCV1 As MidiMonitorCV
	Private SeekBar1 As SeekBar
	Private SeqLength As Long
	Private Timer1 As Timer
	Dim Driver As MidiDriver
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
	Timer1.Initialize("Timer1",1000)
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	'Initialize the Sequence and Sequencer
	Seq.Initialize(MidiSequence_Static.DIVTYPE_PPQ,192)

	'Attach the default receiver so we can hear the midi played on the internal synth
	Seqr.Initialize(Seq,Me,"Playing",True)
	
	Dim MR As MidiReceiver = Seqr.Receivers.Get(0)
	
	If MR.IsDefaultDriver Then
		Driver = MR.GetDefaultDriver
		Driver.SetReverb(Driver.REVERB_OFF)
	End If
	
	MidiMonitorCV1.SetSeqr(Seqr)
	'	Initialize the Options Static module and read the initial file path
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

#Region Gui interface clicks

Sub btnStop_Click
	If Timer1.Enabled Then
		Timer1.Enabled = False

		'Stop the sequencer
		Seqr.Stop
		MidiMonitorCV1.Stop
		btnStop.Text = "Rew"
	Else
		If btnStop.Text = "Rew" Then
			SeekBar1.Value = 0
			Seqr.CurrentMillisecondPosition = 0
		End If 
	End If
End Sub

Sub btnPlay_Click
	btnStop.Text = "Pause"
	Seqr.Start
	MidiMonitorCV1.Start
	Timer1.Enabled = True
End Sub
'Respond to a button Load Click
Sub btnLoad_Click
	
	If Initialized(Seq) Then
		MidiMonitorCV1.Stop
		If Seqr.IsRunning Then
			Seqr.Stop
			Seqr.CurrentMillisecondPosition = 0
			SeekBar1.Value = 0
		End If
		
	End If
	
	Dim Chooser As ContentChooser
	Chooser.Initialize("CC")
	Chooser.Show("audio/midi","Choose Midi")
	
	Wait For CC_Result (Success As Boolean, Dir As String, FileName As String)
	
	If Success Then	
		DoLoad(Dir,FileName)
	End If
End Sub
#End Region Gui interface clicks

'The Actual load Sub
Sub DoLoad(FilePath As String,FileName As String)
	'Load the midi file into a sequence
	Dim Seq As MidiSequence = MidiSystem_Static.GetSequence(FilePath,FileName,False)
	SeqLength = Seq.GetMillisecondLength
	
	'Pass the sequence to the sequencer
	Seqr.SetSequence(Seq)
	btnPlay.Enabled = True
End Sub

Private Sub Timer1_Tick
	SeekBar1.Value = (Seqr.CurrentMillisecondPosition / SeqLength) * 1000
End Sub

Private Sub SeekBar1_ValueChanged (Value As Int, UserChanged As Boolean)
	If UserChanged Then	
		MidiMonitorCV1.ClearIndicators
		Seqr.CurrentMillisecondPosition = (SeqLength / 1000) * Value
	End If
End Sub


Private Sub rbReverb_CheckedChange(Checked As Boolean)
	If Initialized(Driver) Then
		Driver.SetReverb(Sender.As(B4XView).Tag)
	End If
End Sub
