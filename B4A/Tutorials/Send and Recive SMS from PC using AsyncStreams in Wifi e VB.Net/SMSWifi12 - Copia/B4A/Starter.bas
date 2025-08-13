B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=9.85
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	#ExcludeFromLibrary: True
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Public rp As RuntimePermissions
	Public Stato As Boolean
	Public Colore As String
	Public getGsmSignalStrength As Int

End Sub

Sub Service_Create
'	Dim ctxt As JavaObject
'	ctxt.InitializeContext
'	Dim TelephonyManager As JavaObject = ctxt.RunMethod("getSystemService", Array("phone"))
'	Dim listener As JavaObject
'	listener.InitializeNewInstance(Application.PackageName & ".starter.MyPhoneStateListener", Null)
'	TelephonyManager.RunMethod("listen", Array(listener, 0x00000100))
End Sub

Sub Signal_Changed (SignalStrengh As Object)
'	Dim s As JavaObject = SignalStrengh
'	Log(s.RunMethod("getGsmSignalStrength", Null))
'	Log(Round(s.RunMethod("getGsmSignalStrength", Null)*100/31))
'	getGsmSignalStrength=Round(s.RunMethod("getGsmSignalStrength", Null)*100/31)
End Sub

Sub Service_Start (StartingIntent As Intent)
	Service.StopAutomaticForeground 'Starter service can start in the foreground state in some edge cases.
End Sub

Sub Service_TaskRemoved
	Log("Destroying Service TaskRemoved")
	'This event will be raised when the user removes the app from the recent apps list.
End Sub

'Return true to allow the OS default exceptions handler to handle the uncaught exception.
Sub Application_Error (Error As Exception, StackTrace As String) As Boolean
	Return True
End Sub

Sub Service_Destroy
	Log("Destroying Service Starter")
End Sub

'
'#if Java
'
'import android.telephony.*;
'public static class MyPhoneStateListener extends PhoneStateListener {
'public MyPhoneStateListener() {
'}
'public void onSignalStrengthsChanged(SignalStrength signalStrength) {
'        anywheresoftware.b4a.BA.Log("onSignalStrengthsChanged");
'       starter.processBA.raiseEventFromUI(null, "signal_changed", signalStrength);
'    }
'}
'#End If