### open the app in Huawei appGallery... by Almora
### 10/29/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/124017/)

open the app in appgallery…  
  

```B4X
    Private ii As Intent  
    Dim appid As Int=xxxxxx  
    ii.Initialize(ii.ACTION_VIEW, "https://appgallery.cloud.huawei.com/marketshare/app/C" & appid)         
    StartActivity(ii)
```