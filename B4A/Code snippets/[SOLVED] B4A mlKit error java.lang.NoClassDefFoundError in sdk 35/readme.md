### [SOLVED] B4A mlKit error java.lang.NoClassDefFoundError in sdk 35 by valerioup
### 08/04/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/168083/)

I published an app that uses mlkit to scan barcodes. Unfortunately, devices with SDK 35 were experiencing a 6% ANR error rate due to an issue with the mlkit library.  
To resolve the issue, I had to download the following extensions, lifecycle-runtime and lifecycle-common, from the SDK Manager.  
Once downloaded, I added them to the main application, and the published app then returned a 0% ANR error rate on Android version 35.  
  

```B4X
#AdditionalJar: com.google.android.gms:play-services-code-scanner  
#AdditionalJar: com.google.android.gms:play-services-base  
#AdditionalJar: androidx.lifecycle:lifecycle-runtime  
#AdditionalJar: androidx.lifecycle:lifecycle-common  
#AdditionalJar: androidx.activity:activity  
#AdditionalJar: androidx.arch.core:core-runtime
```

  
  
this was the error that appeared in the ANR console  
  
Exception java.lang.NoClassDefFoundError: Failed resolution of: Landroidx/arch/core/executor/ArchTaskExecutor;  
 at androidx.lifecycle.LifecycleRegistry\_androidKt.isMainThread (LifecycleRegistry.android.kt:23)  
 at androidx.lifecycle.LifecycleRegistry.enforceMainThreadIfNeeded (LifecycleRegistry.jvm.kt:297)  
 at androidx.lifecycle.LifecycleRegistry.addObserver (LifecycleRegistry.jvm.kt:172)  
 at androidx.activity.ComponentActivity.<init> (ComponentActivity.kt:256)  
 at com.google.mlkit.vision.codescanner.internal.GmsBarcodeScanningDelegateActivity.<init> (com.google.android.gms:play-services-code-scanner@@16.1.0:1)  
 at java.lang.Class.newInstance  
 at android.app.AppComponentFactory.instantiateActivity (AppComponentFactory.java:95)  
 at androidx.core.app.CoreComponentFactory.instantiateActivity (CoreComponentFactory.java:44)  
 at android.app.Instrumentation.newActivity (Instrumentation.java:1273)  
  
[link to app](https://play.google.com/store/apps/details?id=it.edisoft.mycard&hl=it)