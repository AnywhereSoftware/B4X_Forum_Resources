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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Identifier.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
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
	Wait For (GetAdvertisingId) Complete (Id As String)
	If Id <> "" Then
		Log(Id)
	Else
		Log("Error retreiving key")
		Log(LastException)
	End If
End Sub

Private Sub GetAdvertisingId As ResumableSub
	Dim jo As JavaObject = Me
	jo.RunMethod("GetAdvertisingId", Null)
	Wait For AdvertisingId_Ready (Success As Boolean, Id As String)
	Return Id
End Sub



#if Java
import java.util.concurrent.Callable;
import com.google.android.gms.ads.identifier.AdvertisingIdClient;
import com.google.android.gms.ads.identifier.AdvertisingIdClient.Info;

public void GetAdvertisingId() {
   BA.runAsync(ba, mostCurrent, "advertisingid_ready", new Object[] {false, ""}
       , new Callable<Object[]>() {
                   @Override
                   public Object[] call() throws Exception {
                       String id = AdvertisingIdClient.getAdvertisingIdInfo(ba.context).getId();
                       return new Object[] {true, id};
                   }
               }); }
#End If