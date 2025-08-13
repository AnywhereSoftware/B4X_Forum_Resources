### Audio Visualizer by stevel05
### 09/09/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/41850/)

This demo does not implement the [RuntimePermissions](https://www.b4x.com/android/forum/threads/runtime-permissions-android-6-0-permissions.67689/#content) required for Android 6+ (that's how old it is). You will need to add RuntimePermissions to the demo in order for it to run.  
  
As a response to a request on the forums, and to try out the new JavaObject functionality, I decided to take a diversion and write a wrapper for the <http://developer.android.com/reference/android/media/audiofx/Visualizer.html>.  
  
It's written as a B4a class using JavaObject, and provides the DataCaptureListener and callbacks for wave and fft data.  
  
Just add an audio file, and some processing code.  
  
The Class depends on JavaObject and the Demo App depends on Reflection and JavaObject.  
  
You need to add permission: RECORD\_AUDIO to the Manifest.  
  

```B4X
AddPermission("android.permission.RECORD_AUDIO")
```

  
  
If you want to apply the visualizer to the main outputs (AudioSession = 0) you also need permission: MODIFY\_AUDIO\_SETTINGS  
  

```B4X
AddPermission("android.permission.MODIFY_AUDIO_SETTINGS")
```

  
  
**Requires B4A 3.80+**  
  
The Class depends on JavaObject and the Demo App depends on Reflection and JavaObject.  
  
Enjoy  
  
**Update**: Added a new version with WavForm drawing to a user provided panel. While I have tested it on various configurations, it needs to be tested further before production use. Please let me know if you come across any issues.  
  
**This version has additional dependencies:**  
  
[SLByteArrayBuffer](http://www.b4x.com/android/forum/threads/bytearraybuffer.34306/) and Threading Libraries.  
  
**Edit:** I forgot to mention that as the Wav drawing is done in a separate thread, it won't run in Debug mode. You can disable it by temporarily removing the TH.Start call to the draw routine, better still use conditional compilation.  
  
If you want to debug the rest of the app, add  
  

```B4X
#ExcludeFromDebugger: True
```

  
  
to the top of the WavDraw class, then you can run the app in debug mode, but you can't debug the class. In legacy debug mode the wav will be drawn, in Rapid debug mode it won't, but the app will still run.  
  
As an aside, I know nothing about using fft, if someone would care to provide an example using that, it would be most appreciated.  
  
Edit: 20/1/16 Uploaded new Vizualizer.bas Class which fixes the bug from post [#29](https://www.b4x.com/android/forum/threads/audio-visualizer.41850/page-2#post-394885)  
 26/3/18 Update to fix the bug in post #29