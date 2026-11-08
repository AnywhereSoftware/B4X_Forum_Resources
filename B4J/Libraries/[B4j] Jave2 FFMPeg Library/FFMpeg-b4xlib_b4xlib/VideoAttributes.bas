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
	Public Const VSYNC_AUTO As String = "AUTO"
	Public Const VSYNC_CFR As String = "CFR"
	Public Const VSYNC_DROP As String = "DROP"
	Public Const VSYNC_PASSTHROUGH As String = "PASSTHROUGH"
	Public Const VSYNC_VFR As String = "VFR"
	
	Public Const X264_PROFILE_BASELINE As String = "BASELINE"
	Public Const X264_PROFILE_HIGHE As String = "HIGH"
	Public Const X264_PROFILE_HGIH10 As String = "HIGH10"
	Public Const X264_PROFILE_HIGH422 As String = "HIGH422"
	Public Const X264_PROFILE_HIGH444 As String = "HIGH444"
	Public Const X264_PROFILE_MAIN As String = "MAIN"
	
	Private Tjo As JavaObject
End Sub

'*
Public Sub Initialize
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	Tjo.InitializeNewInstance("ws.schild.jave.encode.VideoAttributes",Null)
End Sub

'*
Public Sub AddFilter(VideoFilter As JavaObject)
	Tjo.RunMethod("addFilter",Array As Object(VideoFilter))
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
'Returns the codec name for the encoding process.
Public Sub GetCodec As String
	Dim O As JavaObject = Tjo.RunMethod("getCodec",Null)
	If O.RunMethod("isPresent",Null) Then
		Return O.RunMethod("get",Null)
	End If
	Return ""
End Sub
'*
Public Sub GetComplexFiltergraph As JavaObject
	Dim O As JavaObject = Tjo.RunMethod("getComplexFiltergraph",Null)
	If O.RunMethod("isPresent",Null) Then
		Return O.RunMethod("get",Null)
	End If
	Return Null
End Sub
'Returns the frame rate value for the encoding process.
Public Sub GetFrameRate As Int
	Dim O As JavaObject = Tjo.RunMethod("getFrameRate",Null)
	If O.RunMethod("isPresent",Null) Then
		Return O.RunMethod("get",Null)
	End If
	Return 0
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return Tjo
End Sub
'*
Public Sub GetPixelFormat As String
	Dim O As JavaObject = Tjo.RunMethod("getPixelFormat",Null)
	If O.RunMethod("isPresent",Null) Then
		Return O.RunMethod("get",Null)
	End If
	Return ""
End Sub
'*
Public Sub GetQuality As Int
	Dim O As JavaObject = Tjo.RunMethod("getQuality",Null)
	If O.RunMethod("isPresent",Null) Then
		Return O.RunMethod("get",Null)
	End If
	Return 0
End Sub
'Returns the video size for the encoding process.
Public Sub GetSize As VideoSize
	Dim VS As VideoSize
	VS.Initialize
	Dim O As JavaObject = Tjo.RunMethod("getSize",Null)
	If O.RunMethod("isPresent",Null) Then
		VS.SetObject(O.RunMethod("get",Null))
	End If
	Return VS
End Sub
'Returns the the forced tag/fourcc value for the video stream.
Public Sub GetTag As String
	Dim O As JavaObject = Tjo.RunMethod("getTag",Null)
	If O.RunMethod("isPresent",Null) Then
		Return O.RunMethod("get",Null)
	End If
	Return ""
End Sub
'*
Public Sub GetVideoFilters As List
	Return Tjo.RunMethod("getVideoFilters",Null)
End Sub
'*
Public Sub GetVsync As JavaObject
	Dim O As JavaObject = Tjo.RunMethod("getVsync",Null)
	If O.RunMethod("isPresent",Null) Then
		Return O.RunMethod("get",Null)
	End If
	Return Null
End Sub
'*
Public Sub GetX264Profile As JavaObject
	Dim O As JavaObject = Tjo.RunMethod("getX264Profile",Null)
	If O.RunMethod("isPresent",Null) Then
		Return O.RunMethod("get",Null)
	End If
	Return Null
End Sub
'*
Public Sub IsFaststart As Boolean
	Return Tjo.RunMethod("isFaststart",Null)
End Sub
'Sets the bitrate value for the encoding process.
Public Sub SetBitRate(BitRate As Int) As VideoAttributes
	Tjo.RunMethod("setBitRate",Array As Object(BitRate))
	Return Me
End Sub
'Sets the codec name for the encoding process.
Public Sub SetCodec(Codec As String) As VideoAttributes
	Tjo.RunMethod("setCodec",Array As Object(Codec))
	Return Me
End Sub
'*
Public Sub SetComplexFiltergraph(ComplexFiltergraph As JavaObject) As VideoAttributes
	Tjo.RunMethod("setComplexFiltergraph",Array As Object(ComplexFiltergraph))
	Return Me
End Sub
'*
Public Sub SetFaststart(Faststart As Boolean) As VideoAttributes
	Tjo.RunMethod("setFaststart",Array As Object(Faststart))
	Return Me
End Sub
'Sets the frame rate value for the encoding process.
Public Sub SetFrameRate(FrameRate As Int) As VideoAttributes
	Tjo.RunMethod("setFrameRate",Array As Object(FrameRate))
	Return Me
End Sub
'*
Public Sub SetPixelFormat(PixelFormat As String) As VideoAttributes
	Tjo.RunMethod("setPixelFormat",Array As Object(PixelFormat))
	Return Me
End Sub
'The video quality value for the encoding process.
Public Sub SetQuality(Quality As Int) As VideoAttributes
	Tjo.RunMethod("setQuality",Array As Object(Quality))
	Return Me
End Sub
'Sets the video size for the encoding process.
Public Sub SetSize(Size As VideoSize) As VideoAttributes
	Tjo.RunMethod("setSize",Array As Object(Size.GetObject))
	Return Me
End Sub
'Sets the forced tag/fourcc value for the video stream.
Public Sub SetTag(Tag As String) As VideoAttributes
	Tjo.RunMethod("setTag",Array As Object(Tag))
	Return Me
End Sub
'Vsync should be one of the VSYNC_ constants
Public Sub SetVsync(Vsync As String) As VideoAttributes
	Tjo.RunMethod("setVsync",Array As Object(Vsync))
	Return Me
End Sub
'*
Public Sub SetX264Profile(X264Profile As JavaObject) As VideoAttributes
	Tjo.RunMethod("setX264Profile",Array As Object(X264Profile))
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