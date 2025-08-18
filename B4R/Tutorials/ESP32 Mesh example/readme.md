### ESP32 Mesh example by KMatle
### 03/15/2021
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/128645/)

Taken from here: <https://randomnerdtutorials.com/esp-mesh-esp32-esp8266-painlessmesh/>  
  
The example uses the "painlessmesh" library. Just add it via arduino's library manager. Other libs will be added, to (like JSON, etc.).  
  
To download the needed "asynctcp" lib go to <https://github.com/me-no-dev/AsyncTCP>, download the zipped version and add it via boardmanager, too.  
  
Use 2 or more ESP32's (Change the message to see which board has sent the message) and take a look at the logs. Inside the inline C code ALL logs are switched to on (mesh.setDebugMsgTypes ….).  
  
Check the docs of the painlessmesh lib to see how to send single messages to a single node, etc. The code runs on ESP8266's, too but uses different libs (see the first link).  
  
  
![](https://www.b4x.com/android/forum/attachments/109683)  
  
  
Code:  
  

```B4X
#Region Project Attributes  
    #AutoFlushLogs: True  
    #CheckArrayBounds: True  
    #StackBufferSize: 600  
#End Region  
'Ctrl+Click to open the C code folder: ide://run?File=%WINDIR%\System32\explorer.exe&Args=%PROJECT%\Objects\Src  
  
Sub Process_Globals  
    Dim t As Timer  
    Public Serial1 As Serial  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("ESP started…")  
    RunNative("MeshSetup", Null)  
      
    t.Initialize("t_tick",500)  
    t.Enabled=True  
      
      
      
End Sub  
  
Sub t_tick  
    Log("Tick…")  
    RunNative("MeshUpdate", Null)  
      
End Sub  
  
#if c  
  
/*  
  Rui Santos  
  Complete project details at https://RandomNerdTutorials.com/esp-mesh-esp32-esp8266-painlessmesh/  
   
  This is a simple example that uses the painlessMesh library: https://github.com/gmag11/painlessMesh/blob/master/examples/basic/basic.ino  
*/  
  
#include "painlessMesh.h"  
  
#define   MESH_PREFIX     "whateverYouLike"  
#define   MESH_PASSWORD   "somethingSneaky"  
#define   MESH_PORT       5555  
  
Scheduler userScheduler; // to control your personal task  
painlessMesh  mesh;  
  
// User stub  
void sendMessage() ; // Prototype so PlatformIO doesn't complain  
  
Task taskSendMessage( TASK_SECOND * 1 , TASK_FOREVER, &sendMessage );  
  
void sendMessage() {  
  String msg = "Hi from node1";  
  msg += mesh.getNodeId();  
  mesh.sendBroadcast( msg );  
  taskSendMessage.setInterval( random( TASK_SECOND * 1, TASK_SECOND * 5 ));  
}  
  
// Needed for painless library  
void receivedCallback( uint32_t from, String &msg ) {  
  Serial.printf("startHere: Received from %u msg=%s\n", from, msg.c_str());  
}  
  
void newConnectionCallback(uint32_t nodeId) {  
    Serial.printf("–> startHere: New Connection, nodeId = %u\n", nodeId);  
}  
  
void changedConnectionCallback() {  
  Serial.printf("Changed connections\n");  
}  
  
void nodeTimeAdjustedCallback(int32_t offset) {  
    Serial.printf("Adjusted time %u. Offset = %d\n", mesh.getNodeTime(),offset);  
}  
  
void MeshSetup(B4R::Object* o) {  
  //Serial.begin(115200);  
  
mesh.setDebugMsgTypes( ERROR | MESH_STATUS | CONNECTION | SYNC | COMMUNICATION | GENERAL | MSG_TYPES | REMOTE ); // all types on  
//mesh.setDebugMsgTypes( ERROR | STARTUP );  // set before init() so that you can see startup messages  
  
  mesh.init( MESH_PREFIX, MESH_PASSWORD, &userScheduler, MESH_PORT );  
  mesh.onReceive(&receivedCallback);  
  mesh.onNewConnection(&newConnectionCallback);  
  mesh.onChangedConnections(&changedConnectionCallback);  
  mesh.onNodeTimeAdjusted(&nodeTimeAdjustedCallback);  
  
  userScheduler.addTask( taskSendMessage );  
  taskSendMessage.enable();  
  sendMessage();  
}  
  
void MeshUpdate(B4R::Object* o) {  
  // it will run the user scheduler as well  
  mesh.update();  
}  
  
  
#End If
```