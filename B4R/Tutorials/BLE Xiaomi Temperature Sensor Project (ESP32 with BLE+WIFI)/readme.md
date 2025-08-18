### BLE Xiaomi Temperature Sensor Project (ESP32 with BLE+WIFI) by tchart
### 04/23/2021
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/130032/)

![](https://www.b4x.com/android/forum/attachments/112144)  
  
My office gets cold overnight in winter. I have a heater which has a basic thermostat but its very inaccurate (its just a min/max dial not temperature based). If I leave it on overnight the office is too hot, if I leave it off the office is too cold.  
  
I do have a Xiaomi BLE Temperature Sensor (like [this](https://www.aliexpress.com/item/32919475946.html?spm=0.search0306.0.0.60c1412d8ptwF3&algo_pvid=6991f432-2c99-4095-8e05-65c9e60657fb&algo_expid=6991f432-2c99-4095-8e05-65c9e60657fb-8&btsid=0b0a555916191269090216170ecaa1&ws_ab_test=searchweb0_0,searchweb201602_,searchweb201603_)) in the office but its not wifi connected so it doesnt have any automation possibilities without a Xiaomi Hub.  
  
I did however come across this project - <https://www.instructables.com/ESP32-Xiaomi-Hack-Get-Data-Wirelessly/> which is the same sensor I have.  
  
I have put together a B4R project using an ESP32 that has WiFi and BLE (<https://developers.wia.io/release/things/esp32-minikit>) and automates my heater using IFTTT and a smart plug.  
  
The B4R project scans for BLE devices and then gets the temperature reading every 15 seconds from the Xiaomi sensor. Once a minute it will check the temperature and depending on the temperature reading toggle my smart plug via IFTTT maker webhook (a URL call). The heater is plugged into the smart plug.  
  
The BLE library mentioned in the instructables project is too large for the ESP32 if you use BLE + WiFi. So I have swapped this for the NimBLE library (just search for NimBLE in Arduino library manager) which is small enough to be used with the B4R WiFi library.  
  
Also [USER=1]@Erel[/USER] I had to change the HttpJob to use http instead of https as it fails to connect when I use https. This was a bit strange as a previous B4R project I wrote used IFTTT with https without issues (but it was sveral months ago). I'm not sure if its an issue with rHttpUtils2 (1.0), IFTTT or the ESP32.