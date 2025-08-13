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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=AxrLOttieExample.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	
	Dim directory As String = xui.DefaultFolder
	Private pnlLottie As B4XView
	
	'Declare platform specific lottie
	#if b4a
		Dim AXrLottie As AXrLottie
		Dim LottieView As AXrLottieImageView
	#else if B4i
		Dim iLottie As iLottie	
	#end if


End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	'Copy lottie file to Default folder
	File.Copy(File.DirAssets,"emoji_simple.json",directory,"emoji_simple.json")
	
	'Initialize
	#if B4A
		AXrLottie.Initialize	
		LottieView.Initialize("")
	#else
		iLottie.Initialize("lottie",Me)
	#End If
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub btnShowLottie_Click
	loadLottie
End Sub


Sub loadLottie

#IF b4a
	pnlLottie.AddView(LottieView,0,0,pnlLottie.Width,pnlLottie.Height)
	Dim Drawable As AXrLottieDrawableBuilder
	Drawable.InitializeFromFile(directory,"emoji_simple.json") _
				.SetAutoRepeat(Drawable.AUTO_REPEAT_INFINITE) _
				.SetAutoStart(True) _
				.SetCacheEnabled(False)
	LottieView.SetLottieDrawable(Drawable.Build)

#ELSE IF b4I
	iLottie.AnimationFromfile(directory,"emoji_simple.json")
	iLottie.ContentMode = iLottie.ASPECT_FIT_CONTENT
	pnlLottie.AddView(iLottie.AnimationView,0,0,pnlLottie.Width,pnlLottie.Height)
	iLottie.LoopAnimation = True
	iLottie.Play
#End If


End Sub

