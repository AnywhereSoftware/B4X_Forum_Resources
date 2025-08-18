### ESP32 Now with encryption, master and automatically added slaves by KMatle
### 03/17/2021
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/128731/)

Here's an advanced ESP32 Now example. The Inlince C code is from several sources (see the inline remarks).  
  
Note: Sometimes there are issues with the Wifi channel (WiFi and ESP Now must use the same channel). There are a lot of discussions in other forums. My examples work fine. If you run into issues when messages are sent but not received, try other channels (channel 0 should be fine as it uses the actual channel).  
  
How to use:  
  
Install ESP32 Now via the board manager  
  
Slave App:  
  
- change the MAC address to the one of the master (I wasn't able to use B4R Wifi and Inline C Wifi parallel here to scan for a master device. Maybe I add it later)  
- to get the masters MAC address just start the "master app"  
- install the slave app to several ESP32's (note: there are limitations of 6 or 10 devices when using encryption). The ESP's will be added by the master automatically  
  
Libs:  
![](https://www.b4x.com/android/forum/attachments/109872)  
  
Master App:  
  
- change the SSID & pw to the credentials of your router  
- Wifi is used to communicate with other devices/apps/the internet (not needed for ESP NOW)  
- compile and upload the app to ONE ESP32 (there is only ONE master)  
- get the MAC address and put it to all slave apps  
  
- restart the master ESP (as it only scans for slaves at the start - change the code if you want to scan every x secs/mins)  
- the master ESP will scan for other ESP's SSIDs starting with ESP32SL: plus the MAC address  
- these ESP's will be added as a noce automatically  
  
All of the added "slaves" will send messages to the master every x seconds. Take a look at the logs if the messages were sent AND received.  
  
Libs:  
![](https://www.b4x.com/android/forum/attachments/109873)  
  
B4J App:  
  
- This small all connects to the master and receives all messages (just a quick demo).   
- change the ip address to the master's ip  
  
Libs:  
![](https://www.b4x.com/android/forum/attachments/109871)