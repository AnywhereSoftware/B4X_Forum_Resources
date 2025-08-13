### BiometricManager - Biometric Authentication by Erel
### 11/22/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/111256/)

![](https://www.b4x.com/basic4android/images/i_view64_rpWKS7JTGJ.png)  
  
This class replaces FingerprintManager (<https://www.b4x.com/android/forum/threads/fingerprint-authentication.72500/#content>).  
It works with all the device supported biometric authentication features.  
  
Setup:  
1. Open B4A Sdk Manager, search for biometric and install androidx.biometric:biometric.  
2. Add to the activity:  

```B4X
#AdditionalJar: androidx.biometric:biometric  
#Extends: android.support.v7.app.AppCompatActivity  
'discard the incorrect warning about AppCompat not being used.  
#IgnoreWarnings: 32
```

  
3. Add to the manifest editor:  

```B4X
AddPermission(android.permission.USE_BIOMETRIC)  
AddPermission(android.permission.USE_FINGERPRINT)  
SetApplicationAttribute(android:theme, "@style/MyAppTheme")  
CreateResource(values, theme.xml,  
<resources>  
    <style name="MyAppTheme" parent="Theme.AppCompat.Light">  
    </style>  
</resources>  
)
```

  
  
Usage:  
- Call CanAuthenticate. It will return "SUCCESS" if biometric authentication is supported and configured.  
- Call Show to show the authentication dialog and wait for the Complete event.  
  
See the attached example.