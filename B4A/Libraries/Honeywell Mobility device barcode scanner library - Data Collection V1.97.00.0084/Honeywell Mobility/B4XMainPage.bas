B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
'#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip

Sub Class_Globals
	Private Root As B4XView
	Private XUI As XUI

	Private HME As HoneywellMobilityEnhanced

	Private PrevX, PrevY As Float

	Private ImageView1 As ImageView
	Private PnlSignature As Panel
	Private CnvSignature As B4XCanvas
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")

	' Initialize the scanner library instance
	HME.Initialize("HME")
	
	' Initialize the Signature Canvas
	CnvSignature.Initialize(PnlSignature)
End Sub

' This is the correct place to claim the scanner.
' The scanner is claimed only when this page is visible.
Private Sub B4XPage_Appear
	Log("Page appeared, claiming scanner...")

	' Can also use
	 HME.OnResume
	
	' Clear the canvas initially
	CnvSignature.DrawRect(CnvSignature.TargetRect, Colors.White, True, 0)
	CnvSignature.Invalidate
	
	If HME.IsClaimed Then
		If HME.IsScannerReady Then
			RunTests
		End If
	End If
End Sub

' This is the correct place to release the scanner.
' The scanner is released as soon as the page is no longer visible.
Private Sub B4XPage_Disappear
	Log("Page disappeared, releasing scanner...")
	
	' Can also use
	 HME.OnPause
End Sub

' This sub is optional but a good practice for final cleanup.
Private Sub B4XPage_CloseRequest As ResumableSub
	Log("Page close request...")

	' Wait for a user response before closing the page
	Dim SF As Object = XUI.Msgbox2Async("Close?", "Title", "Yes", "Cancel", "No", Null)
	Wait For (SF) Msgbox_Result (Result As Int)
	If Result = XUI.DialogResponse_Positive Then
		' Release the scanner one last time before exiting
		HME.ReleaseScanner
		Return True ' Allow the page to close
	End If
	Return False ' Prevent the page from closing
End Sub

Private Sub BtnManualScan_Click
	'HME.SetIlluminationEnabled(True)
	'HME.SetAimerEnabled(True)
	HME.SetSoftwareTriggerState(True)
	HME.SetTriggerScanMode("oneShot")
	HME.StartScan
End Sub

Private Sub PnlSignature_Touch (Action As Int, X As Float, Y As Float)
	' This subroutine handles all touch events on the signature panel, allowing the user to draw.

	' Check the type of touch event
	Select Action
		Case PnlSignature.ACTION_DOWN ' Finger or stylus first touches the screen
			' Record the starting point of the signature.
			PrevX = X
			PrevY = Y

		Case PnlSignature.ACTION_MOVE ' Finger or stylus is moving on the screen
			' Draw a line from the previous point to the current point.
			CnvSignature.DrawLine(PrevX, PrevY, X, Y, Colors.Black, 2dip)

			' Update the canvas to show the new line segment.
			CnvSignature.Invalidate

			' Update the previous point to the current point for the next line segment.
			PrevX = X
			PrevY = Y

		Case PnlSignature.ACTION_UP ' Finger or stylus is lifted from the screen			
			' Drawing is complete for this stroke.
			' No action needed here, as the drawing is handled by ACTION_MOVE.

			ImageView1.Bitmap = CnvSignature.CreateBitmap
			Log("Stroke complete.")
	End Select
End Sub

Private Sub BtnSaveImage_Click
	' Create a bitmap from the canvas.
	Dim BmpCapturedImage As Bitmap = CnvSignature.CreateBitmap 'ignore

	'Put your save bitmap image here
	ToastMessageShow("Your image save routine!!!", True)
End Sub

