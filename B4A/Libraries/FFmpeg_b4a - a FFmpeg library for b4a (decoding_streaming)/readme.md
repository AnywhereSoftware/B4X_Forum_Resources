### FFmpeg_b4a - a FFmpeg library for b4a (decoding/streaming) by moster67
### 01/03/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/44476/)

**[SIZE=6]**FFmpeg\_b4a  
  
EDIT: As of August 2019, this library is not compliant with Google Play store's latest requirements which require native 64bits libs. It is still useable for apps not being distributed on Google Play Store though.   
  
Personally I would probably use the ExoPlayer (search the forum) these days unless you have codec-issues. Alternatively, you can use my [Vitamio5 library/wrapper](https://www.b4x.com/android/forum/threads/vitamio-5-version-5-2-3.65176/#content) which is compliant with ****Google Play store's latest requirements****.** [/SIZE]  
  
FFmpeg\_b4a** wraps the [IJKPlayer](https://github.com/bbcallen/ijkplayer) library. Before FFmpeg\_b4a, the only FFmpeg library available for B4A was Vitamio (for which I wrote a wrapper library back in 2012 - see [here](http://www.b4x.com/android/forum/threads/vitamiob4a-a-b4a-wrapper-of-the-vitamio-plugin-advanced-videoview-library.19329/)). My library for Vitamio was later enhanced by @[USER=11161]warwound[/USER] to support more recent versions of Vitamio - see [here](http://www.b4x.com/android/forum/threads/vitamiobundle.35121/).  
  
**What is so special with FFmpeg and these libraries?**  
-Well, these libraries work like Android's default MediaPlayer and VideoView (see b4a's Audio-library) except that they include much more powerful features. They include a collection of media demuxers, decoders, filters - with FFmpeg you can decode many formats which are not supported natively by Android.  
  
**Why this new FFmpeg\_b4a wrapper when there is already Vitamio?**  
- Good question! I wrote this library mainly due to *licensing costs*. As long as you develop personal and free apps (and with no ads) with Vitamio integrated, you can use Vitamio for free if I have understood things correctly. However, if you publish a pay app, an app with ads or develop an app for a third party where Vitamio is integrated, then you need a license which of course is fair enough. However, when I contacted Vitamio asking for license costs, I was informed the license costs were in thousands USD per app and per year! Well, this may be OK for larger companies but for a hobby programmer like myself (and probably others here on the forum), it is far too expensive. With the FFmpeg\_b4a wrapper I believe the license costs are not any longer necessary. Please refer to the "read-me" in the link I cited above for IJKPlayer where the author of IJKPlayer explains licensing issues. I think the important thing here is that the author wrote the C++ code and the JAVA wrapper code himself and that his work may be used also in commercial projects. Please note that I am not a lawyer so I cannot be certain about this so don't blame me if you run into any licensing problems. However, personally I feel more confident to include this library in commercial projects compared to Vitamio.  
  
**Any disadvantages with FFMpeg\_b4a compared to Vitamio?**  
-well, Vitamio is very mature and exposes more methods and attributes than FFmpeg\_b4a. However, the only things that I personally miss in FFmpeg\_b4a are support for subtitles and multiple audio tracks. Some other things missing in FFMmeg\_b4a are: possibility to select video-quality (for now I believe all streams are "highest quality" only), no support for MIPS, you cannot set buffer-size and some other minor things. However, most methods and attributes available in Vitamio are available also in FFmpeg\_b4a. The implementation of the methods are similar and use mostly the same syntax so replacing Vitamio should be rather easy and straight-forward. Hopefully the author of IJKPlayer will continue improving the library and add missing features.  
  
**How to use FFmpeg\_b4a?**  
  
-*Requirements*:  
a) You need B4A v3.20 or later to compile your app.  
b) Min SDK version is API level 9 (Android 2.3–2.3.2 Gingerbread)  
  
-*Instructions*:  
1)In your B4A-project (refer to the included demo in the attached zip-file), under Project attributes, add 2 lines as follows:  

