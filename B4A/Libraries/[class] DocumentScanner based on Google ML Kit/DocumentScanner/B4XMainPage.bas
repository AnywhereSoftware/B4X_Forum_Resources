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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=DocumentScanner.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private scanner As DocumentScanner
	Private CustomListView1 As CustomListView
	Private Provider As FileProvider
	Private btnPdf As B4XView
	Private LastPdfUri As String
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	scanner.Initialize(Me, "Scanner")
	Provider.Initialize
End Sub

Private Sub btnScan_Click
	CustomListView1.Clear
	Wait For (scanner.Scan(True)) Complete (Result As DocumentScanResult)
	btnPdf.Enabled = Result.Success
	If Result.Success Then
		For Each uri As String In Result.ImageUris
			Dim bmp As B4XBitmap = xui.LoadBitmapResize("ContentDir", uri, 200dip, 200dip, True) 'Dir = "ContentDir"
			Dim pnl As B4XView = xui.CreatePanel("")
			pnl.SetLayoutAnimated(0, 0, 0, CustomListView1.AsView.Width, 200dip)
			Dim iv As B4XImageView = XUIViewsUtils.CreateB4XImageView
			pnl.AddView(iv.mBase, 0, 0, pnl.Width, pnl.Height)
			iv.mBackgroundColor = xui.Color_Black
			iv.Bitmap = bmp
			CustomListView1.Add(pnl, "")
		Next
		LastPdfUri = Result.PdfUri
	End If
End Sub


Private Sub btnPdf_Click
	File.Copy("ContentDir", LastPdfUri, Provider.SharedFolder, "file.pdf")
	'open the pdf with an external pdf viewer:
	Dim in As Intent
	in.Initialize(in.ACTION_VIEW, "")
	Provider.SetFileUriAsIntentData(in, "file.pdf")
	in.SetType("application/pdf")
	Try
		StartActivity(in) 'this will throw an error if there is no pdf viewer installed.
	Catch
		Log(LastException)
		ToastMessageShow(LastException.Message, True)
	End Try
End Sub