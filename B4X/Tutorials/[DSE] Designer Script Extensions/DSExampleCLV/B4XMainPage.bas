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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=DSExampleCLV.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private CustomListView1 As CustomListView
	Private dd As DDD
End Sub

Public Sub Initialize
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'The class instance is created automatically by the designer, when it is first needed.
	'In this case we want to hold a reference to the class and we don't want to wait for the layout to be loaded.
	'The solution is simple, we create it ourselves and register it:
	dd.Initialize
	xui.RegisterDesignerClass(dd) 
	
	Root.LoadLayout("MainPage")
	For i = 1 To 10
		Dim pnl As B4XView = xui.CreatePanel("")
		pnl.SetLayoutAnimated(0, 0, 0, Root.Width, 200dip)
		pnl.LoadLayout("Item")
		CustomListView1.Add(pnl, "")
		dd.GetViewByName(pnl, "Label2").Text = "User #" & i
		'With a few exceptions, custom views are not real views. The view that will return is the base panel. As a convention the base panel tag is set to the custom view class:
		dd.GetViewByName(pnl, "rbRed").Tag.As(B4XRadioButton).Checked = True
	Next
	SwitchTheme(False)
End Sub

Private Sub DarkSwitch_ValueChanged (Value As Boolean)
	SwitchTheme(Value)
End Sub

Private Sub SwitchTheme (dark As Boolean)
	Dim bg As Int = IIf(dark, xui.Color_Black, xui.Color_White)
	Dim TextColor As Int = IIf(dark, xui.Color_White, xui.Color_Black)
	Root.Color = bg
	For i = 0 To CustomListView1.Size - 1
		Dim raw As CLVItem = CustomListView1.GetRawListItem(i)
		raw.Panel.Color = bg
		raw.Color = bg
	Next
	For Each rb As B4XView In dd.GetViewsByClass("radiobutton")
		Dim rbb As B4XRadioButton = rb.Tag 'as written above, we get the custom view class from the base panel tag.
		rbb.mLabel.TextColor = TextColor
	Next
	For Each lbl As B4XView In dd.GetViewsByClass("label")
		lbl.TextColor = TextColor
	Next
End Sub

Private Sub CustomListView1_ItemClick (Index As Int, Value As Object)
	Dim pnl As B4XView = CustomListView1.GetPanel(Index)
	For Each name As String In Array("rbRed", "rbGreen", "rbBlue")
		Dim rbb As B4XRadioButton = dd.GetViewByName(pnl, name).Tag
		If rbb.Checked Then
			Log(name  & ": checked")
		End If
	Next
End Sub