### [ESP32] OTA update from server via WiFi only by peacemaker
### 07/25/2023
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/149206/)

1. For OTA update of ESP32 firmware - only single .bin file is needed (not all partitions): "src.ino.bin"  
2. If to save it into a web-server as, say, "update.bin", we can make the update:  

```B4X
#Region Project Attributes  
    #AutoFlushLogs: True  
    #CheckArrayBounds: True  
    #StackBufferSize: 10000  
#End Region  
  
   'Ctrl + click to merge binaries into merged-flash.bin: ide://run?file=%USERPROFILE%\AppData\Local\Arduino15\packages\esp32\tools\esptool_py\4.5.1\esptool.exe&args=–chip&args=ESP32&args=merge_bin&args=-o&args=..\Objects\bin\merged-flash.bin&args=–flash_mode&args=dio&args=–flash_size&args=4MB&args=0x1000&args=..\Objects\bin\src.ino.bootloader.bin&args=0x8000&args=..\Objects\bin\src.ino.partitions.bin&args=0x10000&args=..\Objects\bin\src.ino.bin  
   'Ctrl + click to flash into ESP32 board: ide://run?file=%USERPROFILE%\AppData\Local\Arduino15\packages\esp32\tools\esptool_py\4.5.1\esptool.exe&args=–chip&args=ESP32&args=–baud&args=921600&args=write_flash&args=0x0&args=..\Objects\bin\merged-flash.bin  
  
Sub Process_Globals  
    Public Serial1 As Serial  
    Private wifi As ESP8266WiFi  
    Private bc As ByteConverter  
    Private FullPath(200) As Byte  
    Private timFlashing As Timer  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("AppStart")  
    timFlashing.Initialize("timFlashing_Tick", 10000)  
    
    Log("Connecting to WiFi…")  
    
    If wifi.Connect2("wifissid","password") Then  
        Log("Connected to wireless network.")  
        Log("My ip: ", wifi.LocalIp)  
        bc.ArrayCopy("http://myserver.com/update.bin",FullPath)  
        timFlashing.Enabled = True  
    Else  
        Log("Failed to connect…")  
    End If  
  
End Sub  
  
Sub timFlashing_Tick  
    timFlashing.Enabled = False  
    RunNative("updateFIRMWARE", Null)    'timer due to the bin file can be broken after downloading  
    timFlashing.Enabled = True    'if not updated and not rebooted - next try  
End Sub  
  
  
#if C  
#include <Update.h>  
#include "HTTPClient.h"  
  
HTTPClient http;  
  
int updateFIRMWARE(B4R::Object* o)  
{  
  http.begin((char*)b4r_main::_fullpath->data);  
  int httpCode = http.GET();  
    
  if (httpCode <= 0) {  
    //Error HTTP failed  
    printf("[HTTP] GET… failed, error: %s\n", http.errorToString(httpCode).c_str());  
    http.end();  
    return 0;  
  }  
   
  int contentLen = http.getSize();  
  bool canBegin = Update.begin(contentLen);  
  if (!canBegin) {  
    // Error, not enough space for the new binary.  
    printf("Error, not enough space for the new binary: %i\n", contentLen);  
    return 0;  
  }  
   
  int len = http.getSize();  
  printf("Downloading: file should be %i\n", len);  
   
  WiFiClient* client = http.getStreamPtr();  
   
  size_t written = Update.writeStream(*client);  
  if (written != contentLen) {  
    // Error, wrote partial binary.  
    printf("Download is corrupted: %i\n", written);  
    http.end();  
    return 0;  
  }  
  if (!Update.end()) {  
    // Error from Update.end()  
    printf("Error from Update.end");  
    http.end();  
    return 0;  
  }  
  if (Update.isFinished()) {  
   // Update successfully completed. Reboot to apply update.  
   printf("Update successfully completed !");  
   delay(1000);  
    http.end();  
    ESP.restart();  
   return 1;  
  } else {  
    // Error from Update.isFinished()  
    printf("Error from Update.isFinished");  
     http.end();  
    return 0;  
  }  
}  
#End If
```

  
  
> AppStart  
> Connecting to WiFi…  
> Connected to wireless network.  
> My ip: 10.1.30.45  
> Downloading: file should be 1069600  
>   
> ets Jun 8 2016 00:22:57  
> rst:0xc (SW\_CPU\_RESET),boot:0x13 (SPI\_FAST\_FLASH\_BOOT)  
> configsip: 0, SPIWP:0xee  
> clk\_drv:0x00,q\_drv:0x00,d\_drv:0x00,cs0\_drv:0x00,hd\_drv:0x00,wp\_drv:0x00  
> mode:DIO, clock div:1  
> load:0x3fff0030,len:1344  
> load:0x40078000,len:13964  
> load:0x40080400,len:3600  
> entry 0x400805f0  
>   
> AppStart: orion\_v.0.222  
> Device\_btMAC = 083AF2A78EAE  
> Waiting for incoming BT connection from a client