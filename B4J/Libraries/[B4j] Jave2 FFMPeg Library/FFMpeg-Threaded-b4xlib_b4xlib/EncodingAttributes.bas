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
'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize As EncodingAttributes
	Tjo.InitializeNewInstance("ws.schild.jave.encode.EncodingAttributes",Null)
	Return Me
End Sub
'Class is a subclass with no constructor, we need to set the object on which JavaObject will operate.
Public Sub SetObject(Target As JavaObject)
	Tjo = Target
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return Tjo
End Sub
'Returns the attributes for the encoding of the audio stream in the target multimedia file.
Public Sub GetAudioAttributes As AudioAttributes
	Dim O As JavaObject = Tjo.RunMethod("getAudioAttributes",Null)
	Dim AA As AudioAttributes
	AA.Initialize
	If O.RunMethod("isPresent",Null) Then
		AA.SetObject(O.RunMethod("get",Null))
	End If
	Return AA
End Sub
'Number of threads to use for decoding (if supported by codec) -1 means use default of ffmpeg
Public Sub GetDecodingThreads As Int
	Dim O As JavaObject = Tjo.RunMethod("getDecodingThreads",Null)
	If O.RunMethod("isPresent",Null) Then
		Return O.RunMethod("get",Null)
	End If
	Return 0
End Sub
'Returns the duration (seconds) of the re-encoded stream.
Public Sub GetDuration As Float
	Dim O As JavaObject = Tjo.RunMethod("getDuration",Null)
	If O.RunMethod("isPresent",Null) Then
		Return O.RunMethod("get",Null)
	End If
	Return 0
End Sub
'Number of threads to use for encoding (if supported by codec) No value (Optional.empty()) means use default of ffmpeg
Public Sub GetEncodingThreads As Int
	Dim O As JavaObject = Tjo.RunMethod("getEncodingThreads",Null)
	If O.RunMethod("isPresent",Null) Then
		Return O.RunMethod("get",Null)
	End If
	Return 0
End Sub
'Returns any additional user supplied context.
Public Sub GetExtraContext As Map
	Return Tjo.RunMethod("getExtraContext",Null)
End Sub
'*
Public Sub GetFilterThreads As Int
	Dim O As JavaObject = Tjo.RunMethod("getFilterThreads",Null)
	If O.RunMethod("isPresent",Null) Then
		Return O.RunMethod("get",Null)
	End If
	Return 0
End Sub
'Returns the format name for the incoming multimedia file.
Public Sub GetInputFormat As String
	Dim O As JavaObject = Tjo.RunMethod("getInputFormat",Null)
	If O.RunMethod("isPresent",Null) Then
		Return O.RunMethod("get",Null)
	End If
	Return 0
End Sub
'Returns if the input is to be considered for looping.
Public Sub GetLoop As Boolean
	Return Tjo.RunMethod("getLoop",Null)
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return Tjo
End Sub
'Returns the start offset time (seconds).
Public Sub GetOffset As Float
	Dim O As JavaObject = Tjo.RunMethod("getOffset",Null)
	If O.RunMethod("isPresent",Null) Then
		Return O.RunMethod("get",Null)
	End If
	Return 0
End Sub

'Returns the format name for the encoded target multimedia file.
Public Sub GetOutputFormat As String
	Dim O As JavaObject = Tjo.RunMethod("getOutputFormat",Null)
	If O.RunMethod("isPresent",Null) Then
		Return O.RunMethod("get",Null)
	End If
	Return ""
End Sub
'Returns whether or not the encoder will consider file paths "safe".
Public Sub GetSafe As Int
	Dim O As JavaObject = Tjo.RunMethod("getSafe",Null)
	If O.RunMethod("isPresent",Null) Then
		Return O.RunMethod("get",Null)
	End If
	Return 0
