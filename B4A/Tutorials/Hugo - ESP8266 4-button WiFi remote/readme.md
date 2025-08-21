### Hugo - ESP8266 4-button WiFi remote by walt61
### 12/24/2019
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/112465/)

Not exactly a tutorial or Android-only, but a hint to the community for those who like playing with home automation stuff, and possibly for others as well. I happened across this very nice device (IMHO): <https://www.tindie.com/products/nicethings/hugo-esp8266-4-button-wifi-remote/> and couldn't resist :) (Plenty of Bluetooth stuff out there, but this was a one of a kind as far as I've discovered.)  
  
The Hugo runs on a rechargeable battery (micro USB connection), communicates via WiFi, and 3 firmware versions are available, as stated on the aforementioned page:  
> You can control anything over wifi that can receive **HTTP (webhooks)** or **MQTT** requests, from smart bulbs, over raspberry pi to a remote website. It can directly control home automation platforms like **Home Assistant (with auto-discovery), Blynk, Domoticz and others** that support HTTP requests or MQTT. It is a perfect alternative to Dash buttons or zigbee remotes.

  
It features 4 buttons as well as three 2-button combinations, which means 7 distinct (fully configurable, with MQTT that means both topic and payload can be setup for each) signals can be sent. When a button is pressed, the device wakes up, sends the data, and goes back to deep sleep; all this happens instantaneously, there's no wait time. According to its creator, the Hugo can go on for a year on a single fully charged battery. There's a separately configurable battery level MQTT topic as well, which has the remaining charge as payload.  
  
You'll find more on the Hugo webpage; the price isn't exactly a showstopper either: $19 plus shipping.  
  
By the way: I'm not at all affiliated, just very enthusiastic :)  
  
Enjoy !