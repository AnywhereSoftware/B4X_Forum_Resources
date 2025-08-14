### Fix to error: Failed resolution of: Landroidx/work/impl/WorkDatabase by asales
### 08/04/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/168089/)

1 - This is happens only with apps that has Admob ads  
2 - Happens in differents devices and Android versions (>= 11)  
3 - Even with B4A 13.40 and the new SDK 35, the error stills occours.  
  
This is the fix that I use in my recents apps and (until now) the error was fixed.  
The lines are based in answers from differents posts:  

```B4X
#AdditionalJar: androidx.work:work-runtime  
#AdditionalJar: androidx.work:work-runtime-ktx  
#AdditionalJar: androidx.startup:startup-runtime  
#AdditionalJar: androidx.room:room-runtime  
#AdditionalJar: androidx.room:room-common
```