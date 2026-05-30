### mcInAppReviewManager - Initiate App reviews using Google API inside your app by mcqueccu
### 05/26/2026
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/171121/)

This works on Apps already in the Playstore  
  
How to use:  
1. Add Additional Jars to the MAIN Module (or download them using the SDK Manager  
  

```B4X
#AdditionalJar: com.google.android.play:review  
#AdditionalJar: com.google.android.gms:play-services-tasks
```

  
  
2. Add this to the Manifest  
  

```B4X
'For inApp Review library  
AddApplicationText(  
<activity  
    android:name="com.google.android.play.core.common.PlayCoreDialogWrapperActivity"  
    android:exported="false"  
    android:theme="@android:style/Theme.Translucent.NoTitleBar"/>  
)
```

  
  
3. Code  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
      
    Private ReviewManager As mcInAppReviewManager  
End Sub  
  
Public Sub Initialize  
'    B4XPages.GetManager.LogEvents = True  
End Sub  
  
'This event will be called once, before the page becomes visible.  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
      
    ReviewManager.Initialize  
End Sub  
  
'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.  
  
Private Sub Button1_Click  
    ReviewManager.LaunchReviewFlow  
End Sub
```

  
  
  
**mcInAppReviewManager**  
  
**Author:** Mcqueccu  
**Version:** 1.00  

- **mcInAppReviewManager**

- **Functions:**

- **Initialize**
- **LaunchReviewFlow**