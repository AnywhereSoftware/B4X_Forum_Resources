### rLittleFS for B4R by candide
### 07/18/2024
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/130630/)

this is littleFS library for esp8266 and esp32 on B4R  
  
it is rESP8266FileSystem modified to work with littleFS  
this library is faster and more reliable then spiffs.  
  
we have all functions of rESP8266FileSystem with a few more :  
 bool OpenAppend (B4RString\* FileName);  
 bool Rename(B4RString\* FileName1,B4RString\* FileName2);  
=> functions added to manage Directories :  
 bool getIsDirectory();  
 bool getIsFile();  
 bool MKDir (B4RString\* DIRName);   
 bool RMDir (B4RString\* DIRName);  
  
  
We can move from rESP8266FileSystem to rLittleFS with a few modifications of code.  
  
the major change is directory management: with rLittleFS we have access to files directory by directory and each time we have to check if it is a file or a new sub-directory  
  
- to use littleFS on esp32, you have to install LITTLEFS in arduino, and a good way is to install development release from espressif :<https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_dev_index.json>  
- more information here: <https://espressif.github.io/arduino-esp32/docs/arduino-ide/boards_manager.html>  
  
both projects FTPserver on esp8266 and esp32 are built with this library to manage files and directories in esp.  
(available in shared creations)  
  
- added an example of project to demonstrate functions of the library  
  
21/01/27 a few modifications for esp32 v2.0 compatibility  
  
last delivery 1.12 ed2 : Zip format ready to unzip it in Additional Library Directory and correct version seen in B4R