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
	
	Private ASDraw1 As ASDraw
	Private xpnl_black As B4XView
	Private xpnl_green As B4XView
	Private xpnl_blue As B4XView
	Private xpnl_red As B4XView
	Private cb_drawmode As B4XComboBox
	Private lst As List
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	B4XPages.SetTitle(Me,"AS Draw Example")
	
	cb_drawmode.SetItems(Array As String("Draw","Erase","Line"))
	cb_drawmode.SelectedIndex = 0
	lst.Initialize
	
End Sub

#If B4J
Sub xlbl_undo_MouseClicked (EventData As MouseEvent)
	ASDraw1.Undo
End Sub

Sub xlbl_redo_MouseClicked (EventData As MouseEvent)
	ASDraw1.Redo
End Sub

Sub xpnl_black_MouseClicked (EventData As MouseEvent)
	ASDraw1.StrokeColor = xpnl_black.Color
End Sub

Sub xpnl_green_MouseClicked (EventData As MouseEvent)
	ASDraw1.StrokeColor = xpnl_green.Color
End Sub

Sub xpnl_blue_MouseClicked (EventData As MouseEvent)
	ASDraw1.StrokeColor = xpnl_blue.Color
End Sub

Sub xpnl_red_MouseClicked (EventData As MouseEvent)
	ASDraw1.StrokeColor = xpnl_red.Color
End Sub

Sub xlbl_clear_MouseClicked (EventData As MouseEvent)
	ASDraw1.Clear
End Sub
#Else
Sub xlbl_undo_Click
	ASDraw1.Undo
End Sub

Sub xlbl_redo_Click
	ASDraw1.Redo
End Sub

Sub xpnl_black_Click
	ASDraw1.StrokeColor = xpnl_black.Color
End Sub

Sub xpnl_green_Click
	ASDraw1.StrokeColor = xpnl_green.Color
End Sub

Sub xpnl_blue_Click
	ASDraw1.StrokeColor = xpnl_blue.Color
End Sub

Sub xpnl_red_Click
	ASDraw1.StrokeColor = xpnl_red.Color
End Sub

Sub xlbl_clear_Click
	ASDraw1.Clear
End Sub
#End If

#If B4I
Private Sub cb_enabled_ValueChanged (Value As Boolean)
	ASDraw1.Enable = Value
End Sub
#Else
Sub cb_enabled_CheckedChange(Checked As Boolean)
	ASDraw1.Enable = Checked
End Sub
#End If

Sub ASDraw1_Touch (Action As Int, XY As Map)
	'Log("Action: " & Action)
	'Log("X: " & XY.Get("X"))
	'Log("Y: " & XY.Get("Y"))
End Sub

Sub xet_strokewidth_TextChanged (Old As String, New As String)
	If New <> "" Then
		ASDraw1.StrokeWidth = New
	End If
End Sub

Private Sub cb_drawmode_SelectedIndexChanged (Index As Int)
	ASDraw1.DrawMode = cb_drawmode.GetItem(Index)
End Sub
