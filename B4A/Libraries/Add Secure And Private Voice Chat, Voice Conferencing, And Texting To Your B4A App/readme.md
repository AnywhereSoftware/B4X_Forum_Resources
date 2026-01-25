### Add Secure And Private Voice Chat, Voice Conferencing, And Texting To Your B4A App by B9X Electronics
### 01/23/2026
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/170103/)

Simple and royalty free VOIP client library that allows multiple B4A apps to connect, to B9X Voice Server(TM), and communicate with each other.  
No dependencies are used. Only uses the libraries included with Basic For Android.  
  
Features:  
\* High Quality Low Latency Audio  
\* End To End 256 Bit AES Encryption  
\* Easily Connect To Server - Only Requires Host/IP, Port, And Password  
\* Absolutely No Data Collection  
  
Follow These Steps To Try Out:  
1) Download, Un-Zip, And Install B9X Voice Server v2.0 On A Windows PC.  
 [Click Here - To Goto Download Page](https://b9xelectronics.com/?page_id=144)  
  
2) Download The Sample Application And B4A Library v1.2.  
 [Click Here - To Goto Download Page](https://b9xelectronics.com/?page_id=935)  
  
3) Place The Library In Your B4A 'Additional Libraries' Directory.  
4) Compile The Sample And Install On At Least Two Android Phones.  
5) Enable Microphone Permissions, Of The Sample App On Each Phone, Before Running The App.  
6) Connect To The Server From Each Phone - Use The IP And Port, found in the title bar of B9X Voice Server, of Your Windows PC.  
7) Give One Of The Phones To A Friend And Talk With Each Other!  
  
Download(s), In Depth Details, And Descriptions can be found, on our website, at: [B9X Electronics](https://b9xelectronics.com)  
  
If you have any questions, please feel free to contact us at support @ b9xelectronics.com (no spaces in email address).  
  
Methods:  
  
Initialize(vCallback As Object, vEventName As String)  
vSetkey(sKey As String)  
vClearKey  
vConnect(password As String)  
vClose(password As String)  
vSetHost(sHost As String)  
vSetPort(sPort As Int)  
vSetListenPort(sPort As Int)  
vStartListening()  
vStopListening()  
vStartSending()  
vStopSending()  
vBroadcast(bMsg As String)  
vSetVOXTrigger(voxValue As Int)  
  
Events:  
vx\_messageReceived(msg As String)