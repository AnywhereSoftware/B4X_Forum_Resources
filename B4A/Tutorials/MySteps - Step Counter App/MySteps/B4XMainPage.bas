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
	Private ps As PhoneSensors
	Private lblSteps As B4XView
	'Private initialSteps As Int = -1
	'Private currentSessionSteps As Int = 0
	Private const KEY_DAY_START As String = "day_start_steps"
	Private const KEY_LAST_DATE As String = "last_saved_date"
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
	' Initialize KVS in XUI.DefaultFolder
	kvs.Initialize(xui.DefaultFolder, "step_data.dat")
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me, "MySteps")
	'Step Counter vs. Step Detector:
	'TYPE_STEP_COUNTER (19) returns total steps since last boot And Is Power-efficient.
	'TYPE_STEP_DETECTOR (18) fires an event on every single Step taken (higher Power draw).

	' TYPE_STEP_COUNTER = 19
	ps.Initialize(19)
    
	CheckAndStartSensor
End Sub

'Called whenever the page becomes visible. Note that in B4J the Appear and Disappear events are only raised when the page is opened and closed. Not when the focus changes to a different window.
Private Sub B4XPage_Appear
	
End Sub

'Called whenever a visible page disappear.
Private Sub B4XPage_Disappear
	ps.StopListening
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

'Private Sub CheckAndStartSensor
'    Dim rp As RuntimePermissions
'    rp.CheckAndRequest(rp.PERMISSION_ACTIVITY_RECOGNITION)
'    Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)
'    
'    If Result Then
'        If ps.StartListening("Sensor") = False Then
'            Log("Step counter sensor not available on this device.")
'        End If
'    Else
'        Log("Activity Recognition permission denied.")
'	End If
'End Sub

Private Sub CheckAndStartSensor
    Dim rp As RuntimePermissions
    
    ' Pass the explicit permission string directly
    rp.CheckAndRequest("android.permission.ACTIVITY_RECOGNITION")
    Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)
    
    If Result Then
        If ps.StartListening("Sensor") = False Then
            Log("Step counter sensor not available on this device.")
        End If
    Else
        Log("Activity Recognition permission denied.")
    End If
End Sub

'Private Sub Sensor_SensorChanged (Values() As Float)
'    ' TYPE_STEP_COUNTER returns total steps since device reboot
'    Dim totalStepsSinceReboot As Int = Values(0)
'    
'    If initialSteps = -1 Then
'        initialSteps = totalStepsSinceReboot
'    End If
'    
'    currentSessionSteps = totalStepsSinceReboot - initialSteps
'    lblSteps.Text = "Steps Today: " & currentSessionSteps
'End Sub

Private Sub Sensor_SensorChanged (Values() As Float)
    Dim totalStepsSinceReboot As Int = Values(0)
    Dim todayDate As String = DateTime.Date(DateTime.Now)
    
    Dim lastSavedDate As String = kvs.GetDefault(KEY_LAST_DATE, "")
    Dim dayStartSteps As Int = kvs.GetDefault(KEY_DAY_START, -1)
    
    ' 1. Handle Midnight Reset or First Run
    If todayDate <> lastSavedDate Or dayStartSteps = -1 Then
        dayStartSteps = totalStepsSinceReboot
        kvs.Put(KEY_DAY_START, dayStartSteps)
        kvs.Put(KEY_LAST_DATE, todayDate)
    End If
    
    ' 2. Handle Device Reboot (Sensor value dropped below baseline)
    If totalStepsSinceReboot < dayStartSteps Then
        dayStartSteps = 0
        kvs.Put(KEY_DAY_START, dayStartSteps)
    End If
    
    ' 3. Calculate actual steps taken today
    Dim stepsToday As Int = totalStepsSinceReboot - dayStartSteps
    Log("Steps Today: " & stepsToday)
	lblSteps.Text = "Steps Today: " & stepsToday
End Sub