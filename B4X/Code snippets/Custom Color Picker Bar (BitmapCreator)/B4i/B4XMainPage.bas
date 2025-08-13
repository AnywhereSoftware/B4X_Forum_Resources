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

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private imgColorPalette As B4XView
	Private pnlContainerColor As B4XView
	Dim bc As BitmapCreator
	Private lblColor As B4XView
	Private pnlColorPreview As B4XView
	Private pnlTouchSensor As B4XView
	Private pnlCursor As B4XView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	Log($"${imgColorPalette.Width} x ${imgColorPalette.Height}"$)
	Log($"${imgColorPalette.GetBitmap.Width} x ${imgColorPalette.GetBitmap.Height}"$)
	
	Dim bmp As B4XBitmap = imgColorPalette.GetBitmap.Resize(imgColorPalette.Width, imgColorPalette.Height, True)
	bc.Initialize(imgColorPalette.Width, imgColorPalette.Height)
	bc.CopyPixelsFromBitmap(bmp)
	
	pnlColorPreview.Color = bc.GetColor(pnlCursor.Left + pnlCursor.Width/2, imgColorPalette.Height/2)
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.


Private Sub pnlTouchSensor_Touch(Action As Int, X As Float, Y As Float)
	' Ignore if user went out the sides of the bar
	If ((X >= 0 And x <= pnlTouchSensor.Width)) Then
		' Update the color in the preview panel
		pnlColorPreview.Color = bc.GetColor(X, imgColorPalette.Height/2)
	End If
	
	If X < 0 Then X = 0
	If X > pnlTouchSensor.Width Then X = pnlTouchSensor.Width
	
	pnlCursor.Left = pnlTouchSensor.Left + X - pnlCursor.Width/2
End Sub