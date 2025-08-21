### Before and after image slider by tuhatinhvn
### 10/07/2019
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/110267/)

This wrapper is based this github : <https://github.com/developer--/before_after_slider>  
Because this written by Kotlin, so you must add this jar to your project:  
<https://repo1.maven.org/maven2/org/jetbrains/kotlin/kotlin-stdlib/1.3.0/kotlin-stdlib-1.3.0.jar>  
Here is code:  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: B4A Example  
    #VersionCode: 1  
    #VersionName:  
    'SupportedOrientations possible values: unspecified, landscape or portrait.  
    #SupportedOrientations: unspecified  
    #CanInstallToExternalStorage: False  
#End Region  
  
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: True  
#End Region  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
  
End Sub  
'#AdditionalJar:android-support-v4.jar  
#AdditionalJar: kotlin-stdlib-1.3.0.jar  
  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    'These variables can only be accessed from this module.  
  
    Private B4ABeforeAfterSlider1 As B4ABeforeAfterSlider  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    Activity.LoadLayout("1")  
    Dim bd1 As BitmapDrawable  
    bd1.Initialize(LoadBitmap(File.DirAssets, "1.jpg"))  
    bd1.Gravity = Gravity.FILL  
    Dim bd2 As BitmapDrawable  
    bd2.Initialize(LoadBitmap(File.DirAssets, "2.jpg"))  
    bd2.Gravity = Gravity.FILL  
   
    B4ABeforeAfterSlider1.bitmapafter=bd1  
    B4ABeforeAfterSlider1.bitmapbefore=bd2  
   
   
End Sub  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub
```

  
  
I used it for my colorize black and white photos app to convert black and white photo to color by deepai API , this view help users can compare two 2 photos before and after converting, you can try it here to see how it works, and can rate 5 stars to help me too if you like ^\_^  
  
<https://play.google.com/store/apps/details?id=smartapps38.colorize.black.andwhite.photos.ai.auto.convert>  
  
![](https://i.imgur.com/MubxhV3.png)