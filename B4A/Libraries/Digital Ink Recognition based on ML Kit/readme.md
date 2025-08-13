### Digital Ink Recognition based on ML Kit by Erel
### 01/19/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/165168/)

![](https://www.b4x.com/android/forum/attachments/160942) ![](https://www.b4x.com/android/forum/attachments/160944)  
  
This is a B4A class that wraps ML Kit digital ink recognition. More information here: <https://developers.google.com/ml-kit/vision/digital-ink-recognition>  
  
This feature has a large set of dependencies. I recommend starting with a simpler feature such as this one: <https://www.b4x.com/android/forum/threads/b4x-textrecognition-based-on-mlkit.161210/#content>  
Once you get it working you can continue with the digital ink feature.  
  
Open B4A Sdk Manager and install the following resources (you might need to install a few more resources. If you get a "missing module" during compilation then install it):  

```B4X
androidx.work:work-gcm  
androidx.work:work-multiprocess  
androidx.room:room-runtime  
androidx.room:room-common  
androidx.room:room-compiler  
androidx.room:room-compiler-processing  
androidx.room:room-compiler-processing-testing  
androidx.room:room-guava  
androidx.room:room-gradle-plugin  
androidx.room:room-migration  
androidx.room:room-paging  
androidx.room:room-paging-android  
androidx.room:room-ktx  
androidx.room:room-paging-guava  
androidx.room:room-paging-rxjava2  
androidx.room:room-runtime-android  
androidx.room:room-paging-rxjava3  
androidx.room:room-rxjava2  
androidx.room:room-rxjava3  
androidx.room:room-testing  
androidx.room:room-testing-android  
androidx.sqlite:sqlite  
androidx.sqlite:sqlite-android  
androidx.sqlite:sqlite-framework  
androidx.sqlite:sqlite-framework-android  
androidx.sqlite:sqlite-ktx  
androidx.paging:paging-common  
androidx.paging:paging-common-android  
androidx.paging:paging-common-ktx  
androidx.paging:paging-compose  
androidx.paging:paging-compose-android  
androidx.paging:paging-guava  
androidx.paging:paging-runtime  
androidx.paging:paging-runtime-ktx  
androidx.paging:paging-rxjava2  
androidx.paging:paging-rxjava2-ktx  
androidx.paging:paging-rxjava3  
androidx.paging:paging-testing  
androidx.paging:paging-testing-android  
androidx.compose.animation:animation  
androidx.compose.animation:animation-android  
androidx.compose.animation:animation-core  
androidx.compose.animation:animation-core-android  
androidx.compose.animation:animation-graphics  
androidx.compose.animation:animation-graphics-android  
androidx.compose.animation:animation-tooling-internal  
androidx.paging:paging-common-jvm  
androidx.paging:paging-testing-jvm  
androidx.work:work-runtime  
androidx.work:work-runtime-ktx  
androidx.work:work-rxjava2  
androidx.work:work-rxjava3  
androidx.work:work-testing
```

  
  
Usage is quite simple and demonstrated in the attached example.  
The app collects a list of strokes which are then processed with a call to recognizer.Recognize. The top 10 candidates are returned.  
  
It supports many languages: <https://developers.google.com/ml-kit/vision/digital-ink-recognition/base-models#text>  
The language model is downloaded if needed.  
Don't miss the manifest editor snippet.