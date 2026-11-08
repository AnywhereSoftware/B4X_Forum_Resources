B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.3
@EndOfDesignText@
'Version: 1.32
Sub Class_Globals
	Public Camera As Camera2
	Private jcamera As JavaObject
	Private id As String
	Private mFront As Boolean = False
	Public PreviewSize, CaptureSize As CameraSize
	Public PreviewSettingsMap, CaptureSettingMap As Map
	Private bothMaps As List
	Private mPanel As Panel
	Private tv As View
	Private StaticCaptureRequest As JavaObject
	Private StaticCameraCharacteristics As JavaObject
	Private StaticCaptureResult As JavaObject
	Private AF_STATE As List = Array("INACTIVE", "PASSIVE_SCAN", "PASSIVE_FOCUSED", "ACTIVE_SCAN", "FOCUSED_LOCKED", "NOT_FOCUSED_LOCKED", "PASSIVE_UNFOCUSED")
	Private FLASH_STATE As List = Array("UNAVAILABLE", "CHARGING", "READY", "FIRED", "PARTIAL") 'ignore
	'auto exposure
	Private AF_MODE As List = Array("OFF", "AUTO", "MACRO", "CONTINUOUS_VIDEO", "CONTINUOUS_PICTURE", "EDOF")
	'flash
	Private AE_MODE As List = Array("OFF", "ON", "ON_AUTO_FLASH", "ON_ALWAYS_FLASH", "ON_AUTO_FLASH_REDEYE")
	Private FLASH_MODE As List = Array("OFF", "SINGLE", "TORCH")
	Private SCENE_MODE As List = Array("DISABLED", "FACE_PRIORITY", "ACTION", "PORTRAIT", "LANDSCAPE", "NIGHT", "PORTRAIT", "THEATRE", "BEACH", "SNOW", "SUNSET", _
		"STEADYPHOTO", "FIREWORKS", "SPORTS", "PARTY", "CANDLELIGHT", "BARCODE", "HIGH_SPEED_VIDEO", "MODE_HDR", "FACE_PRIORITY_LOW_LIGHT")
	Private EFFECT_MODE As List = Array("OFF", "MONO", "NEGATIVE", "SOLARIZE", "SEPIA", "POSTERIZE", "WHITEBOARD", "BLACKBOARD", "AQUA")
	Private SUPPORTED_HARDWARE_LEVEL As List = Array("LIMITED", "FULL", "LEGACY", "LEVEL_3") 
	Private CONTROL_MODE As List = Array("OFF", "AUTO", "USE_SCENE_MODE", "OFF_KEEP_STATE")
	Public PrintKeys As Boolean = False
	Private PreviewRequest As JavaObject
	Private FocusState As String
	Private MediaRecorder As JavaObject
	Public RecordingVideo As Boolean
	Public TaskIndex As Int = 1
End Sub

Public Sub Initialize (CameraPanel As Panel)
	mPanel = CameraPanel
	Camera.Initialize("Camera")
	jcamera = Camera
	PreviewSize.Initialize(640, 480)
	CaptureSize.Initialize(1920, 1080)
	StaticCaptureRequest.InitializeStatic("android.hardware.camera2.CaptureRequest")
	StaticCameraCharacteristics.InitializeStatic("android.hardware.camera2.CameraCharacteristics")
	StaticCaptureResult.InitializeStatic("android.hardware.camera2.CaptureResult")
	PreviewSettingsMap.Initialize
	CaptureSettingMap.Initialize
	bothMaps = Array(PreviewSettingsMap, CaptureSettingMap)
End Sub

