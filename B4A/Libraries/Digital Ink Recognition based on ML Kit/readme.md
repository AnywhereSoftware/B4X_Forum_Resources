### Digital Ink Recognition based on ML Kit by Erel
### 07/17/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/165168/)

![](https://www.b4x.com/android/forum/attachments/160942) ![](https://www.b4x.com/android/forum/attachments/160944)  
  
This is a B4A class that wraps ML Kit digital ink recognition. More information here: <https://developers.google.com/ml-kit/vision/digital-ink-recognition>  
  
Open B4A Sdk Manager and install the following resources:  

```B4X
androidx.room:room-common-jvm
```

  
  
Usage is quite simple and demonstrated in the attached example.  
The app collects a list of strokes which are then processed with a call to recognizer.Recognize. The top 10 candidates are returned.  
  
It supports many languages: <https://developers.google.com/ml-kit/vision/digital-ink-recognition/base-models#text>  
The language model is downloaded if needed.  
Don't miss the manifest editor snippet.