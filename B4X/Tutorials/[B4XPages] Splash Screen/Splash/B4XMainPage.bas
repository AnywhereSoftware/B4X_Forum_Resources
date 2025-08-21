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
	#if B4i
	Private ImageView1 As B4XView
	#end if
End Sub

Public Sub Initialize
	
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Wait For (ShowSplashScreen) Complete (Unused As Boolean)
	Root.LoadLayout("MainPage")
	'don't use %y in your code! Use Root.Height instead.
End Sub

Sub ShowSplashScreen As ResumableSub
#if B4i
	Main.NavControl.NavigationBarVisible = False
	Root.LoadLayout("Splash")
	ImageView1.SetBitmap(xui.LoadBitmapResize(File.DirAssets, "logo.png", ImageView1.Width, ImageView1.Height, True))
	Sleep(3000)
	Root.RemoveAllViews
	Main.NavControl.NavigationBarVisible = True
 #else if B4A
 	Dim start As Long = DateTime.Now
	Do While Activity2.HeightChangedFired = False And DateTime.Now < start + 500
		Sleep(50)
	Loop
	Root.Height = Activity2.CorrectHeight
#End If
	Return True
End Sub

Sub Button1_Click
	xui.MsgboxAsync("Hello world!", "B4X")
End Sub