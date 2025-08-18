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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private pnlPreview As B4XView
	Private btnStartStop As B4XView
	#if B4A
	Private rp As RuntimePermissions
	Private detector As JavaObject
	Private camEx As CameraExClass
	Private LastPreview As Long
	Private IntervalBetweenPreviewsMs As Int = 100
	#else if B4i
	Private scanner As BarcodeScanner
	#End If
	Private toast As BCToast
	Private lblResult As B4XView
	Private Capturing As Boolean
End Sub

Public Sub Initialize
	
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	toast.Initialize(Root)
	StopCamera
	B4XPages.SetTitle(Me, "Barcode Example")
	#if B4A
	CreateDetector (Array("CODE_128", "CODE_93", "QR_CODE"))
	#Else if B4i
	scanner.Initialize2("scanner", pnlPreview, Array(scanner.TYPE_93, scanner.TYPE_128, scanner.TYPE_QR))
	Wait For Scanner_Ready (Success As Boolean)
	If Success = False Then
		btnStartStop.Enabled = False
		toast.Show("Failed to initialize the scanner.")
	End If
	#end if
End Sub

Private Sub B4XPage_Disappear
	StopCamera
End Sub


Sub btnStartStop_Click
	If Capturing = False Then
		StartCamera
	Else
		StopCamera
	End If
End Sub

Private Sub StopCamera
	Capturing = False
	btnStartStop.Text = "Start"
	pnlPreview.Visible = False
	#if B4A
	If camEx.IsInitialized Then
		camEx.Release
	End If
	#Else If B4i
	scanner.Stop
	#end if
End Sub

Private Sub StartCameraShared
	btnStartStop.Text = "Stop"
	pnlPreview.Visible = True
	Capturing = True
End Sub

Private Sub FoundBarcode (msg As String)
	lblResult.Text = msg
	toast.Show($"Found [Color=Blue][b][plain]${msg}[/plain][/b][/Color]"$)
End Sub


#if B4A
Private Sub StartCamera
	rp.CheckAndRequest(rp.PERMISSION_CAMERA)
	Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)
	If Result = False Then
		toast.Show("No permission!")
		Return
	End If
	StartCameraShared
	camEx.Initialize(pnlPreview, False, Me, "Camera1")
	Wait For Camera1_Ready (Success As Boolean)
	If Success Then
		camEx.SetContinuousAutoFocus
		camEx.CommitParameters
		camEx.StartPreview
	Else
		toast.Show("Error opening camera")
		StopCamera
	End If
End Sub


Private Sub CreateDetector (Codes As List)
	Dim ctxt As JavaObject
	ctxt.InitializeContext
	Dim builder As JavaObject
	builder.InitializeNewInstance("com/google/android/gms/vision/barcode/BarcodeDetector.Builder".Replace("/", "."), Array(ctxt))
	Dim barcodeClass As String = "com/google/android/gms/vision/barcode/Barcode".Replace("/", ".")
	Dim barcodeStatic As JavaObject
	barcodeStatic.InitializeStatic(barcodeClass)
	Dim format As Int
	For Each formatName As String In Codes
		format = Bit.Or(format, barcodeStatic.GetField(formatName))
	Next
	builder.RunMethod("setBarcodeFormats", Array(format))
	detector = builder.RunMethod("build", Null)
	Dim operational As Boolean = detector.RunMethod("isOperational", Null)
	If operational = False Then
		toast.Show("Failed to create detector")
	End If
	btnStartStop.Enabled = operational
End Sub

Private Sub Camera1_Preview (data() As Byte)
	If DateTime.Now > LastPreview + IntervalBetweenPreviewsMs Then
		'Dim n As Long = DateTime.Now
		Dim frameBuilder As JavaObject
		Dim bb As JavaObject
		bb = bb.InitializeStatic("java.nio.ByteBuffer").RunMethod("wrap", Array(data))
		frameBuilder.InitializeNewInstance("com/google/android/gms/vision/Frame.Builder".Replace("/", "."), Null)
		Dim cs As CameraSize = camEx.GetPreviewSize
		frameBuilder.RunMethod("setImageData", Array(bb, cs.Width, cs.Height,  842094169))
		Dim frame As JavaObject = frameBuilder.RunMethod("build", Null)
		Dim SparseArray As JavaObject = detector.RunMethod("detect", Array(frame))
		LastPreview = DateTime.Now
		Dim Matches As Int = SparseArray.RunMethod("size", Null)
		If Matches > 0 Then
			Dim barcode As JavaObject = SparseArray.RunMethod("valueAt", Array(0))
			Dim raw As String = barcode.GetField("rawValue")
			FoundBarcode(raw)
		End If
	End If
End Sub

#Else if B4I
Sub B4XPage_Resize (Width As Float, Height As Float)
	scanner.Resize
End Sub

Private Sub StartCamera
	scanner.Start
	StartCameraShared
End Sub

Sub scanner_Detected (Codes As List)
	If Codes.Size > 0 Then
		Dim code As BarcodeCode = Codes.Get(0)
		FoundBarcode(code.Value)
	End If
End Sub
#End If
