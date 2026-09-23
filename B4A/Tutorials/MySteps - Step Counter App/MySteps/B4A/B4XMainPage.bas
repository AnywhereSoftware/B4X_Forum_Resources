B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
'#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'#Macro: Title, Sync Files, ide://run?File=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region
#Region Macros
#Macro: Title, Export, ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip
#Macro: Title, GitHub, ide://run?File=%WINDIR%\System32\cmd.exe&Args=/c&Args=github&Args=..\..\
#Macro: Title, JsonLayouts folder, ide://run?File=%WINDIR%\explorer.exe&Args=%PROJECT%\JsonLayouts
#Macro: After Save, Sync Layouts, ide://run?File=%ADDITIONAL%\..\B4X\JsonLayouts.jar&Args=%PROJECT%&Args=%PROJECT_NAME%
#End Region
Sub Class_Globals
	Private xui As XUI
	Private Root As B4XView
	Private kvs As KeyValueStore
	Private lblSteps As B4XView
	Private lblTarget As B4XView
	Private lblDailyTarget As B4XView
	Private ProgressBar1 As B4XProgressBar ' Requires XUI Views library
	Private const KEY_DAILY_TARGET As String = "daily_target_steps"
	Private const DEFAULT_TARGET As Int = 10000
	Private dailyTarget As Int
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
	kvs.Initialize(xui.DefaultFolder, "step_data.dat")
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me, "MySteps")
	
	' Load target setting (default to 10,000 steps)
	dailyTarget = kvs.GetDefault(KEY_DAILY_TARGET, DEFAULT_TARGET)
	
	' Force the daily target to 5 steps for testing
	'SetDailyTarget(5) ' uncomment for testing
	
	' Request both permissions back-to-back before starting the service
	Wait For (RequestAllPermissions) Complete (Success As Boolean)
	If Success Then
		StartService(StepService)
	Else
		ToastMessageShow("Activity permission is required for step tracking.", True)
	End If
End Sub

'Called whenever the page becomes visible. Note that in B4J the Appear and Disappear events are only raised when the page is opened and closed. Not when the focus changes to a different window.
Private Sub B4XPage_Appear
	' Refresh display on app focus
	Dim stepsToday As Int = kvs.GetDefault("steps_today", 0)
	UpdateStepDisplay(stepsToday)
End Sub

'Called whenever a visible page disappear.
Private Sub B4XPage_Disappear

End Sub

#If B4A
Private Sub B4XPage_CloseRequest As ResumableSub
	Return True
End Sub

Private Sub B4XPage_KeyPress (KeyCode As Int) As Boolean 'ignore
	Select KeyCode
		Case KeyCodes.KEYCODE_BACK
			'code to handle back key
		Case Else
			Return False 'Pass to Android System
	End Select
End Sub
#End If

' Called from StepService or local UI refresh
Public Sub UpdateStepDisplay (steps As Int)
    lblSteps.Text = "Steps Today: " & steps
    
    ' Calculate progress percentage
    Dim progress As Float = steps / dailyTarget
    If progress > 1.0 Then progress = 1.0 ' Cap bar at 100%
    
    ' Update B4XProgressBar (Value ranges from 0 to 100 or 0.0 to 1.0 depending on properties)
	ProgressBar1.Progress = progress * 100
    
    ' Update target display label
    Dim pct As Int = Floor((steps / dailyTarget) * 100)
    lblTarget.Text = steps & " / " & dailyTarget & " steps (" & pct & "%)"
End Sub

Public Sub SetDailyTarget (newTarget As Int)
    dailyTarget = newTarget
    kvs.Put(KEY_DAILY_TARGET, newTarget)
    
    If lblDailyTarget.IsInitialized Then
        lblDailyTarget.Text = "Daily target " & NumberFormat(newTarget, 0, 0) & " steps"
    End If
    
    Dim stepsToday As Int = kvs.GetDefault("steps_today", 0)
    UpdateStepDisplay(stepsToday)
End Sub

Private Sub RequestAllPermissions As ResumableSub
	Dim rp As RuntimePermissions
    
	' 1. Request Physical Activity Recognition
	rp.CheckAndRequest("android.permission.ACTIVITY_RECOGNITION")
	Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)
	If Result = False Then
		Log("Activity Recognition permission denied.")
		Return False
	End If
    
	' 2. Request Post Notifications (Android 13+ / API 33+)
	Dim p As Phone
	If p.SdkVersion >= 33 Then
		rp.CheckAndRequest(rp.PERMISSION_POST_NOTIFICATIONS)
		Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)
		If Result = False Then
			Log("Notification permission denied.")
			' We can still return True so step tracking starts even if notification popups are disabled
		End If
	End If
    
	Return True
End Sub