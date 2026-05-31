B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.5
@EndOfDesignText@
'========================
' mcInAppUpdateManager
' Version: 1.01
' Author: McQueccu
'========================


#Event: Complete (Success As Boolean, ErrorDetails() As String)

Sub Class_Globals
	Private mCallback As Object
	Private mEventName As String
	Private oInAppUpdate As JavaObject
End Sub

Public Sub Initialize(Callback As Object, EventName As String)
	Try
		mCallback = Callback
		mEventName = EventName

		Dim oContext As JavaObject
		oContext.InitializeContext

		oInAppUpdate.InitializeNewInstance( _
            Application.PackageName.ToLowerCase & ".mcinappupdatemanager.UpdateHelper", _
            Array(oContext, Me))

	Catch
		Log(LastException)
	End Try
End Sub

'Immediate = True  -> IMMEDIATE update flow
'Immediate = False -> FLEXIBLE update flow
Public Sub CheckAndUpdate(Immediate As Boolean)
	Try
		If oInAppUpdate.IsInitialized = True Then
			oInAppUpdate.RunMethod("checkAndUpdate", Array(Immediate))
		Else
			Event_OnComplete(False, "InAppUpdate", "InAppUpdate is null.")
		End If
	Catch
		Log(LastException)
		Event_OnComplete(False, "CheckAndUpdate", LastException.Message)
	End Try
End Sub

Private Sub Event_OnComplete (Success As Boolean, ErrorType As String, ErrorDescription As String)
	Try
		If SubExists(mCallback, mEventName & "_Complete") Then
			Dim ErrorDetails() As String = Array As String(ErrorType, ErrorDescription)
			CallSub3(mCallback, mEventName & "_Complete", Success, ErrorDetails)
		End If
	Catch
		Log(LastException)
	End Try
End Sub

#If Java

import android.app.Activity;
import android.content.IntentSender;

import androidx.annotation.NonNull;

import com.google.android.play.core.appupdate.AppUpdateInfo;
import com.google.android.play.core.appupdate.AppUpdateManager;
import com.google.android.play.core.appupdate.AppUpdateManagerFactory;
import com.google.android.play.core.install.model.AppUpdateType;
import com.google.android.play.core.install.model.UpdateAvailability;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.android.gms.tasks.Task;

public static class UpdateHelper {

    private static final int UPDATE_REQUEST_CODE = 1234;

    private Activity activity;
    private B4AClass target;
    private AppUpdateManager appUpdateManager;

    // Constructor
    public UpdateHelper(Activity activity, B4AClass target) {
        try {
            this.activity = activity;
            this.target = target;
            this.appUpdateManager = AppUpdateManagerFactory.create(activity);
        } catch (Exception e) {
            if (target != null) {
                target.getBA().raiseEventFromDifferentThread(
                    target, null, 0,
                    "event_oncomplete", false,
                    new Object[] {false, "Initialization", e.getMessage()}
                );
            }
        }
    }

    // immediate = true  -> IMMEDIATE
    // immediate = false -> FLEXIBLE
    public void checkAndUpdate(final boolean immediate) {

        try {
            if (appUpdateManager == null) {
                target.getBA().raiseEventFromDifferentThread(
                    target, null, 0,
                    "event_oncomplete", false,
                    new Object[] {false, "CheckAndUpdate", "AppUpdateManager is null."}
                );
                return;
            }

            final int updateType = immediate ? AppUpdateType.IMMEDIATE : AppUpdateType.FLEXIBLE;

            Task<AppUpdateInfo> appUpdateInfoTask = appUpdateManager.getAppUpdateInfo();

            if (appUpdateInfoTask == null) {
                target.getBA().raiseEventFromDifferentThread(
                    target, null, 0,
                    "event_oncomplete", false,
                    new Object[] {false, "CheckAndUpdate", "getAppUpdateInfo() returned null."}
                );
                return;
            }

            appUpdateInfoTask.addOnSuccessListener(new OnSuccessListener<AppUpdateInfo>() {
                @Override
                public void onSuccess(AppUpdateInfo appUpdateInfo) {

                    if (appUpdateInfo.updateAvailability() == UpdateAvailability.UPDATE_AVAILABLE
                            && appUpdateInfo.isUpdateTypeAllowed(updateType)) {

                        try {
                            appUpdateManager.startUpdateFlowForResult(
                                    appUpdateInfo,
                                    updateType,
                                    activity,
                                    UPDATE_REQUEST_CODE
                            );

                            // Flow successfully started
                            target.getBA().raiseEventFromDifferentThread(
                                target, null, 0,
                                "event_oncomplete", false,
                                new Object[] {true, "UpdateFlowStarted", ""}
                            );

                        } catch (IntentSender.SendIntentException e) {
                            target.getBA().raiseEventFromDifferentThread(
                                target, null, 0,
                                "event_oncomplete", false,
                                new Object[] {false, "StartUpdateFlow", e.getMessage()}
                            );
                        }

                    } else {
                        // No suitable update available
                        target.getBA().raiseEventFromDifferentThread(
                            target, null, 0,
                            "event_oncomplete", false,
                            new Object[] {false, "NoUpdateAvailable", "No update available or type not allowed."}
                        );
                    }
                }
            });

            appUpdateInfoTask.addOnFailureListener(new OnFailureListener() {
                @Override
                public void onFailure(@NonNull Exception e) {
                    target.getBA().raiseEventFromDifferentThread(
                        target, null, 0,
                        "event_oncomplete", false,
                        new Object[] {false, "CheckAndUpdate", e.getMessage()}
                    );
                }
            });

        } catch (Exception e) {
            target.getBA().raiseEventFromDifferentThread(
                target, null, 0,
                "event_oncomplete", false,
                new Object[] {false, "CheckAndUpdate", e.getMessage()}
            );
        }
    }
}

#End If

