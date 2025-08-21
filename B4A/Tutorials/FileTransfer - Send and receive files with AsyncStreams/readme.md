### FileTransfer - Send and receive files with AsyncStreams by Erel
### 06/07/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/30493/)

**Newer example based on B4XSerializator: <https://www.b4x.com/android/forum/threads/72149>**  
AsyncStream v1.50 (part of RandomAccessFile library) includes support for sending and receiving streams of any size.  
  
Unlike the regular write methods that send an array of bytes there is a new WriteStream method that takes an InputStream and sends it to the other size. **This method is only supported when AsyncStreams is initialized in [prefix mode](http://www.b4x.com/forum/showthread.php?p=43578).**  
  
WriteStream can efficiently handle streams of any sizes. In the receiving side the NewStream event is raised after a complete stream is received.  
  
Note that the data is checked for errors automatically using [Adler-32](http://en.wikipedia.org/wiki/Adler-32) algorithm. The Error event is raised if the checksums do not match.  
  
While a file is received you can check StreamTotal and StreamReceived properties to track the progress.  
  
The received stream is saved in a temporary file. NewStream event includes the file folder and name. The folder can be changed by setting the StreamFolder field. The file name is an arbitrary string. It is recommended to do whatever needs to be done with the file and then delete it. The files will not be deleted automatically and will not be overwritten.  
  
FileTransfer example demonstrates how AsyncStreams can be used to send and receive files of any size. This example allows you to connect two devices over Bluetooth or Wifi (assuming that both are connected to the same local network).  
  
Once connected you can choose files to send.  
  
![](http://www.b4x.com/basic4android/images/SS-2013-06-24_13.24.55.png)  
  
The code includes an activity and service. All the communication is managed in the service. The activity is responsible for the UI and it also manages the process of finding unpaired Bluetooth devices.  
  
As mentioned above the progress of received files is monitored with a timer that checks the StreamTotal and StreamReceived properties. In order to monitor the progress of the file being sent we use a CountingInputStream. This is a stream that wraps another stream and counts how many bytes were read.  
  
  
C# implementation of FileTransfer: <http://www.b4x.com/forum/basic4android-getting-started-tutorials/30741-net-filetransfer-implement-asyncstreams-prefix-mode.html#post178604>  
  
**Edit: example removed as it was outdated.**