B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
'#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private dd As DDD
	

	Private Tiles_JE1 As Tiles_JE
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	dd.Initialize
	xui.RegisterDesignerClass(dd)
	
	Dim lbl As Label = Tiles_JE1.AddLabel("L1", "Label123", 20, xui.Color_Blue)
	lbl.TextSize = 30

	Dim lbl As Label = Tiles_JE1.AddLabel("L2", "Label2", 20, xui.Color_Gray)
	lbl.TextColor = xui.Color_Yellow
	
	Dim lbl As Label = Tiles_JE1.AddLabel("L3", " ", 20, xui.Color_Magenta)
	Dim cs As CSBuilder
	cs.Initialize.Color(Colors.White).Append("CS ").Pop.BackgroundColor(Colors.Yellow).Color(Colors.Black).Append("builder").PopAll
	lbl.Text = cs
	
	Dim s As String = $"line one
	line two
	line three"$
	Dim lbl As Label = Tiles_JE1.AddLabel("L4", s, 22, xui.Color_Red)
	
	Dim img As ImageView = Tiles_JE1.AddImage("Im1", "ic_tilde.png", xui.Color_Green)
	img.Gravity = Gravity.LEFT
'	img.Parent.As(Panel).Color = xui.Color_LightGray
	
	Dim img As ImageView = Tiles_JE1.AddImageResize("Im2", "b4j.png", xui.Color_DarkGray, 70dip, 70dip)

	Dim img As ImageView = Tiles_JE1.AddImageResize("Im3", "android.png", xui.Color_LightGray, 90dip, 90dip)

	Dim pnl As Panel = Tiles_JE1.AddLayout("P1", "l1", xui.Color_White)
	dd.GetViewByName(pnl, "Label1").Text = "Title"
	Dim prog As ProgressBar = dd.GetViewByName(pnl, "ProgressBar1")
	prog.Progress = 66
	
	Dim pnls(8) As Panel
	For i = 0 To pnls.Length -1
		pnls(i) = Tiles_JE1.AddLayout("LA" & i, "l2", xui.Color_RGB(Rnd(0,255), Rnd(0,255), Rnd(0,255)))
	Next

	Tiles_JE1.SelectedItem = "Im2"
	
	Dim p As Panel = Tiles_JE1.FindTile("Im3")
	p.Color = xui.Color_Black
	Tiles_JE1.DefaultColor("Im3", xui.Color_Magenta)
	

End Sub

Private Sub Tiles_JE1_Click(Tag As String)
	Log(Tag)
End Sub

