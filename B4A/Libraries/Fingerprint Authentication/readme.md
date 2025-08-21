### Fingerprint Authentication by Erel
### 11/10/2019
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/72500/)

**Newer class: <https://www.b4x.com/android/forum/threads/biometricmanager-biometric-authentication.111256/>**  
  
![](https://www.b4x.com/android/forum/attachments/49553)  
  
This class uses inline Java to access the fingerprint API introduced in Android 6.  
It will only work on Android 6+ devices.  
  
With this class it is simple to authenticate the user based on his fingerprint. Note that this is a different kind of authentication compared to FirebaseAuth. It is a local authentication that is useful for preventing others from accessing the app.  
  
Usage code:  

```B4X
Sub Process_Globals  
   Private fingerprint As FingerprintManager  
End Sub  
  
Sub Globals  
   Private btnAuthenticate As Button  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
   If FirstTime Then  
     fingerprint.Initialize (Me, "auth")  
   End If  
   Activity.LoadLayout("1")  
   If fingerprint.HardwareDetected = False Then  
     ToastMessageShow("Fingerprint sensor not detected.", True)  
   Else if fingerprint.HasEnrolledFingerprints = False Then  
     ToastMessageShow("No fingerprints were enrolled.", False)  
   Else  
     btnAuthenticate.Enabled = True  
   End If  
End Sub  
  
Sub btnAuthenticate_Click  
   fingerprint.Authenticate  
   ToastMessageShow("Scanning…", False)  
End Sub  
  
Sub Auth_Complete (Success As Boolean, ErrorMessage As String)  
   If Success Then  
     ToastMessageShow("You have been authenticated!!!", True)  
   Else  
     ToastMessageShow($"Error: ${ErrorMessage}"$, True)  
     Log(ErrorMessage)  
   End If  
End Sub
```

  
  
Manifest editor:  

```B4X
AddManifestText(  
<uses-sdk android:minSdkVersion="23" android:targetSdkVersion="23"/>  
<supports-screens android:largeScreens="true"  
  android:normalScreens="true"  
  android:smallScreens="true"  
  android:anyDensity="true"/>)  
SetApplicationAttribute(android:icon, "@drawable/icon")  
SetApplicationAttribute(android:label, "$LABEL$")  
'End of default text.  
AddPermission(android.permission.USE_FINGERPRINT)
```

  
  
At least one fingerprint should be enrolled (under Settings - Security). Note that there must be a screen lock set.