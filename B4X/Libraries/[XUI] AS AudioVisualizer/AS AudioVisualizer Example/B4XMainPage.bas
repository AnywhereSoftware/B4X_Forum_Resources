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
	
	#If B4I
	Private recorder As AudioRecorder
	#Else If B4A
	Private rp As RuntimePermissions
	Private AR As AudioRecord
	#End If
	Private recording As Boolean

	Private AS_AudioVisualizer1 As AS_AudioVisualizer
	Private B4XComboBox1 As B4XComboBox
	Private B4XComboBox2 As B4XComboBox
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XComboBox1.SetItems(Array As String("Spectrum","Waveform","FilledWave"))
	B4XComboBox2.SetItems(Array As String("1.0","1.1","1.2","1.3","1.4","1.5","1.6","1.7","1.8","1.9","2.0"))
	
	
	#If B4A
	rp.CheckAndRequest(rp.PERMISSION_RECORD_AUDIO)
	
	Wait For Activity_PermissionResult (Permission As String, Result As Boolean)
	If Permission = rp.PERMISSION_RECORD_AUDIO Then
		Log("Permission OK")
	End If
	#End If
	
End Sub


Private Sub xlbl_Start_Click
	#If B4I
	Dim FileName As String = "recording.m4a"
	Dim Dir As String = File.DirTemp
	recorder.Initialize(Dir,FileName, 44100, True, 16, False)
	recorder.As(NativeObject).SetField("meteringEnabled", True)
	recorder.Record
	recording = True
	Dim nRecorder As NativeObject = recorder
	Do While recording
		nRecorder.RunMethod("updateMeters", Null)
		Sleep(40)
		If recording Then
			'Log(nRecorder.RunMethod("averagePowerForChannel:", Array(0)).AsNumber)
			Dim dbValue As Double = nRecorder.RunMethod("averagePowerForChannel:", Array(0)).AsNumber
			AS_AudioVisualizer1.UpdateWithDB(dbValue)
		End If

	Loop
	#Else If B4A
	
	Dim BufferSize As Int
	Dim SampleRate As Int = 44100
	Dim ChannelConfig As Int = AR.Ch_Conf_Mono
	Dim AudioFormat As Int = AR.Af_PCM_16
	Dim AudioSource As Int = AR.A_Src_Mic
	BufferSize = AR.GetMinBufferSize(SampleRate, ChannelConfig, AudioFormat)
	
	AR.Initialize(AudioSource, SampleRate, ChannelConfig, AudioFormat, BufferSize)
	AR.StartRecording
	
	recording = True

	Do While recording
		Sleep(40)
		If recording Then
			' Read the PCM buffer as a Short array
			Dim samples() As Short = AR.ReadShort(0, BufferSize)
        
			' Calculate the sum of the squared samples
			Dim sum As Double = 0
			For i = 0 To samples.Length - 1
				sum = sum + samples(i) * samples(i)
			Next
        
			' Calculate the RMS (Root Mean Square) value
			Dim rms As Double = Sqrt(sum / samples.Length)
        
			' Reference value: maximum 16-bit value
			Dim refValue As Double = 32767
        
			' Calculate the dB value (dBFS) using the logarithm function (number, base)
			Dim dbValue As Double
			If rms > 0 Then
				dbValue = 20 * Logarithm(rms / refValue, 10)
			Else
				dbValue = -120 ' Minimum value for silence
			End If
        
			' Pass the calculated dB value to the visualizer
			AS_AudioVisualizer1.UpdateWithDB(dbValue)
		End If
	Loop
	
	#End If
End Sub

Private Sub xlbl_Stop_Click
	recording = False
	#If B4I
	recorder.Stop
	#Else If B4A
	AR.Stop
	#End If
End Sub

Private Sub B4XComboBox1_SelectedIndexChanged (Index As Int)
	AS_AudioVisualizer1.VisualizationType = B4XComboBox1.GetItem(Index)
End Sub

Private Sub B4XComboBox2_SelectedIndexChanged (Index As Int)
	AS_AudioVisualizer1.Sensitivity = B4XComboBox2.GetItem(Index)
End Sub