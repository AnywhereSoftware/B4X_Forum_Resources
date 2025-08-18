### HMS Ads by Erel
### 11/25/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/124908/)

HMS v1.02 adds support for banner and interstitial ads.  
<https://www.b4x.com/android/forum/threads/hms-huawei-sdk.124034/>  
Make sure to update the dependencies list and the manifest editor items.  
  
The code is simple:  
  

```B4X
'Banner  
Dim banner As B4XView = hms.CreateBannerAd("testw6vs28auh3", "BANNER_SIZE_320_50", Me, "Banner")  
Root.AddView(banner, Root.Width / 2 - 320dip / 2, Root.Height - 50dip, 320dip, 50dip)  
hms.LoadBannerAd(banner, hms.CreateRequestBuilder)  
  
Sub Banner_AdFailed (ErrorCode As Int)  
    Log("Failed: " & ErrorCode)  
End Sub  
  
Sub Banner_AdLoaded  
    Log("AdLoaded")  
End Sub  
  
Sub Banner_AdOpened  
    Log("AdOpened")  
End Sub  
  
'Interstitial  
iad = hms.CreateInterstitialAd("testb4znbuh3n2", Me, "Interstitial") 'iad is a global JavaObject variable  
hms.LoadInterstitialAd(iad, hms.CreateRequestBuilder)  
  
Sub Interstitial_AdFailed (ErrorCode As Int)  
    Log("Failed: " & ErrorCode)  
End Sub  
  
Sub Interstitial_AdLoaded  
    Log("AdLoaded")  
    iad.RunMethod("show", Null)  
End Sub
```

  
  
The above ad ids are test ids.  
The process of creating a real ad id is explained here: <https://developer.huawei.com/consumer/en/doc/distribution/monetize/59500560>  
Note that I've tested it with the test ids only. If you encounter any issue with a real id then post here and we will help you solve it.  
  
There is another HMS ads library, created by [USER=31308]@Pendrush[/USER] here: <https://www.b4x.com/android/forum/threads/huawei-ads-kit.123030/#content>  
Note that the request builder options are set based on [USER=31308]@Pendrush[/USER] recommendations.