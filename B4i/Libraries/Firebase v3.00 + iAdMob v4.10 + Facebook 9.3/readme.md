### Firebase v3.00 + iAdMob v4.10 + Facebook 9.3 by Erel
### 12/08/2025
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/144798/)

**Edit: Latest version of Firebase + iAdMob is included with the builder.**  
  
A new package with an updated Firebase and AdMob sdks is available.  
  
  
**Updates:**  
  
- iAdMob v4.10 is included in the package. It fixes an issue with RewardsAds not raising events. Note that the internals of this type have changed. You can use NativeObject.GetField("ad") to get the native ad.  
- iAdMob v4.0 is included in the package.  
This includes implementation of UMP: <https://developers.google.com/admob/ios/privacy>  
Note that you must add your AdMob app id:  

```B4X
'Main module  
#PlistExtra:<key>GADApplicationIdentifier</key>  
'this is a test app id.  
#PlistExtra:<string>ca-app-pub-3940256099942544~1458002511</string>
```

  
  
Example:  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Private ump As UMPConsentInformation  
End Sub  
  
Public Sub Initialize  
'    B4XPages.GetManager.LogEvents = True  
End Sub  
  
'This event will be called once, before the page becomes visible.  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
    ump.Initialize("ump")  
    ump.Reset  
'    ump.UpdateAndRequestIfNeededDebug(B4XPages.GetNativeParent(Me), Array("1A3BEBAD-587A-4600-9845-89C79B863C7D"), True)  
    ump.UpdateAndRequestIfNeeded(B4XPages.GetNativeParent(Me))  
    Wait For ump_Update (Success As Boolean)  
    Log("success: " & Success)  
    Log("canRequestAds: " & ump.CanRequestAds)  
    If ump.CanRequestAds Then  
        Dim ad As AdView  
        ad.Initialize("ad", "ca-app-pub-3940256099942544/2934735716", B4XPages.GetNativeParent(Me), ad.SIZE_BANNER)  
        If Root.Width = 0 Or Root.Height = 0 Then  
            Wait For B4XPage_Resize (Width As Int, Height As Int)  
        End If  
        Root.AddView(ad, 0, 0, Root.Width, 50dip)  
        ad.LoadAd  
    End If  
End Sub  
  
Sub ad_FailedToReceiveAd (ErrorCode As String)  
    Log("fail: " & ErrorCode)  
End Sub  
  
Sub ad_ReceiveAd  
    Log("receive")  
End Sub
```