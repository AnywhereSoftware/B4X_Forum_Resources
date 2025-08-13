### Start receiver at exact time by Erel
### 05/28/2023
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/148185/)

The standard StartReceiverAt is inexact, in order to allow the OS to make optimizations.   
  
Worth reading: <https://developer.android.com/training/scheduling/alarms>  
  
Exact scheduling:  
1. AddPermission(android.permission.SCHEDULE\_EXACT\_ALARM)  
2. Private ion As Object - class global  
3.  
  

```B4X
Private Sub Button1_Click  
    Wait For (GetScheduleExactAlarmPermission) Complete (HasPermission As Boolean)  
    If HasPermission Then  
        StartServiceAtExact(ScheduledReceiver, DateTime.Now + 10 * DateTime.TicksPerSecond, True) 'yes it is StartServiceAtExact and we pass a receiver  
    Else  
        Log("no permission")  
    End If  
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
```