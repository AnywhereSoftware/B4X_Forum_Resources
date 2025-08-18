### ESP32 NOW Example (inline C) by KMatle
### 03/10/2021
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/128479/)

The code was taken from this site: <https://randomnerdtutorials.com/esp-now-esp32-arduino-ide/>  
  
You need 2 ESP32's (one is the sender, the other one the receiver). Modify the code to have multiple receivers/senders and to get/set the variables from B4R  
  
Output is something like this:  
  

```B4X
AppStart  
7C:9E:BD:E4:15:50  
Sent with success  
Last Packet Send Status:    Delivery Success
```

  
  
  
Sender:  
  
**Note: Replace the MAC address to the one of the receiver**  
  

```B4X
#Region Project Attributes  
    #AutoFlushLogs: True  
    #CheckArrayBounds: True  
    #StackBufferSize: 600  
    #DefineExtra: #include "rCore.h"  
#End Region  
'Ctrl+Click to open the C code folder: ide://run?File=%WINDIR%\System32\explorer.exe&Args=%PROJECT%\Objects\Src  
  
Sub Process_Globals  
    Public Serial1 As Serial  
      
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("AppStart")  
    RunNative("StartESPNow", Null)  
End Sub  
  
#if C  
  
  
#include <esp_now.h>  
#include <WiFi.h>  
  
esp_now_peer_info_t peerInfo;  
  
// REPLACE WITH YOUR RECEIVER MAC Address  
uint8_t broadcastAddress[] = {0x24, 0x62, 0xAB, 0xFF, 0xCB, 0x30};  
//24:62:AB:FF:CB:30  
// Structure example to send data  
// Must match the receiver structure  
typedef struct struct_message {  
  char a[32];  
  int b;  
  float c;  
  String d;  
  bool e;  
} struct_message;  
  
// Create a struct_message called myData  
struct_message myData;  
  
// callback when data is sent  
  void OnDataSent(const uint8_t *mac_addr, esp_now_send_status_t status) {  
  Serial.print("\r\nLast Packet Send Status:\t");  
  Serial.println(status == ESP_NOW_SEND_SUCCESS ? "Delivery Success" : "Delivery Fail");  
}  
  
  
  
void StartESPNow(B4R::Object* o) {  
   WiFi.mode(WIFI_STA);  
   Serial.println(WiFi.macAddress());  
    
  // Init ESP-NOW  
  if (esp_now_init() != ESP_OK) {  
    Serial.println("Error initializing ESP-NOW");  
    return;  
  }  
   
    // Once ESPNow is successfully Init, we will register for Send CB to  
  // get the status of Trasnmitted packet  
  esp_now_register_send_cb(OnDataSent);  
   
  // Register peer  
  //esp_now_peer_info_t peerInfo;  
  memcpy(peerInfo.peer_addr, broadcastAddress, 6);  
  peerInfo.channel = 0;   
  peerInfo.encrypt = false;  
   
  // Add peer         
  if (esp_now_add_peer(&peerInfo) != ESP_OK){  
    Serial.println("Failed to add peer");  
    return;  
  }  
   
   
  strcpy(myData.a, "THIS IS A CHAR");  
  myData.b = random(1,20);  
  myData.c = 1.2;  
  myData.d = "Hello";  
  myData.e = false;  
  
  // Send message via ESP-NOW  
  esp_err_t result = esp_now_send(broadcastAddress, (uint8_t *) &myData, sizeof(myData));  
    
  if (result == ESP_OK) {  
    Serial.println("Sent with success");  
  }  
  else {  
    Serial.println("Error sending the data");  
  }  
  
    
}  
  
#End If
```

  
  
  
Receiver:  
  
Output:  
  

```B4X
AppStart  
24:62:AB:FF:CB:30  
Bytes received: 56  
Char: THIS IS A CHAR  
Int: 14  
Float: 1.20  
String: Hello  
Bool: 0
```

  
  

```B4X
#Region Project Attributes  
    #AutoFlushLogs: True  
    #CheckArrayBounds: True  
    #StackBufferSize: 600  
    #DefineExtra: #include "rCore.h"  
#End Region  
'Ctrl+Click to open the C code folder: ide://run?File=%WINDIR%\System32\explorer.exe&Args=%PROJECT%\Objects\Src  
  
Sub Process_Globals  
    Public Serial1 As Serial  
      
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("AppStart")  
    RunNative("StartESPReceiver", Null)  
End Sub  
  
#if C  
  
  
#include <esp_now.h>  
#include <WiFi.h>  
  
esp_now_peer_info_t peerInfo;  
  
// REPLACE WITH YOUR RECEIVER MAC Address  
uint8_t broadcastAddress[] = {0x7C, 0x9E, 0xBD, 0xE4, 0x15, 0x50};  
  
// Structure example to receive data  
// Must match the sender structure  
typedef struct struct_message {  
    char a[32];  
    int b;  
    float c;  
    String d;  
    bool e;  
} struct_message;  
  
// Create a struct_message called myData  
struct_message myData;  
  
// callback function that will be executed when data is received  
void OnDataRecv(const uint8_t * mac, const uint8_t *incomingData, int len) {  
  memcpy(&myData, incomingData, sizeof(myData));  
  Serial.print("Bytes received: ");  
  Serial.println(len);  
  Serial.print("Char: ");  
  Serial.println(myData.a);  
  Serial.print("Int: ");  
  Serial.println(myData.b);  
  Serial.print("Float: ");  
  Serial.println(myData.c);  
  Serial.print("String: ");  
  Serial.println(myData.d);  
  Serial.print("Bool: ");  
  Serial.println(myData.e);  
  Serial.println();  
}  
  
  
  
void StartESPReceiver(B4R::Object* o) {  
   WiFi.mode(WIFI_STA);  
   Serial.println(WiFi.macAddress());  
    
  // Init ESP-NOW  
  if (esp_now_init() != ESP_OK) {  
    Serial.println("Error initializing ESP-NOW");  
    return;  
  }  
   
  
   
  // Once ESPNow is successfully Init, we will register for recv CB to  
  // get recv packer info  
  esp_now_register_recv_cb(OnDataRecv);  
  
    
}  
  
#End If
```