```B4X
#AdditionalRes: C:\testingb4a\testffmpeg\ijkmediaplayer\res, tv.danmaku.ijk.media.player  
#AdditionalRes: C:\testingb4a\testffmpeg\ijkmediawidget\res, tv.danmaku.ijk.media.widget
```

  
  
IMPORTANT - Replace "C:\testingb4a\testffmpeg\ijkmediaplayer\res" and "C:\testingb4a\testffmpeg\ijkmediawidget\res" with the path to your folder where you saved the supplied res-folders on your PC.  
The res-folders are included in the attached zip-file. Please note that the res-folder for ijkmediaplayer is empty. I am unsure if B4A still needs the path when compiling so I included it anyway.  
  
2) Copy the libraries (ijkmediaplayer.jar and ijkmediawidget.jar) included in the attached zip-file to your B4A extra-library folder.  
  
3) The wrapper with the necessary FFmpeg-library (support for armeabi, armeabi-v7a and x86) is available here:  
- FFmpeg\_B4A - first version  
- FFmpeg\_B4A\_v2 - added support for rtsp and some extra codecs  
- FFmpeg\_B4A\_v3 - added support for some speech codecs suitable for IP-cams (<https://www.dropbox.com/s/j5fqvgkl4be4dtk/FFMpeg_B4A_v3.zip?dl=0>)  
  
Extract and copy the library (jar-file and xml-file) into your B4A extra-library folder.  
  
4) In B4A (in the the libs-tab), remember to tick the FFmpeg\_b4a library.  
  
**Notes**:  
-armeabi, armeabi-v7a and x86 architecture are supported while ARMv5, ARMv6, MIPS are not.  
-If the author of the IJKPlayer adds new features and I think it would be a worthwhile upgrade, I will try to include them and release an updated version of the wrapper.  
  
**Important final notes**:  
-Compared to the original FFmpeg build by bbcallen, I built and recompiled the basic FFmpeg-configuration by adding some codecs which I needed. I built the FFmpeg-library according to my needs but I think the FFmpeg\_b4a wrapper should now work with most containers and video/audio decoders. This means that the FFmpeg-library is also rather light-weight compared to others.  
-If you have problems with some streams or with playback of some video/audio-files, you can check the unfiltered logs in B4A and look for a line similar to the following: "*No codec could be found with id XXX*".  
If you see this, then it is likely you need a codec which is not included the FFmpeg-library. Further down in the unfiltered log, you should see an indication which codec is missing. You can then add the missing containers, demuxers, muxers and codec by building and recompiling the FFmpeg-libraries yourself and then replace the existing FFmpeg-libraries (so-files) in the FFmpeg\_B4A wrapper with the ones you generated (you can use 7Zip for that). In this way, you are independent as long as there are no major changes in the wrapper itself which could break the code.  
-The wrapping of the library itself was not tricky. The difficult and time-consuming part was actually learning how to set up everything on a Linux-box, configure everything (dependencies, system environments etc.), get some basic understanding of FFmpeg in order to create and/or modify the FFmpeg-libraries, trouble-shooting errors and make sure that everything worked. I spent quite some time on this to get a better understanding. Most projects which can be found on the Internet are not supplying the FFmpeg-libraries while I actually decided to furnish a basic working set.  
-If you need help with adding missing codecs, then I might be able to help you but you need to contact me by PM for further discussion.  
  
**Credits/Thanks:**  
-to the author of IJKPlayer: Zhang Rui (bbcallen)  
-to @[USER=11161]warwound[/USER] (Martin) for permission to use (and modify) wrapper code for MediaController and OutlineTextView. The wrapper code for VideoView is based on code by myself and Martin.  
  
PS: FFmpeg is actually a solution to record, convert and stream audio and video. It is used also for video and audio creation and manipulation. You can for instance download a YouTube-video and extract the audio-file. The version posted cannot do this since it only handles decoding/streaming. However, if I find some time later on, I will try to wrap a FFmpeg-library which will permit you to do other things and not only streaming(decoding).  
  
Good luck!