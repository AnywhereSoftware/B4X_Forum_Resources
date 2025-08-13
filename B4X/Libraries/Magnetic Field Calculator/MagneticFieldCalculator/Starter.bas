B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=6.5
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	#ExcludeFromLibrary: True
#End Region

Sub Process_Globals
	Public rp As RuntimePermissions
	Public GPS1 As GNSS
	Private gpsStarted As Boolean
	Private Phone As Phone
	Private StatusCallback As JavaObject
	Private location As JavaObject
End Sub

Sub Service_Create
	GPS1.Initialize("GPS")
	Dim ctxt As JavaObject
	ctxt.InitializeContext
	location = ctxt.RunMethod("getSystemService", Array("location"))
End Sub

Sub Service_Start (StartingIntent As Intent)

End Sub

Public Sub StartGps
	If gpsStarted = False Then
		GPS1.Start(0, 0)
		If Phone.SdkVersion >= 24 Then
			Dim StatusCallback As JavaObject
			StatusCallback.InitializeNewInstance(Application.PackageName & ".starter$MyGnssStatusCallback", Null)
			location.RunMethod("registerGnssStatusCallback", Array(StatusCallback))
		End If
		gpsStarted = True
	End If
End Sub

Private Sub GnssStatus_changed (Status As Object)
	Dim jStatus As JavaObject = Status
	CallSub2(Main, "GnssStatus", jStatus)
End Sub


Public Sub StopGps
	If gpsStarted Then
		GPS1.Stop
		If StatusCallback.IsInitialized Then
			location.RunMethod("unregisterGnssStatusCallback", Array(StatusCallback))
		End If
		gpsStarted = False
	End If
End Sub

Sub GPS_LocationChanged (Location1 As Location)
	CallSub2(Main, "LocationChanged", Location1)
End Sub


'Sub GPS_GpsStatus (Satellites As List)
'	CallSub2(Main, "GpsStatus", Satellites)
'End Sub

Sub Application_Error (Error As Exception, StackTrace As String) As Boolean
	Return True
End Sub

Sub Service_Destroy
	StopGps
End Sub

#if java
import android.location.*;
public static class MyGnssStatusCallback extends android.location.GnssStatus.Callback {
	 public void onStarted() {
	 	BA.Log("started.");
	 }

        /**
         * Called when GNSS system has stopped.
         */
        public void onStopped() {
			BA.Log("Stopped.");
		}

        /**
         * Called when the GNSS system has received its first fix since starting.
         * @param ttffMillis the time from start to first fix in milliseconds.
         */
        public void onFirstFix(int ttffMillis) {
		BA.Log("onFirstFix.");
		}

        /**
         * Called periodically to report GNSS satellite status.
         * @param status the current status of all satellites.
         */
        public void onSatelliteStatusChanged(GnssStatus status) {
			processBA.raiseEvent(this, "gnssstatus_changed", status);
		}
}
#End If
