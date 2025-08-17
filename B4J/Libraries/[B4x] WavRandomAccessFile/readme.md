### [B4x] WavRandomAccessFile by stevel05
### 09/15/2022
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/142792/)

A wav file aware wrapper for RandomAccessFile that makes mixing and jumping around audio files easier. This implementation has the same functionality as the version in JAudioTrack2, but does not rely on JavaxSound library and therefore should work in B4a and possibly B4i.  
  
You can also read information stored in the wav files Chunks other than the data chunk.  
To test it download the example project WavRAF-Tezt.zip and an example wav file in the attached metadat.zip.  
  
See the example projects [jAudioTrack2 - SimpleMixer](https://www.b4x.com/android/forum/threads/jaudiotrack2-simplemixer.142509/) and [jAudioTrack2 - Mixer Full](https://www.b4x.com/android/forum/threads/jaudiotrack2-mixer-full.142507/) for more information.  
  
Please let me know if it works on B4i if you have reason to test it.  
  
**Update V0.11**  

- Made WavHeaderChunkMap available after initialization (also updated test project)
- Fix for edge case where fmt is not the first chunk.