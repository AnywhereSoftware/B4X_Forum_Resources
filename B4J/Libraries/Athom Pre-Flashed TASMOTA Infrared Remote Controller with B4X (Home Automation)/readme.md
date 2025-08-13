### Athom Pre-Flashed TASMOTA Infrared Remote Controller with B4X (Home Automation) by walt61
### 01/14/2024
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/158628/)

I got my mitts on this IR remote controller gadget: <https://www.aliexpress.com/item/1005005772315510.html> What's unusual about this one, is that it comes pre-flashed with Tasmota, which makes it extremely simple to control it with your software, without having to tinker with the hardware.  
  
**Initial setup**  
- Connect your PC via WiFi to the Athom's SSID ('tasmota\_xxxx')  
- Start your browser and navigate to any URL; it will be redirected to the Tasmota menu  
- If you use a MAC address whitelist on your router, click the 'Information' button and copy it from there  
- Click 'Configure WiFi' and enter your own SSID and password (**Note:** the SSID value may be case-sensitive; I've experienced that with another device)  
- Save the configuration and restart the Athom  
  
**Flash the proper firmware**  
- Connect your PC to your own SSID  
- From <https://ota.tasmota.com/tasmota/release/>, download file **tasmota-ir.bin**  
- Navigate to the Athom's IP address (You can find that e.g. in your router's active connections report)  
- Flash the firmware with the downloaded file  
  
**Learning your codes**  
- In the Athom's menu, click 'Console' and enter this command, which enables the device to learn custom codes: **SetOption58 1** (notice the space between '58' and '1')  
- Stay in the Console, point your remote control to the Athom and click the key you want to capture; you'll see a line appear in the Console's output pane  
- Rinse and repeat until you have captured all the keys you need (remember the order you used, as the data in the Console don't contain readable info that would allow you to recognise the corresponding key)  
- Copy the data from the console and use it - see the attached project - by formatting it properly and then just using the resulting URL  
  
Enjoy!  
  
**Tasmota menu images:**  
  
  
![](https://www.b4x.com/android/forum/attachments/149676) ![](https://www.b4x.com/android/forum/attachments/149677) ![](https://www.b4x.com/android/forum/attachments/149678)  
  
**Tasmota Console image:**  
  
![](https://www.b4x.com/android/forum/attachments/149679)  
  
**The attached example:**  
  
![](https://www.b4x.com/android/forum/attachments/149680)