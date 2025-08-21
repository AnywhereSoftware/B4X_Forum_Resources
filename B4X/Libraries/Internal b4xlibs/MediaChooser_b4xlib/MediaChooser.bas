B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
#Event: Progress (Value As Int)
#Event: Error (Key As String, Message As String)
Sub Class_Globals
	#if B4J
	Private fc As FileChooser
	Private ImageExtensions As List = Array("*.jpg", "*.png", "*.bmp", "*.gif")
	Private VideoExtensions As List = Array("*.mp3", "*.mp4", "*.m4a", "*.m4v", "*.wav")
	#Else If B4A
	Private ion As Object
	Private VideoRecorder As VideoRecordApp
	Private FileProvider1 As FileProvider
	#Else If B4i
	Private llCamera As LLCamera 'ignore, just used for the authorization status
	Private Camera As Camera
	#End If
	Type MediaChooserResult (Success As Boolean, MediaDir As String, MediaFile As String, Mime As String)
	Private TempFileIndex As Int
	Private NO_RESULT As MediaChooserResult
	Private TempFolder As String
	Private xui As XUI
	Private mCallback As Object
	Private mEventName As String
	Public Const PROGRESS_INDETERMINATE = -1, PROGRESS_SHOW = -2, PROGRESS_HIDE = -3 As Int
End Sub

'Must call XUI.SetDataFolder before calling this method (in B4J).
Public Sub Initialize (CallbackPage As Object, EventName As String)
	mCallback = CallbackPage
	mEventName = EventName
	NO_RESULT = CreateMediaChooserResult(False, "", "", 0)
	#if B4A
	VideoRecorder.Initialize("VideoRecorder")
	FileProvider1.Initialize
	TempFolder = FileProvider1.SharedFolder
	#Else If B4i
	Camera.Initialize("Camera", B4XPages.GetNativeParent(CallbackPage))
	#else if B4J
	fc.Initialize
	#End If
	#if B4I or B4J
	File.MakeDir(xui.DefaultFolder, "mediachooser-temp")
	TempFolder = File.Combine(xui.DefaultFolder, "mediachooser-temp")
	#End If
	DeleteTemporaryFiles
End Sub

Private Sub DetectImageMime (Folder As String, FileName As String) As String
	If File.Size(Folder, FileName) < 4 Then
		Log("file size too small")
		Return ""
	End If
	Dim in As InputStream = File.OpenInput(Folder, FileName)
	Dim b(4) As Byte
	ReadBytesFully(in, b, 4)
	in.Close
	If b(0) = (0xff).As(Byte) And b(1) = (0xd8).As(Byte) Then
		Return "image/jpeg"
	Else if b(0) = (0x47).As(Byte) And b(1) = (0x49).As(Byte) And b(2) = (0x46).As(Byte) Then
		Return "image/gif"
	Else
		Return "image/*"
	End If
End Sub

Private Sub ReadBytesFully(In As InputStream, Data() As Byte, Len As Int) As Byte()
	Dim count = 0, Read As Int
	Do While count < Len And Read > -1
		Read = In.ReadBytes(Data, count, Len - count)
		count = count + Read
	Loop
	Return Data
End Sub

#if B4A
'Lets the user capture video with the camera. Not supported by B4J.
Public Sub CaptureVideo As ResumableSub
	Dim folder As String = FileProvider1.SharedFolder
	Dim FileName As String = GetTempFile
	Wait For (StartForegroundService) Complete (unused As Boolean)
	VideoRecorder.Record3(folder, FileName, -1, FileProvider1.GetFileUri(FileName))
	Wait For VideoRecorder_RecordComplete (Success As Boolean)
	StopForegroundService
	If Success Then
		Return CreateMediaChooserResult(True, folder, FileName, "video/*")
	Else
		Return NO_RESULT
	End If
End Sub

'Lets the user capture an image with the camera. Not supported by B4J.
Public Sub CaptureImage As ResumableSub
	Dim i As Intent
	i.Initialize("android.media.action.IMAGE_CAPTURE", "")
	Dim tempImageFile As String = GetTempFile
	Dim u As Object = FileProvider1.GetFileUri(tempImageFile)
	i.PutExtra("output", u) 'the image will be saved to this path
	Try
		Wait For (StartForegroundService) Complete (unused As Boolean)
		StartActivityForResult(i)
		Wait For ion_Event (MethodName As String, Args() As Object)
		StopForegroundService
		If -1 = Args(0) Then
			Try
				If File.Exists(TempFolder, tempImageFile) Then
					Return CreateMediaChooserResult(True, TempFolder, tempImageFile, DetectImageMime(TempFolder, tempImageFile))
				End If
			Catch
				Log(LastException)
			End Try
		End If
	Catch
		Log(LastException)
	End Try
	Return NO_RESULT
