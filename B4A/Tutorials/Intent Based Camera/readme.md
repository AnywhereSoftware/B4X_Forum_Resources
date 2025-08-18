### Intent Based Camera by Erel
### 09/19/2021
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/69215/)

**Newer example: [[B4X] [B4XPages] Intent based camera](https://www.b4x.com/android/forum/threads/b4x-b4xpages-intent-based-camera.120721/)**  
  
This example uses an intent to take a picture with the default camera app.  
  
It is based on this tutorial: <https://developer.android.com/training/camera/photobasics.html>  
  
It is simple to use and doesn't require any permission (\*).  
  
It does rely on the default camera app to work properly and save the image file in the path passed in the intent.  
As a fallback, if the image was not saved it tries to get the thumbnail from the intent returned.  
  
Don't miss the manifest editor code that is required for sharing file uris.