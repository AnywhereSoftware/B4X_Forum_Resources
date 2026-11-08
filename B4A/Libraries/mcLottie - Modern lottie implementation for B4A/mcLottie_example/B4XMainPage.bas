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

#Macro: Title, Export B4XPages, ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private pnlLottie As B4XView
	
	Dim lot As mcLottie
	Dim myJson As String
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
	lot.Initialize(Me,"lot")
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	File.Copy(File.DirAssets,"alarm.json",File.DirInternal,"alarm.json")
	myJson = File.ReadString(File.DirAssets,"9squares.json")
	
	
	
	pnlLottie.AddView(lot.GetView,0,0,pnlLottie.Width,pnlLottie.Height)	
	
	'lot.LoadAsset("lightbulb.json")
	'lot.LoadUri(xui.FileUri(File.DirAssets,"pinjump.json"))	
	'lot.LoadFile(File.DirInternal,"alarm.json")	
	'lot.LoadUrl("https://lottie.host/39839d31-1449-4b36-8e6c-470c29454258/fLvFChQFmn.lottie")
	lot.LoadJson(myJson,"squarej")
	lot.AutoRepeat = True
	lot.Play

	

End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	xui.MsgboxAsync("Hello world!", "B4X")
End Sub