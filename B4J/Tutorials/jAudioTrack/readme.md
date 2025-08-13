### jAudioTrack by stevel05
### 08/15/2022
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/37973/)

There is a newer version of this library with more functionality (not a direct plugin replacement) [jAudioTrack2](https://www.b4x.com/android/forum/threads/b4j-jaudiotrack2.142197/)  
  
Here is the opposite number to jAudioRecord, again based on [javax.sound.sampled](http://docs.oracle.com/javase/tutorial/sound/sampled-overview.html) it's setup is very similar.  
  
Again, not tested on linux or Mac, feedback would be appreciated.  
  
**AudioTrack  
Author:** Steve Laming  
**Version:** 1.0  
  

- **Methods:**

- **AddLineListener**(EventName As String)
*Adds a listener to this line.  
 Callback to sub {EventName}\_Event will be called when one of the following events has been raised:  
 OPEN, CLOSE, START or STOP*
**Available**  As Int
*Obtains the number of bytes of data currently available   
 to the application for processing in the data line's internal buffer.*
**Buffersize**  As Int
*Get the buffer size of the SourceDataLine*
**Drain**
*Drains queued data from the line by continuing data I/O until the data line's internal buffer has been emptied.*
**Flush**
*Flushes queued data from the line.*
**Initialize**(SampleRateHZ As Float, SampleSizeInBits As Int, ChannelConfig As Int)  As Boolean
*Initialize the object*
**IsActive**  As Boolean
*Indicates whether the line is engaging in active I/O (such as playback or capture). When an inactive line becomes active, it sends a START event to its listeners.   
 Similarly, when an active line becomes inactive, it sends a STOP event.*
**IsInitialized**  As Boolean
*Is the Audiotrack initialized?*
**IsRunning**  As Boolean
*Indicates whether the line is running. The default is false. An open line begins running when the first data is presented in response to an invocation of the start method,   
 and continues until presentation ceases in response to a call to stop or because playback completes.*
**LastException**  As String
*If an error occurred get the last exception*
**Release**
*Closes the line*
**Start**
*Start playing data*
**Stop**
*Stop playing data*
**Write**(Data As Byte(), Off As Int, Len As Int)  As Int
*Writes data to the SourceDataLine, id more data is sent that it can read it will block the thread  
 off = offset into array data  
 Returns the actual number of bytes written*
  
  
The demo app (ATTest.xip) loads a small wav file (you can also load your own with a file selector) to play. It depends on:  
  
jRandomAccessFile  
[Threading](http://www.b4x.com/android/forum/threads/threading-library.6775/)  
  
The threading library is necessary so we can control the processing of data as it arrives within B4j. The data capture is blocking, so if you run it on the GUI thread, the app will lock.  
  
It plays back PCM signed linear data. No Mp3 or other formats, although a byte array is passed to the Write method if you have an decoder library to decode a different format first.  
  
You cannot debug an application that uses the threading library, so if you are just testing and don't need a Gui, run the playing subroutine in the Gui thread.  
  
Download jAudioTrack.zip and unzip the xml and jar files to your additional libraries folder.  
  
Have fun.  
  
ATTest1.zip should fix issues in post [#5](http://www.b4x.com/android/forum/threads/jaudiotrack.37973/#post-226391)