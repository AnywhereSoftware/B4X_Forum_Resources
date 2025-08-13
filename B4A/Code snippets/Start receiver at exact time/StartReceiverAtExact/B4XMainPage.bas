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
	Private ion As Object
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	Wait For (GetScheduleExactAlarmPermission) Complete (HasPermission As Boolean)
	StartServiceAtExact(ScheduledReceiver, DateTime.Now + 10 * DateTime.TicksPerSecond, True)
End Sub

Private Sub GetScheduleExactAlarmPermission As ResumableSub
	Dim p As Phone
	If p.SdkVersion >= 31 Then
		Dim am As JavaObject = GetAlarmManager
		If am.RunMethod("canScheduleExactAlarms", Null).As(Boolean) = False Then
			Dim in As Intent
			in.Initialize("android.settings.REQUEST_SCHEDULE_EXACT_ALARM", "package:" & Application.PackageName)
			StartActivityForResult(in)
			Wait For ion_Event (MethodName As String, Args() As Object)
			Return -1 = Args(0)
		End If
	End If
	Return True
End Sub

Private Sub GetAlarmManager As JavaObject
	Dim ctxt As JavaObject
	ctxt.InitializeContext
	Return ctxt.RunMethod("getSystemService", Array("alarm"))
End Sub

Sub StartActivityForResult(i As Intent)
	Dim jo As JavaObject = GetBA
	ion = jo.CreateEvent("anywheresoftware.b4a.IOnActivityResult", "ion", Null)
	jo.RunMethod("startActivityForResult", Array As Object(ion, i))
End Sub

Sub GetBA As Object
	Dim jo As JavaObject = Me
	Return jo.RunMethod("getBA", Null)
End Sub