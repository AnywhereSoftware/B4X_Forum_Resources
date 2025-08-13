### [class] Google Code Scanner - no permission, very simple to use, barcode scanning by Erel
### 07/18/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/160725/)

This solution is based on ML Kit (<https://developers.google.com/ml-kit/vision/barcode-scanning/code-scanner>).  
  
Instructions:  
1. Add to main module:  

```B4X
#AdditionalJar: com.google.android.gms:play-services-code-scanner  
#MultiDex: True
```

  
2. Add to manifest editor:  

```B4X
CreateResourceFromFile(Macro, FirebaseAnalytics.GooglePlayBase) 'add if not already there  
  
'******* google code scanner  
AddApplicationText(  
<meta-data  
      android:name="com.google.mlkit.vision.DEPENDENCIES"  
      android:value="barcode_ui"/>  
 <activity  
            android:name="com.google.mlkit.vision.codescanner.internal.GmsBarcodeScanningDelegateActivity"  
            android:exported="false"  
            android:screenOrientation="portrait"  
           >  
  </activity>  
)  
'*****************  
  
'*********  ML kit **********  
AddApplicationText(  
 <activity  
            android:name="com.google.mlkit.vision.documentscanner.internal.GmsDocumentScanningDelegateActivity"  
            android:exported="false"  
            android:screenOrientation="portrait"  
            android:theme="@android:style/Theme.Black.NoTitleBar.Fullscreen"  
             >  
        </activity>  
         <provider  
            android:name="com.google.mlkit.common.internal.MlKitInitProvider"  
            android:authorities="${applicationId}.mlkitinitprovider"  
            android:exported="false"  
            android:initOrder="99" />  
  
        <service  
            android:name="com.google.mlkit.common.internal.MlKitComponentDiscoveryService"  
            android:directBootAware="true"  
            android:exported="false"  
             >  
            <meta-data  
                android:name="com.google.firebase.components:com.google.mlkit.common.internal.CommonComponentRegistrar"  
                android:value="com.google.firebase.components.ComponentRegistrar" />  
        </service>  
)  
'******************************
```

  
  
Usage:  

```B4X
Private Sub Button1_Click  
    Dim formats As List = Array(Scanner.FORMAT_ALL_FORMATS) 'For better performance pass the specific formats needed.  
    Wait For (Scanner.Scan(formats)) Complete (Result As ScannerResult)  
    If Result.Success Then  
        Log(Result.Value)  
    End If  
End Sub
```

  
  
See attached project.