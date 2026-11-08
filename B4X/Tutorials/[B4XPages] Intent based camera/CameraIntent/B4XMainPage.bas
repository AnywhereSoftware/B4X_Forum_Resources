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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=CameraIntent.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private ImageView1 As B4XView
	#if B4A
	Private const tempImageFile As String = "tempimage.jpg"
	Private Provider As FileProvider
	Private ion As Object
	#Else If B4i
	Private Camera As Camera
	#end if
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	#if B4A
	Provider.Initialize
	StartService(KeepRunningService)
	#Else If B4i
	Camera.Initialize("Camera", B4XPages.GetNativeParent(Me))
	#end if
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Sub Button1_Click
	TakePicture (ImageView1.Width, ImageView1.Height)
	Wait For Image_Available(Success As Boolean, bmp As B4XBitmap)
	If Success Then
		ImageView1.SetBitmap(bmp)
	End If
End Sub


#if B4A
Private Sub TakePicture (TargetWidth As Int, TargetHeight As Int)
	Dim i As Intent
	i.Initialize("android.media.action.IMAGE_CAPTURE", "")
	File.Delete(Provider.SharedFolder, tempImageFile)
	Dim u As Object = Provider.GetFileUri(tempImageFile)
	i.PutExtra("output", u) 'the image will be saved to this path
	Try
		Wait For (CallSub(KeepRunningService, "Start")) Complete (Unused As Boolean)
		StartActivityForResult(i)
		Wait For ion_Event (MethodName As String, Args() As Object)
		CallSub(KeepRunningService, "Stop")
		Dim bmp As B4XBitmap
		If -1 = Args(0) Then
			Try
				Dim in As Intent = Args(1)
				If File.Exists(Provider.SharedFolder, tempImageFile) Then
					Dim Exif As ExifData
					Exif.Initialize(Provider.SharedFolder, tempImageFile)
					bmp = LoadBitmapSample(Provider.SharedFolder, tempImageFile, Max(TargetWidth, TargetHeight), Max(TargetWidth, TargetHeight))
					Log("Orientation: " & Exif.getAttribute(Exif.TAG_ORIENTATION))
					Select Exif.getAttribute(Exif.TAG_ORIENTATION)
						Case Exif.ORIENTATION_ROTATE_180 '3
							bmp = bmp.Rotate(180)
						Case Exif.ORIENTATION_ROTATE_90 '6
							bmp = bmp.Rotate(90)
						Case Exif.ORIENTATION_ROTATE_270 '8
							bmp = bmp.Rotate(270)
					End Select
					bmp = bmp.Resize(TargetWidth, TargetHeight, True)
				Else If in.HasExtra("data") Then 'try to get thumbnail instead
					Dim jo As JavaObject = in
					bmp = jo.RunMethodJO("getExtras", Null).RunMethod("get", Array("data"))
				End If
			Catch
				Log(LastException)
			End Try
		End If
		CallSubDelayed3(Me, "Image_Available", bmp.IsInitialized, bmp)
	Catch
		ToastMessageShow("Camera is not available.", True)
		Log(LastException)
		CallSubDelayed3(Me, "Image_Available", False, Null)
	End Try
End Sub


Sub StartActivityForResult(i As Intent)
	Dim jo As JavaObject = Me
	jo = jo.RunMethod("getBA", Null)
	ion = jo.CreateEvent("anywheresoftware.b4a.IOnActivityResult", "ion", Null)
	jo.RunMethod("startActivityForResult", Array(ion, i))
End Sub
#else if B4i
Private Sub TakePicture (TargetWidth As Int, TargetHeight As Int)
	Camera.TakePicture
	Dim TopPage As String = B4XPages.GetManager.GetTopPage.Id
	Wait For Camera_Complete (Success As Boolean, Image As Bitmap, VideoPath As String)
	B4XPages.GetManager.mStackOfPageIds.Add(TopPage) 'this is required as the page will be removed from the stack when the external camera page appears.
	If Success Then
		Dim bmp As B4XBitmap = Image
		bmp.Resize(TargetWidth, TargetHeight, True)
		CallSubDelayed3(Me, "Image_Available", True, bmp)
	Else
		CallSubDelayed3(Me, "Image_Available", False, Null)
	End If
End Sub
#end if