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
	Private ASStepSeekBar1,ASStepSeekBar2 As ASStepSeekBar
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	#If B4I
	Wait For B4XPage_Resize (Width As Int, Height As Int)
	#End If
	
	For i = 0 To 4 -1
		ASStepSeekBar1.AddStep(xui.Color_White,"Item " & (i))
		ASStepSeekBar2.AddStep(xui.Color_White,"Item " & (i))	
	Next
	
End Sub




Private Sub ASStepSeekBar1_ValueChanged (Index As Int,Value As Object)
	Log("Index: " & Index)
	Log("Value: " & Value)
End Sub

Private Sub ASStepSeekBar2_ValueChanged (Index As Int,Value As Object)
	Log("Index: " & Index)
	Log("Value: " & Value)
End Sub