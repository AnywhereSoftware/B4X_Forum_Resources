B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.01
@EndOfDesignText@
'Class module
'version 1.20
'See this page for the list of constants:
'http://developer.android.com/intl/fr/reference/android/hardware/Camera.Parameters.html
'Note that you should use the constant values instead of the names.
Sub Class_Globals
	Private nativeCam As Object
	Private cam As Camera
	Private r As Reflector
	Private target As Object
	Private event As String
	Public Front As Boolean
	Type CameraInfoAndId (CameraInfo As Object, Id As Int)
	Type CameraSize (Width As Int, Height As Int)
	Private parameters As Object
	
	Dim DispRotation As Int	'JCP: we can retrieve it from Main
	Dim PreviewWidth As Int
	Dim PreviewHeight As Int
	
End Sub

Public Sub Initialize (Panel1 As Panel, FrontCamera As Boolean, TargetModule As Object, EventName As String)
	target = TargetModule
	event = EventName
	Front = FrontCamera
	Dim id As Int
	id = FindCamera(Front).id
	If id = -1 Then
		Front = Not(Front) 'try different camera
		id = FindCamera(Front).id
		If id = -1 Then
			ToastMessageShow("No camera found.", True)
			Return
		End If
	End If
	cam.Initialize2(Panel1, "camera", id)
End Sub

Private Sub FindCamera (frontCamera As Boolean) As CameraInfoAndId
	Dim ci As CameraInfoAndId
	Dim cameraInfo As Object
	Dim cameraValue As Int
	If frontCamera Then cameraValue = 1 Else cameraValue = 0
	cameraInfo = r.CreateObject("android.hardware.Camera$CameraInfo")
	Dim numberOfCameras As Int = r.RunStaticMethod("android.hardware.Camera", "getNumberOfCameras", Null, Null)
	For i = 0 To numberOfCameras - 1
		r.RunStaticMethod("android.hardware.Camera", "getCameraInfo", Array As Object(i, cameraInfo), _
			Array As String("java.lang.int", "android.hardware.Camera$CameraInfo"))
		r.target = cameraInfo
		If r.GetField("facing") = cameraValue Then 
			ci.cameraInfo = r.target
			ci.Id = i
			Return ci
		End If
	Next
	ci.id = -1
	Return ci
End Sub

Private Sub SetDisplayOrientation
	r.target = r.GetActivity
	r.target = r.RunMethod("getWindowManager")
	r.target = r.RunMethod("getDefaultDisplay")
	r.target = r.RunMethod("getRotation")
	Dim previewResult, result, degrees As Int = r.target * 90
	Dim ci As CameraInfoAndId = FindCamera(Front)
	r.target = ci.CameraInfo
	Dim orientation As Int = r.GetField("orientation")
	If Front Then
		previewResult = (orientation + degrees) Mod 360
		result = previewResult
		previewResult = (360 - previewResult) Mod 360
	Else
		previewResult = (orientation - degrees + 360) Mod 360
		result = previewResult
		Log(previewResult)
	End If
	r.target = nativeCam
	r.RunMethod2("setDisplayOrientation", previewResult, "java.lang.int")
	r.target = parameters
	r.RunMethod2("setRotation", result, "java.lang.int")
	CommitParameters
	
	DispRotation = degrees	'JCP: added
End Sub

Private Sub Camera_Ready (Success As Boolean)
	If Success Then
		r.target = cam
		nativeCam = r.GetField("camera")
		r.target = nativeCam
		parameters = r.RunMethod("getParameters")
		SetDisplayOrientation
	Else
		Log("success = false, " & LastException)
	End If
	
	GetPreviewSize		'JCP: added
	
	CallSub2(target, event & "_ready", Success)
End Sub

Sub Camera_Preview (Data() As Byte)
	If SubExists(target, event & "_preview") Then
		CallSub2(target, event & "_preview", Data)
	End If
End Sub
Public Sub TakePicture
	cam.TakePicture
End Sub

Private Sub Camera_PictureTaken (Data() As Byte)
	CallSub2(target, event & "_PictureTaken", Data)
End Sub

Public Sub StartPreview
	cam.StartPreview
End Sub

Public Sub StopPreview
	cam.StopPreview
End Sub

Public Sub Release

	cam.Release
End Sub

'Saves the data received from PictureTaken event
Public Sub SavePictureToFile(Data() As Byte, Dir As String, FileName As String)
	Dim out As OutputStream = File.OpenOutput(Dir, FileName, False)
	out.WriteBytes(Data, 0, Data.Length)
	out.Close
End Sub

Public Sub SetParameter(Key As String, Value As String)
	r.target = parameters
	r.RunMethod3("set", Key, "java.lang.String", Value, "java.lang.String")
End Sub

Public Sub GetParameter(Key As String) As String
	r.target = parameters
	Return r.RunMethod2("get", Key, "java.lang.String")
End Sub

Public Sub CommitParameters
	Try
		r.target = nativeCam
		r.RunMethod4("setParameters", Array As Object(parameters), Array As String("android.hardware.Camera$Parameters"))
	Catch
		ToastMessageShow("Error setting parameters.", True)
		Log(LastException)
	End Try
End Sub

Public Sub GetColorEffect As String
	Return GetParameter("effect")
End Sub

Public Sub SetColorEffect(Effect As String)
	SetParameter("effect", Effect)
