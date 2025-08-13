### Sending push messages from B4A by Erel
### 10/20/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/163572/)

1. Download dependencies from: <https://www.b4x.com/android/forum/threads/b4x-firebase-push-notifications-2023.148715/>  
2. Download: <https://repo1.maven.org/maven2/com/google/guava/failureaccess/1.0.2/failureaccess-1.0.2.jar>  
  
Copy all jars to the additional libraries folder.  
  
3. Add to main module:  

```B4X
#AdditionalJar: google-auth-library-oauth2-http-1.18.0.jar  
#AdditionalJar: google-auth-library-credentials-1.18.0.jar  
#AdditionalJar: com.google.guava:guava  
#AdditionalJar: com.google.guava:listenablefuture  
#AdditionalJar: failureaccess-1.0.2.jar  
#AdditionalJar: google-http-client-1.43.3.jar  
#AdditionalJar: google-http-client-gson-1.43.3.jar  
#AdditionalJar: gson-2.10.1.jar  
#AdditionalJar: opencensus-api-0.31.1.jar  
#AdditionalJar: opencensus-contrib-http-util-0.31.1.jar  
#AdditionalJar: grpc-context-1.27.2.jar
```

  
  
4. NetworkOnMainThread check should be disabled. This is done by calling this sub:  

```B4X
Private Sub DisableStrictMode  
    Dim jo As JavaObject  
    jo.InitializeStatic("android.os.Build.VERSION")  
    If jo.GetField("SDK_INT") > 9 Then  
        Dim policy As JavaObject  
        policy = policy.InitializeNewInstance("android.os.StrictMode.ThreadPolicy.Builder", Null)  
        policy = policy.RunMethodJO("permitAll", Null).RunMethodJO("build", Null)  
        Dim sm As JavaObject  
        sm.InitializeStatic("android.os.StrictMode").RunMethod("setThreadPolicy", Array(policy))  
    End If
```

  
  
The code is the same as in B4J.  
  
Note that storing the key inside the app is insecure. This is useful for internal apps.