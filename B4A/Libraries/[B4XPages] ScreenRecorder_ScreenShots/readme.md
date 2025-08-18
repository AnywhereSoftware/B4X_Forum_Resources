###  [B4XPages] ScreenRecorder/ScreenShots by moster67
### 01/25/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/71348/)

**B4A B4XPages ScreenRecorder - version 0.7 (25/09/2016)   
  
**25/01/2021 -** Updated the sample app to use SDK29, foreground services, and also wrote it as a B4XPages app. There are no changes to the library.**  
  
Here is a wrapper/library which lets you record the screen and save it as a video file.  
  
It is using [MediaProjection](https://developer.android.com/reference/android/media/projection/MediaProjection.html) which is available from API 21 (Lollipop) and will not work on earlier versions of Android.  
  
It is based on this [Github-project](https://github.com/yrom/ScreenRecorder). Kudos to the original author.  
  
See next post for events and methods.  
  
I am attaching a sample project along with the library.  
  
**Edit:** The free version posted here is OK for screen-recording. There is also a more advanced version of this library which enables screen-recording with audio, capturing screenshots and screen-mirroring. Send me a PM (start a conversation) if you are interested.  
  
Some basic stuff to remember:  
1) you need at least Lollipop to get this to work. The library uses MediaProjection which was introduced with SDK 21.  
2) You cannot use it for a spy-app. When users run your app and the code in your app which triggers the screen-capturing (recording or screenshots), users have to give permission.  
3) some apps, such as Telegram, can block MediaProjection, and thus capturing/recording of the screen is not possible.  
  
  
**Please remember that creating libraries and maintaining them takes time and so does supporting them. Please consider a donation if you use my free libraries as this will surely help to keep me motivated. Thank you!**