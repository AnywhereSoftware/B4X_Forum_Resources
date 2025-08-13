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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	
	Private spectrLeft As B4XView
	Private spectrRight As B4XView

	Private VolumeLab As Label
	Private Scene As B4XSeekBar
	Private SceneLab As Label
	Private TrackLab As Label
	Private BPlayPause As Button
	
	Private MT As ModuleTracker
	Private CurrentTrack As Int

	Private Const Icon_Play As String = "▶"
	Private Const Icon_Pause As String = "⏸"
	
	
	Private PlayList() As String = Array As String("external.xm", "_first_last_.mod", "0-wily.xm", "ybblub.s3m", "99_little_windows.xm" )
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	' For Debug (delete this)
	#if b4j 
	'Dim f As Form = B4XPages.GetNativeParent(Me) : f.WindowTop = -800
	#End If
	' ********* 
	
	MT.Initialize(Me, "MT", spectrLeft, spectrRight)
	Play(0)
End Sub


Sub Play(track As Int)
	Dim Inter As Int = 1
	If MT.ReadyModule = True Then Inter = MT.Interpolation
	
	MT.LoadModule(File.DirAssets, PlayList(track))
	MT.Interpolation = Inter
	
	B4XPages.SetTitle(Me, "Demo TrackerBox. Song: " & MT.SongName)
	
	Scene.Value = 0
	Scene.MaxValue = MT.SequenceLength - 1
	SceneLab.Text = "0 / " & (MT.sequenceLength - 1)
	
	TrackLab.Text = (track+1) & " / " & PlayList.Length
End Sub

Sub MT_Row(pos As Int)
	If pos = 0 Then
		Sleep(0)
		BRight_Click
	Else
		Scene.Value = pos
		SceneLab.Text = pos & " / " & (MT.sequenceLength - 1)
	End If
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Volume_ValueChanged (Value As Int)
	VolumeLab.Text = (Value/10) & "%" 
	MT.Volume = Value
End Sub

Private Sub Scene_ValueChanged (Value As Int)
	If Scene.Tag = True Then MT.SequencePos = Value
	SceneLab.Text = Value & " / " & (MT.SequenceLength - 1)
End Sub

Private Sub Scene_TouchStateChanged (Pressed As Boolean)
	Scene.Tag = Pressed
End Sub

Private Sub BLeft_Click
	CurrentTrack = CurrentTrack - 1
	If CurrentTrack < 0 Then CurrentTrack = PlayList.Length - 1
	Play(CurrentTrack)
End Sub

Private Sub BRight_Click
	CurrentTrack = CurrentTrack + 1
	If CurrentTrack > (PlayList.Length - 1) Then CurrentTrack = 0
	Play(CurrentTrack)
End Sub

Private Sub BPlayPause_Click
	If BPlayPause.Text = Icon_Play Then
		BPlayPause.Text = Icon_Pause
		MT.PlayModule
	Else
		BPlayPause.Text = Icon_Play
		MT.PauseModule
	End If
End Sub

Private Sub BStop_Click
	MT.PauseModule
	Scene.Value = 0
	MT.sequencePos = 0
	BPlayPause.Text = Icon_Play
End Sub

Private Sub ReverbSw_ValueChanged (Value As Boolean)
	If Value = True Then
		MT.Reverb = 50 ' Ms
	Else 
		MT.Reverb = 0
	End If
End Sub

#if b4j 
Private Sub RInt0_SelectedChange(Selected As Boolean)
	If Selected = True Then MT.Interpolation = 0 ' no
End Sub
Private Sub RInt1_SelectedChange(Selected As Boolean)
	If Selected = True Then MT.Interpolation = 1 ' linear
End Sub
Private Sub RInt2_SelectedChange(Selected As Boolean)
	If Selected = True Then MT.Interpolation = 2 ' sinc
End Sub
#else
Private Sub RInt0_CheckedChange(Selected As Boolean)
	If Selected = True Then MT.Interpolation = 0 ' no
End Sub
Private Sub RInt1_CheckedChange(Selected As Boolean)
	If Selected = True Then MT.Interpolation = 1 ' linear
End Sub
Private Sub RInt2_CheckedChange(Selected As Boolean)
	If Selected = True Then MT.Interpolation = 2 ' sinc
End Sub
#End If