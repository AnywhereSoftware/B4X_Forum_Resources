### mcLottie - Modern lottie implementation for B4A by mcqueccu
### 10/18/2026
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/172318/)

[SIZE=5]This is the New implementation of Lottie for B4A. It is ProGuard, Edge to Edge and 16kb Alignment compatible[/SIZE]  
  
  
**STEPS**:  
1. Download the latest Lottie aar file from here, and copy to your additional libraries folder.  
As of today, we are using [**version 6.7.1 - Download here**](https://repo1.maven.org/maven2/com/airbnb/android/lottie/6.7.1/lottie-6.7.1.aar)  
  
Main Link: <https://mvnrepository.com/artifact/com.airbnb.android/lottie/>  
  
2. Download the ***mcLottie*** and copy to your additional libraries folder as well.  
  
3. Add these lines to the MAIN Module.  
NB: Change the Lottie version number to the one you are using.  
  

```B4X
    #AdditionalJar: lottie-6.7.1.aar  
    #AdditionalJar: okio-2.8.0.jar  
    #AdditionalJar: androidx.interpolator:interpolator  
    #AdditionalJar: androidx.appcompat:appcompat
```

  
  
4. If you are using #R8Optimizer (Proguard), then add these lines to the Manifest  
  

```B4X
AddProguardText(  
  -keep class com.airbnb.lottie.** { *; }  
  -dontwarn com.airbnb.lottie.**  
  -dontwarn okio.**  
  -dontwarn kotlin.**  
)
```

  
  
**IMPLEMENTATION**:  

```B4X
Sub Class_Globals  
    Private pnlLottie As B4XView  'Add a panel to your layout  
    Dim lot As mcLottie  
End Sub  
  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
    
    lot.Initialize(Me,"lot")  
     
    pnlLottie.AddView(lot.GetView,0,0,pnlLottie.Width,pnlLottie.Height)     
     
    lot.LoadAsset("lightbulb.json")  
    'lot.LoadUri(xui.FileUri(File.DirAssets,"pinjump.json"))     
    'lot.LoadFile(File.DirInternal,"alarm.json")     
    'lot.LoadUrl("https://lottie.host/39839d31-1449-4b36-8e6c-470c29454258/fLvFChQFmn.lottie")  
    lot.AutoRepeat = True  
    lot.Play  
  
     
  
End Sub
```

  
  
  
  
**mcLottie  
  
Author:** Mcqueccu  
**Version:** 1.00  

- **mcLottie**

- **Events:**

- **AnimationCancel**
- **AnimationEnd**
- **AnimationRepeat**
- **AnimationStart**

- **Functions:**

- **Cancel**
- **GetView** As View
*Add this to a Panel/Activity with AddView*- **Initialize** (Callback As Object, EventName As String)
- **IsPlaying** As Boolean
- **LoadAsset** (FileName As String)
*Load from the Files tab (assets). Use a lowercase file name.*- **LoadFile** (Directory As String, FileName As String)
*Load a JSON animation from a B4A directory, such as File.DirInternal.  
 External image files are read from their JSON-relative folders and inlined.  
 Missing images are replaced with a transparent pixel, matching Flutter Lottie's  
 behavior for the supplied career1.json, whose image file is not bundled.*- **LoadJson** (Json As String, CacheKey As String)
- **LoadUri** (Uri As String)
*Load JSON from a content:// or file:// URI.*- **LoadUrl** (Url As String)
- **Pause**
- **Play**
- **Resume**
- **SetColor** (KeyPath As String, Color As Int)
*Override a fill color on the specified Lottie key path.  
 Separate key path segments with /. Example: SetColor("Layer/Shape/Fill", Colors.Red)*- **SetFillColor** (LayerName As String, ShapeName As String, FillName As String, Color As Int)
*Override the color of a specific fill in a layer and shape.*- **SetImageAssetsFolder** (Folder As String)
*Set the folder inside the app's Assets that contains image assets.  
 This is needed when an animation loaded from Assets refers to image files.*- **SetLayerColor** (LayerName As String, Color As Int)
*Override fill colors belonging to a layer. The layer and its descendants are matched.*- **SetMinMaxProgress** (MinP As Float, MaxP As Float)
- **SetShapeColor** (LayerName As String, ShapeName As String, Color As Int)
*Override fill colors belonging to a shape and its descendants in a layer.*- **SetStrokeColor** (KeyPath As String, Color As Int)
*Override a stroke color on the specified Lottie key path.*
- **Properties:**

- **AutoRepeat** As Boolean
- **Duration** As Long [read only]
*Duration in ms*- **Progress** As Float
*0 to 1*- **RepeatCount** As Int [write only]
*-1 = infinite*- **Speed** As Float [write only]

![](https://www.b4x.com/android/forum/attachments/174281)