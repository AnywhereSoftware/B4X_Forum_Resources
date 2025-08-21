### Protect your application against copy and changes by Informatix
### 04/14/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/116319/)

This method uses the **F5Steg** and **PackageUtils** libraries from [ProBundle](https://www.b4x.com/android/forum/threads/probundle.58754/post-369803).  
  
There's a demo available in the Play Store: <https://play.google.com/store/apps/details?id=b4a.protecthw.flm>  
The source code is attached to this message and is used as a reference in the following explanations. It will not work after compilation on your computer because some of the assets are protected. Only the creator of these resources (me) can compile a working version.  
  
**Protection against copy:**  
If you look at the source code, you can see that the copy protection is quite simple since it is all in these three lines:  

```B4X
If PU.GetInstallerPackageName(PU.GetMyPackageName) = Null Or PU.GetInstallerPackageName(PU.GetMyPackageName) <> "com.android.vending" Then  
   ExitApplication  
End If
```

  
If the installation source is not the Play Store ("com.android.vending"), the program ends.  
This protection would be very weak if a malicious person could remove these lines with a tool like apktool, so the APK must also be protected against modification.  
  
**Protection against changes:**  
To protect the APK against modification, I use the F5Steg library. It can encrypt data inside an image using the APK signature. No password is required from the user. The encryption password is automatically created by the library's C code from the signature (and I won't explain how, of course, because otherwise it would be a piece of cake to circumvent this protection). If someone modifies the program, he has to reassemble it and sign it with his own key. This will change the signature and therefore F5Steg will not be able to decrypt the image correctly.  
  
In the demo, the image containing the encrypted data is "logo.jpg". In this image, I encoded a list with two entries: a password (which is used to decompress the "value.zip" archive) and a Map which contains three data (an integer, a floating number and the name of the image with my picture). Without these data, the application cannot calculate anything correctly when the user clicks the Test button.  
  
If you use this method to protect your application, a small donation (by clicking on the Donate button in my signature) will be greatly appreciated.