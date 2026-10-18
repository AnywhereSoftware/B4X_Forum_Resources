### R8 Dexer & Optimizer by Erel
### 10/15/2026
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/172284/)

The Java compiler generates Java bytecode. The bytecode is then converted to an Android specific format named DEX. This step is done by default with a tool named D8.  
  
There is an alternative"dexing" tool available named R8. R8 goes farther than D8 and it also optimizes, shrinks and obfuscates the compiled code, including the references. It evolved from a tool named Proguard.  
  
The downsides of R8 are:  
1. It is much slower than D8. It does more work and it isn't incremental.  
2. It can break the app if not configured properly and configuration isn't always trivial. With that said, it is not too complicated and mostly requires some patience.  
The configuration is done with "proguard files".  
  
Starting from Feb. 2027, apps with compiled code (DEX files) larger than 10mb, need to be optimized or they will become less visible in Google Play: [https://android-developers.googlebl...ty-memory-optimization-secure-onboarding.html](https://android-developers.googleblog.com/2026/08/app-quality-memory-optimization-secure-onboarding.html)  
  
The main source of problems is dynamically called APIs, for example with JavaObject. The B4A compiler tries to identify such calls and generates a set of "keep" rules but not all cases can be traced automatically and these calls can also happen inside dependant libraries.  
Another type of error is related to missing optional dependencies. These errors happen during compilation and are simple to fix with a "-dontwarn" rule.  
  
Two relevant files are generated during compilation when R8 is enabled:  
Objects\manifest\_auto.proguard - rules based on AndroidManifest.xml, JavaObject calls and a few other hueristics.  
Objects\manifest\_explicit.proguard - manually added rules. These rules are added in the manifest editor with the new AddProguardText keyword.  
Example:  

```B4X
AddProguardText(  
    -keep class okhttp3.OkHttpClient { *; }  
    -keep class okhttp3.Dispatcher { *; }  
    -keep class okhttp3.internal.connection.RealCall$CallReference { *; }  
    -keep class okhttp3.internal.connection.RealCall { *; }  
    -keep class okhttp3.Request { *; }  
)
```

  
  
Note that it can be called multiple times.  
  
Additionaly, jars can have an accompanying <library>.proguard file, b4xlibs can have an embedded proguard.txt file, and AARs can also embed proguard rules. If adventurous check Objects\r8\_arguments.txt to see the arguments that are passed to R8 tool.  
Existing libraries compiled as jars will probably require manual rules. If possible library developers should recompile and distribute the generated proguard file. b4xlibs are handled as source code internally so will be processed by the compiler (although manual rules might be needed and can be embedded, see SimpleMediaManager for example).  
  
B4A relies on dynamic calling and B4A modules are excluded from renaming and removal by default. When you compile a library as jar, a proguard file will be generated as well.  
With non-small projects, most of the dexed code comes from referenced SDKs and R8 can easily shrink the DEX size by ~80%.  
  
R8 emits a mapping file named Objects\mapping.txt. This file maps the original names with the new names. Note that it is not related to B4A obfuscation (at least for now).  
The file is also embedded in the AAB file when building an app bundle.  
If you get a runtime error about a missing obfuscated class then find its original name by searching the following term in this file: "-> [obfuscated name]:".  
  
Enabling R8:  

```B4X
#R8Optimizer: True
```

  
Once you tested it and especially in release mode, you can limit it to the app bundle:  

```B4X
#if AAB  
#R8Optimizer: True  
#End If
```

  
  
To conclude:  
  
1. D8 is still the default dexer and it works exactly as before.  
2. It is recommended to test your app with #R8Optimizer: True. Report issues encountered in the forum and we will help you solve them.   
3. Tips regarding JavaObject and R8: <https://www.b4x.com/android/forum/threads/tips-regarding-javaobject-and-r8-optimizer.172191/#content>  
4. Old B4A compiled libraries (not b4xlibs) may fail with R8. If possible compile again and the compiler will generate the required proguard file. If not possible then it is usually simple to create the rules yourself. Check BitmapCreator.proguard as an example.