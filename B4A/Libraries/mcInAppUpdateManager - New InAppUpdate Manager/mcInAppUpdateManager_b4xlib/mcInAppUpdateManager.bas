B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.5
@EndOfDesignText@
'========================
' InAppUpdateManager
' Version: 1.0
' Author: McQueccu
'========================

Sub Class_Globals

	Private jo As JavaObject
	Private ctxt As JavaObject

	Private mCallback As Object
	Private mEventName As String

	Public Const FLEXIBLE As Int = 0
	Public Const IMMEDIATE As Int = 1

End Sub

Public Sub Initialize(Callback As Object, EventName As String)

	mCallback = Callback
	mEventName = EventName

	jo.InitializeStatic("anywheresoftware.b4a.BA")

	ctxt.InitializeContext

End Sub

Public Sub CheckForUpdate

	Try

		Dim manager As JavaObject

		manager = manager.InitializeStatic("com.google.android.play.core.appupdate.AppUpdateManagerFactory") _
            .RunMethod("create", Array(ctxt))

		Dim task As JavaObject
		task = manager.RunMethod("getAppUpdateInfo", Null)

		Dim listener As Object
		listener = CreateUpdateListener(manager)

		task.RunMethod("addOnSuccessListener", Array(listener))

	Catch

		Log(LastException)

		Dim m As Map
		m.Initialize

		m.Put("success", False)

		CallSubDelayed2(mCallback, mEventName & "_OnCheckCompleted", m)

	End Try

End Sub

Private Sub CreateUpdateListener(manager As JavaObject) As Object

	Return Me.As(JavaObject).RunMethod("createUpdateListener", Array(manager))

End Sub

Public Sub StartUpdateFlow(AppUpdateInfo As JavaObject, UpdateType As Int)

	Try

		Dim manager As JavaObject

		manager = manager.InitializeStatic("com.google.android.play.core.appupdate.AppUpdateManagerFactory") _
            .RunMethod("create", Array(ctxt))

		manager.RunMethod("startUpdateFlowForResult", Array( _
            AppUpdateInfo, _
            UpdateType, _
            ctxt, _
            9871 _
        ))

	Catch
		Log(LastException)
	End Try

End Sub

#if JAVA

import com.google.android.play.core.appupdate.*;
import com.google.android.play.core.install.model.*;
import com.google.android.gms.tasks.*;

public Object createUpdateListener(AppUpdateManager manager) {

    update_success_listener listener =
        new update_success_listener();

    listener.ba = ba;
    listener.manager = manager;

    return listener;
}

public static class update_success_listener
implements OnSuccessListener<AppUpdateInfo> {

    public anywheresoftware.b4a.BA ba;

    public AppUpdateManager manager;

    @Override
    public void onSuccess(AppUpdateInfo info) {

        try {

            boolean available =
                info.updateAvailability() ==
                UpdateAvailability.UPDATE_AVAILABLE;

            boolean developerTriggered =
                info.updateAvailability() ==
                UpdateAvailability.DEVELOPER_TRIGGERED_UPDATE_IN_PROGRESS;

            anywheresoftware.b4a.objects.collections.Map map =
                new anywheresoftware.b4a.objects.collections.Map();

            map.Initialize();

            map.Put("success", true);

            map.Put("available",
                available || developerTriggered);

            map.Put("info", info);

            ba.raiseEventFromUI(
                this,
                "inappupdate_oncheckcompleted",
                map
            );

        } catch(Exception e) {

            anywheresoftware.b4a.objects.collections.Map map =
                new anywheresoftware.b4a.objects.collections.Map();

            map.Initialize();

            map.Put("success", false);

            ba.raiseEventFromUI(
                this,
                "inappupdate_oncheckcompleted",
                map
            );
        }
    }
}

#End If