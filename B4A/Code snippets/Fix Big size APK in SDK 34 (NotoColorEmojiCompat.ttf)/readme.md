### Fix Big size APK in SDK 34 (NotoColorEmojiCompat.ttf) by tuhatinhvn
### 04/10/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/166559/)

As two topic and after update to newest b4a version, my apk size very big (+9MB because file NotoColorEmojiCompat.ttf which only use Android Kitkat ):  
<https://www.b4x.com/android/forum/threads/closed-sdk-34-vs-sdk-33-bigger-apk-file-size-in-sdk-34.162202/>  
<https://www.b4x.com/android/forum/threads/solved-increase-in-apk-size-with-the-new-sdk34.162630/>  
This problem cause by Appcompat library use :emoji2 bundled library , and some bugs about customview-poolingcontainer too.  
  
So this is my fix:  
1. Download all files from my zip, copy it to your external library.  
2. Replace your Appcompat library in internal library OR you can delete form internal library and copy these files to external library folder (because default b4a will use form internal appcompat library, we need update it by replace it or use external library )  
3. Add these line to your project:  

```B4X
#AdditionalJar:customview-poolingcontainer-1.0.0.aar  
#AdditionalJar:emoji2-1.0.0.aar  
#AdditionalJar:emoji2-views-helper-1.0.0.aar
```

  
Enjoy! Now APK size will be - 9(10MB). Please test and comment for me to fix more!