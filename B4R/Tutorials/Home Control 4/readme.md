### Home Control 4 by XorAndOr
### 05/18/2023
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/148024/)

Hi guys  
I want to share my project on this great community (source code free no donation)  
I think it may be useful to someone  
in the source code I commented out the functions  
it should be simple enough to figure out.  
  
hardware:  
Module Elegoo 4 Relays 5V  
NodeMCU ESP8266 wifi (chip 2102 drive)  
software:  
MQTT Broker online  
B4R - control relays 4  
B4J - client  
B4A - client  
  
B4A Android and B4J Desktop   
![](https://www.b4x.com/android/forum/attachments/142108) ![](https://www.b4x.com/android/forum/attachments/142109)  
  
Wires 2 Board  
![](https://www.b4x.com/android/forum/attachments/142110)  
IDE B4R:  
Board Type - NodeMCU 1.0 (ESP-12E Module)  
![](https://www.b4x.com/android/forum/attachments/142111)   
after you send the code in the ESP8266 with B4R, restart it  
and wait for it to connect to wifi and then to the online broker  
on the log you will see that everything is ok.  
![](https://www.b4x.com/android/forum/attachments/142113)  
ESP8266 is now ready to receive commands from B4A or B4J.  
  
Remenber:  
1)B4R –> change the name of the MQTT Topic, and add (ISP and Password access point) your Router wifi.  
  
2)B4J/B4A –> change the name of the MQTT Topic.  
  
That's all!  
  
Caution:  
The elegoo module is isolated with photocouplers between the esp and the relays, so it is very safe.  
anyway if you don't have a good knowledge of electrical parts  
I advise you to be very careful!.  
  
P.S. I'm working on version 2 of the project where I have a real feedback of the state of the relays. Stay tuned!  
(Sorry!English is not my native language :D).