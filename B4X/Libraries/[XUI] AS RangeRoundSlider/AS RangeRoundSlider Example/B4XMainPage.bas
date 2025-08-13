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
	Private ASRangeRoundSlider1 As ASRangeRoundSlider
	Private Label1 As B4XView
	Private Label2 As B4XView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	B4XPages.SetTitle(Me,"AS RangeRoundSlider Example")
	
	#If B4I
	Wait For B4XPage_Resize (Width As Int, Height As Int)
	#End If
	
	'Sets the Thumb Icon
	ASRangeRoundSlider1.ThumbIcon1 = ASRangeRoundSlider1.FontToBitmap(Chr(0xF186),False,IIf(xui.IsB4J,30,20),xui.Color_White)
	ASRangeRoundSlider1.ThumbIcon2 = ASRangeRoundSlider1.FontToBitmap(Chr(0xE430),True,IIf(xui.IsB4J,30,20),xui.Color_White)
	'ASRangeRoundSlider1.ThumbIcon1 = Null 'If you dont need a icon anymore set the value to NULL
	
	'Sleep(2000)
	'ASRangeRoundSlider1.Value = 50
	
End Sub



Private Sub ASRangeRoundSlider1_ValueChanged (Value1 As Int,Value2 As Int)
	Log("Value1: " & Value1 & " Value2: " & Value2)
	Label1.Text = "#" & Value1
	Label2.Text = "#" & Value2
End Sub