End Sub

Private Sub StartForegroundService As ResumableSub
	If B4XPages.GetManager.IsForeground = False Then Return True
	If IsPaused(KeepRunningService) Then
		StartService(KeepRunningService)
	End If
	Do While IsPaused(KeepRunningService)
		Sleep(10)
	Loop
	CallSub(KeepRunningService, "Start")
	Return True
End Sub

Private Sub StopForegroundService
	If IsPaused(KeepRunningService) Then Return
	CallSub(KeepRunningService, "Stop")
End Sub

Private Sub StartActivityForResult(i As Intent)
	Dim jo As JavaObject = Me
	jo = jo.RunMethod("getBA", Null)
	ion = jo.CreateEvent("anywheresoftware.b4a.IOnActivityResult", "ion", Null)
	jo.RunMethod("startActivityForResult", Array(ion, i))
End Sub

Private Sub MediaFromContentChooser (Video As Boolean) As ResumableSub
	Dim cc As ContentChooser
	cc.Initialize("cc")
	Wait For (StartForegroundService) Complete (unused As Boolean)
	If Video Then
		cc.Show("video/*", "Choose video")
	Else
		cc.Show("image/*", "Choose image")
	End If
	Wait For CC_Result (Success As Boolean, Dir As String, FileName As String)
	StopForegroundService
	If Success Then
		Dim TargetFileName As String = GetTempFile
		Dim Complete(1) As Boolean
		MonitorTargetFile(TargetFileName, 0, Complete)
		Wait For (File.CopyAsync(Dir, FileName, TempFolder, TargetFileName)) Complete (Success As Boolean)
		Complete(0) = True
		Return CreateMediaChooserResult(True, TempFolder, TargetFileName, IIf(Video, "video/*", DetectImageMime(TempFolder, TargetFileName)))
	End If
	Return NO_RESULT
End Sub
#end if

#if B4i
Private Sub CheckPermission As Boolean
	If llCamera.AuthorizationDenied Then
		RaiseErrorEvent("permission", "No permission to access camnera. Enable it in device settings.")
		Return False
	End If
	Return True
End Sub

'Lets the user capture an image with the camera. Not supported by B4J.
Public Sub CaptureImage As ResumableSub
	If CheckPermission = False Then
		Return NO_RESULT
	End If
	If Camera.IsSupported = False Then
		RaiseErrorEvent("not_supported", "Not supported")
		Return NO_RESULT
	Else
		Camera.AllowsEditing = True
		Camera.TakePicture
		Wait For Camera_Complete (Success As Boolean, Image As Bitmap, VideoPath As String)
		If Success Then
			Dim TempFile As String = CopyImageFromCamera(Image)
			Return CreateMediaChooserResult(True, TempFolder, TempFile, DetectImageMime(TempFolder, TempFile))
		End If
	End If
	Return NO_RESULT
End Sub

'Lets the user capture video with the camera. Not supported by B4J.
Public Sub CaptureVideo As ResumableSub
	If CheckPermission = False Then
		Return NO_RESULT
	End If
	If Camera.IsVideoSupported = False Then
		RaiseErrorEvent("not_supported", "Not supported")
		Return NO_RESULT
	Else
		Camera.AllowsEditing = True
		Camera.TakeVideo
		Wait For Camera_Complete (Success As Boolean, Image As Bitmap, VideoPath As String)
		If Success Then
			Return CreateMediaChooserResult(True, VideoPath, "", "video/*")
		End If
	End If
	Return NO_RESULT
End Sub


Private Sub CopyImageFromCamera (Image As Bitmap) As String
	Dim temp As String = GetTempFile
	Dim out As OutputStream = File.OpenOutput(TempFolder, temp, False)
	Image.WriteToStream(out, 100, "JPEG")
	out.Close
	Return temp
End Sub
#End If

Private Sub GetTempFile As String 'ignore
	TempFileIndex = TempFileIndex + 1
	Return "mediachooser-temp-" & TempFileIndex
End Sub

Private Sub CreateMediaChooserResult (Success As Boolean, MediaDir As String, MediaFile As String, mime As String) As MediaChooserResult
	Dim t1 As MediaChooserResult
	t1.Initialize
	t1.Success = Success
	t1.MediaDir = MediaDir
	t1.MediaFile = MediaFile
	t1.Mime = mime
	Return t1
