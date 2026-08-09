### I Love My Back Key (And My Back Key Loves Me Back) by drgottjr
### 08/03/2026
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/171691/)

this is Backster. it addresses the missing back key touch that some users may be experiencing.  
  
for devices running < sdk 33, the back key functions as normal. you don't need Backster.  
  
starting with android 13 and running through android 16 (and sdk 33 through 36), google phased out what happens when you touch the back key. it essentially nullifies B4A's activity\_keypress. that is to say, your app is terminated. no warning, no error, no bug. it was a design decision. fortunately, your participation in this scheme was (mostly) optional.  
we are given the chance to opt out of this new behavior by a statement in the manifest: AddManifestText(<application android:enableOnBackInvokedCallback="false">)  
this allowed your activity\_keypress sub to work as before. unless your device runs android 17!  
  
update regarding the struck-through statement above:  
beginning with sdk 37, there is no opting out. for sdk's 33 through 36, if you add: AddManifestText(<application android:enableOnBackInvokedCallback="false">), our legacy activity.keypress behavior is maintained. if you don't add this statement to the manifest, android's predictive gesture scheme will default, and your app will appear to crash when you tap the back key.   
  
if you want to see what it's like to maintain the legacy effect under the predictive gesture scheme, add this to the manifest: AddManifestText(<application android:enableOnBackInvokedCallback="false">) and use Backster.  
  
copy the attached .jar and .xml files to your additional libraries folder and build and run the example. pay attention to the manifest.  
  
———————————————————————————————————————————————————————————————  
update in post #12. new example with multiple activities to show how to deal with that.