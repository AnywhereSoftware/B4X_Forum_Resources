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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip

Sub Class_Globals
	Private Root As B4XView
	Private XUI As XUI

	Private HME As HoneywellMobilityEnhanced

	Private Title As String = "Honeywell Mobility Library"

	Private PrevX, PrevY As Float

	Private PnlSignature As B4XView
	Private CnvSignature As B4XCanvas
	Private LblData As B4XView
	Private ImgImage As B4XView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True

	'Initialize the scanner library instance
	HME.Initialize("HME")
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me, Title)

	'Enables library logging for debugging purposes, disabled (False) by default).
	HME.EnableLogging(True)

	'Initialize the Signature Canvas
	CnvSignature.Initialize(PnlSignature)
	CnvSignature.DrawRect(CnvSignature.TargetRect, Colors.White, True, 0)
	CnvSignature.Invalidate
End Sub

'This is the correct place to claim the scanner if it has not already been claimed (OnResume).
'The scanner is claimed as soon as the page is visible.
Private Sub B4XPage_Appear
	Log("Page appeared, claim scanner (if need be)...")
	HME.OnResume

	If HME.IsClaimed Then
		If HME.IsScannerReady Then
			RunTests
		End If
	End If
End Sub

'This is the correct place to release the scanner (OnPause).
'The scanner is released as soon as the page is no longer visible.
Private Sub B4XPage_Disappear
	Log("Page disappeared, releasing scanner...")
	If HME.IsScannerReady Then HME.OnPause
End Sub

'This sub is optional but a good practice for final cleanup.
Private Sub B4XPage_CloseRequest As ResumableSub
	Log("Page close request...")

	'Wait for a user response before closing the page
	Dim SF As Object = XUI.Msgbox2Async("Close this app?", Title, "Yes", "", "No", Null)
	Wait For (SF) Msgbox_Result (Result As Int)
	If Result = XUI.DialogResponse_Positive Then
		'Clean up all the resources
		HME.OnDestroy
		Return True 'Allow the page to close
	Else
		Return False 'Prevent the page from closing
	End If
End Sub

'MAIN TEST APP CODE BELOW

'MANUALLY SCAN FOR BARCODES OR QR CODES
Private Sub BtnManualScan_Click
	HME.SetSoftwareTriggerState(True)
	HME.SetTriggerScanMode("oneShot")
	HME.StartScan
End Sub

'SHOW SCAN HISTORY (LAST 50 SCANS)
Private Sub BtnLastFifty_Click	
	Dim History As List = HME.GetScanHistory
	If History.Size > 0 Then
		Log("Showing Scan History (last 50 items):")
		For Each scannedData As String In History
			Log(scannedData)
		Next
	Else
		Log("Scan history is empty.")
	End If
End Sub

'THIS IS JUST A BASIC TEST SIGNATURE PAD, YOU SHOULD USE THE PAD CREATED BY DonManfred ETC ON THE FORUM
Private Sub PnlSignature_Touch (Action As Int, X As Float, Y As Float)
	'Check the type of touch event
	Select Action
		Case PnlSignature.As(Panel).ACTION_DOWN 'Finger or stylus first touches the screen
			'Record the starting point of the signature.
			PrevX = X
			PrevY = Y
		Case PnlSignature.As(Panel).ACTION_MOVE 'Finger or stylus is moving on the screen
			'Draw a line from the previous point to the current point.
			CnvSignature.DrawLine(PrevX, PrevY, X, Y, Colors.Black, 2dip)

			'Update the canvas to show the new line segment.
			CnvSignature.Invalidate

			'Update the previous point to the current point for the next line segment.
			PrevX = X
			PrevY = Y
		Case PnlSignature.As(Panel).ACTION_UP 'Finger or stylus is lifted from the screen
			'Drawing is complete for this stroke.
			'No action needed here, as the drawing is handled by ACTION_MOVE.

			ImgImage.SetBitmap(CnvSignature.CreateBitmap)
			Log("Stroke complete.")
	End Select
End Sub

'CLEAR THE SIGNATURE
Private Sub BtnClear_Click
	CnvSignature.DrawRect(CnvSignature.TargetRect, Colors.White, True, 0)
	CnvSignature.Invalidate

	ImgImage.SetBitmap(CnvSignature.CreateBitmap)
End Sub

'PUT YOUR OWN SAVE SIGNATURE ROUTINE IN HERE
Private Sub BtnSaveImage_Click
	'Create a bitmap from the canvas.
	Dim BmpCapturedImage As Bitmap = CnvSignature.CreateBitmap 'ignore

	'Put your save bitmap image here
	ToastMessageShow("Your own image save routine!!!", True)
End Sub

