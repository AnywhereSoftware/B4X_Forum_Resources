### ESP Configurator based on B4RSerializator by Erel
### 12/08/2022
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/81452/)

![](https://www.b4x.com/basic4android/images/SS-2017-07-09_16.48.51.png)  
  
This tool replaces the browser based solution (<https://www.b4x.com/android/forum/threads/esp8266-wifi-remote-configuration.68596/>). It is simpler and much more powerful.  
  
B4RSerializator, which converts objects to bytes and vice versa, is used for the communication with the B4J app and to save the settings in the EEPROM. B4RSerializator is also compatible with B4A and B4i so you can also create a mobile app.  
  
In this specific example the data includes MQTT related settings. It should be simple to change it to store other fields. Just make sure to set the field types correctly.  
  
If the ESP is not connected to the local network then you should connect the PC to the ESP access point and set the ip address to 192.168.4.1, which is the default ip.  
If it is connected to the network and you know its ip address then you can use it instead. The ESP local ip is printed in the logs.  
  
Now click on Get to get the stored parameters or click on Set to send the parameters to the board.  
In this example it is configured to connect to the network and then connect to a MQTT broker.  
  
Note that the Get and Set features start a new connection and close it when done. This is a simpler and safer approach compared to maintaining a continuous connection.  
  
**If you are using Java 9+ then replace jControlsFX with jControlsFX9.**