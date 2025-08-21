###  Log Server by stevel05
### 12/31/2019
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/92438/)

[SIZE=4]This is one of the things I've been working on. It enables multi window logging so you can organise and more easily read the logs you create in your code.[/SIZE]  
  

[SIZE=4]![](https://www.b4x.com/android/forum/attachments/86987)[/SIZE]  
  
[MEDIA=youtube]\_6UCm7e\_VN8[/MEDIA]

  
  
[SIZE=4]You can :[/SIZE]  

- [SIZE=4]create multiple dockable LogAreas (windows) the last area created will become the current default.[/SIZE]
- [SIZE=4]SwitchTo another existing area to make that the default.[/SIZE]
- [SIZE=4]Send a message to a specific log area[/SIZE]
- [SIZE=4]Log in Color[/SIZE]
- [SIZE=4]Write all messages simultaneously to a file for specified LogAreas[/SIZE]
- [SIZE=4]Filter or Find messages in each LogArea[/SIZE]
- [SIZE=4]Copy messages to the clipboard (select then ctrl-c)[/SIZE]
- [SIZE=4]Turn on and off logging of the messages to the IDE log (LogLocal)[/SIZE]
- [SIZE=4]Configure the output in the Server app (Edit/UserOptions) - Font size, Background color, Port number max message and a few more.[/SIZE]
- [SIZE=4]Run the server app on a separate computer.[/SIZE]

  
[SIZE=4]LogServerClient is now a b4xlib which should work on all platforms. It has a different name to the previous libraries to avoid confusion.  
  
The LogServer runs on a PC (untested on a MAC but please let me know) and is provided as a jar file which you should open before running the app containing the client module. Nothing bad will happen if you run the app without opening the server first, all messages will be sent to the IDE log window, you will get a "java.net.ConnectException: Connection refused: connect." message which you can ignore.  
  
If you lose connection while an app is running for any reason, any subsequent messages will be sent to the IDE log.  
  
  
**The client module depends on**:  
jNetwork / Network  
jRandomAccessFile / RandomAccessFile  
jXUI / XUI (except NonUI B4j apps)  
JavaObject  
  
Limitations:[/SIZE]  

- [SIZE=4]This is not a replacement for the IDE log, it cannot show application errors.[/SIZE]
- [SIZE=4]The Gui slows down once there are about 3000 items in a LogArea, which is why the limit is initially set to that in the User Options. If you experience a slow Gui, or are running it on an old slow computer you can try limiting this further.[/SIZE]

[SIZE=4]The Server will now accept multiple connections.  
  
**Documentation:** available as [Html file on dropbox](https://www.dropbox.com/s/gmlc8ekzcjto1s2/LogServerClient-B4x.htm?dl=0)  
  
  
**Downloads:**  
  
Examples for B4a and B4j and single b4xlib file are attached.  
  
The LogServer jar is too big to upload to the forum, you can get it from my Dropbox here : [LogServer download](https://www.dropbox.com/s/s99c1quswg676ga/LogServer.jar?dl=0)  
  
  
**Update V2:**  
Supports multiple connections from any platform  
  
The library is now a distributed as a B4xlib and should work on b4j, b4a and b4i as I have removed threading and java specific code.  
  
The only downside is that if you send a lot of messages while the device is connecting, they are handled by a timer instead of a thread, which makes the updates a little slower. To negate this, there is a Stream\_Ready callback that will fire when the stream is ready, if you wait for that as in the examples, then the slow down will not occur.  
  
**Update V2.10** Client library Updated to work with Non\_UI apps in Java 9+  
  
**Update V2.2**[/SIZE]  
  

- [SIZE=4]Added ServertimeStamp[/SIZE]
- [SIZE=4]Added CircularProgressBar - Erel's [Circular Progress Bar](https://www.b4x.com/android/forum/threads/b4x-xui-custom-view-circularprogressbar.81604/post-517008)[/SIZE]
- [SIZE=4]Added TimePlot - Based on Klaus's [xChart](https://www.b4x.com/android/forum/threads/b4x-xui-xchart-class-and-b4xlib.91830/post-580026) V4.2[/SIZE]
- [SIZE=4]Added [LedMatrix](https://www.b4x.com/android/forum/threads/b4x-led-matrix.112360/post-700482)[/SIZE]
- [SIZE=4]Added [HexView](https://www.b4x.com/android/forum/threads/b4j-hex-view-customview.112588/post-701943)[/SIZE]
- [SIZE=4]Improved tcp connection process[/SIZE]
- [SIZE=4]Added IsConnected method to LogServerClient[/SIZE]

  
[SIZE=4]**Don't forget to download the new version of LogServer.jar from the Dropbox link above and set the IP address of the server in b4a / b4i and also in b4j if you are running the server on a different computer.**  
  
If you test it on B4i, please let me know the results.  
  
  
Please try it out and let me know how you get on with it.  
  
Enjoy.[/SIZE]