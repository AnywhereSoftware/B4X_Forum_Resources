### Publishing your app to the App Store by Erel
### 03/11/2020
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/57528/)

This tutorial explains the steps required to create a store ready ipa file.  
  
1. The first step is to uninstall your app from the device and install it again in Release mode (Tools - Build Server - Build Release App). This is an important test. Similar to the test Apple will run.  
Make sure to also test it with airplane mode on.  
The certificate used at this point should be the same non-store certificate.  
  
2. Make sure to use a distribution certificate and create a store provision profile.  
Managing multiple certificates (in most cases you should always use a distribution certificate): <https://www.b4x.com/android/forum/threads/managing-multiple-certificates-provision-files.48539/#content>  
  
  
3. Add code similar to this to select the new store certificate when the app is compiled in release mode:  

```B4X
#If RELEASE  
   #ProvisionFile: store.mobileprovision  
#END IF
```

  
  
4. Compile your app in Release mode (Alt + T + B + R). Don't try to install the app on the device as it is not possible to install store signed apps.  
  
5. Download the compiled app to the PC: Tools - Build Server - Download last build. This step is required even if you are using a local mac.  
  
You will see this message:  
![](https://www.b4x.com/basic4android/images/SS-2015-08-23_10.33.26.png)  
  
6. Create an app specific password: <https://appleid.apple.com/account/manage> - Security - App Specific Passwords  
  
7. Upload the IPA with the local builder: <https://www.b4x.com/android/forum/threads/local-mac-upload-ipa-to-apple-connect-without-application-loader.110105/#content>  
Or with the build server - Tools - Build Server - Upload App To Itunes Connect. Make sure to use the app specific password.  
  
  
Apple App Store review guidelines: <https://developer.apple.com/app-store/review/guidelines/>