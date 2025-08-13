### Provisioning: Start Access point, display it's Wifi credentials as a Wifi-QRCode (can be scanned by any phone) by KMatle
### 02/26/2024
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/159507/)

As the title says, a standard WiFi-QRCode ist displayed on a tft screen. This can be scanned by any modern phone to automatically and it connects to the ESP, so you don't need to type any credentials. Like when you share your WiFi credentials from your phone to another. You could display your guest WiFi, too and put the ESP with it's display somewhere (e.g. wall) for guests to scann or just provision other data to the ESP.  
  
1. You need the code of the tft example: [tft\_espi example](https://www.b4x.com/android/forum/threads/tft-displays-tft_espi-inline-c-example.159169/) . You can use any display. Change the pins, etc. for it.  
2. Additionally download this QRLib: <https://github.com/ricmoo/QRCode>  
3. The lib has a bug so we need to do small changes (renames)   
4. in you additional libs folder create a folder named "qrcode" (all lowercase)  
5. copy the source folder "src" into the the "qrcode" folder. You don't need the other folders  
6. rename the header file to "qrcode2.h"  
7. rename all occurences inside the "qrcode.c" file to "qrcode2.h"  
  
What the app does:  
  
1. Create an AccessPoint (AP-Name is ESP plus some random chars, pw is generated, too)  
2. These credentials are packed into a "WiFi-formatted" string to be recognized as a connection string. Looks like  
  

```B4X
WIFI:T:WPA;S:ESP32ntmmhxar;P:rnbattkh;;
```

  
  
Browse the www for details   
  
3. This string ist displayed as a QRCode  
4. Take your phone an scan it (just with your camera, no other app ist needed)  
5. A new window should open where you can accept the connection  
6. You will see the WiFi connection after 1-2 seconds  
  
Next steps (not included):  
  
- send some data to the ESP e.g. with your router's wifi credentials (so the ESP can connect to your WiFi)  
- I like to use UDP as it doen't need any connect logic  
- good here: The connection is private and encrypted (WPA) so you can safely provision your credentials