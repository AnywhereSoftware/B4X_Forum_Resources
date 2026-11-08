B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
' #################################################################
' Main/Startup B4XPage
' #################################################################
' Name:			B4XMainPage (MainPage)
' Version:		1
' Filename:		B4XMainPage.bas
' Dev State:	(x)WIP ()Rel
' Type:			()Activity (X)B4XPage ()Class ()Mod ()CustView XUI
' Template : 	TDB4A_B4XPages
' -----------------------------------------------------------------
' Libs:			XUI, Core, B4XPages, SQL
' Classes:		Main, TD_ActionBar
' Modules:		-
' Layouts:		MainPage.bal
' Files:		techdoc.png
' -----------------------------------------------------------------
' Devloper/s:	G. Becker
' -----------------------------------------------------------------
' NOTICE! -
' #################################################################
' (C) TechDoc G. Becker | https://www.gbecker.de
' Licence: Royalty Free for Private and Commercial Usage
' #################################################################

#Region Shared Files and Links
' tested: Name:G. Becker / 2023/11/01
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'all links activate with Ctrl + click
'sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
'export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip
'open documentation file://G:\Android_B4A\TD_ActionBar\Documents\DB_Framework_3.2.pdf
'based on https://www.gbecker.de
#End Region

' #################################################################

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	
	' CustomView
	Private TD_SwipePanel1 As TD_SwipePanel
	
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
End Sub

#region CustomView Events
' tested: Name:G. Becker / 2023/10/31
#end region

Private Sub TD_SwipePanel1_ScrollChanged(PosX As Int, PosY As Int)
	Log(PosY & "/" & PosY)
End Sub