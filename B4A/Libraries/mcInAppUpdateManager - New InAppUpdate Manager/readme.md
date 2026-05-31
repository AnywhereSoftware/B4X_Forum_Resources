### mcInAppUpdateManager - New InAppUpdate Manager by mcqueccu
### 05/29/2026
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/171120/)

This is a java object (Inline) implementation of In App Update Manager. It supports both Flexible and Immediate flow  
  
<https://developer.android.com/guide/playcore/in-app-updates>  
  
**NOTE: It works with apps from playstore: So you can include it in the Initial version of your App, Upload to Testing Tracks (Internal or open). Download on your test device  
Then upload Version 2 of the app to that same track, open the app, and you should see the update trigger.  
  
mcInAppUpdateManager  
  
Author:** Mcqueccu  
**Version:** 1.01  

- **mcInAppUpdateManager**

- **Events:**

- **Complete** (Success As Boolean, ErrorDetails() As String)

- **Functions:**

- **CheckAndUpdate** (Immediate As Boolean)
*Immediate = True -> IMMEDIATE update flow  
 Immediate = False -> FLEXIBLE update flow*- **Initialize** (Callback As Object, EventName As String)

  
  
How to use it:  
1. Add the library to the Additional Libraries Folder (B4A). Refresh libraries tab, and select the library  
  
2. Add the dependent libraries to MAIN Module: If its not available, open your SDK Manager and Install Only that  

```B4X
#AdditionalJar: com.google.android.play:app-update  
#AdditionalJar: com.google.android.gms:play-services-tasks
```

  
  
3. Add this code to the B4XMainpage  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
     
    Private InAppUpdate As mcInAppUpdateManager  
End Sub  
  
Public Sub Initialize  
    B4XPages.GetManager.LogEvents = True  
End Sub  
  
'This event will be called once, before the page becomes visible.  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
     
    InAppUpdate.Initialize(Me, "InAppUpdate")  
     
End Sub  
  
'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.  
  
Sub B4XPage_Appear  
    InAppUpdate.CheckAndUpdate(True)  
     
    Wait For InAppUpdate_Complete (Success As Boolean, ErrorDetails() As String)  
         
    Log("InAppUpdate Success = " & Success)  
    Log("ErrorType = " & ErrorDetails(0))  
    Log("ErrorDescription = " & ErrorDetails(1))  
         
  
  
End Sub
```