End Sub

'Deletes temporary media files. This is called whenever MediaChooser is initialized.
Public Sub DeleteTemporaryFiles
	For Each f As String In File.ListFiles(TempFolder)
		If f.StartsWith("mediachooser-temp-") Then
			File.Delete(TempFolder, f)
		End If
	Next
End Sub

'Lets the user choose an existing video.
'B4iButton - The button that the dialog will be anchored to (on iPad only).
Public Sub ChooseVideo (B4iButton As B4XView) As ResumableSub
	Wait For (ChooseMediaFromGallery(B4iButton, True)) Complete (Result As MediaChooserResult)
	Return Result
End Sub

'Lets the user choose an existing image.
'B4iButton - The button that the dialog will be anchored to (on iPad only).
Public Sub ChooseImage (B4iButton As B4XView) As ResumableSub
	Wait For (ChooseMediaFromGallery(B4iButton, False)) Complete (Result As MediaChooserResult)
	Return Result
End Sub

#if B4J
'Lets the user capture video with the camera. Not supported by B4J.
Public Sub CaptureVideo As ResumableSub
	RaiseErrorEvent("not_supported", "Not supported")
	Return NO_RESULT
End Sub

'Lets the user capture an image with the camera. Not supported by B4J.
Public Sub CaptureImage As ResumableSub
	RaiseErrorEvent("not_supported", "Not supported")
	Return NO_RESULT
End Sub
#end if

Private Sub ChooseMediaFromGallery(B4iButton As B4XView, Video As Boolean) As ResumableSub 'ignore
	#If B4A
	Wait For (MediaFromContentChooser(Video)) Complete (Result As MediaChooserResult)
	Return Result
	#else if B4i
	Camera.AllowsEditing = False
	Camera.SelectFromPhotoLibrary(B4iButton, IIf(Video, Camera.TYPE_MOVIE, Camera.TYPE_IMAGE))
	Wait For Camera_Complete (Success As Boolean, Image As Bitmap, VideoPath As String)
	If Success Then
		If Video Then
			Return CreateMediaChooserResult(True, VideoPath, "", "video/*")
		Else
			Dim mediaUrl As String = Camera.GetPickedMediaInfo.GetDefault("UIImagePickerControllerImageURL", "")
			If mediaUrl.EndsWith(".gif") Then
				If mediaUrl.StartsWith("file://") Then mediaUrl = mediaUrl.SubString(7)
				Return CreateMediaChooserResult(True, mediaUrl, "", "image/gif")
			Else
				Dim TempFile As String = CopyImageFromCamera(Image)
				Return CreateMediaChooserResult(True, TempFolder, TempFile, DetectImageMime(TempFolder, TempFile))
			End If
		End If
	End If
	#else if B4J
	fc.SetExtensionFilter(IIf(Video,"Video", "Image"), IIf(Video, VideoExtensions, ImageExtensions))
	Dim f As String = fc.ShowOpen(B4XPages.GetNativeParent(mCallback))
	If f <> "" Then
		Return CreateMediaChooserResult(True, f, "", IIf(Video, "video/*", DetectImageMime(f, "")))
	End If
	#end if
	Return NO_RESULT 'ignore
End Sub


Private Sub MonitorTargetFile (TargetFile As String, TotalSize As Long, Complete() As Boolean) 'ignore
	RaiseProgressEvent(PROGRESS_SHOW)
	Dim PrevValue As Int = 0
	Do While Complete(0) = False
		Dim NewValue As Int
		If NewValue > 0 Then
			NewValue = Round(File.Size(TempFolder, TargetFile) / TotalSize * 100)
		Else
			NewValue = PROGRESS_INDETERMINATE
		End If
		If NewValue <> PrevValue Then
			RaiseProgressEvent(NewValue)
			PrevValue = NewValue
		End If
		Sleep(50)
	Loop
	RaiseProgressEvent(PROGRESS_HIDE)
End Sub

Private Sub RaiseProgressEvent (Value As Int)
	If xui.SubExists(mCallback, mEventName & "_progress", 1) Then
		CallSubDelayed2(mCallback, mEventName & "_progress", Value)
	End If
End Sub

Private Sub RaiseErrorEvent (Key As String, Message As String) 'ignore
	If xui.SubExists(mCallback, mEventName & "_error", 2) Then
		CallSubDelayed3(mCallback, mEventName & "_error", Key, Message)
	End If
End Sub