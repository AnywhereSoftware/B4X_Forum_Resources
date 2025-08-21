### vlcb4a - a B4A wrapper of VLC (Android) by moster67
### 01/14/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/64007/)

**vlcb4a** - a B4A wrapper of VLC (Android)  
  
**NOTE:** As of August 2019, this library is not compliant with Google Play store's latest requirements which require native 64bits libs. It is still useable for apps not being distributed on Google Play Store though. If I can find my original sources and if it is not too complicated, I will try to recompile the sources in order to provide 64bit native libs. That said, things have changed over time and personally I would probably use the ExoPlayer (search the forum) these days unless you have codec-issues. Alternatively, you can use my [Vitamio5 library/wrapper](https://www.b4x.com/android/forum/threads/vitamio-5-version-5-2-3.65176/#content) which has ARM64 and which is just as powerful as VLC.   
  
This is the 2nd experimental release (Work in progress) of my library attempting to wrap VLC for Android (or parts of it) and its underlying libraries (so-files) and the most important properties/methods of VLC in order to provide a VideoView-object for B4A.  
  
What is VLC for Android?  
VLC media player is a free and open source cross-platform multimedia player that plays most multimedia files as well as discs, devices, and network streaming protocols. This is the port of VLC media player to the Android™ platform. VLC for Android can play any video and audio files, as well as network streams and DVD ISOs, like the desktop version of VLC.  
VLC for Android is a full audio player, with a complete database, an equalizer and filters, playing all weird audio formats.  
  
The official VLC Android app can be found here:  
<https://play.google.com/store/apps/details?id=org.videolan.vlc>  
  
As mentioned above, the vlcb4a wrapper is not the full Android VLC app but more an attempt to wrap the underlying libraries (so-files) and the most important properties/methods of VLC (its engine) to provide a VideoView-object for B4A. Apparently they are/were planning to write a VideoView-class but there has not been any development on this class for ages and all there is, is a "skeleton-class" of no use since even the related MediaPlayer-class is incomplete.  
  
This wrapper provides its own VideoView class which I have written and compiled into the original VLC-sources based on SDK 3. The SDK can be found here: <https://code.videolan.org/videolan/vlc-android/tree/master>  
  
This release (version 0.77 of June 27, 2016) adds and includes more features and also fixed some issues (see below for details). I have noted that the vlcb4a plays nearly everything I throw at it.  
  
This is still a "Work in progress" and ETAs for new versions cannot be given. However, I think it should be OK for production by now.  
  
In this moment, I have only compiled the so-sources for ARM but I could compile them also for other platforms such as ARM64, X86 and MIPS. Might add them later though.  
  
The minimum SDK version is 7 (although I have not tried it if it works on such old devices).  
  
See the [second post](https://www.b4x.com/android/forum/threads/vlcb4a-a-b4a-wrapper-of-vlc-android.64007/#post-404929) for a current summary of methods, properties and events supported.  
  
You can download the wrapper from here:  
<https://www.dropbox.com/s/i4d9bul243fc1o4/vlcb4aLIBS_v077.zip?dl=0>  
  
I also attach a sample-project (*vlcdemo.zip*) for B4A.  
  
Note: use a real device  
Note2: always use the VideoView object in its own activity. Within this activity, you can then add panels, subtitles and so on as usual. See sample project.  
  
Changes in vlcb4a version 0.77 (June 27, 2016):  

- -added native subtitle support
- -added possibility to change between 6 different video-sizes
- -added support for selecting different audio-tracks
- -added a MediaController (uses the standard Android one for now)
- -added possibility to add VLC-options. You can add logging,
OpenSL ES, audio time stretching and more. You can find many more options by googling.- added volume controls
- bug fixes

Please report any bugs and/or post general feedback (negative/positive). This will help to keep me motivated and work on the library further.  
  
  
Good luck!