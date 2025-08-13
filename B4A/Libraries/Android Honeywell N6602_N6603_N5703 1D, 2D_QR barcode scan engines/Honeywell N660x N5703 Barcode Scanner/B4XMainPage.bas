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
'Ctrl + click To export As zip: ide://run?File=%B4X%\Zipper.jar&Args=\%PROJECT_NAME%.zip

Sub Class_Globals
	Private Root As B4XView
	Private XUI As XUI

	Private BScannner As HoneywellN660xN5703
	Public B4XLblBarcode As B4XView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.MainPage.B4XPages.SetTitle(Me, "Generic Barcode Scanner Library")

	StartReceiver(BarcodeReceiver) 'Start instantly

	BScannner.Initialize(Null)

	If BScannner.IsInitialized Then
		BScannner.SetScanBeep(True)
		BScannner.SetScanVibrate(True)
		BScannner.SetIndicatorLightMode(True)

		Log($"Open the scanner: ${BScannner.OpenScanner}"$) 'Laser scanner is turned on and will scan
		Log($"Is scanner open: ${BScannner.IsScanOpened}"$)
		Log($"Get beep state: ${BScannner.GetScanBeepState}"$)
		Log($"Get vibrate state: ${BScannner.GetScanVibrateState}"$)
		Log($"Get indicator light state: ${BScannner.GetIndicatorLightMode}"$)
		Log($"Get broadcast mode: ${BScannner.GetOutScanMode}"$)
		Log($"Get scan mode: ${BScannner.GetScanLaserMode}"$)
		Log($"Scanned barcode value: ${BScannner.GetScanCodeValue}"$)
		Log($"Reset the scanner: ${BScannner.ResetScan}"$)
		'Log($"Close the scanner: ${BScannner.CloseScanner}"$) 'Laser scanner is turned off and will not scan
	End If
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.