'SHOW THE BARCODE DATA IN THE LOGS
Private Sub HME_BarcodeScanned(Data As String)
	Log("Scanned: " & Data)
	LblData.Text = Data

	'Retrieve the last scanned image, the _OnImageCaptured (Image As Bitmap) sub will be fired
	HME.CaptureLastScannedImage

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
	If Pressed Then
		Log("Trigger pressed")
	Else
		Log("Trigger released")
	End If
End Sub

'THIS SUB WILL BE TRIGGERED WHEN THE IMAGE IS CAPTURED.
Sub HME_OnImageCaptured(ImageData() As Byte)
	Dim In As InputStream
		In.InitializeFromBytesArray(ImageData, 0, ImageData.Length)

	Dim BmpImageCaptured As Bitmap
		BmpImageCaptured.Initialize2(In)

	ImgImage.SetBitmap(BmpImageCaptured)
End Sub

'THIS SUB WILL BE TRIGGERED WHEN THE IMAGE CAPTURE FAILS.
Private Sub HME_OnImageCaptureFailed (Message As String)
	'This Sub is called when the HME library fails to capture a bitmap image
	Log("Image capture failed: " & Message)
End Sub

Sub HME_OnGuidanceFeedback(Message As String)
	Log("Guidance: " & Message)
End Sub

