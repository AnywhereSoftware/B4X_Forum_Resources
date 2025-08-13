### [class] DocumentScanner based on Google ML Kit by Erel
### 07/18/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/160560/)

This class allows using ML Kit to scan documents: <https://developers.google.com/ml-kit/vision/doc-scanner>  
  
![](https://www.b4x.com/android/forum/attachments/152783)  
  
It requires some configuration:  
  
1. Main module:  

```B4X
#AdditionalJar: com.google.android.gms:play-services-mlkit-document-scanner  
#AdditionalJar: kotlin-stdlib-1.6.10  
#AdditionalJar: androidx.arch.core:core-runtime
```

  
2. Manifest editor:  

```B4X
CreateResourceFromFile(Macro, FirebaseAnalytics.GooglePlayBase) 'add if not already there  
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

  
  
Usage is simple. You call scan, the scanning UI appears, after the user scans you get a list of image uris that are loaded using the special "ContentDir" virtual folder.  
See the attached example. The class is inside.  
This is a B4A only class.  
  
**Updates**  
  
- v1.01 - New option to generate a PDF document. The Scan method now accepts a single boolean parameter. If true then a PDF document will be created, as well as the jpeg images. See the updated example.