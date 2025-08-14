B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#Macro: Title, B4XPages Export, ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip
#Macro: Title, GitHub Desktop, ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=github&Args=..\..\
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region
Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Public loc As Localizator
	Private cmbLanguages As B4XComboBox
	Dim availableLangs() As String = Array As String("en", "fr", "de", "ru")
	Dim availableLanguages As List
	Dim Selected As Int
End Sub
Public Sub Initialize

End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	loc.Initialize(File.DirAssets, "strings.db")
	Selected = availableLangs.As(List).IndexOf(loc.Language)
	ResetLayout
End Sub

Private Sub ResetLayout
	Root.RemoveAllViews
	Root.LoadLayout("1")
	B4XPages.SetTitle(Me, "B4XPages Localizator")
	loc.LocalizeLayout(Root)
	availableLanguages = loc.LocalizeList(availableLangs)
	cmbLanguages.SetItems(availableLanguages)
	cmbLanguages.SelectedIndex = Selected
End Sub

Private Sub cmbLanguages_SelectedIndexChanged (Index As Int)
	Selected = Index
	loc.ForceLocale(availableLangs(Selected))
	ResetLayout
End Sub