'TEST ROUTINE SUB TO SHOW THE DEVELOPER EXAMPLES OF HOW TO USE THIS LIBRARY
Private Sub RunTests()
	Log("----------------------------------------------------------------")
	'Gets the barcode scanners firmware version.
	Log("Firmware version: " & HME.GetScannerFirmwareVersion)

	Log("----------------------------------------------------------------")
	'Get the barcode scanner name
	Log("Connected to: " & HME.GetConnectedScannerName)

	Log("----------------------------------------------------------------")
	'Get barcode connection status	
	Log("Barcode is: " & HME.GetConnectionStatus)

	Log("----------------------------------------------------------------")
	'Get the scanner Id
	Log("Scanner Id: " & HME.GetScannerId)

	Log("----------------------------------------------------------------")
	'Get the scanner serial number
	Log("Serial number: " & HME.GetScannerSerialNumber)

	Log("----------------------------------------------------------------")
	'Get the Scanner Information
	Dim ScannerInfo As Map = HME.GetBarcodeReaderInfo

	Log("----------------------------------------------------------------")
	'Now you can access the values from the map using the key names.
	If ScannerInfo.IsInitialized Then
		Log("Scanner Name: " & ScannerInfo.Get("Name"))
		Log("Connection Name: " & ScannerInfo.Get("ConnectionName"))
		Log("Scanner Friendly Name: " & ScannerInfo.Get("FriendlyName"))
		Log("Scanner Firmware Version: " & ScannerInfo.Get("FirmwareVersion"))
		Log("Scanner ScannerId: " & ScannerInfo.Get("ScannerId"))
		Log("Scanner Version: " & ScannerInfo.Get("ScannerVersionNumber"))
		Log("Scanner Serial: " & ScannerInfo.Get("ScannerSerialNumber"))
		Log("Full Decode Version: " & ScannerInfo.Get("FullDecodeVersion"))

		'You can also check if a key exists before trying to get it.
		If ScannerInfo.ContainsKey("ScannerSerialNumber") Then
			Log("Scanner Serial: " & ScannerInfo.Get("ScannerSerialNumber"))
		End If
	Else
		Log("Scanner information could not be retrieved.")
	End If

	Log("----------------------------------------------------------------")
	'Select scanner by friendly name
	HME.SelectScannerByFriendlyName(ScannerInfo.Get("FriendlyName")) 
	Log("Connected to: " & HME.GetConnectedScannerName)

	Log("----------------------------------------------------------------")
	'Gets a list of system-level scanner names.
	Dim ScannerList As List = HME.ListScanners
	If ScannerList.IsInitialized And ScannerList.Size > 0 Then
		Log("Found the following scanners:")
		For Each scannerName As String In ScannerList
			Log(scannerName)
		Next
	Else
		Log("No scanners found or library not initialized.")
	End If

	Log("----------------------------------------------------------------")
	'Gets a list of user-friendly names for all available scanners.
	Dim ScannerNames As List = HME.ListAvailableScanners
	If ScannerNames.IsInitialized And ScannerNames.Size > 0 Then
		Log("Found the following scanners:")
		For Each scannerName As String In ScannerNames
			Log(scannerName)
		Next
	Else
		Log("No scanners found or library not initialized.")
	End If

	Log("----------------------------------------------------------------")
	'Gets a list of strings detailing the enabled/disabled state of various symbologies.
	Dim SymbologyList As List = HME.GetSymbologyStates
	If SymbologyList.IsInitialized Then
		Log("Current Symbology States:")
		For Each stateString As String In SymbologyList
			Log(stateString)
		Next
	Else
		Log("Could not get symbology states. Scanner may not be initialized.")
	End If

	Log("----------------------------------------------------------------")
	'Gets a Map of all scanner properties (each key-value pair).
	Dim AllProps As Map = HME.GetAllProperties
	If AllProps.IsInitialized Then
		Log("Listing all scanner properties:")
		For Each key As Object In AllProps.Keys
			Log(key & ": " & AllProps.Get(key))
		Next
		'You can also retrieve a specific property by its key
		Dim GoodReadEnabled As Object = AllProps.Get("NTF_GOOD_READ_ENABLED")
		Log("Is good read notification enabled? " & GoodReadEnabled)
	Else
		Log("Map is not initialized. Scanner may not be ready.")
	End If

	Log("----------------------------------------------------------------")
	'Retrieve the property value using the GetProperty method
	'The property is of type boolean in the Honeywell SDK, so it will return a B4A boolean.
	Dim IsGoodReadEnabled As Object = HME.GetProperty("NTF_GOOD_READ_ENABLED")
	If IsGoodReadEnabled <> Null Then
		'The value is an Object, so you can check if it's a Boolean and cast it.
		If IsGoodReadEnabled Then
			Log("Good read notification is enabled.")
		Else
			Log("Good read notification is disabled.")
		End If
	Else
		Log("Could not retrieve the good read notification property.")
	End If

	Log("----------------------------------------------------------------")
	'Example 1: Set a boolean property (Enable a symbology)
	'Property name constants can be found in the Honeywell SDK documentation.

	'Here we enabling the EAN8 check digit transmit.
	HME.SetProperty("DEC_EAN8_CHECK_DIGIT_TRANSMIT", True)
	Log("DEC_EAN8_CHECK_DIGIT_TRANSMIT: " & HME.GetProperty("DEC_EAN8_CHECK_DIGIT_TRANSMIT"))	

	'Here we enabling the EAN13 check digit transmit.
	HME.SetProperty("DEC_EAN13_CHECK_DIGIT_TRANSMIT", True)
	Log("DEC_EAN13_CHECK_DIGIT_TRANSMIT: " & HME.GetProperty("DEC_EAN13_CHECK_DIGIT_TRANSMIT"))

	Log("----------------------------------------------------------------")
	'Example 2: Set an integer property (Set the decoder timeout)
	'Property name constants can be found in the Honeywell SDK documentation.
	'Defines a timeout period in milliseconds for decoding the same barcode twice in a row
	HME.SetProperty("TRIG_SCAN_SAME_SYMBOL_TIMEOUT", 5000)
	Log("TRIG_SCAN_SAME_SYMBOL_TIMEOUT: " & HME.GetProperty("TRIG_SCAN_SAME_SYMBOL_TIMEOUT"))

	'Get the state of a specific symbology (returns a Boolean)
	'Property name constants can be found in the Honeywell SDK documentation.
	Dim UPCE_enabled As Object = HME.GetProperty("DEC_UPCE0_ENABLED")
	If UPCE_enabled <> Null Then
		If UPCE_enabled Then
			Log("UPC-E symbology is currently enabled.")
		Else
			Log("UPC-E symbology is currently disabled.")
		End If		
	End If

	'You can use the above method for any property that accepts a value
	'that can be represented as a String, Boolean, or Number.
	'For a full list of properties, you would need to consult the Honeywell
	'SDK documentation.

	Log("----------------------------------------------------------------")
	'Set trigger mode
	HME.SetTriggerScanMode("readOnRelease")

	Log("----------------------------------------------------------------")
	'Manage the trigger and control absolutely everything yourself (light, aimer, imagr). 
	'If set to true, the _TriggerChanged will be triggered
	HME.ManageTrigger(False)

	Log("----------------------------------------------------------------")
	'Set decoder timeout to 5000ms (5000 is the default)
	HME.SetDecoderTimeout(5000)
	
	Log("----------------------------------------------------------------")
	'Open the browser if the scanned QR code is a url.
	HME.QROpenBrowser = True
	
	Log("----------------------------------------------------------------")
	'*** Read/Set the symbology state ***
	'Read the current state
	ReadSymbologyState
	
	'Set the state to true (Should be already true, you can set to false to see the log result)
	HME.SetSymbologyEnabled(HME.Symbologies.QR_ENABLED, True)
	
	'Read the current state again
	ReadSymbologyState
	
	'Reset scanner back to it's initialization settings
	'HME.ResetScannerToDefaults

	Log("----------------------------------------------------------------")
End Sub

'Test for HME.SetSymbologyEnabled(HME.SymbologyList.QR_ENABLED, True)
Sub ReadSymbologyState
	Dim SymbologyList As List = HME.GetSymbologyStates
	If SymbologyList.IsInitialized Then
		For Each stateString As String In SymbologyList
			If stateString.Contains("DEC QR") Then Log(stateString)
		Next
	Else
		Log("Could not get symbology states. Scanner may not be initialized.")
	End If
End Sub
