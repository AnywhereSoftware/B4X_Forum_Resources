### [class] Google Open Ads by Erel
### 12/01/2025
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/169504/)

This class implements the Google Open Ads feature: <https://developers.google.com/admob/ios/app-open>  
It is compatible with B4i v10+.  
  
Usage:  
call Initialize when the app starts:  

```B4X
OpenAd.Initialize("ca-app-pub-3940256099942544/5575463023") 'test id
```

  
  
And call ShowAdIfAvailable in B4XPage/Application\_Foreground:  

```B4X
If OpenAd.IsInitialized Then OpenAd.ShowAdIfAvailable
```