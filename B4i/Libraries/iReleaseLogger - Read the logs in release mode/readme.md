### iReleaseLogger - Read the logs in release mode by Erel
### 10/14/2019
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/51164/)

iReleaseLogger combined with the desktop B4iLogger tool (written with B4J) allow you to monitor the app logs in release mode. This is useful when you encounter an error that you are unable to reproduce in debug mode.  
  
The release logger sends udp messages which the desktop logger prints.  
Depending on your firewall settings you may see a dialog such as this one when you first run the logger:  
  
![](http://www.b4x.com/basic4android/images/SS-2015-02-25_17.30.25.png)  
  
You can also manually add an incoming rule for **UDP** connections on port 54323.  
  
In order to activate the logger you need to:  
1. **Add a reference to iReleaseLogger and iNetwork libraries.**  
2. Add this code to your app (with the desktop ip address):  

```B4X
Private Sub Application_Start (Nav As NavigationController)  
Dim rl As ReleaseLogger  
rl.Initialize("192.168.0.6", 54323)
```

  
  
Run the desktop tool with:  

```B4X
java -jar B4iLogger.jar
```

  
  
**Notes**  
  
- The logs in release mode do not include all the information that is available in debug mode.  
- Do not try to upload your app with iReleaseLogger library included to the App Store. It will be rejected.  
**-** You can keep the desktop tool running for as long as needed.  
  
  
In case you are interested, the B4J code is:  

```B4X
Sub Process_Globals  
   Private usock As UDPSocket  
End Sub  
  
Sub AppStart (Args() As String)  
   Dim port As Int = 54323  
   Dim serv As ServerSocket 'ignore  
   usock.Initialize("usock", port, 16000)  
   Log($"My IP Address ${serv.GetMyIP}"$)  
   Log($"Waiting on port ${port}"$)  
   StartMessageLoop  
End Sub  
  
Sub usock_PacketArrived (Packet As UDPPacket)  
   Log(BytesToString(Packet.Data, 0, Packet.Length, "UTF8"))  
End Sub
```

  
It should be trivial to create a similar logging monitor in B4A or B4i (to read the logs on a different device).