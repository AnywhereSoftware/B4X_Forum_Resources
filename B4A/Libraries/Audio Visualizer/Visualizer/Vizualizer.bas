B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=3.8
@EndOfDesignText@
'Class module
#IgnoreWarnings: 12

Sub Class_Globals
	Private Viz As JavaObject	
	Private mModule As Object
	Private mPnl As Panel
	Private WV As WavDraw
	Private DoWavDraw As Boolean
	Type PeakRMS(mPeak As Int,mRMS As Int)

End Sub
'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Module As Object,AudioSession As Int)
	mModule = Module
	
	Viz.InitializeNewInstance("android.media.audiofx.Visualizer",Array As Object(AudioSession))
End Sub
'Registers an OnDataCaptureListener interface and specifies the rate at which the capture should be updated as well as the type of capture requested.
'Rate	rate In milliHertz at which the capture should be updated
'WaveForm	True If a waveform capture Is requested: the onWaveFormDataCapture() method will be called on the OnDataCaptureListener interface.
'FFT	True If a frequency capture Is requested: the onFftDataCapture() method will be called on the OnDataCaptureListener interface.
'Returns
'SUCCESS (0) In Case of success, ERROR_NO_INIT (-3) OR ERROR_BAD_VALUE (-4) In Case of failure.
Sub SetDataCaptureListener(Rate As Int,WaveForm As Boolean,FFT As Boolean) As Int
	Dim Listener As Object = Viz.CreateEvent("android.media.audiofx.Visualizer.OnDataCaptureListener","ondatacapture",Null)
	Return Viz.RunMethod("setDataCaptureListener",Array As Object(Listener,Rate,WaveForm,FFT))
End Sub
'Stop Data Capture
Sub StopDataCapture
	If DoWavDraw Then 
		WV.Stop
		DoWavDraw = False
	End If
	Viz.RunMethod("setDataCaptureListener",Array As Object(Null,0,False,False))
End Sub
'Get / Set the capture buffer size i.e. the number of bytes returned by getWaveForm(byte[]) and getFft(byte[]) methods. 
'The capture size must be a Power of 2 In the range returned by getCaptureSizeRange(). This method must Not be called when the Visualizer Is enabled.
Sub getCaptureSize As Int
	Return Viz.RunMethod("getCaptureSize",Null)
End Sub
Sub setCaptureSize(Size As Int)
	Viz.RunMethod("setCaptureSize",Array As Object(Size))
End Sub
'Returns the capture size range.
Sub getCaptureSizeRange As Int()
	Return Viz.RunMethod("getCaptureSizeRange",Null)
End Sub
'Get / Set the Vizualizers enabled status
Sub getEnabled As Boolean
	Return Viz.RunMethod("getEnabled",Null)
End Sub
Sub setEnabled(Enable As Boolean)
	Viz.RunMethod("setEnabled",Array As Object(Enable))
End Sub
'Get the sampled waveform
Sub getWaveForm As Byte()
	Dim WF(getCaptureSize) As Byte
	Viz.RunMethod("getWaveForm",Array As Object(WF))
	Return WF
End Sub
'Returns a frequency capture of currently playing audio content.
Sub getFft As Byte()
	Dim FFT(getCaptureSize) As Byte
	Viz.RunMethod("getFft",Array As Object(FFT))
	Return FFT
End Sub
'Returns the maximum capture rate For the callback capture method.
Sub getMaxCaptureRate As Int
	Dim V As JavaObject
	V.InitializeStatic("android.media.audiofx.Visualizer")
	Return V.RunMethod("getMaxCaptureRate",Null)
End Sub
'Returns the current measurement modes performed by this audio effect
Sub getMeasurementMode As Int
	Return Viz.RunMethod("getMeasurementMode",Null)
End Sub
'Retrieves the latest peak AND RMS measurement.
Sub getMeasurementPeakRms As PeakRMS
	Dim PRMS As JavaObject
	PRMS.InitializeNewInstance("android.media.audiofx.Visualizer.MeasurementPeakRms",Null)
	Viz.RunMethod("getMeasurementPeakRms",Array(PRMS))
	Dim Result As PeakRMS
	Result.mPeak = PRMS.GetField("mPeak")
	Result.mRMS = PRMS.GetField("mRms")
	Return Result
End Sub
'Returns the sampling rate of the captured audio.
Sub getSamplingRate As Int
	Return Viz.RunMethod("getSamplingRate",Null)
End Sub
'Returns the current scaling mode on the captured visualization data.
Sub getScalingMode As Int
	Return Viz.RunMethod("getScalingMode",Null)
End Sub
'Releases the native Visualizer resources.
Sub Release
	Viz.RunMethod("release",Null)
End Sub
'Sets the combination of measurement modes To be performed by this audio effect.
Sub setMeasurementMode(Mode As Int)
	Viz.RunMethod("setMeasurementMode",Array As Object(Mode))
End Sub
'Set the Type of scaling applied on the captured visualization data.
Sub setScalingMode(Mode As Int)
	Viz.RunMethod("setScalingMode",Array As Object(Mode))
End Sub
'Callback for OnDataCapture
Sub ondatacapture_Event(MethodName As String,Args() As Object) As Object
	Dim Data(getCaptureSize) As Byte = Args(1)
	Dim SamplingRate As Int = Args(2)
	Select MethodName
		Case "onFftDataCapture"
			If SubExists(mModule,"FFT_Capture") Then
				CallSub3(mModule,"FFT_Capture",Data,SamplingRate)
			End If
		Case "onWaveFormDataCapture"
			If DoWavDraw Then WV.Wave_Capture(Data,SamplingRate)
			If SubExists(mModule,"Wave_Capture") Then
				CallSub3(mModule,"Wave_Capture",Data,SamplingRate)
			End If
	End Select
	Return True
End Sub
'Initialize for wave form drawing
Sub DrawWavFormInitialize(Pnl As Panel)
	mPnl = Pnl
	WV.Initialize(Me,Pnl)
End Sub
'Start drawing the wave form
Sub DrawWaveFormStart
	DoWavDraw = True
	WV.Start
End Sub
'Stop drawing the wave form
Sub DrawWaveFormStop
	DoWavDraw = False
	WV.Stop
End Sub
'Get / Set the zoom level for the waveform
Sub setDrawWavZoom(Value As Float)
	WV.Zoom = Value
End Sub
Sub getDrawWaveZoom As Float
	Return WV.Zoom
End Sub
'Get / Set the amplitude for the wave form drawing
Sub getDrawWaveGain As Int
	Return WV.Gain
End Sub
Sub setDrawWaveGain(Value As Int)
	WV.Gain = Value
End Sub
'Set the wav form drawing color
Sub setDrawWavColor(Color As Int)
	WV.Color = Color
End Sub