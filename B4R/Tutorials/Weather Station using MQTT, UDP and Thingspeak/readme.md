### Weather Station using MQTT, UDP and Thingspeak by Mark Read
### 04/09/2021
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/129558/)

This is my humble effort to produce a weather station (based on [this](https://www.instructables.com/Solar-Powered-WiFi-Weather-Station/) project). You will need:  
  
1 x Wemos D1 Mini  
1 x BME280 Sensor  
1 x TP4056 Li-Ion Charging board  
1 x 3.7V Li-Ion Battery  
1 x Holder for the battery  
1 x Solar Panel delivering at least 5V  
1 x LED  
1 220 ohm Resistor  
1 x Jumper (as in PC jumper) or a cable  
1 x 70 mm x 90 mm PCB  
1 x 1N4007 Diode (to stop battery discharge)  
Solder & Iron  
Various headers, so you dont solder the Wemos to the PCB.  
Screw connectors for the battery and solar cell  
  
Firstly you need to make the PCB. The plan is here:  
  
![](https://www.b4x.com/android/forum/attachments/111349)  
  
The jumper is required otherwise the Wemos will not wake up after deep sleep.  
  
After soldering the board, I put mine in a 3D printed case and hung it up outside.  
  
![](https://www.b4x.com/android/forum/attachments/111350)![](https://www.b4x.com/android/forum/attachments/111351)