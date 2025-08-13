### [GlideImageLoader] An image loading and caching library by tummosoft
### 10/15/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/142351/)

GlideImageLoader version 2.0.1 ([Source Code](https://github.com/tummosoft/GlideWrapper))  
  
***\* Support: svg, gif, png, jpg…***  
  
Glide library supports fetching, decoding, images, and animated GIFs for Android. (Link here: [Github](https://bumptech.github.io/glide/))  
Glide library takes in to account two key aspects of image loading performance on Android:  

- The speed at which images can be decoded.
- The amount of jank incurred while decoding images.

![](https://www.b4x.com/android/forum/attachments/133032)  
  
**Notes:**  
Glide has problem with some *SSL* certificates (ex: Sectigo, Let's Encrypt…). It working fine with SSL.com… If your server using Sectigo SSL Glide will not load images into Imageview.  
  
***Manifest***  
  

```B4X
SetApplicationAttribute(android:requestLegacyExternalStorage, true)  
AddPermission(android.permission.ACCESS_NETWORK_STATE)  
AddPermission(android.permission.INTERNET)  
AddManifestText(  
<uses-permission  
  android:name="android.permission.READ_EXTERNAL_STORAGE"  
  android:maxSdkVersion="19" />  
)  
AddPermission(android.permission.WRITE_EXTERNAL_STORAGE)
```

  
  
***AdditionalJar:***  
  

```B4X
#AdditionalJar: glidewrapper.jar  
#AdditionalJar: collection-1.2.0.jar  
#AdditionalJar: core-1.3.1.jar  
#AdditionalJar: vectordrawable-1.1.0.jar  
#AdditionalJar: vectordrawable-animated-1.1.0.jar  
#AdditionalJar: androidsvg-1.4.jar
```

  
  
***Using***  
  

```B4X
Dim g1 As GlideLoader  
    g1.initialize("")  
    g1.SetTransparentBackground(True)  
    g1.SetCircleCrop(True, False)  
    g1.SetCircleBorderColor(Colors.White)  
    g1.SetCircleBorderSize(5)
```

  
  

```B4X
rp.CheckAndRequest(rp.PERMISSION_WRITE_EXTERNAL_STORAGE)  
    Wait For Activity_PermissionResult (Permission As String, Result As Boolean)  
    If Result Then  
        rp.CheckAndRequest(rp.PERMISSION_READ_EXTERNAL_STORAGE)  
        Wait For Activity_PermissionResult (Permission As String, rs As Boolean)  
        If rs Then  
         
        End If     
    End If
```

  
  
**Download:** [Github](https://github.com/tummosoft/GlideWrapper/raw/main/Glide.zip)