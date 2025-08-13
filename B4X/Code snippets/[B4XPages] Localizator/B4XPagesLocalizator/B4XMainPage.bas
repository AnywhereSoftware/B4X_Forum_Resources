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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=B4XPagesLocalizator.zip

Sub Class_Globals
	Private Root As B4XView
	Private B4XPage2 As Page2
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	Main.Loc.Initialize(File.DirAssets, "strings.db")
	LocalizePage ' apply Localization
	
	B4XPage2.Initialize
	B4XPages.AddPage("Page2", B4XPage2)
End Sub

Sub LocalizePage
	Log("Localizing MainPage...")
	Main.Loc.ForceLocale("zh")
	Main.Loc.LocalizeLayout(Root)
End Sub

Private Sub Button1_Click
	B4XPages.ShowPage("Page2")
End Sub