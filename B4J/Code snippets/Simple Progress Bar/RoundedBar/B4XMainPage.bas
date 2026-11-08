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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=RoundedBar.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private pnlBar As B4XView
	Dim BarColor As Int
	Dim BarWidth As Int
	Dim BarHeight As Int
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	BarColor = xui.Color_RGB(124, 252, 0)
	BarWidth = pnlBar.Width
	BarHeight = pnlBar.Height
End Sub

Private Sub Button1_Click
	Dim Value As Double = Rnd(1, 101) / 100
	pnlBar.RemoveAllViews
	DrawBar(pnlBar, BarColor, Value * BarWidth, BarHeight, BarHeight / 2)
End Sub

' Create a static rounded bar
Sub DrawBar (Pane As B4XView, BackgroundColor As Int, Width As Double, Height As Double, CornerRadius As Int)
	Try
		If Width < 1 Or Height < 1 Then Return
		Dim mIV As B4XView
		Dim iv As ImageView
		Dim bc As BitmapCreator
		iv.Initialize("")
		mIV = iv
		Pane.AddView(mIV, 0, 0, Width, Height)
		bc.Initialize(Width, Height)
		bc.DrawRectRounded(bc.TargetRect, BackgroundColor, True, 0, CornerRadius)
		bc.SetBitmapToImageView(bc.Bitmap, mIV)
	Catch
		Log(LastException)
	End Try
End Sub