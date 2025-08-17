### jSerial library by Erel
### 03/06/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/34762/)

The jSerial library allows you to open and communicate with other devices through the computer COM ports.  
  
It can also be used to communicate with Bluetooth devices over a virtual com port.  
(jBluetooth library is now available: <https://www.b4x.com/android/forum/threads/jbluetooth-library.60184/>)  
  
![](http://www.b4x.com/basic4android/images/SS-2013-11-21_15.46.10.png)  
  
The attached examples implement an Android <-> PC chat app.  
  
In order to run the example you need to first pair the PC and the device and make sure that the Bluetooth is mapped to a virtual com port.  
  
jSerial works with AsyncStreams. Both standard mode and prefix mode are supported. **Note that prefix mode can only work if both sides of the connection follow the protocol.**  
Change AStream.InitializePrefix to AStream.Initialize to disable prefix mode.  
  
jSerial depends on an open source project named JSSC: <https://github.com/java-native/jssc>  
  
Updates:  
v1.40 - Based on jssc v2.9.6. Provides better handling of low level errors. Edit: a new zip was uploaded which fixes an issue with the standalone packager.  
v1.32 - Based on jssc v2.9.4.  
v1.31 - Adds missing BAUDRATE, DATABITS, STOPBITS and PARITY constants.  
v1.30 - Adds support for Java 11 and 64 bit computers based on: <https://github.com/java-native/jssc>  
  
Instructions related to jSerial and B4J Packager 11: <https://www.b4x.com/android/forum/threads/jserial-library.34762/post-735742>