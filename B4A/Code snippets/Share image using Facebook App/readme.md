### Share image using Facebook App by asales
### 10/01/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/54686/)

**Edit (Erel): this code will no longer work. Search for FileProvider.**  
  
I'm using this code to post an image in Facebook with the Facebook app of the device.  
  
I don't need create a Facebook App to get "App ID" and "App Secret" to share (until now).  
  
The step 2 ("select the intent…") is because I found differents intents of Facebook app to share an image in several versions of Android (2.3.6, 4.0, 4.4, 5.0):  
- com.facebook.katana/com.facebook.composer.shareintent.ImplicitShareIntentHandler  
- com.facebook.katana/com.facebook.composer.shareintent.ImplicitShareIntentHandlerDefaultAlias  
- com.facebook.katana/.ComposerActivity  
  
I'll be glad to anyone who can test this code (example B4A 4.30 in attached) and any tip to help improve it.  
  
Libraries: Phone (uri) and ContentResolver (packagemanager).  
  

```B4X
Sub PostImageFacebook  
    '1. copy the image to File.DirDefaultExternal  
    File.Copy(File.DirAssets, "android.jpg", File.DirDefaultExternal, "android.jpg")  
  
    '2. select the image  
    Dim u As Uri  
    u.Parse("file://" & File.Combine(File.DirDefaultExternal,"android.jpg"))  
  
    Dim pm As PackageManager  
    Dim fb1 As String  
  
    '3. select the intent of facebook to share image  
    Dim i As Intent  
    i.Initialize(i.ACTION_SEND,"")  
    i.SetType("image/jpg")  
  
    For Each cn As String In pm.QueryIntentActivities(i)  
        If cn.SubString2(0,20) = "com.facebook.katana/" Then  
              fb1 = cn  
            Exit  
        End If  
    Next  
  
    i.SetComponent(fb1)  
    i.PutExtra("android.intent.extra.STREAM",u)  
  
    '4. start intent  
    Try  
        StartActivity(i)  
    Catch  
        ToastMessageShow("Error!",False)  
    End Try  
End Sub
```