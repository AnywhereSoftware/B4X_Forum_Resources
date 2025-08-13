### AES256 encrypted BLE (ESP32 & B4A) example by KMatle
### 02/02/2023
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/145872/)

I took [Erel's BLE example](https://www.b4x.com/android/forum/threads/b4x-ble-2-bluetooth-low-energy.59937/#content) and added (as on the ESP32 side) AES256 encryption. For some reasons I wasn't able to use SPIFFS and/or WiFi parallel to BLE on the ESP32 side. Maybe you find a reason why this doesn't word (I understand WiFi & BLE using the same antenna, but SPIFFS should work but gives a hard crash when writing a file). First idea was to use it for provisioning (ESP gets the WiFi credentials, save it to SPIFFS and restarts with WiFi).  
  
You can connect/reconnect. I did not implement code to connect to multiple ESP's and send data to it, but it is quite easy to change the code. If you B4A app doesn't connect anymore check (BT menue) if the ESP has been "paired" by accident (then you can't connect anymore- remove the ESP by hand). I've added a disconnat in B4A before connecting which seems to work, too.  
  
**B4R: No libs needed (inline C)**  
  
At the start a random BLE name is generated starting with "ESP" (so the B4A app can recognize the ESP). This name is used as the AES256 password to encrypt the data so every ESP (or at every start) a new random name is generated. This gives better security than using the same start password all the time.  
  
The BLECharacteristic is set to PROPERTY\_WRITE only (as we don't want others to read the data even if it's encrypted). So the B4A can write to it but can't read the value which is good.  
  
From the inline C code a B4R sub "NewBLEMessage" is called where the message is decrypted, depadded and de-serialized (I use the B4x-serializator here).  
  
**Workflow (beneath starting a BLE server on the ESP, starting a scan on the B4A side and define some callbacks when data arrives, etc.)**  
  
1. B4A app scans for device names starting with "ESP" and connects to it  
2. An array for the serializator is created (her with 3 items) and serialized  
3. AES needs a data length as a multiple of 16, so I use a sub to pad the data to the next blocksize of a multiple of 16. A message of 12 bytes will be padded to 16, 24 to 32. Last byte is the number of bytes padded(added). The padded value can be anything. A random byte is perfect (never use repeating values for security). For test reasons I use 0 as the padding value but the sub even supports random bytes.  
4. The password (the devices random name) is hashed to 32 bytes (AES256 uses 256 bits which is 32 bytes). Usually you should use the full 32 bytes with total random values if possible.  
5. The Initializationvector (IV) is set to 16 random bytes (this info is public and scrambles the data to prevent repeating structures in the data)  
6. The data is then ancrypted with AES256  
6. A "Salt" of 32 bytes is generated. This is public to and added at the beginning of the final message. Another standard to add more security (only you know how long the salt is, could be 32000 bytes long but creates overhead)  
7. A Sender ID is added at the beginning of the date (cleartext)  
  
Final data: SenderID+Salt+IV+EncryptedMessage   
  
The data is sent "to" the characteristic defined on the B4R side (see the code there).  
  
On the B4R side  
  
1. SenderID, Salt, IV and the encrypted message are extracted  
2. The message is decrypted (with the BLE name), de-padded (from block of 16 to the real size) and then de-serialized to an array (of objects).  
  
**B4A libs:**  
  
![](https://www.b4x.com/android/forum/attachments/138836)  
  
If you don't want to use B4x pages, just copy the code to your project.  
  
Encryption library: <https://www.b4x.com/android/forum/threads/base64-and-encryption-library.6839/>