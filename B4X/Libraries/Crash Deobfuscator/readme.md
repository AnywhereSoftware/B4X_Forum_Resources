###  Crash Deobfuscator by Computersmith64
### 12/22/2019
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/112234/)

I've put together a very quick & dirty B4J app that will deobfuscate Firebase Crashlytics crash reports. Basically all you do is copy the crash dump text from your Firebase console & paste it into the TextArea view, specify the path to the ObfuscatorMap file for the project in question & then hit the Deobfuscate button & it will convert all those pesky "\_vvvvvvvvvv" obfuscations to the actual objects they represent.  
  
I've tested it (briefly) on some of the crash reports from my B4A projects & I'm guessing it will work with all B4X projects (assuming they use the same format for the ObfuscatorMap file).  
  
As it is, it's very simple - but I can see that it might be useful to quickly see where an issue is happening without having to look through the project's .java files to work out which objects are being referenced by the obfuscation symbols in the Firebase crash reports.  
  
If people find it useful I might be willing to enhance it if there's enough interest.  
  
![](https://www.b4x.com/android/forum/attachments/86415) ![](https://www.b4x.com/android/forum/attachments/86416)  
  
- Colin.