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
	Private xui As XUI
	Private PdfExport As WebViewPdfExport
	Private WebView1 As WebView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	PdfExport.Initialize(WebView1)
	Log(PdfExport.SetupInstructions)
'	WebView1.LoadUrl("https://www.b4x.com/b4a.html")
	WebView1.LoadHtml(File.ReadString(File.DirAssets,"pdf_test_page.html"))
	
End Sub

Private Sub btnExport_Click
'Save PDF only
	'PdfExport.ExportToFile("my_file.pdf")
	
' Export + share sheet (one call)
	Wait For (PdfExport.ExportAndShare("My Document.pdf", "Share your document")) Complete (success As Boolean)
	If success Then
		Log("PDF shared!")
	Else
		Log("PDF export failed")
	End If
End Sub