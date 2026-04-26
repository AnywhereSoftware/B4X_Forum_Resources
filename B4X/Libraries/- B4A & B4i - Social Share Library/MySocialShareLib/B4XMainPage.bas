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


'******************************************************************************************
'TODO: Initialy Ctrl+A --> Ctrl+H --> Replace "B4XLibFilename" with "{MyLibName}.b4xlib"
'******************************************************************************************


'1 - Create the B4XLib and open it in Winrar for editing (you can double click manifest.txt edit it, save it and close it in order to be updated in b4xlib. You can also delete files or directories
'Ctrl + click to build b4xlib: 'ide://run?file=C:\B4X\MyCode\b4xlibcreate.bat&Args=%PROJECT%\..&Args=%JAVABIN%&Args=NHSocialShare.b4xlib

'2 - Move to B4X special sub-folder of additional libraries folder
'Ctrl + click to move b4xlib to Additional Libraries B4X sub-folder: 
'ide://run?file=C:\B4X\MyCode\b4xlibmoveonadditionalb4xlibs.bat&Args=%PROJECT%\..\NHSocialShare.b4xlib&Args=%ADDITIONAL%\..\B4X
'
'If you accidentally hit the previous line link click the immediately bellow link to delete the libary and recreate it:
'ide://run?file=C:\B4X\MyCode\b4xlibdeleteifmistake.bat&Args=%ADDITIONAL%\..\B4X\NHSocialShare.b4xlib

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private sc As SocialShare
	Private Button1 As Button
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	sc.Initialize(B4XPages.GetNativeParent(Me), Root)
	sc.ButtonForiPad = Button1
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	'xui.MsgboxAsync("Hello world!", "B4X")
	sc.ShareMessage("My message is this", sc.ChooseChannel)
End Sub