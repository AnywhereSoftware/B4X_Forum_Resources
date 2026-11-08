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
	Private ddgrid As DDDGrid
	Private Pane1 As B4XView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	ddgrid.Initialize
	xui.RegisterDesignerClass(ddgrid)
	Root.LoadLayout("MainPage")
	ddgrid.GetCell(Pane1, 2, 0).LoadLayout("TextCell")
	For x = 0 To 3
		For y = 0 To 2
			If x = 2 And y = 0 Then Continue
			Dim lbl As B4XView = XUIViewsUtils.CreateLabel
			lbl.Text = $"${x}, ${y}"$
			lbl.Font = xui.CreateDefaultBoldFont(20)
			Dim pnl As B4XView = ddgrid.GetCell(Pane1, x, y)
			pnl.Color = Rnd(xui.Color_Black, xui.Color_White)
			pnl.AddView(lbl, 5dip, 5dip, 100dip, 30dip)
		Next
	Next
End Sub

Private Sub Button1_Click
	#if B4i
	B4XPages.GetNativeParent(Me).ResignFocus
	#end if
End Sub