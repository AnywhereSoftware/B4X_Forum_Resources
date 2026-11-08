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

Public Sub GetMixerInfo As Object()
	'Get a static instance of the AudiSystem class
	Dim AudioSystem As JavaObject
	AudioSystem.InitializeStatic("javax.sound.sampled.AudioSystem")
	Return AudioSystem.RunMethod("getMixerInfo",Null)
End Sub

Public Sub GetMixer(MI As Object) As JavaObject
	Dim AudioSystem As JavaObject
	AudioSystem.InitializeStatic("javax.sound.sampled.AudioSystem")
	Return AudioSystem.RunMethod("getMixer",Array(MI))
End Sub

Public Sub GetTargetDataLine(AudioFormat As Object) As JavaObject
	Dim AudioSystem As JavaObject
	AudioSystem.InitializeStatic("javax.sound.sampled.AudioSystem")
	Return AudioSystem.RunMethod("getTargetDataLine",Array(AudioFormat))
End Sub

Public Sub GetTargetDataLine2(AudioFormat As Object,MixerInfo As Object) As JavaObject
	Dim AudioSystem As JavaObject
	AudioSystem.InitializeStatic("javax.sound.sampled.AudioSystem")
	Return AudioSystem.RunMethod("getTargetDataLine",Array(AudioFormat,MixerInfo))
End Sub

Public Sub NewAudioFormat(SampleRateHz As Float,SampleSizeInBits As Int,ChannelConfig As Int, Signed As Boolean, BigEndian As Boolean) As JavaObject
	Dim AudioFormat As JavaObject
	Return AudioFormat.InitializeNewInstance("javax.sound.sampled.AudioFormat",Array(SampleRateHz,SampleSizeInBits,ChannelConfig, Signed, BigEndian))
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