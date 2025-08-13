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
	Public rp As RuntimePermissions
	Private WifiManager As JavaObject
	Private Callback As JavaObject
	Public HotspotReservation As JavaObject
	Private btnStart As B4XView
	Private btnStop As B4XView
	Private lblStatus As B4XView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	Dim ctxt As JavaObject
	ctxt.InitializeContext
	WifiManager = ctxt.RunMethod("getSystemService", Array("wifi"))
	Callback.InitializeNewInstance(Application.PackageName & ".b4xmainpage$MyHotspotCallback", Array(Me))
	HotspotStateChanged
End Sub

Private Sub btnStart_Click
	Wait For (CheckAndRequestWifiPermission) Complete (HasPermission As Boolean)
	If HasPermission Then
		StartHotspot
	End If
End Sub

Private Sub CheckAndRequestWifiPermission As ResumableSub
	Dim p As Phone
	Dim permission As String = IIf(p.SdkVersion < 33, rp.PERMISSION_ACCESS_FINE_LOCATION, "android.permission.NEARBY_WIFI_DEVICES")
	rp.CheckAndRequest(permission)
	Wait For B4XPage_PermissionResult (permission As String, Result As Boolean)
	If Result Then
		
		Return True
	Else
		Log("no permission: " &  permission)
		ToastMessageShow("no permission", True)
		Return False
	End If
End Sub

Private Sub StartHotspot
	WifiManager.RunMethod("startLocalOnlyHotspot", Array(Callback, Null))
	Wait For Hotspot_Started (Success As Boolean, Reservation As Object)
	If Success Then
		HotspotReservation = Reservation
	End If
	HotspotStateChanged
End Sub

Private Sub btnStop_Click
	StopHotspot
End Sub

Private Sub StopHotspot
	If HotspotReservation.IsInitialized Then
		HotspotReservation.RunMethod("close", Null)
		Dim HotspotReservation As JavaObject
		HotspotStateChanged
	End If
End Sub

Private Sub HotspotStateChanged
	If HotspotReservation.IsInitialized Then
		Dim config As JavaObject = HotspotReservation.RunMethod("getWifiConfiguration", Null)
		lblStatus.Text = $"SSID: ${config.GetField("SSID")}
Password: ${config.GetField("preSharedKey")}"$
	Else
		lblStatus.Text = "No network"
	End If
	btnStart.Enabled = Not(HotspotReservation.IsInitialized)
	btnStop.Enabled = HotspotReservation.IsInitialized
End Sub

#if Java
import android.net.wifi.*;
public class MyHotspotCallback extends WifiManager.LocalOnlyHotspotCallback {
@Override
public void onFailed(int reason) { 
		BA.Log("failed: " + reason);
		ba.raiseEventFromUI(this, "hotspot_started", false, null);
		
	}
	@Override
 public void onStopped() {
 		BA.Log("OnStopped");
 	}
	@Override
 public void onStarted(WifiManager.LocalOnlyHotspotReservation reservation) {
 	BA.Log("onStarted");
 	ba.raiseEventFromUI(this, "hotspot_started", true, reservation);
 }
}
#End If
