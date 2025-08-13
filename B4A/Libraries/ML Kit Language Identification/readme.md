### ML Kit Language Identification by Pendrush
### 05/20/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/130404/)

Original library: <https://developers.google.com/ml-kit/language/identification>  
Usage: <https://developers.google.com/ml-kit/language/identification/android>  
Supported languages: <https://developers.google.com/ml-kit/language/identification/langid-support>  
  
With ML Kit's on-device language identification API, you can determine the language of a string of text.  
Language identification can be useful when working with user-provided text, which often doesn't come with any language information.  
  
![](https://www.b4x.com/android/forum/attachments/112778) ![](https://www.b4x.com/android/forum/attachments/112779)  
  
> **MlKitLanguageId  
>   
> Author:** Author: Google - B4a Wrapper: Pendrush  
> **Version:** 1.02  
>
> - **MlKitLanguageId**
>
> - **Events:**
>
> - **OnError** (Error As String)
> - **OnSuccess** (Language As String)
> - **OnSuccessAll** (Languages As Map)
>
> - **Functions:**
>
> - **IdentifyLanguage** (InputText As String, SetConfidenceThreshold As Float)
> *If the call succeeds, a BCP-47 language code is passed to the OnSuccess event, indicating the language of the text.  
>  If no language is confidently detected, the code 'und' (undetermined) is passed.  
>  SetConfidenceThreshold - From 0.01 to 1   
>  MlKitLanguageId1.IdentifyLanguage("Hello", 0.01)*- **IdentifyPossibleLanguages** (InputText As String, SetConfidenceThreshold As Float)
> *To get the confidence values of a string's most likely languages, pass the string to the IdentifyPossibleLanguages() method.  
>  From each object, you can get the language's BCP-47 code and the confidence that the string is in that language.  
>  Note that these values indicate the confidence that the entire string is in the given language.  
>  ML Kit doesn't identify multiple languages in a single string.  
>  SetConfidenceThreshold - From 0.01 to 1  
>  MlKitLanguageId1.IdentifyPossibleLanguages("Hello", 0.01)*- **Initialize** (EventName As String)
> *Initialize MlKitLanguageId  
>  MlKitLanguageId1.Initialize("MlKitLanguageId1")*- **IsInitialized** As Boolean

  
Add this to manifest:  

```B4X
AddPermission(android.permission.ACCESS_NETWORK_STATE)  
AddPermission(android.permission.INTERNET)  
AddPermission(${applicationId}.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION)  
AddManifestText(<permission  
        android:name="${applicationId}.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION"  
        android:protectionLevel="signature" />)  
          
AddApplicationText(<provider  
            android:name="com.google.mlkit.common.internal.MlKitInitProvider"  
            android:authorities="${applicationId}.mlkitinitprovider"  
            android:exported="false"  
            android:initOrder="99" />  
  
   <service  
            android:name="com.google.mlkit.common.internal.MlKitComponentDiscoveryService"  
            android:directBootAware="true"  
            android:exported="false" >  
            <meta-data  
                android:name="com.google.firebase.components:com.google.mlkit.nl.languageid.bundled.internal.ThickLanguageIdRegistrar"  
                android:value="com.google.firebase.components.ComponentRegistrar" />  
                <meta-data  
                android:name="com.google.firebase.components:com.google.mlkit.common.internal.CommonComponentRegistrar"  
                android:value="com.google.firebase.components.ComponentRegistrar" />  
                 <meta-data  
                android:name="com.google.firebase.components:com.google.mlkit.nl.languageid.internal.LanguageIdRegistrar"  
                android:value="com.google.firebase.components.ComponentRegistrar" />  
        </service>  
   
      <activity android:name="com.google.android.gms.common.api.GoogleApiActivity" android:theme="@android:style/Theme.Translucent.NoTitleBar" android:exported="false" />  
    )
```