'Opens the camera and returns the "TaskIndex" number. You need to keep it and use it in future calls.
'Returns 0 if failed to open the camera.
Public Sub OpenCamera (Front As Boolean) As ResumableSub
	TaskIndex = TaskIndex + 1
	If Camera.IsCameraOpen Then
		Stop
	End If
	mFront = Front
	id = Camera.FindCameraId(mFront)
	If id = "" Then
		Log("Camera not found.")
		id = Camera.CameraIDs(0)
	End If
	Camera.OpenCamera(id)
	Wait For Camera_CameraState (Open As Boolean)
	If Open = False Then
		Log("Failed to open camera")
		Return 0
	End If
	If PrintKeys Then PrintAllKeys(Camera.GetCameraCharacteristics(id), "Camera Characteristics")
	Return TaskIndex
End Sub

Private Sub CloseSession
	Dim session As JavaObject = jcamera.GetFieldJO("captureSession")
	If session.IsInitialized Then
		session.RunMethod("stopRepeating", Null)
		session.RunMethod("abortCaptures", Null)
		jcamera.SetField("captureSession", Null)
	End If
End Sub


Public Sub getSupportedHardwareLevel As String
	Dim jo As JavaObject = Camera.GetCameraCharacteristics(0)
	Return IntToConst(jo.RunMethod("get", Array(StaticCameraCharacteristics.GetField("INFO_SUPPORTED_HARDWARE_LEVEL"))), SUPPORTED_HARDWARE_LEVEL)
End Sub


'Prepared the surface for still capture.
Public Sub PrepareSurface (MyTaskIndex As Int) As ResumableSub
	If MyTaskIndex <> TaskIndex Then Return False
	CloseSession
	Wait For (CreateSurface) Complete (Result As Boolean)
	If MyTaskIndex <> TaskIndex Then Return False
	Camera.StartSession(tv, PreviewSize, CaptureSize, 256, 0, False) '256 = JPEG
	Wait For Camera_SessionConfigured (Success As Boolean)
	If MyTaskIndex <> TaskIndex Then Return False
	Return Success
End Sub

'Prepares the surface for video capture.
'Need to add this line to the manifest editor:
'AddPermission(android.permission.RECORD_AUDIO)
Public Sub PrepareSurfaceForVideo (MyTaskIndex As Int, Dir As String, FileName As String) As ResumableSub
	If MyTaskIndex <> TaskIndex Then Return False
	CloseSession
	Wait For (CreateSurface) Complete (Result As Boolean)
	If MyTaskIndex <> TaskIndex Then Return False
	File.Delete(Dir, FileName)
	MediaRecorder = Camera.CreateMediaRecorder(PreviewSize, Dir, FileName)
	MediaRecorder.RunMethod("setOrientationHint", Array(GetHintOrientation))
	Camera.StartSession(tv, PreviewSize, CaptureSize, 0, 0, True)
	Wait For Camera_SessionConfigured (Success As Boolean)
	If MyTaskIndex <> TaskIndex Then Return False
	Return Success
End Sub

Private Sub GetHintOrientation As Int
	Dim SensorOrientation As Int = GetFromCameraCharacteristic("SENSOR_ORIENTATION")
	Dim front As Int = -1
	If getIsFrontFacingCamera Then front = 1
	Dim orientation As Int = (SensorOrientation + jcamera.GetField("lastKnownOrientation") * front + 360) Mod 360
	Return orientation
End Sub

'Startd recording.
Public Sub StartVideoRecording (MyTaskIndex As Int)
	If MyTaskIndex <> TaskIndex Then Return
	MediaRecorder.RunMethod("start", Null)
	RecordingVideo = True
End Sub

'Stops recording. Need to prepare the surface again.
Public Sub StopVideoRecording (MyTaskIndex As Int)
	CloseSession
	Try
		MediaRecorder.RunMethod("stop", Null)
	Catch
		Log(LastException)
	End Try
	RecordingVideo = False
End Sub

Private Sub CreateSurface As ResumableSub
	If tv.IsInitialized Then tv.RemoveView
	tv = Camera.CreateSurface
	mPanel.AddView(tv, 0, 0, mPanel.Width, mPanel.Height)
	tv.SendToBack
	Wait For Camera_SurfaceReady
	Return True
End Sub

