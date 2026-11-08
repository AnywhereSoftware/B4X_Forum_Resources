B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
Sub Class_Globals	
	Private Root As B4XView
	Private xui As XUI
	Private socket1 As Socket
	Private camEx As CameraExClass
	Private astream As AsyncStreams
	Private rp As RuntimePermissions
	Private Panel1 As Panel
	Private IntervalMs As Int = 50
	Private lastPreviewSaved As Long
	Private frontCamera As Boolean = False
	Private ServerIp As String = "192.168.50.42" ' B4J server IP
	Private ServerPort As Int = 17178
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("1")
	B4XPages.SetTitle(Me, "CCTV")
End Sub

Private Sub B4XPage_Disappear
	StopCamera
End Sub

Sub B4XPage_Appear
	StartCamera
End Sub

Sub B4XPage_CloseRequest As ResumableSub
	camEx.Release
	astream.Close
	Return True
End Sub

Private Sub StartCamera
	rp.CheckAndRequest(rp.PERMISSION_CAMERA)
	Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)
	If Result = False Then
		ToastMessageShow("No permission!", False)
		Return
	End If
	camEx.Initialize(Panel1, frontCamera, Me, "Camera1")
	Wait For Camera1_Ready (Success As Boolean)
	If Success Then
		camEx.StartPreview
		'Log("Supported preview sizes")
		'For Each cs As CameraSize In camEx.GetSupportedPreviewSizes
		'	Log(cs.Width & "x" & cs.Height)
		'Next
		'camEx.SetPreviewSize(640, 480)
		'camEx.CommitParameters
	Else
		ToastMessageShow("Error opening camera", False)
		StopCamera
	End If
End Sub

Private Sub StopCamera
	If camEx.IsInitialized Then
		camEx.Release
	End If
End Sub

Private Sub btnChangeCamera_Click
	camEx.Release
	frontCamera = Not(frontCamera)
	StartCamera
End Sub

Private Sub btnFlash_Click
	Dim f() As Float = camEx.GetFocusDistances
	Log(f(0) & ", " & f(1) & ", " & f(2))
	Dim flashModes As List = camEx.GetSupportedFlashModes
	If flashModes.IsInitialized = False Then
		ToastMessageShow("Flash not supported.", False)
		Return
	End If
	Dim flash As String = flashModes.Get((flashModes.IndexOf(camEx.GetFlashMode) + 1) Mod flashModes.Size)
	camEx.SetFlashMode(flash)
	ToastMessageShow(flash, False)
	camEx.CommitParameters
End Sub

Private Sub btnEffect_Click
	Dim effects() As String = Array As String("aqua", "blackboard", "mono", "negative", "posterize", _
		"sepia", "solarize", "whiteboard")
	Dim effect As String = effects(Rnd(0, effects.Length))
	camEx.SetColorEffect(effect)
	ToastMessageShow(effect, False)
	camEx.CommitParameters
End Sub

Private Sub btnTakePicture_Click
	camEx.TakePicture
End Sub

Private Sub btnConnect_Click
	If socket1.IsInitialized Then socket1.Close
	socket1.Initialize("socket1")
	socket1.Connect(ServerIp, ServerPort, 5000)
	Wait For Socket1_Connected (Successful As Boolean)
	If Successful Then
		If astream.IsInitialized Then astream.Close
		astream.InitializePrefix(socket1.InputStream, False, socket1.OutputStream, "astream")
		Log("Connected")
		ToastMessageShow("Connected", False)
	Else
		Log(LastException)
	End If
End Sub

Private Sub Panel1_Click
	camEx.FocusAndTakePicture
End Sub

Sub Camera1_Preview (PreviewPic() As Byte)
	If DateTime.Now > lastPreviewSaved + IntervalMs Then
		Dim jpeg() As Byte = camEx.PreviewImageToJpeg(PreviewPic, 70)
		lastPreviewSaved = DateTime.Now
		If astream.IsInitialized  Then
			astream.Write(jpeg)
		End If
	End If
End Sub

Sub Camera1_PictureTaken (Data() As Byte)
	camEx.SavePictureToFile(Data, File.DirInternal, "1.jpg")
	camEx.StartPreview
End Sub

Sub astream_Error
	Log("Error: " & LastException)
	astream.Close
	astream_Terminated
End Sub

Sub astream_Terminated
	Log("Disconnected")
	ToastMessageShow("Disconnected", False)
End Sub