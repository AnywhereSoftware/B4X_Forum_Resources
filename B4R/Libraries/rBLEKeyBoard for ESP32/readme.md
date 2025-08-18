### rBLEKeyBoard for ESP32 by kolbe
### 01/03/2021
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/126129/)

Here's a wrapper for [this Arduino library](https://github.com/T-vK/ESP32-BLE-Keyboard) by T-vK. This library allows you to make the ESP32 act as a Bluetooth Keyboard! For more info follow the link.  
  
If you have ever wanted to make your own wireless video editing, audio editing, livestreaming or game keyboard here's your chance.  
  
Use is pretty straight forward. Initialize the object, then call write or press/release to send keys. Use the constants to send non printable and media keys. You can even send battery levels.  
  
Once the ESP32 has started you should see the BT device waiting to be paired. Careful once you are connected as Windows (your OS) will receive all that is being sent and may become hard to control.  
  
This wrapper depends on 8 different .h and .cpp files make sure they all make it to your added libraries folder.  
  
Enjoy