'Starts the preview.
Public Sub StartPreview (MyTaskIndex As Int, VideoRecording As Boolean)
	Dim PreviewBuilder As JavaObject
	If VideoRecording Then
		PreviewBuilder = Camera.CreateVideoRequestBuilder		
	Else
		PreviewBuilder = Camera.CreatePreviewBuilder
	End If
	SetSettingsFromMap(PreviewBuilder, PreviewSettingsMap)
	PreviewRequest = Camera.SetRepeatingRequest(PreviewBuilder)
	If PrintKeys Then PrintAllKeys(PreviewRequest, "Preview Capture Request")
End Sub

'Gets the supported preview sizes.
Public Sub getSupportedPreviewSizes As List
	Return Camera.GetSupportedPreviewSizes(id)
End Sub
'Gets the supported capture sizes.
Public Sub getSupportedCaptureSizes As List
	Return Camera.GetSupportedCaptureSizes(id)
End Sub

Public Sub getSupportedVideoSizes As List
	Return Camera.GetSupportedVideoSizes(id)
End Sub
'Gets the supported scene modes.
Public Sub getSupportedSceneModes As List
	Return RemoveDuplicates(IntsToConstsList(GetFromCameraCharacteristic("CONTROL_AVAILABLE_SCENE_MODES"), SCENE_MODE))
End Sub
'Gets or sets the scene mode (one of the SCENE_MODE values). Call StartPreview to apply changes.
Public Sub setSceneMode(Mode As String)
	SetBothMaps("CONTROL_SCENE_MODE", SCENE_MODE.IndexOf(Mode))
End Sub

Public Sub getSceneMode As String
	Return IntToConst(GetFromCaptureRequest(PreviewRequest, "CONTROL_SCENE_MODE"), SCENE_MODE)
End Sub
'Gets or sets the applied effect (one of the EFFECT_MODE values). Call StartPreview to apply changes.
Public Sub setEffectMode(Mode As String)
	SetBothMaps("CONTROL_EFFECT_MODE", EFFECT_MODE.IndexOf(Mode))
End Sub

Public Sub getEffectMode As String
	Return IntToConst(GetFromCaptureRequest(PreviewRequest, "CONTROL_EFFECT_MODE"), EFFECT_MODE)
End Sub
'Returns the supported effects modes.
Public Sub getSupportedEffectModes As List
	Return IntsToConstsList(GetFromCameraCharacteristic("CONTROL_AVAILABLE_EFFECTS"), EFFECT_MODE)
End Sub
'Returns the supported focus modes. Best mode in most cases is CONTINUOUS_PICTURE.
Public Sub getSupportedFocusModes As List
	Return RemoveDuplicates(IntsToConstsList(GetFromCameraCharacteristic("CONTROL_AF_AVAILABLE_MODES"), AF_MODE))
End Sub

Private Sub RemoveDuplicates(Raw As List) As List
	Dim unique As Map
	unique.Initialize
	For Each f As String In Raw
		unique.Put(f, "")
	Next
	Raw.Clear
	For Each f As String In unique.Keys
		Raw.Add(f)
	Next
	Return Raw
End Sub
'Gets or sets the focus mode (one of the AF_MODE values). Call StartPreview to apply changes.
Public Sub getFocusMode As String
	Return IntToConst(GetFromCaptureRequest(PreviewRequest, "CONTROL_AF_MODE"), AF_MODE)
End Sub

Public Sub setFocusMode(mode As String)
	SetBothMaps("CONTROL_AF_MODE", AF_MODE.IndexOf(mode))
End Sub

'Gets the maximum value of the digital zoom.
Public Sub getMaxDigitalZoom As Float
	Return GetFromCameraCharacteristic("SCALER_AVAILABLE_MAX_DIGITAL_ZOOM")
End Sub

'Gets the supported auto exposure modes.
Public Sub getSupportedAutoExposureModes As List
	Return IntsToConstsList(GetFromCameraCharacteristic("CONTROL_AE_AVAILABLE_MODES"), AE_MODE)