Private Sub HME_BarcodeScanned(Data As String)
	' Show the barcode data in the logs
	Log("Scanned: " & Data)

	' Retrieve the last scanned image, the _OnImageCaptured (Image As Bitmap) sub will be fired
	HME.CaptureLastScannedImage

	' Show scan history (Last 50 scans)
	Dim History() As String = HME.GetScanHistory
	If History.Length > 0 Then
		Log("Showing Scan History (last 50 items):")
		For Each scannedData As String In History
			Log(scannedData)
		Next
	Else
		Log("Scan history is empty.")
	End If
	
	'Set trigger mode again
	HME.SetTriggerScanMode("readOnRelease")
End Sub

Private Sub HME_OnFailureEvent (Message As String)
	Log("Scanner Failure: " & Message)
End Sub

Private Sub HME_ScannerConnectionChanged (IsConnected As Boolean)
	Log("Scanner Connected: " & IsConnected)
End Sub

Private Sub HME_ScannerStatusChanged(Status As String)
	Log("Status: " & Status)
End Sub

Private Sub HME_ScannerUnavailable (Message As String)
	Log("Scanner Unavailable: " & Message)
End Sub

Private Sub HME_TriggerChanged(Pressed As Boolean)
	' Barcode trigger button
	If Pressed Then
		Log("Trigger pressed")
	Else
		Log("Trigger released")
	End If
End Sub

	' This sub will be triggered when the image is captured or you use CaptureSignatureImage for the last image to be recalled.
Sub HME_OnImageCaptured(ImageData() As Byte)
	Dim In As InputStream
		In.InitializeFromBytesArray(ImageData, 0, ImageData.Length)

	Dim BmpImageCaptured As Bitmap
		BmpImageCaptured.Initialize2(In)

	ImageView1.Bitmap = BmpImageCaptured
End Sub

Private Sub HME_OnImageCaptureFailed (Message As String)
	' This Sub is called when the HME library fails to capture a bitmap image
	Log("Image capture failed: " & Message)
End Sub

Sub HME_OnGuidanceFeedback(Message As String)
	Log("Guidance: " & Message)
End Sub

