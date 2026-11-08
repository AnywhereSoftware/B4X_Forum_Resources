B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
#IgnoreWarnings:12
'Class Module
Sub Class_Globals
	'Private fx As JFX ' Uncomment if required. For B4j only

	Private Tjo As JavaObject
End Sub

'*
Public Sub Initialize
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	Tjo.InitializeNewInstance("ws.schild.jave.encode.AudioAttributes",Null)
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return Tjo
End Sub
'Returns the bitrate value for the encoding process.
Public Sub GetBitRate As Int
	Dim O As JavaObject = Tjo.RunMethod("getBitRate",Null)
	If O.RunMethod("isPresent",Null) Then
		Return O.RunMethod("get",Null)
	End If
	Return 0
End Sub
'Returns the channels value (1=mono, 2=stereo, 4=quad) for the encoding process.
Public Sub GetChannels As Int
	Dim O As JavaObject = Tjo.RunMethod("getChannels",Null)
	If O.RunMethod("isPresent",Null) Then
		Return O.RunMethod("get",Null)
	End If
	Return 0
End Sub
'Returns the codec name for the encoding process.
Public Sub GetCodec As String
	Dim O As JavaObject = Tjo.RunMethod("getCodec",Null)
	If O.RunMethod("isPresent",Null) Then
		Return O.RunMethod("get",Null)
	End If
	Return ""
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return Tjo
End Sub
'*
Public Sub GetQuality As Int
	Dim O As JavaObject = Tjo.RunMethod("getQuality",Null)
	If O.RunMethod("isPresent",Null) Then
		Return O.RunMethod("get",Null)
	End If
	Return -1
End Sub
'Returns the samplingRate value for the encoding process.
Public Sub GetSamplingRate As Int
	Dim O As JavaObject = Tjo.RunMethod("getSamplingRate",Null)
	If O.RunMethod("isPresent",Null) Then
		Return O.RunMethod("get",Null)
	End If
	Return 0
End Sub
'Returns the volume value for the encoding process.
Public Sub GetVolume As Int
	Dim O As JavaObject = Tjo.RunMethod("getVolume",Null)
	If O.RunMethod("isPresent",Null) Then
		Return O.RunMethod("get",Null)
	End If
	Return -1
End Sub
'Sets the bitrate value for the encoding process.
Public Sub SetBitRate(BitRate As Int) As AudioAttributes
	Tjo.RunMethod("setBitRate",Array As Object(BitRate))
	Return Me
End Sub
'Sets the channels value (1=mono, 2=stereo, 4=quad) for the encoding process.
Public Sub SetChannels(Channels As Int) As AudioAttributes
	Tjo.RunMethod("setChannels",Array As Object(Channels))
	Return Me
End Sub
'Sets the codec name for the encoding process.If null or not specified the encoder will perform a direct stream copy.
Public Sub SetCodec(Codec As String) As AudioAttributes
	Tjo.RunMethod("setCodec",Array As Object(Codec))
	Return Me
End Sub
'The audio quality value for the encoding process.
Public Sub SetQuality(Quality As Int) As AudioAttributes
	Tjo.RunMethod("setQuality",Array As Object(Quality))
	Return Me
End Sub
'Sets the samplingRate value for the encoding process.
Public Sub SetSamplingRate(SamplingRate As Int) As AudioAttributes
	Tjo.RunMethod("setSamplingRate",Array As Object(SamplingRate))
	Return Me
End Sub
'Sets the volume value for the encoding process.
Public Sub SetVolume(Volume As Int) As AudioAttributes
	Tjo.RunMethod("setVolume",Array As Object(Volume))
	Return Me
End Sub
'*
Public Sub ToString As String
	Return Tjo.RunMethod("toString",Null)
End Sub

'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	Tjo = Obj
End Sub

