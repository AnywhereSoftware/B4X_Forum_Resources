### ThingSpeak Data Viewer Tutorial (updated) by Didier9
### 06/16/2024
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/161682/)

I made a few useful (in my biased opinion :) updates to the very interesting project by Mark Read: [ThingSpeak Data Viewer](https://www.b4x.com/android/forum/threads/read-and-graph-thingspeak-data.138406/)  
Thank you Mark and thank you Klaus for xChart  
  
![](https://www.b4x.com/android/forum/attachments/154666)  
  
The features listed in the original post are all still there.  
  
The tool now accommodates any scan rate for the data and more precisely displays one day, one week or one month worth of data, with useful placement of time ticks.  
The tool also lets you add and delete channels from the drop down list and the channel numbers are accompanied by the channel description for easier reference.  
  
![](https://www.b4x.com/android/forum/attachments/154664)  
  
There are further comments in the source code.  
  
I have also attached the Arduino code for the D1 mini that I use to send data. The device helps me track the operating conditions of my salt water chlorine generator. Note that I am still working on this project (need to add pool temperature and cell voltage).  
  
The D1 mini is one of the easiest Arduino module (small and cheap) to use if you want to upload data to ThingSpeak, the downside is that it has only one ADC input.  
The ESP32-WROOM is the next easiest (a bit larger and more expensive but still cheap). It has more IOs with multiple ADC inputs and an ESP32 CPU with Bluetooth LE.  
Both are trivial to program, requiring only a USB cable without the need for an adapter board, to press buttons or move switches.