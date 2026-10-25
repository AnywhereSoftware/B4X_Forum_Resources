### Wireless Thermometer: Low-cost Components, No Wiring, TFT Display by William Lancee
### 10/23/2026
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/172349/)

I tested this with B4R V4.20 Beta - works like a charm.  
  
On Amazon…  
1. Govee Digital Wireless Bluetooth Thermometer/Hygrometer H5074-001CA, 262ft Connecting Range CA$19.99  
2. ideaspark® ESP32 Development Board 16MB Integrated 1.9 inch ST7789 170x320 TFT LCD Display, WiFi+BL Wireless Module, CH340 Driver, USB Type-C CA$21.99  
  
  
![](https://www.b4x.com/android/forum/attachments/174414)  
  
This project is similar to [USER=12970]@tchart[/USER] <https://www.b4x.com/android/forum/threads/ble-xiaomi-temperature-sensor-project-esp32-with-ble-wifi.130032/>  
  
The Govee sensor requires a very different interface. AI was very helpful in debugging the idiosyncrasies of the ESP32 TFT driver and the newest version of NimBLE library.  
  
The project is the first step in helping a friend who heats his house in the winter with a wood stove. He would like to automate the damper mechanism to keep the heat steady.  
P.S. I am using the Bread-Board as a stand to hold the ESP32 (behind and attached to the display with this all-in-one "ideaspark" module).  
  
It has been a cool night here and my office/workshop is cold.. I turned the heater on and now it is 23 degrees celcius.