### Ffmpeg Library for B4X with Inline JAVA Only by tuhatinhvn
### 08/23/2019
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/108905/)

With ffmpeg library, you can work with ffmpeg by using command-line  
It base this: <https://github.com/bravobit/FFmpeg-Android>  
  
You can convert any media to other format, edit video and audio,…..  
  
Because it use command to control ffmpeg so you should test on windows or mac firsts, if it works you can test it on android  
  
Note that: Size of aar is large, but you can remove x86 library to reduce size (1/2 only)  
  
  
very easily to use:  
download ffmeg library for android <http://maven.endeavourhealth.net:8081/artifactory/libs-release/nl/bravobit/android-ffmpeg/>  
  
i current use 1.1.6 : <http://maven.endeavourhealth.net:8081/artifactory/libs-release/nl/bravobit/android-ffmpeg/1.1.6/android-ffmpeg-1.1.6.aar>  
  
copy file aar to your Additional Library  
  
Add this line to your project version 1.1.6 you can change to 1.1.5 or 1.1.7,…)  
  

```B4X
#AdditionalJar: android-ffmpeg-1.1.6.aar
```

  
  
Add Inline-JAVA code to your project (You can modify my demo project for faster)  
  
  
1. Check device if it support ffmpeg by sub checkdevicesupport  
2. Command is a list:  
  

```B4X
Dim command_to_run As List  
command_to_run.Initialize  
command_to_run.AddAll( Array As String("-y","-i",inputfile,outputfile))
```

  
  
It same command on Windows or other platform : ffmpeg -y -i inputfile outputfile  
So you will be easily to test and command to work  
  
Has some events to check progress and complete.  
  
because my bad English and my code is very badly now, i dont have time to pretty it, hope member b4A will find it to usefull for you!  
Thank you!  
I hope that somebody can remake it to perfect library for every member B4X can has a library for apps  
And hope that has a wrapper for this libray for IOS too!  
Thank you all!