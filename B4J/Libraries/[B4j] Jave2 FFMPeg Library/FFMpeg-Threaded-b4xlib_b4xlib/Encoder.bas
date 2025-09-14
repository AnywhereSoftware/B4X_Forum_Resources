B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
#IgnoreWarnings:12
#Event: Event(MethodName,Args() as Object)
#Event: Complete(EndedOK as Boolean, Error As string)

'Class Module
Sub Class_Globals
	'Private fx As JFX ' Uncomment if required. For B4j only

	Private Tjo As JavaObject
	'You may need to remove this if another class has already defined it.
	Private mCallback As Object
	Private mEventName As String
End Sub

'It builds an encoder using a DefaultFFMPEGLocator instance to locate the ffmpeg executable to use.
Public Sub Initialize(Callback As Object, EventName As String) As Encoder
	mCallback = Callback
	mEventName = EventName
	Tjo.InitializeNewInstance("ws.schild.jave.Encoder",Null)
	Return Me
End Sub

'Force the encoding process to stop
Public Sub AbortEncoding
	Tjo.RunMethod("abortEncoding",Null)
End Sub
'*
Public Sub AddOptionAtIndex(Arg As JavaObject, Index As JavaObject)
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("ws.schild.jave.Encoder")
	Tjo1.RunMethod("addOptionAtIndex",Array As Object(Arg, Index))
End Sub
'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return Tjo
End Sub
'Re-encode a multimedia file(s). Not threaded, will NOT call complete event.
Public Sub Encode(SourceMultimediaObject As MultimediaObject,TargetDirName As String, TargeFileName As String, Attributes As EncodingAttributes)
	'Code for File Object Creation
	Dim Target As JavaObject
	Target.InitializeNewInstance("java.io.File",Array(TargetDirName,TargeFileName))

	Tjo.RunMethod("encode",Array As Object(SourceMultimediaObject.GetObject, Target, Attributes.GetObject))
End Sub
'Concatenate multiple files. Source files must be in compatible formats. Not threaded, will NOT call complete event.
Public Sub Encode2(SourceMultimediaObjects As List,TargetDirName As String, TargeFileName As String, Attributes As EncodingAttributes)
	'Code for File Object Creation
	Dim Target As JavaObject
	Target.InitializeNewInstance("java.io.File",Array(TargetDirName,TargeFileName))
	Tjo.RunMethod("encode",Array As Object(UnwrapList(SourceMultimediaObjects), Target, Attributes.GetObject))
End Sub
'Re-encode a multimedia file. - Threaded will call complete event when finished
Public Sub Encode3(SourceMultimediaObject As MultimediaObject,TargetDirName As String, TargeFileName As String, Attributes As EncodingAttributes)
	'Code for File Object Creation
	Dim Target As JavaObject
	Target.InitializeNewInstance("java.io.File",Array(TargetDirName,TargeFileName))
	
	Dim Listener As Object = Tjo.CreateEventFromUI("ws.schild.jave.progress.EncoderProgressListener", "Listener" ,Null)
	
	Dim Args() As Object = Array As Object(SourceMultimediaObject.GetObject, Target, Attributes.GetObject, Listener)
	Dim TH As Thread		'Ignore
	TH.Initialise("TH")
	TH.Start(Me,"Encode_Thread",Args)
	
End Sub

'Concatenate multiple files. Source files must be in compatible formats. Threaded will call complete event when finished
Public Sub Encode4(SourceMultimediaObjects As List,TargetDirName As String, TargeFileName As String, Attributes As EncodingAttributes)
	'Code for File Object Creation
	Dim Target As JavaObject
	Target.InitializeNewInstance("java.io.File",Array(TargetDirName,TargeFileName))
	
	Dim Listener As Object = Tjo.CreateEventFromUI("ws.schild.jave.progress.EncoderProgressListener", "Listener" ,Null)
	
	Dim Args() As Object = Array As Object(UnwrapList(SourceMultimediaObjects), Target, Attributes.GetObject, Listener)
	Dim TH As Thread		'Ignore
	TH.Initialise("TH")
	TH.Start(Me,"Encode_Thread",Args)
	
End Sub

Private Sub Listener_Event(MethodName As String,Args() As Object)
	If SubExists(mCallback, mEventName & "_Event") Then CallSubDelayed3(mCallback, mEventName & "_Event",MethodName,Args)
End Sub

Private Sub Encode_Thread(SourceMultimediaObject As Object,Target As Object, Attributes As Object, Listener As Object)
	Tjo.RunMethod("encode",Array As Object(SourceMultimediaObject, Target, Attributes, Listener))
	
End Sub

Private Sub TH_Ended(endedOK As Boolean, error As String) 'The thread has terminated. If endedOK is False error holds the reason for failure
	If SubExists(mCallback,mEventName & "_Complete") Then CallSubDelayed3(mCallback,mEventName & "_Complete",endedOK,error)
End Sub

'Returns a list with the names of all the audio decoders bundled with the ffmpeg distribution in use.
Public Sub GetAudioDecoders As String()
	Return Tjo.RunMethod("getAudioDecoders",Null)
End Sub
'Returns a list with the names of all the audio encoders bundled with the ffmpeg distribution in use.
Public Sub GetAudioEncoders As String()
	Return Tjo.RunMethod("getAudioEncoders",Null)
End Sub

'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return Tjo
End Sub
'Returns a list with the names of all the file formats supported at decoding time by the underlying ffmpeg distribution.
Public Sub GetSupportedDecodingFormats As String()
	Return Tjo.RunMethod("getSupportedDecodingFormats",Null)
End Sub
'Returns a list with the names of all the file formats supported at encoding time by the underlying ffmpeg distribution.
Public Sub GetSupportedEncodingFormats As String()
	Return Tjo.RunMethod("getSupportedEncodingFormats",Null)
End Sub
'Return the list of unhandled output messages of the ffmpeng encoder run
Public Sub GetUnhandledMessages As List
	Return Tjo.RunMethod("getUnhandledMessages",Null)
End Sub
'Returns a list with the names of all the video decoders bundled with the ffmpeg distribution in use.
Public Sub GetVideoDecoders As String()
	Return Tjo.RunMethod("getVideoDecoders",Null)
End Sub
'Returns a list with the names of all the video encoders bundled with the ffmpeg distribution in use.
Public Sub GetVideoEncoders As String()
	Return Tjo.RunMethod("getVideoEncoders",Null)
End Sub
'*
Public Sub RemoveOptionAtIndex(Index As JavaObject)
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("ws.schild.jave.Encoder")
	Tjo1.RunMethod("removeOptionAtIndex",Array As Object(Index))
End Sub
'*
Public Sub SetOptionAtIndex(Arg As JavaObject, Index As JavaObject)
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("ws.schild.jave.Encoder")
	Tjo1.RunMethod("setOptionAtIndex",Array As Object(Arg, Index))
End Sub
'*
Public Sub SetOptionAtIndex2(Index As JavaObject) As JavaObject
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("ws.schild.jave.Encoder")
	Return Tjo1.RunMethod("setOptionAtIndex",Array As Object(Index))
End Sub

'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	Tjo = Obj
End Sub

Private Sub UnwrapList(L As List) As List
	Dim L1 As List
	L1.Initialize
	For Each T As Object In L
		L1.Add(CallSub(T,"GetObject"))
	Next
	Return L1
End Sub