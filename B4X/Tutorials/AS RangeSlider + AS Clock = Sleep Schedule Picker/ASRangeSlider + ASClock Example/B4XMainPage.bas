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
	Private ASClock1 As ASClock
	Private ASRangeRoundSlider1 As ASRangeRoundSlider
	Private xlbl_Value1 As B4XView
	Private xlbl_Value2 As B4XView
	
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"ASRangeSlider + ASClock Example")
	
	#If B4I
	ASClock1.mBase.As(Panel).UserInteractionEnabled = False 'In B4I we have to set this to False, otherwise the clock will cover the touch event.
	#End If
	
	#If B4I
	wait for B4XPage_Resize (Width As Int, Height As Int)
	#End If
	
	ASRangeRoundSlider1.MaxValue = 720 '720 minutes = 12 hours
	
	ASRangeRoundSlider1.OverScrollMultiplier = 2 'Set the Multiplier to 2, so we can reach 0-12 and 12-24 = 24h
	
	'Sets the Thumb Icons
	ASRangeRoundSlider1.ThumbIcon1 = ASRangeRoundSlider1.FontToBitmap(Chr(0xF186),False,20,xui.Color_White)
	ASRangeRoundSlider1.ThumbIcon2 = ASRangeRoundSlider1.FontToBitmap(Chr(0xE430),True,20,xui.Color_White)
	
	'Sets the Text to default Text and sets the clock middle text size
	ASClock1.MiddleTextProperties.xFont = xui.CreateDefaultFont(35)
	ASClock1.MiddleText = "00:00"
	
End Sub


Private Sub ASRangeRoundSlider1_ValueChanged (Value1 As Int,Value2 As Int)
	
	Dim p_Bedtime As Period
	p_Bedtime.Minutes = Value1
	
	Dim Time_Bedtime As Long = DateUtils.AddPeriod(DateUtils.SetDate(DateTime.GetYear(DateTime.Now),DateTime.GetMonth(DateTime.Now),DateTime.GetDayOfMonth(DateTime.Now)),p_Bedtime)
	
	Dim p_Wake As Period
	p_Wake.Minutes = Value2
	Dim Time_Wake As Long = DateUtils.AddPeriod(DateUtils.SetDate(DateTime.GetYear(DateTime.Now),DateTime.GetMonth(DateTime.Now),DateTime.GetDayOfMonth(DateTime.Now)),p_Wake)
	
	xlbl_Value1.Text = "Bedtime" & CRLF & NumberFormat(DateTime.GetHour(Time_Bedtime),2,0) & ":" & NumberFormat(DateTime.GetMinute(Time_Bedtime),2,0)
	xlbl_Value2.Text = "Wake" & CRLF & NumberFormat(DateTime.GetHour(Time_Wake),2,0) & ":" & NumberFormat(DateTime.GetMinute(Time_Wake),2,0)
	
	Dim p_Range As Period
	p_Range.Minutes = IIf(Value1 < Value2,Value2-Value1,Value1-Value2)
	Dim Time_Range As Long = DateUtils.AddPeriod(DateUtils.SetDate(DateTime.GetYear(DateTime.Now),DateTime.GetMonth(DateTime.Now),DateTime.GetDayOfMonth(DateTime.Now)),p_Range)
	
	ASClock1.MiddleText = NumberFormat(DateTime.GetHour(Time_Range),2,0) & ":" & NumberFormat(DateTime.GetMinute(Time_Range),2,0)

End Sub