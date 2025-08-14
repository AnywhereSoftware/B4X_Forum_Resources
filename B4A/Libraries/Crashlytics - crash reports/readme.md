### Crashlytics - crash reports by Erel
### 07/09/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/87510/)

1. Make sure to use B4A v13.4+ with the recommended SDK: <https://www.b4x.com/b4a.html>
2. Follow firebase integration tutorial: [Integrating Firebase Services](https://www.b4x.com/android/forum/threads/67692/#content)
3. Add a reference to OkHttpUtils2.
4. Add to Main:

```B4X
#AdditionalJar: com.google.firebase:firebase-crashlytics  
#AdditionalJar: com.google.android.datatransport:transport-runtime  
#AdditionalJar: com.google.android.datatransport:transport-backend-cct
```

5. Make sure that #VersionName attribute is not empty. It will not work with an empty value.
6. Add to manifest editor:

```B4X
CreateResourceFromFile(Macro, FirebaseAnalytics.GooglePlayBase)  
CreateResourceFromFile(Macro, FirebaseAnalytics.Firebase)  
CreateResourceFromFile(Macro, FirebaseAnalytics.Crashlytics)
```

7. Make sure that Crashlytics is enabled in Firebase console and crash the app in release mode. You can use this code:

```B4X
Dim i As Int = "aaa"
```


The crash should appear in Firbease console under Quality - Crashlytics after a few minutes.