Private Sub RunTests()
	' Enables logging for debugging purposes, disabled (False) by default).
	HME.EnableLogging(True)

	' Gets the barcode scanners firmware version.
	Log("Firmware version: " & HME.GetScannerFirmwareVersion)

	' Get the barcode scanner name
	Log("Connected to: " & HME.GetConnectedScannerName)

	' Get barcode connection status	
	Log("Barcode is: " & HME.GetConnectionStatus)

	' Get the scanner Id
	Log(HME.GetScannerId)

	' Get the scanner serial number
	Log(HME.GetScannerSerialNumber)

	' Get the Scanner Information
	Dim ScannerInfo As Map = HME.GetBarcodeReaderInfo
	' Now you can access the values from the map using the key names.
	If ScannerInfo.IsInitialized Then
		Log("Scanner Name: " & ScannerInfo.Get("Name"))
		Log("Connection Name: " & ScannerInfo.Get("ConnectionName"))
		Log("Scanner Friendly Name: " & ScannerInfo.Get("FriendlyName"))
		Log("Scanner Firmware Version: " & ScannerInfo.Get("FirmwareVersion"))
		Log("Scanner ScannerId: " & ScannerInfo.Get("ScannerId"))
		Log("Scanner Version: " & ScannerInfo.Get("ScannerVersionNumber"))
		Log("Scanner Serial: " & ScannerInfo.Get("ScannerSerialNumber"))
		Log("Full Decode Version: " & ScannerInfo.Get("FullDecodeVersion"))

		' You can also check if a key exists before trying to get it.
		If ScannerInfo.ContainsKey("ScannerSerialNumber") Then
			Log("Scanner Serial: " & ScannerInfo.Get("ScannerSerialNumber"))
		End If
	Else
		Log("Scanner information could not be retrieved.")
	End If

	' Select scanner by friendly name
	HME.SelectScannerByFriendlyName(ScannerInfo.Get("FriendlyName")) 
	Log("Connected to: " & HME.GetConnectedScannerName)

	' Gets a list of system-level scanner names.
	Dim scannerList As List = HME.ListScanners
	If scannerList.IsInitialized And scannerList.Size > 0 Then
		Log("Found the following scanners:")
		For Each scannerName As String In scannerList
			Log(scannerName)
		Next
	Else
		Log("No scanners found or library not initialized.")
	End If

	' Gets a list of user-friendly names for all available scanners.
	Dim scannerNames As List = HME.ListAvailableScanners
	If scannerNames.IsInitialized And scannerNames.Size > 0 Then
		Log("Found the following scanners:")
		For Each scannerName As String In scannerNames
			Log(scannerName)
		Next
	Else
		Log("No scanners found or library not initialized.")
	End If

	' Gets a list of strings detailing the enabled/disabled state of various symbologies.
	Dim symbologyList As List = HME.GetSymbologyStates
	If symbologyList.IsInitialized Then
		Log("Current Symbology States:")
		For Each stateString As String In symbologyList
			Log(stateString)
		Next
	Else
		Log("Could not get symbology states. Scanner may not be initialized.")
	End If

	' Gets a Map of all scanner properties (each key-value pair).
	Dim allProps As Map = HME.GetAllProperties
	If allProps.IsInitialized Then
		Log("Listing all scanner properties:")
		For Each key As Object In allProps.Keys
			Log(key & ": " & allProps.Get(key))
		Next
		' You can also retrieve a specific property by its key
		Dim GoodReadEnabled As Object = allProps.Get("NTF_GOOD_READ_ENABLED")
		Log("Is good read notification enabled? " & GoodReadEnabled)
	Else
		Log("Map is not initialized. Scanner may not be ready.")
	End If
	
	' Retrieve the property value using the GetProperty method
	' The property is of type boolean in the Honeywell SDK, so it will return a B4A boolean.
	
	Dim IsGoodReadEnabled As Object = HME.GetProperty("NTF_GOOD_READ_ENABLED")
	If IsGoodReadEnabled <> Null Then
		' The value is an Object, so you can check if it's a Boolean and cast it.
		If IsGoodReadEnabled Then
			Log("Good read notification is enabled.")
		Else
			Log("Good read notification is disabled.")
		End If
	Else
		Log("Could not retrieve the good read notification property.")
	End If

	' Example 1: Set a boolean property (Enable a symbology)
	' Property name constants can be found in the Honeywell SDK documentation.
	' Here we enable the EAN13 barcode type.
	HME.SetProperty("DEC_EAN13_ENABLED", True)
	Log("DEC_EAN13_ENABLED: " & HME.GetProperty("DEC_EAN13_ENABLED"))
    
	' Example 2: Set an integer property (Set the decoder timeout)
	' Property name constants can be found in the Honeywell SDK documentation.
	' Defines a timeout period in milliseconds for decoding the same barcode twice in a row
	HME.SetProperty("TRIG_SCAN_SAME_SYMBOL_TIMEOUT", 5000)
	Log("TRIG_SCAN_SAME_SYMBOL_TIMEOUT: " & HME.GetProperty("TRIG_SCAN_SAME_SYMBOL_TIMEOUT"))

	' Get the state of a specific symbology (returns a Boolean)
	' Property name constants can be found in the Honeywell SDK documentation.
	Dim upcE_enabled As Object = HME.GetProperty("DEC_UPCE0_ENABLED")
	If upcE_enabled <> Null Then
		If upcE_enabled Then
			Log("UPC-E symbology is currently enabled.")
		Else
			Log("UPC-E symbology is currently disabled.")
		End If		
	End If

	' You can use the above method for any property that accepts a value
	' that can be represented as a String, Boolean, or Number.
	' For a full list of properties, you would need to consult the Honeywell
	' SDK documentation.

	' Set trigger mode
	HME.SetTriggerScanMode("readOnRelease")

	' Set decoder timeout to 5000ms (5000 is the default)
	HME.SetDecoderTimeout(5000)
	Log("DecoderTimeout: " & HME.GetDecoderTimeout)
End Sub
