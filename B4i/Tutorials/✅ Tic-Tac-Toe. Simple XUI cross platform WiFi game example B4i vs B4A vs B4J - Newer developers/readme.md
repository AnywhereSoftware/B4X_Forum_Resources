### ✅ Tic-Tac-Toe. Simple XUI cross platform WiFi game example B4i vs B4A vs B4J - Newer developers by Peter Simpson
### 06/10/2020
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/118636/)

Hello fellow B4X developers.  
Here is my example of using a broadcast address to automatically find another devices IP address on a network, then to use that IP address to play a game (in this case Tic-Tac-Toe) across that WiFi network (device 1 vs device 2, iOS, Android or Desktop). This tutorial not only shows you how to use UDPSocket (GetBroadcastAddress) to manipulate your routers broadcast address, but I've also used Canvas.DrawLine, SetVisibleAnimated, a Timer, XUI, Images, MediaPlayer (for sound effects), UDPPacket, ServerSocket, B4XSerializator and also B4XView to help create this example which is now based on Erels original example with some changes.  
  
The two modules named **TicTacToe.bas** and **ConnectPlayer.bas** are in fact shared modules, thus you should place them in your shared projects modules folder as these two modules work with B4A, B4i and also B4J without any changes necessary. You **DO NOT** need them in your main projects folder, but if you are not using B4A or B4J then you might as well leave them where they are currently located.  
  
**What is a broadcast address (taken from wikipedia):** A broadcast address is a network address at which all devices connected to a multiple-access communications network are enabled to receive datagrams, which comprise UDP and TCP/IP packets, for instance. A message sent to a broadcast address may be received by all network-attached hosts  
  
**>>>** [**CLICK HERE**](https://www.dropbox.com/s/q4pn8eq6yhepk71/Tic-Tac-Toe.zip?dl=0) **<<<** to download all three Tic-Tac-Toe code examples.  
  
**The B4A example can be found below**  
<https://www.b4x.com/android/forum/threads/%F0%9F%92%A1-tic-tac-toe-simple-xui-cross-platform-wifi-game-example-b4a-vs-b4i-vs-b4j-newer-developers.118635/#post-742287>  
  
**The B4J example can be found below**  
<https://www.b4x.com/android/forum/threads/%F0%9F%92%A1-tic-tac-toe-simple-xui-cross-platform-wifi-game-example-b4j-vs-b4a-vs-b4i-newer-developers.118764/>  
  
**Please note:** There are multiple ways to achieve what I've done here, I chose this way as I believe that this is one of the easiest for newer B4X developers to follow and to learn from. I would usually only use AsyncStreams (AStream.Write) with ServerSocket (Server.Listen) to send and receive data over a WiFi network, but because I wanted the devices to automatically find and connect to each other without any user interaction I decided to use UDP.  
  
04/06/2020: Released V1.0.0.0  
05/06/2020: Updated V1.0.0.1 - Replaced 3 x #If B4A / #If B4i conditions in shared modules  
10/06/2020: Remove TTT sub from the main module  
  
**Libraries used:-**  
![](https://www.b4x.com/android/forum/attachments/95252)  
  
**iOS screenshot**  
![](https://www.b4x.com/android/forum/attachments/95255)  
  
**YouTube video showing vs iOS vs Android**  
[MEDIA=youtube]jRyzCDq2W8k[/MEDIA]  
  
  
  
**Enjoy…**