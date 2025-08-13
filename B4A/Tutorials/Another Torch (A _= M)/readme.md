### Another Torch (A >= M) by Johan Schoeman
### 09/10/2023
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/150835/)

Based on this posting:  
  
<https://www.geeksforgeeks.org/how-to-build-a-simple-flashlight-torchlight-android-app/>  
  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: b4aTorchNew  
    #VersionCode: 1  
    #VersionName:  
    'SupportedOrientations possible values: unspecified, landscape or portrait.  
    #SupportedOrientations: portrait  
    #CanInstallToExternalStorage: False  
#End Region  
  
'https://www.geeksforgeeks.org/how-to-build-a-simple-flashlight-torchlight-android-app/  
  
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: True  
#End Region  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
    Private xui As XUI  
    Dim rp As RuntimePermissions  
    Dim nativeMe As JavaObject  
End Sub  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    Private Button1 As Button  
    Dim flashON As Boolean = False  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("Layout")  
    
    nativeMe.InitializeContext  
    
    rp.CheckAndRequest(rp.PERMISSION_CAMERA)  
    Wait For Activity_PermissionResult (Permission As String, Result As Boolean)  
    Log( Permission & " " & Result)  
    If Result Then  
        rp.CheckAndRequest("android.permission.FLASHLIGHT")  
        Wait For Activity_PermissionResult (Permission As String, Result As Boolean)  
        Log( Permission & " " & Result)  
        If Result Then  
            nativeMe.RunMethod("init", Null)  
        End If  
    End If  
End Sub  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
    
    If flashON = True Then  
        nativeMe.RunMethod("stopFlash", Null)  
    End If   
  
End Sub  
  
Sub Button1_Click  
    
    If flashON = False Then  
        flashON = True  
        nativeMe.RunMethod("setIsChecked", Array(True))  
        nativeMe.RunMethod("startFlash", Null)  
    Else  
        flashON = False  
        nativeMe.RunMethod("setIsChecked", Array(False))  
        nativeMe.RunMethod("startFlash", Null)  
    End If     
    
End Sub  
  
#If Java  
  
import android.content.Context;  
import android.hardware.camera2.CameraAccessException;  
import android.hardware.camera2.CameraManager;  
import android.os.Build;  
import androidx.annotation.RequiresApi;  
  
private CameraManager cameraManager;  
private String getCameraID;  
  
    public void init() {  
   
        // cameraManager to interact with camera devices  
        cameraManager = (CameraManager) getSystemService(Context.CAMERA_SERVICE);  
   
        // Exception is handled, because to check whether  
        // the camera resource is being used by another  
        // service or not.  
        try {  
            // O means back camera unit,  
            // 1 means front camera unit  
            getCameraID = cameraManager.getCameraIdList()[0];  
        } catch (CameraAccessException e) {  
            e.printStackTrace();  
        }  
    }  
   
     private boolean isChecked = false;  
    public void setIsChecked(boolean isChecked) {  
        this.isChecked = isChecked;  
    }   
    
    // RequiresApi is set because, the devices which are  
    // below API level 10 don't have the flash unit with  
    // camera.  
    @RequiresApi(api = Build.VERSION_CODES.M)  
    public void startFlash() {  
        if (isChecked) {  
            // Exception is handled, because to check  
            // whether the camera resource is being used by  
            // another service or not.  
            try {  
                // true sets the torch in ON mode  
                cameraManager.setTorchMode(getCameraID, true);  
   
            } catch (CameraAccessException e) {  
                // prints stack trace on standard error  
                // output error stream  
                e.printStackTrace();  
            }  
        } else {  
            // Exception is handled, because to check  
            // whether the camera resource is being used by  
            // another service or not.  
            try {  
                // true sets the torch in OFF mode  
                cameraManager.setTorchMode(getCameraID, false);  
   
            } catch (CameraAccessException e) {  
                // prints stack trace on standard error  
                // output error stream  
                e.printStackTrace();  
            }  
        }  
    }  
    
  // when you click on button and torch open and  
  // you do not close the torch again this code  
  // will off the torch automatically  
  @RequiresApi(api = Build.VERSION_CODES.M)  
  
    public void stopFlash() {  
        try {  
            // true sets the torch in OFF mode  
            cameraManager.setTorchMode(getCameraID, false);  
   
        } catch (CameraAccessException e) {  
            // prints stack trace on standard error  
            // output error stream  
            e.printStackTrace();  
        }  
    }  
  
#End If
```

  
  
Amend it to your liking.