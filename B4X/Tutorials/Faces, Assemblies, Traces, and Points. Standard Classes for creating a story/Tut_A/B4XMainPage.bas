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
	Private CV As B4XCanvas
	Private Pnt As Point
End Sub

Public Sub Initialize
	Pnt.Initialize
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	CV.Initialize(Root)
	Dim center As Point = Pnt.New(Root.Width / 2, Root.Height / 2)
	Log(center.X & TAB & center.Y)	'300    300
	
	CV.drawCircle(center.X, center.Y, 50dip, xui.Color_Blue, False, 3)

	Log(2 * center.DistanceTo(Pnt.New(0, 0)))	'length of screen diagonal
'Or
	Log(2 * Pnt.New(0, 0).DistanceTo(center))	'length of screeen diagonal
	
'You could also define center as halfway down the diagonal
	Dim TopLeft As Point = Pnt.New(0, 0)
	Dim BottomRight As Point = Pnt.New(Root.Width, Root.Height)
	center = TopLeft.halfwayTo(BottomRight)
	Log(center.X & TAB & center.Y)	'300    300

'Or as the centroid
	center = TopLeft.Add(BottomRight).MultBy(1 / 2)
	Log(center.X & TAB & center.Y)	'300    300
End Sub