End Sub
'Returns the attributes for the encoding of the video stream in the target multimedia file.
Public Sub GetVideoAttributes As VideoAttributes
	Dim VA As VideoAttributes
	VA.Initialize
	Dim O As JavaObject = Tjo.RunMethod("getVideoAttributes",Null)
	If O.RunMethod("isPresent",Null) Then
		 VA.SetObject(O.RunMethod("get",Null))
	End If
	Return VA
End Sub
'*
Public Sub IsMapMetaData As Boolean
	Return Tjo.RunMethod("isMapMetaData",Null)
End Sub
'Sets the attributes for the encoding of the audio stream in the target multimedia file.
Public Sub SetAudioAttributes(TAudioAttributes As AudioAttributes) As EncodingAttributes
	Tjo.RunMethod("setAudioAttributes",Array As Object(TAudioAttributes.GetObject))
	Return Me
End Sub
'Number of threads to use for decoding (if supported by codec) -1 means use default of ffmpeg
Public Sub SetDecodingThreads(DecodingThreads As Int) As EncodingAttributes
	Tjo.RunMethod("setDecodingThreads",Array As Object(DecodingThreads))
	Return Me
End Sub
'Sets the duration (seconds) of the re-encoded stream.
Public Sub SetDuration(Duration As Float) As EncodingAttributes
	Tjo.RunMethod("setDuration",Array As Object(Duration))
	Return Me
End Sub
'Number of threads to use for encoding (if supported by codec) null means use default of ffmpeg
Public Sub SetEncodingThreads(EncodingThreads As Int) As EncodingAttributes
	Tjo.RunMethod("setEncodingThreads",Array As Object(EncodingThreads))
	Return Me
End Sub
'Adds all key/value pairs from context to the extraContext private variable.Meant to be used in conjunction with Encoder.addOptionAtIndex(EncodingArgument, Integer).Add context here and retrieve the context via an EncodingArgument.
Public Sub SetExtraContext(ExtraContext As Map) As EncodingAttributes
	Tjo.RunMethod("setExtraContext",Array As Object(ExtraContext))
	Return Me
End Sub

'ffmpeg uses multiple cores for filtering
Public Sub SetFilterThreads(FilterThreads As Int) As EncodingAttributes
	Tjo.RunMethod("setFilterThreads",Array As Object(FilterThreads))
	Return Me
End Sub
'Sets the format name for the source multimedia file.
Public Sub SetInputFormat(InputFormat As String) As EncodingAttributes
	Tjo.RunMethod("setInputFormat",Array As Object(InputFormat))
	Return Me
End Sub
'Sets if the inputs will be looped or not.
Public Sub SetLoop(TLoop As Boolean) As EncodingAttributes
	Tjo.RunMethod("setLoop",Array As Object(TLoop))
	Return Me
End Sub
'Copy over meta data from original file to new output if possible
Public Sub SetMapMetaData(MapMetaData As Boolean) As EncodingAttributes
	Tjo.RunMethod("setMapMetaData",Array As Object(MapMetaData))
	Return Me
End Sub
'Sets the start offset time (seconds).
Public Sub SetOffset(Offset As Float) As EncodingAttributes
	Tjo.RunMethod("setOffset",Array As Object(Offset))
	Return Me
End Sub
'Sets the format name for the encoded target multimedia file.
Public Sub SetOutputFormat(Format As String) As EncodingAttributes
	Tjo.RunMethod("setOutputFormat",Array As Object(Format))
	Return Me
End Sub
'Are the file paths considered safe: A file path is considered safe if it does not contain a protocol specification and is relative and all components only contain characters from the portable character set (letters, digits, period, underscore and hyphen) and have no period at the beginning of a component.
Public Sub SetSafe(Safe As Int) As EncodingAttributes
	Tjo.RunMethod("setSafe",Array As Object(Safe))
	Return Me
End Sub
'Sets the attributes for the encoding of the video stream in the target multimedia file.
Public Sub SetVideoAttributes(TVideoAttributes As VideoAttributes) As EncodingAttributes
	Tjo.RunMethod("setVideoAttributes",Array As Object(TVideoAttributes.GetObject))
	Return Me
End Sub
