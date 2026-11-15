B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
	'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

	#Macro: Title, Export B4XPages, ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip

Sub Class_Globals
	Private Root As B4XView
	Private XUI As XUI

	Private NP As NativePrinter
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")

	NP.Initialize
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	NP.PrintContent(Root, True, False, "A4", 20, 20, 20, 20, "HIGH", "Print Form...")
	'NP.PrintCustomContent(NP.Snapshot(Root), True, True, 100, 50, 5, 5, 5, 5, "HIGH", "Test Print...")
End Sub

Private Sub Button2_Click
	Dim IV As ImageView
		IV.Initialize("")
		IV.SetSize(555, 810) 'A great ImageView size for printing on A4 paper
		IV.SetImage(XUI.LoadBitmap(File.DirAssets, "Invoice.jpg"))
		'IV.SetImage(Root.Snapshot) 'Standard lower quality screenchot
		'IV.SetImage(NP.Snapshot(Root)) 'Higher quality screenshot
		IV.PreserveRatio = True

	NP.PrintContent(IV, True, False, "A4", 20, 20, 20, 20, "HIGH", "Print Imageview...")
	'NP.PrintCustomContent(IV, True, False, 100, 50, 5, 5, 5, 5, "HIGH", "Test Print...")
End Sub

Private Sub Button3_Click
	For Each Prn As String In NP.GetPrinters
		Log($"Installed: ${Prn}"$  )
	Next
	
	Log($"Default: ${NP.GetDefaultPrinter}"$)
End Sub
