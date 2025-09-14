B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Public Const DEVICETYPE_INPUT As String = "input"
	Public Const DEVICETYPE_OUTPUT As String = "output"
End Sub

Public Sub NewAudioFormat(SampleRateHz As Float,SampleSizeInBits As Int,ChannelConfig As Int, Signed As Boolean, BigEndian As Boolean) As JavaObject
	Dim AudioFormat As JavaObject
	Return AudioFormat.InitializeNewInstance("javax.sound.sampled.AudioFormat",Array(SampleRateHz,SampleSizeInBits,ChannelConfig, Signed, BigEndian))
End Sub

Public Sub NewAudioInputStream(InpStream As InputStream,AudioFormat As JavaObject,Length As Long) As JavaObject
	Dim AIS As JavaObject
	Return AIS.InitializeNewInstance("javax.sound.sampled.AudioInputStream",Array(InpStream,AudioFormat,Length))
End Sub

Public Sub NewAudioInputStreamFromBytes(Bytes() As Byte, AudioFormat As JavaObject) As JavaObject
	Dim Length As Long = Bytes.Length / ((AudioFormat.RunMethod("getSampleSizeInBits",Null) / 8) * AudioFormat.RunMethod("getChannels",Null))
	Dim InpStream As InputStream
	InpStream.InitializeFromBytesArray(Bytes,0,Bytes.Length)
	Return NewAudioInputStream(InpStream,AudioFormat,Length)
End Sub

'Obtains an array of mixer info objects that represents the set of audio mixers that are currently installed on the system.
Public Sub GetMixerInfo As Object()
	'Get a static instance of the AudiSystem class
	Dim AudioSystem As JavaObject
	AudioSystem.InitializeStatic("javax.sound.sampled.AudioSystem")
	Return AudioSystem.RunMethod("getMixerInfo",Null)
End Sub

'Obtains the requested audio mixer.
Public Sub GetMixer(MI As Object) As JavaObject
	Dim AudioSystem As JavaObject
	AudioSystem.InitializeStatic("javax.sound.sampled.AudioSystem")
	Return AudioSystem.RunMethod("getMixer",Array(MI))
End Sub

'Obtains a clip from the specified mixer that can be used for playing back an audio file or an audio stream.
Public Sub GetClip(MixerInfo As JavaObject) As ClipWrapper
	Dim AudioSystem As JavaObject
	AudioSystem.InitializeStatic("javax.sound.sampled.AudioSystem")
	Dim Wrapper As ClipWrapper
	Wrapper.Initialize
	Wrapper.SetObject(AudioSystem.RunMethod("getClip",Array(MixerInfo)))
	Return Wrapper
End Sub

'Obtains an audio input stream from the provided File.
Public Sub GetAudioInputStream(DirName As String, FileName As String) As JavaObject
	'Code for File Object Creation
	Dim TFile As JavaObject
	TFile.InitializeNewInstance("java.io.File",Array(DirName,FileName))

	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("javax.sound.sampled.AudioSystem")
	Return TJO1.RunMethod("getAudioInputStream",Array As Object(TFile))
End Sub

'Obtains an audio input stream from the provided input stream.
Public Sub GetAudioInputStream2(Stream As InputStream) As JavaObject
	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("javax.sound.sampled.AudioSystem")
	Return TJO1.RunMethod("getAudioInputStream",Array As Object(Stream))
End Sub
'Obtains an audio input stream from the URL provided.
Public Sub GetAudioInputStream3(Url As String) As JavaObject
	Dim URLObj As JavaObject
	URLObj.InitializeNewInstance("java.net.URL",Array(Url))
	Log(URLObj)
	Dim TJO1 As JavaObject
	TJO1.InitializeStatic("javax.sound.sampled.AudioSystem")
	Return TJO1.RunMethod("getAudioInputStream",Array As Object(URLObj))
