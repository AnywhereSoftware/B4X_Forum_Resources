### jBluetooth library by Erel
### 08/02/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/60184/)

This library allows you to discover and connect to Bluetooth devices. It is similar to B4A Serial library.  
It is based on the BlueCove open project (Apache license): <http://bluecove.org/>  
This library runs on Windows.  
A modified version for Raspberry Pi is available here: <https://www.b4x.com/android/forum/posts/379631/>  
  
Don't confuse it with jSerial library: <https://www.b4x.com/android/forum/threads/jserial-library.34762/#content>  
jSerial library provides access to com ports (you can map a Bluetooth adapter to a virtual com and then use jSerial to connect with a Bluetooth device).  
  
[MEDIA=facebook]941113055981141[/MEDIA]  
If full screen doesn't work then you can open the video with this link: [plain]<https://www.facebook.com/130066193752502/videos/941113055981141/>[/plain]  
  
The steps required to connect to a Bluetooth device:  
1. Check that Bluetooth.IsEnabled returns true.  
2. Start a discovery process.  
3. Once Device\_Found is raised you can connect to the device.  
4. The Connected event will be raised with the BluetoothConnection object.  
5. Use AsyncStreams with the input and output streams.  
  
You can also listen to incoming connections. In that case you should call Bluetooth.Listen. The Connected event will be raised when a client is connected.  
  
The library depends on the following jar file: <https://repo1.maven.org/maven2/io/ultreia/bluecove/2.1.1/bluecove-2.1.1.jar>  
Copy it together with the library to the additional libs folder.  
  
The B4A project is also included.