End Sub

'Gets or sets the auto exposure mode (one of the AE_MODE values). Call StartPreview to apply changes.
Public Sub getAutoExposureMode As String
	Return IntToConst(GetFromCaptureRequest(PreviewRequest, "CONTROL_AE_MODE"), AE_MODE)
End Sub

Public Sub getControlMode As String
	Return IntToConst(GetFromCaptureRequest(PreviewRequest, "CONTROL_MODE"), CONTROL_MODE)
End Sub
Public Sub setAutoExposureMode (Mode As String)
	SetBothMaps("CONTROL_AE_MODE", AE_MODE.IndexOf(Mode))
	PreviewSettingsMap.Put("FLASH_MODE", FLASH_MODE.IndexOf("OFF"))
	If Mode = "ON_ALWAYS_FLASH" Then
		CaptureSettingMap.Put("FLASH_MODE", FLASH_MODE.IndexOf("SINGLE"))
	End If
End Sub

'Sets the preview region.
Public Sub setPreviewCropRegion(r As Rect)
	PreviewSettingsMap.Put("SCALER_CROP_REGION", r)
	CaptureSettingMap.Put("SCALER_CROP_REGION", r)
End Sub

'Gets the image sensor region.
Public Sub getActiveArraySize As Rect
	Return GetFromCameraCharacteristic("SENSOR_INFO_ACTIVE_ARRAY_SIZE")
End Sub

Private Sub SetBothMaps(Key As String, Value As Object)
	For Each m As Map In bothMaps
		m.Put(Key, Value)
	Next
End Sub

'Triggers the auto focus feature and then takes a picture.
Public Sub FocusAndTakePicture (MyTaskIndex As Int) As ResumableSub
	Dim PreviewFocusMode As String = AF_MODE.Get(GetFromCaptureRequest(PreviewRequest, "CONTROL_AF_MODE"))
	Dim PreviewAEMode As String = AE_MODE.Get(GetFromCaptureRequest(PreviewRequest, "CONTROL_AE_MODE"))
	If PreviewFocusMode = "OFF" Or PreviewFocusMode = "EDOF" Then
		Log("Focus not supported")
	Else if PreviewFocusMode.Contains("CONTINUOUS") = False Or PreviewAEMode = "ON_ALWAYS_FLASH" Then
		Dim PreviewBuilder As JavaObject = Camera.CreatePreviewBuilder
		PreviewSettingsMap.Put("CONTROL_AF_TRIGGER", 1) 'CONTROL_AF_TRIGGER_START
		SetSettingsFromMap(PreviewBuilder, PreviewSettingsMap)
		Camera.AddCaptureRequest(PreviewBuilder)
		Wait For (WaitForFocusWithTimeout(5000)) Complete (Success As Boolean)
		If Success = False Then
			Log("Focus failed")
		Else
			Log("Focused!")
		End If
		Wait For (TakePictureNow(MyTaskIndex)) Complete (data() As Byte)
		Dim PreviewBuilder As JavaObject = Camera.CreatePreviewBuilder
		PreviewSettingsMap.Put("CONTROL_AF_TRIGGER", 2) 'CONTROL_AF_TRIGGER_CANCEL
		SetSettingsFromMap(PreviewBuilder, PreviewSettingsMap)
		Camera.AddCaptureRequest(PreviewBuilder)
		PreviewSettingsMap.Remove("CONTROL_AF_TRIGGER")
		Wait For (PreviewBuilder) Camera_CaptureComplete (CaptureResult As Object)
		Return data
	End If
	Wait For (TakePictureNow(MyTaskIndex)) Complete (data() As Byte)
	Return data
End Sub