End Sub
'Obtains an audio input stream from an Array of Bytes.
Public Sub GetAudioInputStream4(Bytes() As Byte) As JavaObject
	Dim InpStream As InputStream
	InpStream.InitializeFromBytesArray(Bytes,0,Bytes.Length)
	Return GetAudioInputStream2(InpStream)
End Sub

'Obtains a source data line that can be used for playing back audio data in the format specified by the AudioFormat object.
Public Sub GetSourceDataLine(AudioFormat As Object) As JavaObject
	Dim AudioSystem As JavaObject
	AudioSystem.InitializeStatic("javax.sound.sampled.AudioSystem")
	Return AudioSystem.RunMethod("getSourceDataLine",Array(AudioFormat))
End Sub

'Obtains a source data line that can be used for playing back audio data in the format specified by the AudioFormat object, provided by the mixer specified by the Mixer.Info object.
Public Sub GetSourceDataLine2(AudioFormat As Object,MixerInfo As Object) As JavaObject
	Dim AudioSystem As JavaObject
	AudioSystem.InitializeStatic("javax.sound.sampled.AudioSystem")
	Return AudioSystem.RunMethod("getSourceDataLine",Array(AudioFormat,MixerInfo))
End Sub

Public Sub ConvertMillisecondsToString(t As Long) As String
	Dim hours, minutes, seconds As Int
	hours = t / DateTime.TicksPerHour
	minutes = (t Mod DateTime.TicksPerHour) / DateTime.TicksPerMinute
	seconds = (t Mod DateTime.TicksPerMinute) / DateTime.TicksPerSecond
	Return $"$1.0{hours}:$2.0{minutes}:$2.0{seconds}"$
End Sub


'Returns a list of available devices, filtered by filter.  Pass an empty string for all.
'DType should be one of the DEVICETYPE constants
Public Sub GetDevices(DType As String,Filter As String) As List
	
	'Instance of this class so we can call inline java
	Dim CallJava As JavaObject = Me
	
	Dim Result As List
	Result.Initialize
	
	'Get the appropriate class for the device type.  Input or output
	Dim ClassName As String
	If DType.ToLowerCase = DEVICETYPE_INPUT Then
		ClassName = "TargetDataLine"
	Else If DType.ToLowerCase = DEVICETYPE_OUTPUT Then
		ClassName = "SourceDataLine"
	Else
		Log("Invalid device " & DType)
		Return Result
	End If
	
	Dim Class As JavaObject
	Class.InitializeStatic("java.lang.Class")
	Dim ThisLineClass As Object = Class.RunMethod("forName",Array($"javax.sound.sampled.${ClassName}"$))
	
	'Get a Line.Info instance for this dataline type.
	Dim LineInfo1 As JavaObject
	LineInfo1.InitializeNewInstance("javax.sound.sampled.Line.Info",Array(ThisLineClass))

	'Get a list Mixer.Ifo objects of all Mixers available on the system
	Dim MixerInfoList() As Object = GetMixerInfo
	
	For Each MI As JavaObject In MixerInfoList
		'Filter the names if needed.  An empty string will always match
		If MI.RunMethod("getName",Null).As(String).ToLowerCase.Contains(Filter.ToLowerCase) Then
			Dim M As JavaObject = GetMixer(MI)
			
			'Check if the required DataLine is supported by the mixer.
			'This has to be done with inline java as not all mixer classes inherit methods from the javax.sound.sampled.Mixer class
			'so needs to be explicitly cast. I'm not totally sure why.
			If CallJava.RunMethod("isLineSupported",Array(M,LineInfo1)) Then
				'Add to the list
				Result.Add(MI)
			End If
		End If
	Next
	
	Return Result
End Sub

#If java
import javax.sound.sampled.Line;
import javax.sound.sampled.Mixer;
import javax.sound.sampled.LineUnavailableException;

public static boolean isLineSupported(Mixer m, Line.Info targetLineInfo) throws LineUnavailableException{
	 Boolean found;
	 m.open();
	 found = m.isLineSupported(targetLineInfo);
	 m.close();
	 return found;
}
#End If