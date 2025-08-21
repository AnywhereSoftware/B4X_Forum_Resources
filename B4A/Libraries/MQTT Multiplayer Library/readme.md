### MQTT Multiplayer Library by paris7162
### 04/03/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/115825/)

This is a MQTT Multiplayer Library created by one of the best B4A library creators and member in the B4X Community. I use his libraries in all of my games. I didn’t write any of this code and I told him I would keep his identity private unless he wanted to reveal who he is.   
  
I use it to play a Multiplayer card game with an Android and iOS device. I couldn’t find a better way for and Android player to play and iPhone player. I uploaded the Broker.jar to my Linux Virtual Private Server. I send a list from B4a and a NSMutableArray (NSArray) from Xcode in Objective C.  
  
I used the following pods to install the library on my iOS devices.  
pod 'MQTTClient/MinL'  
pod 'MQTTClient/ManagerL'  
pod 'MQTTClient/WebsocketL'  
  
<https://cocoapods.org/pods/MQTTClient>  
  
Here is the explanation on how to use the library.  
  
Step by step to try the demos:  
- download the archive and copy the content of Lib to the directory of additional libraries of B4J;  
- set a valid port number in Broker/Broker. b4j (line 10);  
- open this port on your server, if necessary;  
- compile the Broker.b4j project;  
- upload the result (Broker.jar) on your server and execute it;  
- in the two projects under Demo\_Clients, enter the IP address of the server and the port used by the broker (B4A: lines 28 and 29; B4J: lines 19 and 20);  
- in the Client.b4a project, you can change the method of identification of the device line 48 (the goal is that the device is identified with an unique ID; the demo code will work but that won’t be the case in a real application with many users because some devices share the same android\_id);  
- in the Client.b4j project, you can also change the ClientID and put whatever you want;  
- run the clients and click on the Connect button.  
  
I've used this for 2 years and it works perfectly so far. Feel free to use this however you like. B4J has been updated a few times since then so I hope this still compiles. I'm the worst programmer so I can't be of much help to anyone but I will answer what I can.