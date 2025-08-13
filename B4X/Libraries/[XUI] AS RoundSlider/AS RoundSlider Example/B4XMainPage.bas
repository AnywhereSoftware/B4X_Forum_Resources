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
	Private ASRoundSlider1 As ASRoundSlider
	Private Label1 As B4XView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	B4XPages.SetTitle(Me,"AS RoundSlider Example")
	
	#If B4I
	Wait For B4XPage_Resize (Width As Int, Height As Int)
	#End If
	
	'Sets the Thumb Icon
	ASRoundSlider1.ThumbIcon = ASRoundSlider1.FontToBitmap(Chr(0xE430),True,IIf(xui.IsB4J,30,20),xui.Color_White)
	'ASRoundSlider1.ThumbIcon = Null 'If you dont need a icon anymore set the value to NULL
	
	'Sleep(2000)
	'ASRoundSlider1.Value = 50
	
End Sub

Private Sub ASRoundSlider1_ValueChanged (Value As Int)
	Log("Value: " & Value)
	Label1.Text = "#" & Value
End Sub