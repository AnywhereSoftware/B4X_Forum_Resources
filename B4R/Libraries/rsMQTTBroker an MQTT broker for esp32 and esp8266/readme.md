### rsMQTTBroker an MQTT broker for esp32 and esp8266 by candide
### 07/26/2023
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/149225/)

it is a wrapper for sMQTTBroker from here : <https://github.com/terrorsl/sMQTTBroker>  
  
this simple MQTT broker is working on esp32 and esp8266  
 - it can work without callback,   
 - it can work with 6 callbacks on NewClient, Subscribe, UnSubscribe, Publish, RemoveClient, and LostConnection : it can help at debugging on a small network, but it will have an impact on performances.  
- Mqtt 3.1.1 / Qos 0, 1 supported