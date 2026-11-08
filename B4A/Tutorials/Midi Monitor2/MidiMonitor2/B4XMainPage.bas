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
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	'Initialize the Sequence and Sequencer
	Seq.Initialize(MidiSequence_Static.DIVTYPE_PPQ,192)
	'Attach the default receiver so we can hear the midi played on the internal synth
	Seqr.Initialize(Seq,Me,"Playing",True)
	MidiMonitorCV1.SetSeqr(Seqr)
	'	Initialize the Options Static module and read the initial file path
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

#Region Gui interface clicks

Sub btnStop_Click
	'Stop the sequencer
	MidiMonitorCV1.Stop
	Seqr.Stop
	btnPlay.Enabled = True
End Sub

Sub btnPlay_Click
	'Start the sequencer from the beginning of the sequence
	Seqr.CurrentMillisecondPosition = 0
	Seqr.Start
	MidiMonitorCV1.Start
End Sub
'Respond to a button Load Click
Sub btnLoad_Click
	
	If Initialized(Seq) Then
		MidiMonitorCV1.Stop
		If Seqr.IsRunning Then Seqr.Stop
		btnPlay.Enabled = True
	End If
	
	Dim Chooser As ContentChooser
	Chooser.Initialize("CC")
	Chooser.Show("audio/midi","Choose Midi")
	
	Wait For CC_Result (Success As Boolean, Dir As String, FileName As String)
	
	If Success Then	DoLoad(Dir,FileName)
End Sub
#End Region Gui interface clicks

'The Actual load Sub
Sub DoLoad(FilePath As String,FileName As String)
	'Load the midi file into a sequence
	Dim Seq As MidiSequence = MidiSystem_Static.GetSequence(FilePath,FileName,False)
	'Pass the sequence to the sequencer
	Seqr.SetSequence(Seq)
	btnPlay.Enabled = True
End Sub