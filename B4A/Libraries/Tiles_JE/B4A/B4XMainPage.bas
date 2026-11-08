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

	Public dd As DDD
	
	Type myTag(P1 As Int, P2 As String)

	Private Tiles_JE1 As Tiles_JE
	Private Tiles_JE2 As Tiles_JE
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	dd.Initialize
	xui.RegisterDesignerClass(dd)

	Root = Root1
	Root.LoadLayout("MainPage")
	
	Tiles_JE1.BackgroundColor = xui.Color_LightGray
	Tiles_JE1.TilesPerRow = 2
	 
	Dim mTag As myTag
	mTag.P1 = 123
	mTag.P2 = "ABC"
	Dim lbl As Label = Tiles_JE1.AddLabel("L1", "Label1", 20, xui.Color_Blue, mTag)
	lbl.TextSize = 30
	
	Dim pnl As Panel = Tiles_JE1.AddLayout("P1", "l1", xui.Color_White, Null)
	dd.GetViewByName(pnl, "Label1").Text = "Title"
	Dim prog As ProgressBar = dd.GetViewByName(pnl, "ProgressBar1")
	prog.Progress = 66
	
	
	Dim lbl As Label = Tiles_JE1.AddLabel("L3", " ", 20, xui.Color_Magenta, Null)
	Dim cs As CSBuilder
	cs.Initialize.Color(Colors.White).Append("CS ").Pop.BackgroundColor(Colors.Yellow).Color(Colors.Black).Append("builder").PopAll
	lbl.Text = cs

	Dim img As ImageView = Tiles_JE1.AddImage("Im1", "ic_tilde.png", xui.Color_Green, Null)
	img.Gravity = Gravity.RIGHT
	img.Parent.As(Panel).Color = xui.Color_Cyan

	Sleep(3000)	
	Tiles_JE1.DeleteTile("L3")
		
'	Dim s As String = $"line one
'	line two
'	line three"$
'	Dim lbl As Label = Tiles_JE1.AddLabel("L4", s, 22, xui.Color_Red, Null)
'	
'	Dim img As ImageView = Tiles_JE1.AddImageResize("Im2", "b4j.png", xui.Color_DarkGray, 70dip, 70dip, Null)
'
'	Dim img As ImageView = Tiles_JE1.AddImageResize("Im3", "android.png", xui.Color_LightGray, 90dip, 90dip, Null)
'
'	Dim pnls(5) As Panel
'	For i = 0 To pnls.Length -1
'		pnls(i) = Tiles_JE1.AddLayout("LA" & i, "l2", xui.Color_RGB(Rnd(0,255), Rnd(0,255), Rnd(0,255)), Null)
'	Next
'
'	Tiles_JE1.SelectedItem = "Im2"
'	Log("selected" & Tiles_JE1.SelectedItem)
'	
'	Dim p As Panel = Tiles_JE1.FindTile("Im3")
'	p.Color = xui.Color_Black
''	Tiles_JE1.DefaultColor("Im3", xui.Color_Magenta)
'	


	Tiles_JE2.Initialize(Me, "Tiles_JE2")
	Tiles_JE2.AddToParent(Root, 0dip, 440dip, Root.Width, 400dip)
	Do While Not(Tiles_JE2.IsInitialized)
		Sleep(100)
	Loop
	Dim pnl As Panel = Tiles_JE2.AddLayout("P1", "l1", xui.Color_White, Null)
	dd.GetViewByName(pnl, "Label1").Text = "Title1"
	Dim prog As ProgressBar = dd.GetViewByName(pnl, "ProgressBar1")
	prog.Progress = 66
	
	Dim img As ImageView = Tiles_JE2.AddImageResize("Im3", "android.png", xui.Color_LightGray, 90dip, 90dip, Null)
	
	Dim lbl As Label = Tiles_JE2.AddLabel("L3", "xxxxx", 20, xui.Color_Blue, Null)
	lbl.TextSize = 30
	Tiles_JE2.TilesPerRow = 2
	Tiles_JE2.RedrawTiles
	Tiles_JE2.SetMaxHeight
End Sub

Private Sub Tiles_JE1_Click(Id As String, Tag As Object)
	Log("ID: " & Id)
	If Tag <> Null Then
		If  GetType(Tag).Contains("mytag") Then
			Log(Tag.As(myTag).P1)
			Log(Tag.As(myTag).P2)
		End If
	End If
End Sub

Private Sub Tiles_JE2_Click(Id As String, Tag As Object)
	Log("ID: " & Id)
	If Tag <> Null Then
		If  GetType(Tag).Contains("mytag") Then
			Log(Tag.As(myTag).P1)
			Log(Tag.As(myTag).P2)
		End If
	End If
End Sub


