### Midi System3 driver and library update Beta by stevel05
### 07/18/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/167823/)

Looking at the latest BillTheFarmer midi driver, it now has the ability to control the Reverb. I though it was worth giving it a go.  
  
This time, I have accessed the library using JavaObject as opposed to using a java wrapper, which has the advantage of being easily maintainable, but the disadvantage of having to add an #AdditionalJar directive to each project.  
  
Anyway, here is the MidiSystem3 compiled library, MidiSystem3-Source (only the MidiReceiver and MidiDriver Classes have changed) the code for the MidiDriver (which is now part of the MidiSystem3 wrapper so just for reference, or if you want to try it separately from the midi library) and a Midimonitor demo with access to the Reverb control. The additional controls are only available on the default driver, so we need to check that is the correct driver before calling the setReverb and setVolume methods.  
  
To use the library, download the aar library from [BillTheFarmers](https://github.com/billthefarmer/mididriver/releases) github page under Releases. Currently tested with Version 1.27. Add that and the compiled library files attached (from MidiSystem3.zip) to your B4a Additional libraries folder. Add the AdditionalJar directive - [ICODE]#AdditionalJar: MidiDriver-1.27.aar[/ICODE], select the library MidiSystem3 and you should be good to go.  
  
If you are testing in a copy of an existing project, remove the reference to MidiSystem2 in the libraries tab, and add MidiSystem3. And add the #AdditionalJar directive as above.