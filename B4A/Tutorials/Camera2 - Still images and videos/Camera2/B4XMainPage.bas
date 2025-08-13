B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=CamEx2.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private frontCamera As Boolean = False
	Private VideoMode As Boolean = False
	Private VideoFileDir, VideoFileName As String
	Private MyTaskIndex As Int
	Private rp As RuntimePermissions
	Private cam As CamEx2
	Private pnlCamera As B4XView
	Private pnlBackground As B4XView
	Private btnEffects As Button
	Private btnScene As Button
	Private buttons As List
	Private btnAutoExposure As Button
	Private btnFocus As Button
	Private ProgressBar1 As ProgressBar
	Private openstate, busystate As Boolean
	Private btnRecord As Button
	Private btnMode As Button
	Private btnCamera As Button
	Private barZoom As SeekBar
	Private B4XImageView1 As B4XImageView
End Sub

Public Sub Initialize
	
End Sub

'If you want to use this code in an Activity then make the following changes:
'- search for B4XPage_PermissionResult and change to Activity_PermissionResult
'- Change B4XPage_Background / Foreground to Activity_Pause and Activity_Resume
'- Change Root with Activity

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("1")
	Root.LoadLayout("StillPicture")
	VideoFileDir = rp.GetSafeDirDefaultExternal("")
	VideoFileName = "1.mp4"
	cam.Initialize(pnlCamera)
	Log(cam.SupportedHardwareLevel)
	buttons = Array(btnScene, btnAutoExposure, btnEffects, btnFocus, btnMode)
	SetState(False, False, VideoMode)
End Sub

Sub OpenCamera (front As Boolean)
	rp.CheckAndRequest(rp.PERMISSION_CAMERA)
	Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)
	If Result = False Then
		ToastMessageShow("No permission!", True)
		Return
	End If
	
	SetState(False, False, VideoMode)
	Wait For (cam.OpenCamera(front)) Complete (TaskIndex As Int)
	If TaskIndex > 0 Then
		MyTaskIndex = TaskIndex 'hold this index. It will be required in later calls.
		Wait For(PrepareSurface) Complete (Success As Boolean)
	End If
	Log("Start success: " & Success)
	SetState(Success, False, VideoMode)
	If Success = False Then
		ToastMessageShow("Failed to open camera", True)
	End If
End Sub

Sub PrepareSurface As ResumableSub
	SetState(False, busystate, VideoMode)
	'sizes can be modified here
	If VideoMode Then
		cam.PreviewSize.Initialize(640, 480)
		ResizePreviewPanelBasedPreviewSize
		'Using a temporary file to store the video.
		Wait For (cam.PrepareSurfaceForVideo(MyTaskIndex, VideoFileDir, "temp-" & VideoFileName)) Complete (Success As Boolean)
	Else
		cam.PreviewSize.Initialize(1920, 1080)
		ResizePreviewPanelBasedPreviewSize
'		For Each cs As CameraSize In cam.SupportedPreviewSizes
'			Log(cs)
'		Next
		Wait For (cam.PrepareSurface(MyTaskIndex)) Complete (Success As Boolean)
	End If
	
	If Success Then cam.StartPreview(MyTaskIndex, VideoMode)
	SetState(Success, busystate, VideoMode)
	Return Success
End Sub

Private Sub ResizePreviewPanelBasedPreviewSize
	Dim pw = cam.PreviewSize.Height, ph = cam.PreviewSize.Width As Int
	Dim r As Float = Max(Root.Width / pw, Root.Height / ph)  'FILL_NO_DISTORTIONS (change to Min for FIT)
	Dim w As Int = pw * r
	Dim h As Int = ph * r
	pnlCamera.SetLayoutAnimated(0, Round(Root.Width / 2 - w / 2), Round(Root.Height / 2 - h / 2), Round(w), Round(h))
End Sub

Sub btnCamera_Click
	frontCamera = Not(frontCamera)
	OpenCamera(frontCamera)
End Sub

Sub B4XPage_Foreground
	OpenCamera(frontCamera)
End Sub

Sub B4XPage_Background
	cam.Stop
End Sub

Sub btnMode_Click
	VideoMode = Not(VideoMode)
	If VideoMode Then
		rp.CheckAndRequest(rp.PERMISSION_RECORD_AUDIO)
		Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)
		If Result = False Then
			ToastMessageShow("No permission!", True)
			VideoMode = False
		End If
	End If
	SetState(openstate, busystate, VideoMode)
	PrepareSurface
End Sub

Sub btnRecord_Click
	If VideoMode Then
		CaptureVideo
	Else
		TakePicture
	End If
End Sub

Sub CaptureVideo
	Try
		SetState(openstate, True, VideoMode)
		If cam.RecordingVideo = False Then
			cam.StartVideoRecording (MyTaskIndex)
		Else
			cam.StopVideoRecording (MyTaskIndex)
			File.Copy(VideoFileDir, "temp-" & VideoFileName, VideoFileDir, VideoFileName)
			ToastMessageShow($"Video file saved: $1.2{File.Size(VideoFileDir, VideoFileName) / 1024 / 1024} MB"$, True)
			Wait For (PrepareSurface) Complete (Success As Boolean)
			SetState(openstate, False, VideoMode)
			
		End If
	Catch
		HandleError(LastException)
	End Try
