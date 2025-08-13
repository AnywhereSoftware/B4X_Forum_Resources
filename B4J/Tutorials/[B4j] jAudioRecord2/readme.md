### [B4j] jAudioRecord2 by stevel05
### 10/16/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/142154/)

This is an new version of the jAudioRecord library (but not a direct plugin replacement) provided as a b4xlib and uses current B4x practices and classes.  
  
It allows selection of audio inputs and capturing directly to file or to a byte array so you can process the data further.  
  

![](https://www.b4x.com/android/forum/attachments/132064)

  
The library no longer relies on the threading library.  
  
The CaptureRaw class uses B4xBytesBuilder from theB4xCollections library.  
  
Demo  

- jAudioRecord2-Demo

- Demonstrates the full functionality of the library and enumerates and allows selecting the input device and capturing directly to a file or to a byte array (which is subsequently written to a file in the demo, but doesn't have to be).
- Contains CaptureMethod class which is a parent class to the CaptureRaw, CaptureToFile, CaptureRaw\_TH and CaptureToFile\_TH classes and uses duck typing to enable switching between the classes within the app. If you only want to use one method, you can just use the class you want directly.

- For an example of recording and playing see the jAudioRecAndPlay demo in [jAudioTrack2](https://www.b4x.com/android/forum/threads/b4j-jaudiotrack2.142197/) library.
- jAudiorecordNonUI

- An example for a non-ui app. Just records for 10 seconds and then exits the application. You will need to provide the start/stop recording controls as appropriate to your app.

  
**CaptureRaw vs CaptureToFile**  
The method GetBuffer is only relevant to the CaptureRaw class, a zero length byte array is returned from the CaptureToFile class as it does not buffer the data and is therefore more memory efficient.  
  
**B4xlib**  
The jAudioRecord2 b4xlib contains the code and some necessary utilities. Feel free to unzip and inspect or change it as you wish.  
  
**Dependencies**  

- [Threading](https://www.b4x.com/android/forum/threads/threading-library.6775/)

**Updates  
V0.11**  

- Added sub GetDevices and related Constants to JAudioRecordUtils

**V0.12 - 2023-10-13**  
[INDENT]Added Threaded classes (now depends on the Threading library. The threaded classes cannot be used in debug mode)[/INDENT]  
[INDENT]Demo contains the source code[/INDENT]  
[INDENT]Removed dependency on Xui for use in Non-ui apps.[/INDENT]  
[INDENT][/INDENT]  
  
**Comments**  
There are as many device configurations as there are PC's. It does work with mine and I have an external sound card as well as an internal sound card, Whether java supports all devices will remain to be seen.  
  
Please bear in mind that the demo and B4xlib provides all of the capabilities for the library. For your code, you can pick which classes you want to use. If you don't want to use the threaded classes you can copy only the classes you want to your project (or build a b4xlib) and remove the dependency on the threading library.  
  
Please try it and let me know how you get on and report any issues.