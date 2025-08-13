### ESP32: detailed OTA/Update via WebServer from SPIFFS file system by peacemaker
### 07/27/2023
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/149239/)

When i tried the initial code <https://www.b4x.com/android/forum/threads/esp32-simple-ota-update-via-webserver.130576/> - i have faced tons of troubles with OTA via file system, at least, with my ESP32 board example:  

- previously saved file on the partition can be of strange size - smaller than before rebooting
- partition could be non-empty, but without files (!)
- downloading file from a server can show … smaller size that must be - so, file is corrupted, but no trouble with WiFi Internet connection…
Actually, no idea why this way (with file system) is needed, if [it's possible without file system](https://www.b4x.com/android/forum/threads/esp32-ota-update-from-server-via-wifi-only.149206/). But OK, i just need to understand all.
This is more detailed code of ESP32 OTA update from a local file that pre-dowbloaded from a web-server (http- and https-links are both tested) and saved into the local flash memory file system (SPIFFS).

```B4X
AppStart  
Connecting to WiFi…  
Connected to wireless network.  
My ip: 10.1.30.45  
Preparing #1  
Initializing Filesystem…  
Files:                        'NO FILES !!!  
Total size: 1318001 B  
Used size: 856914 B  
Deleting all files…  
Total size: 1318001 B  
Used size: 856914 B           'BUT space is used (!)  
Files:  
Total size: 1318001 B  
Used size: 856914 B  
Formatting Filesystem. This may take some time  
Formatting successful…  
Files:                    'no files  
Total size: 1318001 B  
Used size: 0 B            'and space is free !  
Downloading from https://server.com/update.bin…    'https link, but the server does not have SSL-certificate, so …  
Saving as /update.bin…  
[HTTP] GET…  
Downloaded size = -1     '…so, download does not work  
Wrong URL or server trouble
```

  
  

```B4X
AppStart  
Connecting to WiFi…  
Connected to wireless network.  
My ip: 10.1.30.45  
  
Preparing #1  
Initializing Filesystem…  
Files:  
Total size: 1318001 B  
Used size: 0 B  
Files:  
Total size: 1318001 B  
Used size: 0 B  
Files:  
Total size: 1318001 B  
Used size: 0 B  
Downloading from http://server.com/update.bin…      'NORMAL working URL  
Saving as /update.bin…  
[HTTP] GET…  
Connected…  
File size to be downloaded: 1069600  
Writing File…  
Total Bytes downloaded: 1069600  
Downloaded size = 1069600  
Files:  
     update.bin Size: 1069600  
Total size: 1318001 B  
Used size: 1078547 B             'some space (more than file size) is used for FileSystem…  
Local file size = 1069600        'file is downloaded OK  
Try to start update  
Written : 1069600 successfully  
OTA done!  
Update sucessfully completed. Rebooting.  
  
  
ets Jun  8 2016 00:22:57  
  
rst:0xc (SW_CPU_RESET),boot:0x13 (SPI_FAST_FLASH_BOOT)  
configsip: 0, SPIWP:0xee  
clk_drv:0x00,q_drv:0x00,d_drv:0x00,cs0_drv:0x00,hd_drv:0x00,wp_drv:0x00  
mode:DIO, clock div:1  
load:0x3fff0030,len:1344  
load:0x40078000,len:13964  
load:0x40080400,len:3600  
entry 0x400805f0  
  
  
AppStart: orion_v.0.222  
  
Device_btMAC = 083AF2A78EAE  
Waiting for incoming BT connection from a client
```

  
  
  
  
IMPORTANT:  
1. only single .bin file is needed (not all partitions): "src.ino.bin", saved on a server as "update.bin".  
2. separate "otafs" module is used, to include into projects (inline-C code is tied to this module name)  
  
At last the code:  

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
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("AppStart")  
   
    Log("Connecting to WiFi…")     
    If wifi.Connect2("mywifi","password") Then  
        Log("Connected to wireless network.")  
        Log("My ip: ", wifi.LocalIp)  
        otafs.Start  
    Else  
        Log("Failed to connect…")  
    End If  
End Sub
```

  
  

```B4X
Private Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
    Private fs As ESP8266FileSystem  
    Private bc As ByteConverter  
    Private FullPath(200) As Byte  
    Private SaveAs(40) As Byte  
    Private returnedvalue As Long  
   
End Sub  
  
Sub Start  
    bc.ArrayCopy("http://server.com/update.bin",FullPath)  
    bc.ArrayCopy("/update.bin", SaveAs) '/ is important!  
    Prepare  
End Sub  
  
  
Private Sub Prepare  
    For i = 1 To 10  
        Log("Preparing #", i)  
        InitFS  
        ListFiles  
        Dim fn As String = bc.StringFromBytes(SaveAs)  
       
'        'remove prev file, if exists  
'        fs.Remove(fn)  
'        Log(fn, " deleted")  
'        ListFiles  
       
        'check space  
        Dim free_space As Long = fs.TotalSize - fs.UsedSize  
        If free_space < 1100000 Then    'clear the storage for new file  
            DeleteAllFiles  
        End If  
       
        're-check space  
        Dim files_qty As Int = ListFiles  
        Dim free_space As Long = fs.TotalSize - fs.UsedSize  
        If free_space < 1100000 And files_qty = 0 Then    'strange, but no space and no files  
            FormatFS  
        End If  
        ListFiles  
       
        DownloadBinFile  
        Dim size As Long = returnedvalue  
        Log("Downloaded size = ", returnedvalue)  
        If size = -1 Then  
            Log("Wrong URL or server trouble")  
            Continue  
        End If  
  
        ListFiles  
        Dim size2 As Long = FileSize(fn)  
        Log("Local file size = ", size2)  
        If size2 = size Then  
            UpdateFW  
            If returnedvalue = 1 Then  
                Log("UPDATED !")  
                Exit  
            End If  
        End If  
    Next  
End Sub  
  
Private Sub DownloadBinFile  
    RunNative("downloadfile", Null)  
End Sub  
  
Private Sub UpdateFW  
    RunNative("updateFromFS", Null)  
End Sub  
  
Private Sub InitFS  
    Log("Initializing Filesystem…")  
    If fs.Initialize = False Then  
        FormatFS  
    End If  
End Sub  
  
Sub FormatFS As Boolean  
    Log("Formatting Filesystem. This may take some time")  
    Dim res As Boolean = fs.Format  
    If(fs.Initialize()) = True Then  
        Log("Formatting sucessful…")  
    Else  
        Log("Error formatting Filesystem…")  
    End If  
    Return res  
End Sub  
  
Private Sub ListFiles As Int  
    Log("Files:")  
    Dim qty As Int  
    For Each f As File In fs.ListFiles("/")  
        Log("     ",f.Name," Size: ",f.Size)  
        qty = qty + 1  
    Next  
    Log("Total size: ", fs.TotalSize, " B")  
    Log("Used size: ", fs.UsedSize, " B")  
    Return qty  
End Sub  
  
Private Sub DeleteAllFiles  
    Log("Deleting all files…")  
    For Each f As File In fs.ListFiles("/")  
        Log("Deleting ", f.Name)  
        If fs.Remove(JoinStrings(Array As String("/", f.Name))) Then  
            Log("Deleted: ", f.Name)  
        End If  
    Next  
    Log("Total size: ", fs.TotalSize, " B")  
    Log("Used size: ", fs.UsedSize, " B")  
End Sub  
  
Private Sub FileSize (filename As String) As Long  
    For Each f As File In fs.ListFiles("/")  
    If filename = JoinStrings(Array As String("/", f.Name)) Then  
            Return f.Size  
        End If  
    Next  
    Return 0  
End Sub  
  
#if c  
#include <HTTPClient.h>  
#include "FS.h"  
#include "SPIFFS.h"  
#include <Update.h>  
int downloadfile(B4R::Object* o) {  
   
    HTTPClient http;  
  
    printf("Downloading from %s…\n",(char*)b4r_otafs::_fullpath->data);  
    printf("Saving as %s…\n",(char*)b4r_otafs::_saveas->data);  
   
    // configure server and url  
    http.begin((char*)b4r_otafs::_fullpath->data);  
  
    printf("[HTTP] GET…\n");  
    // start connection and send HTTP header  
    int httpCode = http.GET();  
    if(httpCode > 0) {  
        // HTTP header has been send and Server response header has been handled  
        // file found at server  
        if(httpCode == HTTP_CODE_OK) {  
            printf("Connected…\n");  
            // get lenght of document (is -1 when Server sends no Content-Length header)  
            int len = http.getSize();  
            printf("File size to be downloaded: %i\n", len);  
            // create buffer for read  
            uint8_t buff[1024] = { 0 };  
  
            // get tcp stream  
            WiFiClient * stream = http.getStreamPtr();  
           
            //File  
           
            File file = SPIFFS.open((char*)b4r_otafs::_saveas->data, "w");  
            if(!file){  
                Serial.println("- failed to open file for writing");  
                b4r_otafs::_returnedvalue = -1;  
                return -1;  
            }  
            printf("Writing File…\n");  
            //File  
            int total=0;  
            // read all data from server  
            while(http.connected() && (len > 0 || len == -1)) {  
                // get available data size  
                size_t size = stream->available();  
               
                if(size) {  
                    // read up to (buffer size) bytes  
                    int c = stream->readBytes(buff, ((size > sizeof(buff)) ? sizeof(buff) : size));  
                                       
                    //file.print((char *)buff);  
                    file.write((byte*) &buff, c);  
                    total=total+ c;      
                    //File  
  
                    if(len > 0) {  
                        len -= c;  
                    }  
                }  
                delay(1);  
            }  
            file.close();  
            printf("Total Bytes downloaded: %i\n", total);  
            b4r_otafs::_returnedvalue = total;  
            return total;  
        }  
    } else {  
        printf("[HTTP] GET… failed, error: %s\n", http.errorToString(httpCode).c_str());  
    }  
  
    http.end();  
    b4r_otafs::_returnedvalue = -1;  
    return -1;  
}  
  
// perform the actual update from a given stream  
int performUpdate(Stream &updateSource, size_t updateSize) {  
   if (Update.begin(updateSize)) {    
      size_t written = Update.writeStream(updateSource);  
      if (written == updateSize) {  
         Serial.println("Written : " + String(written) + " successfully");  
      }  
      else {  
         Serial.println("Written only : " + String(written) + "/" + String(updateSize) + ". Retry?");  
         b4r_otafs::_returnedvalue = -1;  
         return -1;  
      }  
      if (Update.end()) {  
         Serial.println("OTA done!");  
         if (Update.isFinished()) {  
            Serial.println("Update sucessfully completed. Rebooting.");  
             ESP.restart();  
             return 0;  
         }  
         else {  
            Serial.println("Update not finished? Something went wrong!");  
            b4r_otafs::_returnedvalue = -1;  
            return -1;  
         }  
      }  
      else {  
         Serial.println("Error Occurred. Error #: " + String(Update.getError()));  
         b4r_otafs::_returnedvalue = -1;  
         return -1;  
      }  
  
   }  
   else  
   {  
      Serial.println("Not enough space to begin OTA");  
      b4r_otafs::_returnedvalue = -1;  
      return -1;  
   }  
}  
  
// check given FS for valid update.bin and perform update if available  
int updateFromFS(B4R::Object* o) {  
   File updateBin = SPIFFS.open("/update.bin");  
   if (updateBin) {  
      if(updateBin.isDirectory()){  
         Serial.println("Error, update.bin is not a file");  
         updateBin.close();  
         b4r_otafs::_returnedvalue = -1;  
         return -1;  
      }  
  
      size_t updateSize = updateBin.size();  
  
      if (updateSize > 0) {  
         Serial.println("Try to start update");  
         performUpdate(updateBin, updateSize);  
      }  
      else {  
         Serial.println("Error, file is empty");  
         b4r_otafs::_returnedvalue = -1;  
         return -1;  
      }  
  
      updateBin.close();  
   
      // whe finished remove the binary from sd card to indicate end of the process  
      SPIFFS.remove("/update.bin");  
      b4r_otafs::_returnedvalue = 1;  
      return 1;  
   }  
   else {  
      Serial.println("Could not load update.bin from sd root");  
      b4r_otafs::_returnedvalue = -1;  
      return -1;  
   }  
}  
  
#End If
```