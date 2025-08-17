### Playing audio stream with audio effects using FFmpeg by Vitor
### 08/17/2024
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/162599/)

1- Download FFMPEG [used  
ffmpeg version 6.1.1-full\_build-[www.gyan.dev](http://www.gyan.dev) Copyright © 2000-2023 the FFmpeg developersffmpeg version 6.1.1-full\_build-[www.gyan.dev](http://www.gyan.dev) Copyright © 2000-2023 the FFmpeg developers  
 built with gcc 12.2.0 (Rev10, Built by MSYS2 project)] and copy to c:\ , rename it with ffmpeg wich is the path of command.  
2 - Copy File "Large Long Echo Hall.wav" to C:\ffmpeg\bin  
3- Double\_Click on file play.bat and enjoy  
  

```B4X
 c:\FFmpeg\bin\ffmpeg.exe  -y -ss "0" -i "https://stream-icy.bauermedia.pt/m80.mp3" -i "c:\FFmpeg\bin\\Large Long Echo Hall.wav" -filter_complex "[0] [1] afir=irgain=0.5:dry=5:wet=10:length=1:irfmt=input [IRReverb]; [0] [IRReverb] amix=inputs=2:weights=0.6 2":normalize=0 -f mp3 -b:a 128k -ar 48000  -ac 2  pipe: | c:\ffmpeg\bin\ffmpeg.exe -y -i pipe: -af volume=volume=14dB,asetrate=48000,rubberband=pitch=1:tempo=1,bass=gain=0:frequency=1000:width_type=h:width=1000:normalize=1,treble=gain=0:frequency=5000:width_type=h:width=3000:normalize=1,asubboost=boost=2:dry=0.5:wet=0.5:cutoff=100:feedback=0.9:slope=0.5:delay=20:decay=0.2:channels=0,silencedetect=noise=-30dB:duration=2 -f mp3 -b:a 128k -ar 48000  -ac 2 pipe: | c:\ffmpeg\bin\ffplay.exe -  -af astats=length=1:metadata=1:reset=1,ametadata=print:key=lavfi.astats.1.PEAK_level,ametadata=print:key=lavfi.astats.2.PEAK_level,asetrate=48000 -autoexit -window_title miradio#0 -x 1 -y 1 -showmode 1 -volume 100
```