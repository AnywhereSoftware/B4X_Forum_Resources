### Getting/saving photos with metadata by Semen Matusovskiy
### 11/01/2019
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/110985/)

Small class (BitmapEx) for following tasks  
1) Getting photos with metadata similar Camera app  
2) Disable autorotate (not all external viewers understand "orientation")  
  
A set of class methods is very short and should be clear from the sample.  
  
How to run a sample … Correct bundle id and certificates. Run. Press "camera icon", make a photo. "Refresh" icon is used to load jpg from the file. It will be a small differences between saved and loaded metadata, because IOS automatically adds such tags as ColorModel, ProfileName etc.