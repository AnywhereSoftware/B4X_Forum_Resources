### Image Gesture View Library by jkhazraji
### 12/15/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/169733/)

Based on [this Github repo](https://github.com/alexvasilkov/GestureViews), I adopted the view into a b4a library. *The view mixes ImageView and FrameLayout with gestures control and position animation.  
The goal of this library is to make images viewing process as smooth as possible and to make it easier for developers to integrate it into their apps. (Quoted)*  
Although the original view is rich in features, I scratched its surface with this library. It zooms in and out, rotates, translates and above all allows gestures by the user.  
It is based on the .aar file and it should be placed in the additional libraries folder.  
  
Here is a demo video:  
[MEDIA=youtube]GcEEuuC8RfU[/MEDIA]  
  
Note that the rotation is 'jerky' because it is done with the mouse in an emulator. Using two fingers on a real device will run it smoothly.  
**\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\***  
It depends on: JavaObject and Reflection libraries.  
***Properties:*  
-Max Zoom: Float  
-Min Zoom: Float  
-Fit Method: List of String  
-Set rotation enabled: Boolean  
-Set Double tap enable: Boolean  
-Set Double Tap Enabled: Boolean  
-Set Zoom Enabled: Boolean  
-Image File: String  
-Enable Events: Boolean  
  
*Events:*  
-StateChanged (cMap as Map)  
- StateReset (cMap as Map)  
*Methods or Subs:*  
-SetImageBitmap(Bitmap As Bitmap)  
-SetImageFromAssets(FileName As String)  
-SetFillViewport(Fill As Boolean)  
-SetOverzoomFactor(Factor As Float)  
-SetOverscrollDistance(Horizontal As Float, Vertical As Float)  
- SetAnimationsDuration(Duration As Long)  
-SetRestrictRotation(Restrict As Boolean)  
-SetGravity(Gravty As Int)  
-ZoomBy(Factor As Float, PivotX As Float, PivotY As Float)  
-ZoomTo(Zoom As Float, PivotX As Float, PivotY As Float)  
-RotateBy(Angle As Float, PivotX As Float, PivotY As Float)  
-RotateTo(Angle As Float, PivotX As Float, PivotY As Float)  
-TranslateBy(dX As Float, dY As Float)  
-TranslateTo(X As Float, Y As Float)  
- ResetState  
- GetZoom As Float  
-GetRotation As Float  
-GetX As Float  
-GetY As Float  
-AnimateToState(TargetZoom As Float, TargetRotation As Float, TargetX As Float, TargetY As Float, Duration As Int)**  
  
Example:  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: B4A Example  
    #VersionCode: 1  
    #VersionName:  
    'SupportedOrientations possible values: unspecified, landscape or portrait.  
    #SupportedOrientations: unspecified  
    #CanInstallToExternalStorage: False  
    #AdditionalJar:  gesture-views-2.8.3.aar  
#End Region  
  
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: True  
#End Region  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
    Private xui As XUI  
End Sub  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    Private cvGestureImage1 As cvGestureImage  
    Private btnReset As Button  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("Layout")  
End Sub  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub  
  
Private Sub cvGestureImage1_StateChanged (cMap As Map)  
    Log($"Zoom: ${NumberFormat2(cvGestureImage1.GetZoom, 1, 2, 2,False)}x | Rotation: ${NumberFormat(cvGestureImage1.GetRotation, 0, 1)}° Position: ${NumberFormat(cvGestureImage1.GetX, 0, 0)}, ${NumberFormat(cvGestureImage1.GetY, 0, 0)}"$)  
End Sub  
  
Private Sub cvGestureImage1_StateReset (cMap As Map)  
    Log("State Reset")  
End Sub  
  
Private Sub btnReset_Click  
    cvGestureImage1.ResetState  
End Sub
```

  
  
P.S. Download the aar file from : [mvn repository](https://mvnrepository.com/artifact/com.alexvasilkov/gesture-views) and place it in the additional libraries