### Node-Red MQTT controlling 8 relays ESP32 by TiDi
### 06/05/2022
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/141004/)

Hi  
Here a sample program to control 8 outputs on arduino ESP32. The program use the MQTT protocol to exchange the data (really a single byte). By Node-red web interface the user set or reset the relay and the arduino send back the status as feedback. The program use Aerdes as MQTT broker.  
Before start fill the configuration parameters: WiFi name , password, broker name, password, IP and Port.  
  
I am new of Node-Red, and takes some time to figure out how to connect to Arduino, especially with the “real time” feedback.  
I post the full folder of the B4R project, including library copy.  
  
![](https://www.b4x.com/android/forum/attachments/130017)