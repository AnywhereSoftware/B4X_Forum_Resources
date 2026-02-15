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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private XUI As XUI

	Private BI As BlurImage

	Private ImageView1 As B4XView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")

	BI.Initialize("BI")

	ImageView1.SetBitmap(XUI.LoadBitmapResize(File.DirAssets, "Squirrel.jpg", ImageView1.Width, ImageView1.Height, False))
End Sub

Private Sub B4XPage_CloseRequest As ResumableSub
	BI.Release
	Return True
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	Dim Img As B4XBitmap = ImageView1.GetBitmap ' CAN ALSO USE ImageView1.Snapshot
	If Img.IsInitialized = False Then Return

	'Loop for slow transition blur effect
	For i = 0 To 99
		BI.BlurAsync(Img, i)
		Sleep(20) '20 milliseconds per transition for slow blur
	Next
End Sub

Sub BI_BlurDone(Blurred As Object)
	Dim Bmp As B4XBitmap = Blurred
	If Bmp.IsInitialized = False Then Return
	ImageView1.SetBitmap(Bmp)
End Sub
