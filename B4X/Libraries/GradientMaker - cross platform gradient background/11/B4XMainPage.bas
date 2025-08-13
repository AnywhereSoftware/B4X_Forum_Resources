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
	Private Gradient As GradientMaker
	Private Panel1 As B4XView
	Private DDDGrid1 As DDDGrid
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	DDDGrid1.Initialize
	xui.RegisterDesignerClass(DDDGrid1)
	Root = Root1
	Root.LoadLayout("MainPage")
	Gradient.Initialize
	Dim clrs As List = Array(xui.Color_Red, xui.Color_Green, xui.Color_Blue)
	Dim orientations As List = Array("TL_BR", "TOP_BOTTOM", "TR_BL", "LEFT_RIGHT", "RIGHT_LEFT", _
		"BL_TR", "BOTTOM_TOP", "BR_TL")
	Dim c As Int
	For x = 0 To 2
		For y = 0 To 2
			If x = 1 And y = 1 Then Continue
			Dim pnl As B4XView = DDDGrid1.GetCell(Panel1, y, x)
			Gradient.SetGradient(pnl, orientations.Get(c), clrs)
			c = c + 1
		Next
	Next
End Sub


Private Sub Button1_Click
	Gradient.SetGradient(DDDGrid1.GetCell(Panel1, 1, 1), "TOP_BOTTOM", _
		Array(Rnd(xui.Color_Black, xui.Color_White), Rnd(xui.Color_Black, xui.Color_White)))
End Sub

