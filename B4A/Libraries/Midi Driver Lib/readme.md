### Midi Driver Lib by stevel05
### 07/16/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/48923/)

Android have still not allowed streaming Midi to the internal Midi device so for those interested in trying out streaming midi data to the onboard Sonivox midi device, here is a wrapper for [BillTheFarmers Midi Driver](https://github.com/billthefarmer/mididriver). This is the first of a few things I will be posting over the next week or two that are Midi Related.  
  
Be aware that performance will vary greatly depending on the device it is used on.  
  
The wrapper is pretty light with very few modifications. It has been working pretty well while I have been developing other things (to be released soon) so I thought I'd share it sooner rather than later.  
  
Unfortunately the Midi Driver Lib is too large to upload to the Forum as it contains the Sonivox Library even though it uses a fraction of it (see link below).  
  
The Midi Piano project attached is what is says it is, a graphic of a piano that sends midi note on, note off and patch change messages to the driver.  
  
If you do not know anything about the Midi standards I suggest you do some research before starting to try to program it. Two very good resources are:  
  
<http://www.sonicspot.com/guide/midifiles.html>  
  
and  
  
<http://www.somascape.org/midi/tech/mfile.html>  
  
You should be able to get most of the information you need from these.  
  
I am hoping that I can soon release a port of a large portion of the Javax.Midi classes, written entirely in B4a which will support MidiEvents, Sequence ,RealTimeSequencer and Recording which may also be of interest.  
  
The Midi Piano app depends on JavaObject and [Gestures](https://www.b4x.com/android/forum/threads/gestures-multi-touch-library.7421/) Libraries and of course the MidiDriver Lib available below. Unzip the jar and XML files and copy them to your additional Libraries folder.  
  
The biggest downside is that we are stuck with the reverb, apparently the Sonivox library has disabled the changing of the reverb by conventional means. I am trying to find out their Sysex command structure, but am not having much luck so far. I'll keep you posted on that one.  
  
**You can download the Midi Driver V2 Library from the Github Repository** [here](https://github.com/stevel05/MidiDriver2/tree/main/Files)  
  
**This is definitely Beta software**, please test it thoroughly and let me know if you find any issues in this thread. It would also be useful to know how usable it is on different devices.  
  
For my part, it's OK on my 2013 Nexus 7.  
  
Update to V2 (Download from the above link) to allow newer android devices to access the mididriver (Requires the MidiSystem2 download from [here](https://www.b4x.com/android/forum/threads/midisystem.50106/))  
  
Enjoy  
  
**25-07-15** Added [GitHub Project](https://github.com/stevel05/MidiDriver2)