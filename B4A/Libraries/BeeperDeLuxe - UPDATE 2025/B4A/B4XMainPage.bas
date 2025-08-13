B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
'###############################################
' Starts after Main, 1st visible Page
'-----------------------------------------------
' Name:			MainPage - B4XMainPage holds Child Pages
'				is managed from B4XPagesManager from Main
' Version:		1		
' Depend Libs:	B4XPages, Core,XUI,XUIViews,XUIViewsExt, StringUtils
' Depend Mod.:	-
' Depend Class:	starter,Main,Page1
' Layout:		MainPage.bal
' Files:		-
' Other:		-
'-----------------------------------------------
' B4XPages are Page Objects holded in the memory and managed by
' B4XPagesManager. If activated the Page Object is loaded into
' the base of the Main Activity.
' ----------------------------------------------
' (C) TechDoc G. Becker | TD_ProjTemplateB4XPages 1.0
'###############################################

#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip
#End Region


'###############################################

#region Globals
'## Function:	Page Globals
'## Tested:		
Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	
	Dim beeper As TD_Beeperdeluxe

End Sub
'## Function:	Initialize Globals
'## Tested:		
Public Sub Initialize
	beeper.Initialize
End Sub
#end region 

#region page
'## Function:	Create Main B4XPage
'## Parameter:	Root1 as B4XPage base
'## Tested:		
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	Sleep(0)
	
End Sub
#end region	

'# Function:	beep one time
'# Parameter:	Duration in ms, frequency
'# Tested:		02/2025
Private Sub Button1_Click
	beeper.beep(250,300)
End Sub
'# Function:	beep and vibrate one time
'# Parameter:	Duration in ms, frequency
'# Tested:		02/2025
private Sub Button2_Click
	beeper.beepAndVibrate(250,300)
End Sub
'# Function:	beep several times time
'# Parameter:	Beepduration in ms, frequency, Alarmduration in ms
'# Tested:		02/2025
Private Sub Button3_Click
	beeper.Alarm(250,500,1000)
End Sub

'###############################################


'###############################################
' (C) TechDoc G. Becker
'###############################################


