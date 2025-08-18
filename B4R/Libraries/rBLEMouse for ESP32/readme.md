### rBLEMouse for ESP32 by kolbe
### 01/03/2021
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/126146/)

Here's a wrapper for [this Arduino library](https://github.com/T-vK/ESP32-BLE-Mouse) by T-vK. This library allows you to make the ESP32 act as a Bluetooth Mouse! For more info follow the link.  
  
Very similar to the rBLEKeyboard, this library allows the ESP32 to be a BT mouse. If you include both libraries it won't compile. One ESP32 can't be both a keyboard and mouse device.  
  
Use is pretty straight forward. Initialize the object, then call click, press/release for the mouse buttons or move to move the mouse and the vertical and horizontal wheels on the mouse.  
  
Once the ESP32 has started you should see the BT device waiting to be paired. Careful once you are connected as Windows (your OS) will receive all that is being sent and may become hard to control.  
  
This wrapper depends on 6 different .h and .cpp files make sure they all make it to your added libraries folder.  
  
Enjoy