End Sub

Public Sub GetSupportedPicturesSizes As CameraSize()
	r.target = parameters
	Dim list1 As List = r.RunMethod("getSupportedPictureSizes")
	Dim cs(list1.Size) As CameraSize
	For i = 0 To list1.Size - 1
		r.target = list1.Get(i)
		cs(i).Width = r.GetField("width")
		cs(i).Height = r.GetField("height")
	Next
	Return cs
End Sub

Public Sub GetSupportedPreviewSizes As CameraSize()
	r.target = parameters
	Dim list1 As List = r.RunMethod("getSupportedPreviewSizes")
	Dim cs(list1.Size) As CameraSize
	For i = 0 To list1.Size - 1
		r.target = list1.Get(i)
		cs(i).Width = r.GetField("width")
		cs(i).Height = r.GetField("height")
	Next
	Return cs
End Sub


Public Sub SetPictureSize(Width As Int, Height As Int)
	r.target = parameters
	r.RunMethod3("setPictureSize", Width, "java.lang.int", Height, "java.lang.int")
End Sub

Public Sub SetJpegQuality(Quality As Int)
	r.target = parameters
	r.RunMethod2("setJpegQuality", Quality, "java.lang.int")
End Sub

Public Sub SetFlashMode(Mode As String)
	r.target = parameters
	r.RunMethod2("setFlashMode", Mode, "java.lang.String")
End Sub

Public Sub GetFlashMode As String
	r.target = parameters
	Return r.RunMethod("getFlashMode")
End Sub

Public Sub GetSupportedFlashModes As List
	r.target = parameters
	Return r.RunMethod("getSupportedFlashModes")
End Sub

Public Sub GetSupportedColorEffects As List
	r.target = parameters
	Return r.RunMethod("getSupportedColorEffects")
End Sub

Public Sub GetPreviewSize As CameraSize
	r.target = parameters
	r.target = r.RunMethod("getPreviewSize")
	Dim cs As CameraSize
	cs.Width = r.GetField("width")
	cs.Height = r.GetField("height")
	
	PreviewWidth = cs.Width		' JCP: added
	PreviewHeight = cs.Height
	
	Return cs
End Sub

Public Sub SetPreviewSize(width As Int, height As Int)
	r.target = parameters
	r.target = r.RunMethod3("setPreviewSize",width,"java.lang.int",height,"java.lang.int")
	PreviewWidth=width
	PreviewHeight=height
End Sub

Public Sub GetPictureSize As CameraSize
	r.target = parameters
	r.target = r.RunMethod("getPictureSize")
	Dim cs As CameraSize
	cs.Width = r.GetField("width")
	cs.Height = r.GetField("height")
	Return cs
End Sub
#if 0
'Converts a preview image formatted in YUV format to JPEG.
'Note that you should not save every preview image as it will slow down the whole process.
Public Sub PreviewImageToJpeg(data() As Byte, quality As Int) As Byte()
	Dim size, previewFormat As Object
	r.target = parameters
	size = r.RunMethod("getPreviewSize")
	previewFormat = r.RunMethod("getPreviewFormat")
	r.target = size
	Dim width = r.GetField("width"), height = r.GetField("height") As Int
	Dim yuvImage As Object = r.CreateObject2("android.graphics.YuvImage", _
		Array As Object(data, previewFormat, width, height, Null), _
		Array As String("[B", "java.lang.int", "java.lang.int", "java.lang.int", "[I"))
	r.target = yuvImage
	Dim rect1 As Rect
	rect1.Initialize(0, 0, r.RunMethod("getWidth"), r.RunMethod("getHeight"))
	Dim out As OutputStream
	out.InitializeToBytesArray(100)
	r.RunMethod4("compressToJpeg", Array As Object(rect1, quality, out), _
		Array As String("android.graphics.Rect", "java.lang.int", "java.io.OutputStream")) 
	Return out.ToBytesArray
End Sub
#end if
Public Sub GetSupportedFocusModes As List
    r.target = parameters
    Return r.RunMethod("getSupportedFocusModes")
End Sub

Public Sub SetContinuousAutoFocus
    Dim modes As List = GetSupportedFocusModes
    If modes.IndexOf("continuous-picture") > -1 Then
        SetFocusMode("continuous-picture")
    Else If modes.IndexOf("continuous-video") > -1 Then
        SetFocusMode("continuous-video")
    Else
        Log("Continuous focus mode is not available")
    End If
End Sub

Public Sub SetFocusMode(Mode As String)
    r.target = parameters
    r.RunMethod2("setFocusMode", Mode, "java.lang.String")
End Sub

Public Sub GetFocusDistances As Float()
	Dim F(3) As Float
	r.target = parameters
	r.RunMethod4("getFocusDistances", Array As Object(F), Array As String("[F"))
	Return F
End Sub
'This method should only be called if you need to immediately release the camera.
'For example if you need to start another application that depends on the camera.
Public Sub CloseNow
	cam.Release
	r.target = cam
	r.RunMethod2("releaseCameras", True, "java.lang.boolean")
End Sub
'Calls AutoFocus and then takes the picture if focus was successfull.
Public Sub FocusAndTakePicture
	cam.AutoFocus
End Sub
Private Sub Camera_FocusDone (Success As Boolean)
	If Success Then
		TakePicture
	Else
		Log("AutoFocus error.")
	End If
End Sub