Private Sub WaitForFocusWithTimeout (TimeoutMs As Int) As ResumableSub
	Dim start As Long = DateTime.Now
	Do Until FocusState = "FOCUSED_LOCKED" Or FocusState = "NOT_FOCUSED_LOCKED"
		Sleep(50)
		If DateTime.Now - start > TimeoutMs Then Return False
	Loop
	Return FocusState = "FOCUSED_LOCKED"
End Sub

Private Sub Camera_PreviewCaptureComplete (CaptureResult As Object)
	FocusState = IntToConst(GetFromCaptureResult(CaptureResult, "CONTROL_AF_STATE"), AF_STATE)
	'Log(IntToConst(GetFromCaptureResult(CaptureResult, "FLASH_STATE"), FLASH_STATE))
'	PrintAllKeys(CaptureResult, "Capture Result")
End Sub

'Takes a picture now. Without waiting for the picture to be focused.
Public Sub TakePictureNow (MyTaskIndex As Int) As ResumableSub
	If MyTaskIndex <> TaskIndex Then
		Dim Empty() As Byte
		Return Empty
	End If
	Camera.AbortCaptures
	Dim builder As JavaObject = Camera.CreateCaptureBuilder
	CaptureSettingMap.Put("JPEG_ORIENTATION", GetHintOrientation)
	SetSettingsFromMap(builder, CaptureSettingMap)
	Dim CaptureRequest As Object = Camera.AddCaptureRequest(builder)
	If PrintKeys Then PrintAllKeys(CaptureRequest, "Capture Request")
	Wait For Camera_PictureTaken (Data() As Byte)
	StartPreview(MyTaskIndex, False)
	Return Data
End Sub

'Private Sub Camera_PreviewTaken (Image As Object)
'	Log(Image)
'End Sub

'Takes multiple pictures. Should be called like this:
'<code>Wait For(cam.TakePicturesNow(MyTaskIndex, 9)) Complete (Pictures As List)</code>
Public Sub TakePicturesNow (MyTaskIndex As Int, NumberOfPictures As Int) As ResumableSub
	If MyTaskIndex <> TaskIndex Then Return False
	Camera.AbortCaptures
	Dim builder As JavaObject = Camera.CreateCaptureBuilder
	CaptureSettingMap.Put("JPEG_ORIENTATION", GetHintOrientation)
	SetSettingsFromMap(builder, CaptureSettingMap)
	Dim result As List
	result.Initialize
	For i = 1 To NumberOfPictures
		Camera.AddCaptureRequest(builder)
	Next
	For i = 1 To NumberOfPictures
		Wait For Camera_PictureTaken (Data() As Byte)
		result.Add(Data)
	Next
	StartPreview(MyTaskIndex, False)
	Return result
End Sub


'Gets a Bitmap object from the preview stream. 
'Returns an uninitialized bitmap if not available.
Public Sub GetPreviewBitmap(Width As Int, Height As Int) As Bitmap
	Dim mbmp As Bitmap
	mbmp.InitializeMutable(Width, Height)
	Dim jo As JavaObject = tv
	Return jo.RunMethod("getBitmap", Array(mbmp))
End Sub

'Converts the data to a bitmap.
Public Sub DataToBitmap(Data() As Byte) As Bitmap
	Dim in As InputStream
	in.InitializeFromBytesArray(Data, 0, Data.Length)
	Dim bmp As Bitmap
	bmp.Initialize2(in)
	in.Close
	Return bmp
End Sub

'Saves the data to a file.
Public Sub DataToFile(Data() As Byte, Dir As String, FileName As String)
	Dim out As OutputStream = File.OpenOutput(Dir, FileName, False)
	out.WriteBytes(Data, 0, Data.Length)
	out.Close
End Sub

'Returns true if the camera is a front camera
Public Sub getIsFrontFacingCamera As Boolean
	Return 0 = GetFromCameraCharacteristic("LENS_FACING")
End Sub

Private Sub GetFromCameraCharacteristic (Field As String) As Object
	Dim jo As JavaObject = Camera.GetCameraCharacteristics(id)
	Return jo.RunMethod("get", Array(StaticCameraCharacteristics.GetField(Field)))
