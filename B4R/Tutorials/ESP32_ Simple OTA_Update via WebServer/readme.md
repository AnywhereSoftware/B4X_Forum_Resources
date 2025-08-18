### ESP32: Simple OTA/Update via WebServer by KMatle
### 05/10/2021
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/130576/)

This example (adapted from the Arduino examples under Arduino->File->Examples)  
  
- downloads a file from a server (exactly: the update file)  
- store this file to the filesystem (SPIFFS)  
- starts an update with the downloaded file  
  
How to use:  
  
- Compile this app with "default" options from the Boardmanager  
- Create a 2nd app (= the update)  
- Go to options/bin and copy the \*.bin file to a folder on your server. Change the name to "update.bin" or similar (must be the same as in the code of course)  
- Start the app. It will download the \*.bin file and try to update the ESP with the file  
  
Notes:  
  
- can be used without a server if you transmit the file via AsyncStreams or similar.  
- https works, too  
  

```B4X
#Region Project Attributes  
    #AutoFlushLogs: True  
    #CheckArrayBounds: True  
    #StackBufferSize: 10000  
#End Region  
  
Sub Process_Globals  
    Public Serial1 As Serial  
    Private fs As ESP8266FileSystem  
    Private wifi As ESP8266WiFi  
    Private bc As ByteConverter  
    Private FullPath(200) As Byte  
    Private SaveAs(40) As Byte  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("AppStart")  
      
    For i=1 To 10  
        Log("Connecting to WiFi…")  
        Log(i)  
          
        If wifi.Connect2("SSID","PW") Then  
            Log("Connected to wireless network.")  
            Log("My ip: ", wifi.LocalIp)  
            InitFS  
            DownloadFile  
            ListFiles  
            Exit  
        Else  
            Log("Failed to connect…")  
        End If  
    Next  
      
End Sub  
  
Sub DownloadFile  
    bc.ArrayCopy("http://192.168.178.23/esp32ota/update.bin",FullPath)  
    bc.ArrayCopy("/update.bin",SaveAs) '/ is important!  
    RunNative("downloadfile", Null)  
    RunNative("updateFromFS", Null)  
      
End Sub  
  
Sub InitFS  
    Log("Initializing Filesystem…")  
      
    If(fs.Initialize())=False Then  
        Log("Formatting Filesystem. This may take some time")  
        fs.Format  
        If(fs.Initialize())=True Then  
            Log("Formatting succesful…")  
              
        Else  
            Log("Error formatting Filesystem…")  
        End If  
    End If  
      
    Log("Total size: ", NumberFormat(fs.TotalSize / 1024, 0, 0), " KB")  
    Log("Used size: ", NumberFormat(fs.UsedSize / 1024, 0, 0), " KB")  
    ListFiles  
End Sub  
  
Sub ListFiles  
    Log("Files:")  
    For Each f As File In fs.ListFiles("/")  
        Log("     ",f.Name," Size: ",f.Size)  
    Next  
End Sub  
  
  
  
#if c  
#include <HTTPClient.h>  
#include "FS.h"  
#include "SPIFFS.h"  
#include <Update.h>  
void downloadfile(B4R::Object* o) {  
      
    HTTPClient http;  
  
    printf("Downloading from %s…\n",(char*)b4r_main::_fullpath->data);  
    printf("Saving as %s…\n",(char*)b4r_main::_saveas->data);  
      
    // configure server and url  
    http.begin((char*)b4r_main::_fullpath->data);  
  
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
            printf("Filesize is %i\n", len);  
            // create buffer for read  
            uint8_t buff[1024] = { 0 };  
  
            // get tcp stream  
            WiFiClient * stream = http.getStreamPtr();  
              
            //File  
              
            File file = SPIFFS.open((char*)b4r_main::_saveas->data, "w");  
            if(!file){  
                Serial.println("- failed to open file for writing");  
                return;  
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
        }  
    } else {  
        printf("[HTTP] GET… failed, error: %s\n", http.errorToString(httpCode).c_str());  
    }  
  
    http.end();  
}  
  
// perform the actual update from a given stream  
void performUpdate(Stream &updateSource, size_t updateSize) {  
   if (Update.begin(updateSize)) {       
      size_t written = Update.writeStream(updateSource);  
      if (written == updateSize) {  
         Serial.println("Written : " + String(written) + " successfully");  
      }  
      else {  
         Serial.println("Written only : " + String(written) + "/" + String(updateSize) + ". Retry?");  
      }  
      if (Update.end()) {  
         Serial.println("OTA done!");  
         if (Update.isFinished()) {  
            Serial.println("Update successfully completed. Rebooting.");  
             ESP.restart();  
         }  
         else {  
            Serial.println("Update not finished? Something went wrong!");  
         }  
      }  
      else {  
         Serial.println("Error Occurred. Error #: " + String(Update.getError()));  
      }  
  
   }  
   else  
   {  
      Serial.println("Not enough space to begin OTA");  
   }  
}  
  
// check given FS for valid update.bin and perform update if available  
void updateFromFS(B4R::Object* o) {  
   File updateBin = SPIFFS.open("/update.bin");  
   if (updateBin) {  
      if(updateBin.isDirectory()){  
         Serial.println("Error, update.bin is not a file");  
         updateBin.close();  
         return;  
      }  
  
      size_t updateSize = updateBin.size();  
  
      if (updateSize > 0) {  
         Serial.println("Try to start update");  
         performUpdate(updateBin, updateSize);  
      }  
      else {  
         Serial.println("Error, file is empty");  
      }  
  
      updateBin.close();  
      
      // whe finished remove the binary from sd card to indicate end of the process  
      SPIFFS.remove("/update.bin");       
   }  
   else {  
      Serial.println("Could not load update.bin from sd root");  
   }  
}  
  
#End If
```