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
	
	Private xlbl_Seek1_Value1,xlbl_Seek1_Value2 As B4XView
	Private xlbl_Seek2_Value1,xlbl_Seek2_Value2 As B4XView
	Private ASRangeSeekBar1 As ASRangeSeekBar
	Private ASRangeSeekBar2 As ASRangeSeekBar
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me,"AS RangeSeekBar Example")
	
	#If B4I
	Wait For B4XPage_Resize (Width As Int, Height As Int)
	#End If
	
	ASRangeSeekBar1_ValueChanged(ASRangeSeekBar1.Value1,ASRangeSeekBar1.Value2)
	ASRangeSeekBar2_ValueChanged(ASRangeSeekBar2.Value1,ASRangeSeekBar2.Value2)
	
End Sub



Private Sub ASRangeSeekBar1_ValueChanged (Value1 As Int,Value2 As Int)
	xlbl_Seek1_Value1.Text = Value1
	xlbl_Seek1_Value2.Text = Value2
End Sub

Private Sub ASRangeSeekBar2_ValueChanged (Value1 As Int,Value2 As Int)
	xlbl_Seek2_Value1.Text = Value1
	xlbl_Seek2_Value2.Text = Value2
End Sub