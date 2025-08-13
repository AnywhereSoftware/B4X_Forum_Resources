### Disable Admob Native Ad validator by asales
### 01/22/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/158796/)

In the last update of Admob, if you use the native ad, it shows a popup with tips about the ad.  
![](https://www.b4x.com/android/forum/attachments/149965) ![](https://www.b4x.com/android/forum/attachments/149967)  
<https://developers.google.com/admob/android/native/validator>  
  
If your implementation has no issues, you can disable the validator warning putting this line in the manifest:  

```B4X
AddApplicationText(  
<meta-data android:name="com.google.android.gms.ads.flag.NATIVE_AD_DEBUGGER_ENABLED" android:value="false" />  
)
```