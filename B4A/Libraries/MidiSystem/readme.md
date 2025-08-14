### MidiSystem by stevel05
### 07/17/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/50106/)

OK, here is the culmination of many months of work, it is a port of a large part of the javax MidiSystem, written entirely in Basic4Android.  
  
This Library gives access to a Midi file at the event/message level, you can create, load, play and save midi files and much more. It incorporates a USB manager module so you can attach external midi devices via USB and receive and send midi messages to the attached hardware. You can also create your own transmitter module and send midi data to the Sequencer as if it were a hardware device.  
  
I have simplified some of the workings as Android devices do not provide as many in/out configurations as working on a PC.  
  
The biggest problem remains audio latency especially when playing from a User module to the internal Midi module, using USB hardware provides better performance.  
  
I will post some complete examples so you can see how the System works in the Example forum as there are a few of them. Most of the documentation for the Javax Midi System is relevant.  
  
**The library depends on these libraries** which should be in your additional libs folder:  
  
[threading](https://www.b4x.com/android/forum/threads/threading-library.6775/), javaobject, [slbytearraybuffer](https://www.b4x.com/android/forum/threads/bytearraybuffer.34306/), [mididriver](https://www.b4x.com/android/forum/threads/midi-driver-lib.48923/), [usb](https://www.b4x.com/android/forum/threads/usb-host-library.11290/), [slstreams](https://www.b4x.com/android/forum/threads/slstreams.50105/), [nanotime](https://www.b4x.com/android/forum/threads/nanotime.50104/)  
  
**You can alternatively download the SupportLibs.zip file from the GithubPage [here](https://github.com/stevel05/MidiSystem/blob/main/Files/SupportLibs.zip). and the [threading](https://www.b4x.com/android/forum/threads/threading-library.6775/) library**  
  
This is a large library, although I have tested it as thoroughly as possible, I am sure there will be some bugs in there somewhere, please treat it as Beta software and test any app using it thoroughly yourself prior to release.  
  
I have a reasonably fast (2013 Asus Nexus 7) which handles the workload very well, I can't guarantee that all devices will do the same. Please have a target in mind and test developed software on that. I would be surprised if anything over 3 years old would give acceptable performance. There could be as many a 5 threads (including the Gui thread) running at once if you are recording, so it could be a drain on resources for older / slower devices.  
  
Updated to v1.01 as post#2  
Update to V2 to allow newer android versions to access the midi driver. (You also need the [mididriver2](https://www.b4x.com/android/forum/threads/midi-driver-lib.48923/) Lib)  
Update to V2.1 Added getShortMessageData3 To MidiMessage  
  
MidiLibNew contains the B4a source code for the library. This is here for completeness, and will not work if built as a b4xlib, there is a lot of threading in the library. Please use the library files provided in MidiSystem2.zip.  
  
Enjoy  
  
**2025-07-15:** Created a [github project](https://github.com/stevel05/MidiSystem)  
  
Related Links:  

- [Midi Driver lib](https://www.b4x.com/android/forum/threads/midi-driver-lib.48923/#content)
- [Play a Midi file](https://www.b4x.com/android/forum/threads/midi-system-example-play-a-midi-file.50107/#content)
- [Accessing devices via USB](https://www.b4x.com/android/forum/threads/midi-usb-device-manager.41118/#content)
- [Midi Monitor2](https://www.b4x.com/android/forum/threads/midi-monitor2.167812/)