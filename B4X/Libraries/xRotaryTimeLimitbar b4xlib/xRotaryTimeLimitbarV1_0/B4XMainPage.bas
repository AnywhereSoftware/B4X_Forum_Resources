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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=\%PROJECT_NAME%.zip

'B4A ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=start&Args=..\..\B4A\%PROJECT_NAME%.b4a 
'B4i ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=start&Args=..\..\B4i\%PROJECT_NAME%.b4i 
'B4J ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=start&Args=..\..\B4J\%PROJECT_NAME%.b4j

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	
	Private xRotaryTimeLimitbar1 As xRotaryTimeLimitbar
#If B4J
	Private xRotaryTimeLimitbar2 As xRotaryTimeLimitbar
#End If
	Private lblStartTime, lblEndTime, lblTimeInterval As B4XView
	Private btnDisplayMode As B4XView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	B4XPages.SetTitle(B4XPages.MainPage, "xRotaryTimeLimitbarDemo Version 1.0")
	Sleep(0)
	
#If B4J
	AddRotaryTimeLimitbar
#End If
	
'	xRotaryTimeLimitbar1.StartTime = "8:11"
'	xRotaryTimeLimitbar1.EndTime = "15:44"
'	xRotaryTimeLimitbar1.SetStartAndEndTimesToFuture
'	xRotaryTimeLimitbar1.SetSliderBitmapFileNames("green.png", "red.png")
End Sub

Private Sub xRotaryTimeLimitbar1_TimeChanged(Times() As String, TimeInterval As String)
	lblStartTime.Text = Times(0)
	lblEndTime.Text = Times(1)
	lblTimeInterval.Text = TimeInterval
End Sub

Private Sub btnReset_Click
	xRotaryTimeLimitbar1.StartTime = "08:30"
	xRotaryTimeLimitbar1.EndTime = "18:30"
End Sub

Private Sub btnDisplayMode_Click
	If btnDisplayMode.Text.Contains("24") Then
		xRotaryTimeLimitbar1.Mode24Hours = True
		btnDisplayMode.Text = "Set AM / PM"
	Else
		xRotaryTimeLimitbar1.Mode24Hours = False
		btnDisplayMode.Text = "Set 24 hours"
	End If
End Sub

#If B4J
Public Sub AddRotaryTimeLimitbar
	xRotaryTimeLimitbar2.Initialize(Me, "xRotaryTimeLimitbar2")
	xRotaryTimeLimitbar2.AddToParent(Root, 360dip, 20dip, 220dip)

	xRotaryTimeLimitbar2.StartTime = "10:00"
	xRotaryTimeLimitbar2.EndTime = "17:30"
	xRotaryTimeLimitbar2.EarliestStartTime = "0:01"
	xRotaryTimeLimitbar2.LatestStartTime = "23:30"
	xRotaryTimeLimitbar2.EarliestEndTime = "0:30"
	xRotaryTimeLimitbar2.LatestEndTime = "24:00"
	xRotaryTimeLimitbar2.MinTimeInterval = 30
	xRotaryTimeLimitbar2.MaxTimeInterval = 960
	xRotaryTimeLimitbar2.MinuteResolution = 10
	xRotaryTimeLimitbar2.BackgroundColor = xui.Color_DarkGray
	xRotaryTimeLimitbar2.NoneWorkTimeColor = xui.Color_Red
	xRotaryTimeLimitbar2.TimeIntervalColor = xui.Color_Green
	xRotaryTimeLimitbar2.SliderBeginColor = xui.Color_Blue
	xRotaryTimeLimitbar2.SliderEndColor = xui.Color_Magenta
	xRotaryTimeLimitbar2.ScaleBackgroundColor = xui.Color_LightGray
	xRotaryTimeLimitbar2.ScaleColor = xui.Color_Black
End Sub
#End If
