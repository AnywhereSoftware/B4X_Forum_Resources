### rArduinoNvs NVS library for esp32 by candide
### 07/30/2023
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/149307/)

it is a wrapper for NVS library from : <https://github.com/rpolitex/ArduinoNvs>  
  
NVS is a port for a non-volatile storage (NVS, flash) [library](https://docs.espressif.com/projects/esp-idf/en/latest/api-reference/storage/nvs_flash.html) for ESP32 to the Arduino Platform and B4R now.  
  
The ESP32 NVS stored data in the form of key-value. Keys are ASCII strings, up to 15 characters. Values can have one of the following types:  

- integer types in B4R: byte, uint, int, ulong, long, ArrayByte, String
- read of String can be made by return or in a buffer
- variable length binary data (blob) are used for ArrayByte only and read is done in a buffer
- and with B4RSerializator you can create ArrayByte with multiple variable, to save it with NVS, and to recover it when needed

thanks [USER=1637]peacemaker[/USER] for his highlight of this library