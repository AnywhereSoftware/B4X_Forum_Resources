### jAudioRecord by stevel05
### 08/04/2022
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/37930/)

There is a newer version of this library with more functionality (not a direct plugin replacement) [jAudioRecord2](https://www.b4x.com/android/forum/threads/b4j-jaudiorecord2.142154/)  
  
This is an Audio Recording Library based on [javax.sound.sampled](http://docs.oracle.com/javase/tutorial/sound/sampled-overview.html) that I have tried to make as simple to use as possible. It will record from the default device as selected in the Control Panel or Mixer (on Windows Machines).  
  
I haven't been able to test it on Linux and Mac, but as it only uses the default devices, I hope it should be OK. I may be able to test it on Linux soon. If you run it on any system, please let me know how it runs.  
  
The Java Audio system is a great deal more complicated than the Android equivalent, I may look at implementing more features such as input / output selection and accessing Volume and Pan controls if there is a demand for it.  
  
My sound card doesn't support 8bit recording so I would be grateful if someone could test that. I get a lot of noise and was about to investigate when I thought I should check if the Realtek HD actually did 8bit, and apparently it doesn't so I was getting a 0 byte for every valid data byte, hence the noise.  
  
The library:  
  
**JAudioRecord  
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
*Get the buffer size of the TargetDataLine*
**Drain**
*Drains queued data from the line by continuing data I/O until the data line's internal buffer has been emptied.*
**Flush**
*Flushes queued data from the line.*
**Initialize**(SampleRateHZ As Float, SampleSizeInBits As Int, ChannelConfig As Int)  As Boolean
**IsActive**  As Boolean
*Indicates whether the line is engaging in active I/O (such as playback or capture). When an inactive line becomes active, it sends a START event to its listeners.   
 Similarly, when an active line becomes inactive, it sends a STOP event.*
**IsInitialized**  As Boolean
**IsRunning**  As Boolean
*Indicates whether the line is running. The default is false. An open line begins running when the first data is presented in response to an invocation of the start method,   
 and continues until presentation ceases in response to a call to stop or because playback completes.*
**LastException**  As String
*If an error occurred get the last exception*
**Read**(Data As Byte(), Off As Int, Len As Int)  As Int
*Reads data from the TargetDataLine, it requests len bytes which are stored in data  
 off = offset into array data  
 Returns the actual number of bytes read*
**Release**
*Closes the line and*
**Start**
*Start capturing data*
**Stop**
*Stop capturing data*
  
There are no external dependencies for the Library.  
  
The Demo is a modified version of the Android one and depends on libraries:  
  
[jMsgBoxes](http://www.b4x.com/android/forum/threads/msgbox-library.34700/)  
jRandomAccessFile  
[Threading](http://www.b4x.com/android/forum/threads/threading-library.6775/)  
  
The threading library is necessary so we can control the processing of data as it arrives within B4j. The data capture is blocking, so if you run it on the GUI thread, the app will lock.  
  
It captures PCM Signed linear data. No Mp3 or other formats, although access to the samples is available if you have an encoder library. The demo captures the input stream and saves it to a wav file and plays it back through MediaPlayer.  
  
You cannot debug an application that uses the threading library, so if you are just testing and don't need a Gui, run the record subroutine in the Gui thread.  
  
Unzip jAudioRecord and copy the xml and jar files to your addl Libraries folder.