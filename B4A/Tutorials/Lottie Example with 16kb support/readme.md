### Lottie Example with 16kb support by mcqueccu
### 09/25/2025
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/168792/)

This example is based on the Lotti Library by DonManfred found here. (It still works)  
<https://www.b4x.com/android/forum/threads/lotti.76087/>  
  
 I tried it on 16kb android 15 emulator and tested the apk with the 16kb script and it passed  
  
1. Download the lotti library v3.4 from the link above, and add to your additional libraries folder (B4A)  
2. Add Appcompat Library  
  
3. Get this additional jars if dont already have it  
  
#AdditionalJar: androidx.core:core  
#AdditionalJar: androidx.appcompat:appcompat  
#AdditionalJar: Lottie.aar  
#AdditionalJar: kotlin-stdlib-1.3.21  
#AdditionalJar: Lottie-assets.aar  
#AdditionalJar: okio-1.17.4.jar  
  
OPTIONAL: If you want the latest Lottie.aar and kotlin-stdlib you can get them below  
  
Lottie.aar: <https://mvnrepository.com/artifact/com.airbnb.android/lottie/6.6.9>  
kotlin-stdlib: <https://mvnrepository.com/artifact/org.jetbrains.kotlin/kotlin-stdlib/2.2.20>  
  
Then replace  
#AdditionalJar:Lottie.aar with #AdditionalJar:Lottie-6.6.9.aar  
#AdditionalJar:kotlin-stdlib-1.3.21 with #AdditionalJar:kotlin-stdlib-2.2.20  
  
4. Compile  
  
DOWNSIDE:  
1. The library Author has lost the library files due to hdd crash, so do not expect update to the library version3.4  
2. I am yet to figure out how to load lottie files that depends on additional images  
Its working with new json files with embeded assets tags