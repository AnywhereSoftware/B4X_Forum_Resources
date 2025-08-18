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
	Private mock As LocationProvider
	Private rf As Reflector
	Private Timer1 As Timer
	Private StopMock As Label
	Private StartMock As Label
	Private lat=52.072062 As Double
	Private lon= 5.533306 	As Double
	Private  spd=10.0	As Float
	Private  bearng=310.0	As Float
	Private  alt=84.0	 As Float
	Private  accuracy=2.0	As Float
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")

		Try
		mock.enableMock("gps",rf.GetContext)
		Timer1.Initialize("TimerCallBack",1000)
		StartMock.Visible=True
		Catch 
			MsgboxAsync("ENABLE MOCKLOCATIONS","")
	End Try
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub TimerCallBack_tick
		InsertMockPosition
		
End Sub
Private Sub InsertMockPosition

		Try
		mock.publishMock(lat,lon,alt,spd,bearng,accuracy,"gps",rf.GetContext)
		Catch 
			MsgboxAsync("MockProvider stopped due error","")
			If Timer1.IsInitialized Then Timer1.Enabled=False
			StartMock.Visible=False
			StopMock.Visible=False
	End Try
End Sub

Private Sub StopMock_Click
	mock.disableMock("gps",rf.GetContext)
	xui.MsgboxAsync("Mock provider Stopped!", "B4X")
	Timer1.Enabled=False
	StartMock.Visible=True	
	StopMock.Visible=False
End Sub

Private Sub StartMock_Click
	xui.MsgboxAsync("Mock provider running!", "B4X")
	Timer1.Enabled=True
	StopMock.Visible=True
	StartMock.Visible=False
End Sub
#If JAVA
import android.content.Context;
#End If



Private Sub Speed_TextChanged (Old As String, New As String)
	If New>0 And New<200 Then spd=New
End Sub

Private Sub Longitude_TextChanged (Old As String, New As String)
	If New<181 And New>-181 Then lon=New
End Sub


Private Sub Latitude_TextChanged (Old As String, New As String)
	If New<91 And New>-91 Then lat=New
End Sub


Private Sub Bearing_TextChanged (Old As String, New As String)
	If New<361 And New>-1 Then bearng=New
End Sub
