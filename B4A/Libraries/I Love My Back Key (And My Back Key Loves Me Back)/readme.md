### I Love My Back Key (And My Back Key Loves Me Back) by drgottjr
### 08/01/2026
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/171691/)

this is Backster. it addresses the missing back key touch that some users may be experiencing. it's for B4A activities. i don't know if it works with B4X Pages.  
  
for devices running < android 13, the back key functions as normal. you don't need Backster.  
  
starting with android 13 and running through android 16 (and sdk 33 through 35), google phased out what happens when you touch the back key. it essentially nullifies B4A's activity\_keypress. that is to say, your app is terminated. no warning, no error, no bug. it was a design decision. fortunately, your participation in this scheme was (mostly) optional.  
we are given the chance to opt out of this new behavior by a statement in the manifest: AddManifestText(<application android:enableOnBackInvokedCallback="false">)  
this allowed your activity\_keypress sub to work as before. unless your device runs android 17!  
  
beginning with android 17, there is no opting out. that is to say, if your device runs android 17 you need to be able to handle what google refers to as "predictive" behavior (whatever that means). note: for android 13 through 16, if you add: AddManifestText(<application android:enableOnBackInvokedCallback="true">), and you have Backster in place, you can achieve the same behavior in android 17 that we used to have when touching the backkey.  
  
my test devices run android 12 and 17, so i can't test 13 through 16. i've tested with my devices. between targeting various sdk's, opting in/out in the manifest and testing on various devices, my head is spinning. copy the attached .jar and .xml files to your additional libraries folder and build and run the example. pay attention to the manifest.  
  
———————————————————————————————————————————————————————————————  
updated example and library.  
1) example change: callback must be unregistered onpause. i've add this step to the example.  
2) library change: added some logging for info. (unregsitering was already there). make sure you're using version 0.75