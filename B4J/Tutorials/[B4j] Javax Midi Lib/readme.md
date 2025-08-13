### [B4j] Javax Midi Lib by stevel05
### 02/19/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/113466/)

Here is a wrap of the JavaxMidi Library as a B4xLib.  
  
It is a large library and I haven't tested all of the available methods, it you get any problems let me know and I'll take a look.  
  
The code is in the b4xlib, but only supports B4j feel free to unzip it and use it as you wish.  
  
The example attached is a simple midi player and dump viewer for the midi tracks and has no additional dependencies.  
  

![](https://www.b4x.com/android/forum/attachments/87966)

  
  
  
  
  
**Depends on**: JavaObject and ByteConverter.  
  
Documentation for the library is in the attached XMLfile which you can open with one of the Document viewers available on the Forum. Documentation and examples for the JavaxMidi package are available on the internet,  
  
As always, if you try it, let me know how you get on with it and please report any bugs or problems.  
  
**Update to V1.2**  
Amended to work with external midi devices. (see [post #7](https://www.b4x.com/android/forum/threads/b4j-javax-midi-lib.113466/post-844150))  
  
**Update to V1.3**  
Fixed bug in soundfont initialization (Thanks luca1967 for finding it)  
  
**Update to V 1.4**  

- Added TransposeTrack2 to MidiUtils which allows ignoring transpose on certain midi channels.
- Fixed bug in MidiSynthesizer GetLoadedInstruments

**Update to V 1.5 - Breaking Change**  

- Added ChrSet where needed to allow use of different character encoding for text events in a midifile.
- Added VirtualMachinArgs and PackagerProperty to the example project as required to create a package on Java9+ (Uncomment the 2 lines)

It will be obvious in the IDE where the changes are required, I suggest you used "UTF-8" for the characterset unless you know it needs something different.  
  
**Update to V 1.6 - Breaking Change (if using a transmitter listener)**  

- Amended MidiData\_Event in MidiTransmitter class to return a MidiMessage instead of MidiShortMessage See [this post](https://www.b4x.com/android/forum/threads/javaxmidi-b4xlib-for-b4j.141242/post-899204) for modifications required

**Update to V 1.7**  

- Modified MidiySytemStatic GetSequence2 and GetSequence3 to return wrapped Sequence Objects

**Update to V 1.8**   

- Fixed bug in MidiSystemGetMidiFileFormat3
- Bug Fixes

**Update to V 1.9**  
Modified for compatibility with B4j V10.20 Beta +