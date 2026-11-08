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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=PDFtoImage.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	
	Private ImageView1 As B4XView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	ImageView1.SetBitmap(PdfToImage(File.DirAssets,"invoice.pdf"))
End Sub

#IF B4J
Private Sub PdfToImage(Path As String,filename As String) As B4XBitmap
	Dim PDF As pdfBoxWrapper
	PDF.Initialize(Me,"PDF", 1,0)
	File.Copy(Path,filename,File.DirTemp,filename)
	Dim img As B4XBitmap = PDF.loadDocumentToImage(File.Combine(File.DirTemp,filename),0)
	' 400dot is max for width
	Return img.Resize(400,600,True)
End Sub
	
	
#ELSE IF B4A
Private Sub PdfToImage(Path As String,filename As String) As B4XBitmap
	Dim pdfr As PDFRenderer
	File.Copy(Path,filename,File.DirInternalCache,filename)
	pdfr.Initialize("pdf",File.DirInternalCache, filename)
	Log(pdfr.PageCount)
	' 400dot is max for width
	Return pdfr.renderPageforDisplay(0).As(B4XBitmap).Resize(400,600,True)
	End Sub
#ELSE IF B4i
	Private Sub PdfToImage(Path As String,filename As String) As B4XBitmap
	Dim pdf As PDFDocument
	pdf.Initialize(Path,filename)
	
	Dim P As B4XView = xui.CreatePanel("")
	P.SetLayoutAnimated(0,0,0,ImageView1.Width,ImageView1.Height)
	
	Dim C As Canvas
	C.Initialize(p)
	C.DrawColor(Colors.White)
	C.DrawPDF(pdf,1,C.TargetRect)
	C.Refresh
	C.Release
	
	' 400dot is max for width
	Return P.Snapshot.Resize(400,600,True)
	End Sub
#End If