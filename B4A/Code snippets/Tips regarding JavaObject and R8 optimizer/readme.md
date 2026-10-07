### Tips regarding JavaObject and R8 optimizer by Erel
### 10/01/2026
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/172191/)

JavaObject dynamically calls Java APIs. R8 doesn't detect these calls and can therefore remove or rename the runtime called APIs.  
  
The B4A compiler can detect some of the cases. Check this code for example:  

```B4X
Dim builder As JavaObject  
builder.InitializeNewInstance("com.google.android.gms.ads.AdLoader.Builder", Array(ctxt, AdUnitId))  
  
Dim onUnifiedAdLoadedListener As Object = builder.CreateEventFromUI("com.google.android.gms.ads.nativead.NativeAd.OnNativeAdLoadedListener", _  
   "UnifiedAdLoaded", Null)  
builder.RunMethod("forNativeAd", Array(onUnifiedAdLoadedListener))  
Dim AdLoader As JavaObject = builder.RunMethod("build", Null)  
AdLoader.RunMethod("SomeMethodThatMightFailAtRuntime")
```

  
  
The B4A compiler will add two "keep rules", one for com.google.android.gms.ads.AdLoader.Builder and the second for com.google.android.gms.ads.nativead.NativeAd.OnNativeAdLoadedListener.  
  
The problematic API is here:  

```B4X
Dim AdLoader As JavaObject = builder.RunMethod("build", Null)
```

  
The compiler will not add a rule for AdLoader (unknown) type and it can fail in two ways:  
1. ClassNotFoundException - R8 removed or renamed the class.  
2. MethodNotFoundException because R8 renamed *SomeMethodThatMightFailAtRuntime*.  
  
The solution is to add a rule such as:  

```B4X
-keep class com.google.android.gms.ads.AdRequest{ *; }
```

  
You can find it in the API documentation or ask an AI to do work for you.  
  
  
Now for code such as this one (usually wrote by myself):  

```B4X
builder.CreateEventFromUI("com/google/android/gms/ads/nativead/NativeAd.OnNativeAdLoadedListener".Replace("/", ".")
```

  
In this case the B4A compiler will not detect the class and will not automatically add a rule.