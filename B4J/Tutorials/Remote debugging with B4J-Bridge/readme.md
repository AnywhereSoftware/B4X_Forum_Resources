### Remote debugging with B4J-Bridge by Erel
### 10/15/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/38804/)

B4J v1.80 adds support for remote debugging using B4J-Bridge, a tool similar to the beloved [B4A-Bridge](http://www.b4x.com/android/forum/threads/7978/#content).  
   
The purpose of B4J-Bridge is to allow you to connect the IDE to a remote machine such as a Mac computer or a Raspberry Pi board and to easily debug your app on the remote machine. The connection is done over the network (usually the local network).  
  
**Instructions**  

- Download b4j\_bridge.jar to the remote machine: [www.b4x.com/b4j/files/b4j-bridge.jar](https://www.b4x.com/b4j/files/b4j-bridge.jar)
Note that you can download it with this command:

```B4X
wget www.b4x.com/b4j/files/b4j-bridge.jar  
'or (remove space between 'c' and 'url')  
c url -o b4j-bridge.jar https://www.b4x.com/b4j/files/b4j-bridge.jar
```

Tip: delete the previous version before download: rm b4j-bridge.jar- Make sure that Java 8+ is installed on the remote machine.
- Open a terminal and run java -jar b4j-bridge.jar:
![](http://www.b4x.com/basic4android/images/SS-2014-03-13_13.13.11.png)
If you are running it on a raspberry pi together with the jPi4J library then you need to run it with:

```B4X
sudo java -jar b4j-bridge.jar
```

- Choose Tools -> B4J-Bridge -> Connect and enter the remote machine IP address:
![](http://www.b4x.com/basic4android/images/SS-2014-03-13_13.14.43.png)- The status icon should change to:
![](http://www.b4x.com/basic4android/images/SS-2014-03-13_13.15.43.png)- Now you can run your app in Release or Debug mode and debug it directly on the target machine:
![](http://www.b4x.com/basic4android/images/SS-2014-03-13_13.17.27.png)
You can disconnect with Shift + F2 and later reconnect with F2.  
Note that the jar is copied to the target machine and deployed under a folder named tempjars.  
  
If the debugger fails to connect to the remote machine then you should open the following ports for incoming connections:  
59812, 8937 and 8938  
  
**Updates**  
  
v1.50 - Adds support for signed Mac Java 14. See the Java section here: <https://www.b4x.com/android/forum/threads/building-notarized-mac-packages.130890>  
v1.44 - Adds support for Java versions above Java 11.