End Sub

Private Sub GetFromCaptureResult(CaptureResult As Object, Field As String) As Object
	Dim jresult As JavaObject = CaptureResult
	Return jresult.RunMethod("get", Array(StaticCaptureResult.GetField(Field)))
End Sub

Private Sub GetFromCaptureRequest(CaptureRequest As Object, Field As String) As Object
	Dim jo As JavaObject = CaptureRequest
	Return jo.RunMethod("get", Array(StaticCaptureRequest.GetField(Field)))
End Sub


Private Sub IntToConst (Int1 As Object, Consts As List) As String
	If Int1 = Null Then Return ""
	Dim i As Int = Int1
	If i >= 0 And i < Consts.Size Then
		Return Consts.Get(i)
	Else
		Log(Consts)'ignore
		Log("Unknown const: " & i)
		Return ""
	End If
End Sub

Private Sub IntsToConstsList (Ints As Object, Consts As List) As List
	Dim res As List
	res.Initialize
	If Ints = Null Then Return res
	Dim f() As Int = Ints
	For Each mode As Int In f
		If mode >=0 And mode < Consts.Size Then
			res.Add(Consts.Get(mode))
		Else
			Log(Consts) 'ignore
			Log("Unknown consts: " & mode)
		End If
	Next
	Return res
End Sub

Private Sub SetSettingsFromMap (Builder As JavaObject, m As Map)
	For Each key As String In m.Keys
		Builder.RunMethod("set", Array(StaticCaptureRequest.GetField(key), m.Get(key)))
	Next
End Sub

Public Sub Stop
	RecordingVideo = False
	Camera.Stop
	TaskIndex = TaskIndex + 1
End Sub


#Region Not interesting

Private Sub PrintAllKeys (CameraMap As Object, title As String) 'ignore
	Log($"******  ${title} **********"$)
	Dim jo As JavaObject = CameraMap
	Dim keys As List = jo.RunMethod("getKeys", Null)
	For Each k As JavaObject In keys
		Dim value As Object = jo.RunMethod("get", Array(k))
		If value = Null Then Continue
		Dim typ As String = GetType(value)
		If typ = "[F" Then
			value = FloatsToList(value)
		Else If typ = "[I" Then
			value = IntsToList(value)
		Else If typ = "[Z" Then
			value = BoolsToList(value)
		Else If typ = "[B" Then
			value = BytesToList(value)
		Else if typ.StartsWith("[") Then
			value = ObjectsToList(value)
		End If
		Log($"${k.RunMethod("getName", Null)}: ${value}"$)
	Next
End Sub
Private Sub ObjectsToList(Obj As Object) As List
	Dim res As List
	res.Initialize
	If Obj = Null Then Return res
	Dim o() As Object = Obj
	For Each oo As Object In o
		res.Add(oo)
	Next
	Return res
End Sub

Private Sub BoolsToList (Obj As Object) As List
	Dim res As List
	res.Initialize
	If Obj = Null Then Return res
	Dim i() As Boolean = Obj
	For Each ii As Boolean In i
		res.Add(ii)
	Next
	Return res
End Sub

Private Sub BytesToList (Obj As Object) As List
	Dim res As List
	res.Initialize
	If Obj = Null Then Return res
	Dim i() As Byte = Obj
	For Each ii As Byte In i
		res.Add(ii)
	Next
	Return res
End Sub


Private Sub IntsToList (Obj As Object) As List
	Dim res As List
	res.Initialize
	If Obj = Null Then Return res
	Dim i() As Int = Obj
	For Each ii As Int In i
		res.Add(ii)
	Next
	Return res
End Sub

Private Sub FloatsToList (Obj As Object) As List
	Dim res As List
	res.Initialize
	If Obj = Null Then Return res
	Dim f() As Float = Obj
	For Each ff As Float In f
		res.Add(ff)
	Next
	Return res
End Sub
#End Region