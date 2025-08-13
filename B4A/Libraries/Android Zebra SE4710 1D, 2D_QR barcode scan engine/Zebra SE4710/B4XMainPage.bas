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

	'Ctrl + click To export As zip: ide://run?File=%B4X%\Zipper.jar&Args=\%PROJECT_NAME%.zip
	'Ctrl + click To build: ide://run?File=%B4X%\B4ABuilder.exe&Args=-Task%3DBuild&Args=-BaseFolder%3D..

Sub Class_Globals
	Private Root As B4XView
	Private XUI As XUI

	Private BarcodeScanner As ZebraSE4710
	Public LblBarcode As B4XView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")

	BarcodeScanner.Initialize(Null)
	Log($"BarcodeScanner Initialized: ${BarcodeScanner.IsInitialized}"$)
	
	If BarcodeScanner.IsInitialized Then
		BarcodeScanner.OpenScanner
		StartReceiver(BarcodeReceiver) 'Start instantly
	End If
End Sub

Private Sub B4XPage_Appear
End Sub

private Sub B4XPage_Disappear
End Sub

Private Sub B4XPage_KeyPress (KeyCode As Int) As Boolean
	Log($"KeyCode: ${KeyCode}"$)

	Select Case KeyCode
		Case KeyCodes.KEYCODE_VOLUME_UP '24
			Log("Volume up")
		Case KeyCodes.KEYCODE_VOLUME_DOWN '25
			Log("Volume down")
		Case 134 'Top scan button
			B4XPages.MainPage.BarcodeScanner.StartScan
		Case 136 'PTT
			Log("Push to talk")
		Case 137 'Left and right scan buttons
			B4XPages.MainPage.BarcodeScanner.StartScan
	End Select

	Return False
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.\\\\
