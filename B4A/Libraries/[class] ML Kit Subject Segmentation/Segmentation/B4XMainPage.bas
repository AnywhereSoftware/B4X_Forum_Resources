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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=SubjectSegmentation.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private segmenter As Segmentation
	Private B4XImageView1 As B4XImageView
	Private B4XImageView2 As B4XImageView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	segmenter.Initialize
End Sub

Private Sub Button1_Click
	Dim cc As ContentChooser
	cc.Initialize("cc")
	cc.Show("image/*", "choose image")
	Wait For cc_Result (Success As Boolean, Dir As String, FileName As String)
	If Success Then
		'I'm resizing the image here. It might be better to leave the image with the original resolution.
		Dim bmp As B4XBitmap = xui.LoadBitmapResize(Dir, FileName, B4XImageView1.mBase.Width, B4XImageView1.mBase.Height, True)
		B4XImageView1.Bitmap = bmp
		B4XImageView2.Clear
		Wait For (segmenter.Process(bmp)) Complete (Result As SegmentationResult)
		If Result.Success Then
			B4XImageView2.Bitmap = Result.ForegroundBitmap
		End If
	End If
End Sub