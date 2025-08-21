### ESP32 Camera Picture Capture and Video Streaming! (Updated with code!) by miker2069
### 10/05/2019
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/110131/)

Hello!  
  
Last December I made a [request](https://www.b4x.com/android/forum/threads/esp32-camera-module-support.100906/) for support for the ESP32 Camera support. Well, I finally found the time to work on it myself and here's my initial attempt at implementing this with B4R. I'm using an ESP32CAM camera board with 4GB of PSRAM (like extended memory for the camera). I'm using one similar to this [one](https://www.amazon.com/AiTrip-ESP32-CAM-Bluetooth-Dual-core-Development/dp/B07WCFGMTF/ref=sr_1_3?keywords=esp32cam+psram&qid=1570044625&sr=8-3) you can find on Amazon. The board has an OV2640 2MP camera and an SD card slot (it's worth mentioning this model does not have a USB interface so you'll need an FTDI programmer).  
  
I started with knowing nothing about image capture or video streaming to a working prototype, after about a week, I'm happy to say it works :).  
  
The B4R app allows for picture capture using a /pic URL and stream video using /live over HTTP.  
  
You can see a small demo of the screen capture and video on [MEDIA=youtube]UO5bN3zgr3M[/MEDIA]. The video shows my attempt to capture my daughter's toy duck picture (had a problem lining up the camera) using the /pic URL. Then I show video streaming from the camera in browser and inVLC using the /live URL. You can see the debug info as connections come in my B4R log window on the right of the screen.  
  
The picture below is my ESP32 Camera board, my FTDI programmer on the left and my wiring.  
  
![](https://www.b4x.com/android/forum/attachments/84370)  
  
Basically I'm using inline C to access the camera driver (which is now part of the Arduino library), and B4R WiFiServerSocket for the web server. It actually works quite well **for a $10 camera and microcontroller**. I plan on doing a full blown tutorial here on how it works and posting the source code (in the next day or so - I want to do a proper tutorial because I learned a **lot** during this fun project.  
  
I want to contribute back to the community since I get so much from here. I hope you enjoy! :)  
  
**See the below lengthy tutorial and code :)**