End Sub

Sub HandleError (Error As Exception)
	Log("Error: " & Error)
	ToastMessageShow(Error, True)
	OpenCamera(frontCamera)
End Sub

Sub TakePicture
	Try
		SetState(openstate, True, VideoMode)
		Wait For(cam.FocusAndTakePicture(MyTaskIndex)) Complete (Data() As Byte)
		SetState(openstate, False, VideoMode)
		cam.DataToFile(Data, VideoFileDir, "1.jpg")
		Dim bmp As Bitmap = cam.DataToBitmap(Data)
		Log("Picture taken: " & bmp) 'ignore
		pnlBackground.SetVisibleAnimated(100, True)
		B4XImageView1.Bitmap = RotateJpegIfNeeded(bmp, Data)
		Sleep(4000)
		pnlBackground.SetVisibleAnimated(500, False)
	Catch
		HandleError(LastException)
	End Try
	
End Sub

Sub pnlBackground_Click
	pnlBackground.Visible = False
End Sub

Sub btnEffects_Click
	Dim effects As List = cam.SupportedEffectModes
	Dim i As Int = effects.IndexOf(cam.EffectMode)
	i = (i + 1) Mod effects.Size
	cam.EffectMode = effects.Get(i)
	btnEffects.Text = effects.Get(i)
	cam.StartPreview(MyTaskIndex, VideoMode)
End Sub

Sub btnScene_Click
	Dim scenes As List = cam.SupportedSceneModes
	Dim i As Int = scenes.IndexOf(cam.SceneMode)
	i = (i + 1) Mod scenes.Size
	cam.SceneMode = scenes.Get(i)
	btnScene.Text = scenes.Get(i)
	cam.StartPreview(MyTaskIndex, VideoMode)
End Sub

Sub btnAutoExposure_Click
	Dim flashes As List = cam.SupportedAutoExposureModes
	Dim i As Int = flashes.IndexOf(cam.AutoExposureMode)
	i = (i + 1) Mod flashes.Size
	cam.AutoExposureMode = flashes.Get(i)
	btnAutoExposure.Text = flashes.Get(i)
	cam.StartPreview(MyTaskIndex, VideoMode)
End Sub

Sub btnFocus_Click
	Dim focuses As List = cam.SupportedFocusModes
	Dim i As Int = focuses.IndexOf(cam.FocusMode)
	i = (i + 1) Mod focuses.Size
	cam.FocusMode = focuses.Get(i)
	btnFocus.Text = focuses.Get(i)
	cam.StartPreview(MyTaskIndex, VideoMode)
End Sub

'This sub enables or disables the various UI elements based on the current state.
Sub SetState(Open As Boolean, Busy As Boolean, Video As Boolean)
	For Each b As Button In buttons
		b.Visible = Open And Not(Busy)
	Next
	btnCamera.Visible = Not(Busy)
	btnRecord.Visible = Open And (Video Or Not(Busy))
	openstate = Open
	ProgressBar1.Visible = Busy
	busystate = Busy
	VideoMode = Video
	barZoom.Visible = Open
	Dim btnRecordText As String
	If VideoMode Then
		If Busy Then
			btnRecordText = Chr(0xF04D)
		Else
			btnRecordText = Chr(0xF03D)
		End If
	Else
		btnRecordText = Chr(0xF030)
	End If
	btnRecord.Text = btnRecordText
End Sub

Sub barZoom_ValueChanged (Value As Int, UserChanged As Boolean)
	Dim OriginalSize As Rect = cam.ActiveArraySize
	Dim Zoom As Float = 1 + Value / 100 * (cam.MaxDigitalZoom - 1)
	Dim Crop As Rect
	Dim NewWidth As Int = OriginalSize.Width / Zoom
	Dim NewHeight As Int = OriginalSize.Height / Zoom
	Crop.Initialize(OriginalSize.CenterX - NewWidth / 2, OriginalSize.CenterY - NewHeight / 2, _
		OriginalSize.CenterX + NewWidth / 2, OriginalSize.CenterY + NewHeight / 2)
	cam.PreviewCropRegion = Crop
	cam.StartPreview(MyTaskIndex, VideoMode)
End Sub

Private Sub RotateJpegIfNeeded (bmp As B4XBitmap, Data() As Byte) As B4XBitmap
	Dim p As Phone
	If p.SdkVersion >= 24 Then
		Dim ExifInterface As JavaObject
		Dim in As InputStream
		in.InitializeFromBytesArray(Data, 0, Data.Length)
		ExifInterface.InitializeNewInstance("android.media.ExifInterface", Array(in))
		Dim orientation As Int = ExifInterface.RunMethod("getAttribute", Array("Orientation"))
		Select orientation
			Case 3  '180
				bmp = bmp.Rotate(180)
			Case 6 '90
				bmp = bmp.Rotate(90)
			Case 8 '270
				bmp = bmp.Rotate(270)
		End Select
		in.Close
	End If
	Return bmp
End Sub




