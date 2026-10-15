### rOpen62541 (OPC UA Server) by rwblinn
### 10/12/2026
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/172071/)

**B4R Library rOpen62541**  
  

---

  
  
**Brief  
rOpen62541** is an open-source library wrapper for the industrial **open62541 OPC UA protocol stack**, specifically optimized for the **ESP32-S3 Dual-Core architecture**.  
It provides thread-safe cross-core communication, dynamic string-node creation, and type-agnostic runtime write diagnostics.  
  
**Important Notice:** This project is actively hosted and maintained on GitHub. Not all minor version bumps, patch adjustments, or documentation extensions will be individually announced in this forum thread. For the absolute latest code baseline and active development branches, please bookmark and monitor the repository directly.  
  
👉 **Access the main repository and assets here: [GitHub](https://github.com/rwbl/rOpen62541)**  
  

---

  
  
**Author's Note & Personal Context**  
*This library was developed purely for personal educational use, born out of a desire to dive deep into industrial connectivity and tackle the challenging feat of wrapping the open62541 stack for B4R. It wasn't easy to build, but exploring cross-platform client integration — such as B4J with the PyBridge or Node-RED — and seeing the dual-core hardware spring to life made it an incredibly rewarding project. Moving forward, this proof-of-concept server framework will serve as a foundational wireless gateway component for the author's open-source several **MAKE projects**.*  
  

---

  
  
[SPOILER="What is OPC UA & What is it used for?"]  
OPC UA (Open Platform Communications Unified Architecture) is a robust, platform-independent, and highly secure industrial machine-to-machine (M2M) communication protocol framework widely deployed in Industry 4.0 / Industrial IoT (IIoT) environments.  
  
Unlike standard message-based IoT protocols (like MQTT), OPC UA provides a unified Address Space allowing devices to structurally expose complex object folders, variable data nodes, and custom tracking methods with rich data metadata. It is extensively used to interconnect hardware sensors, embedded controllers, PLCs, industrial SCADA systems, and high-level enterprise MES/ERP software architectures seamlessly over modern Ethernet/Wi-Fi networks.  
[/SPOILER]  
  

---

  
  
**Purpose & Scope**  

- **Server-Only Architecture:** This library is dedicated exclusively to acting as an **OPC UA Server**.
It turns your microcontroller into a data provider but does not include client connection parsing capabilities.- **Proof of Concept & Learning Project:** This framework was explicitly developed as a personal educational project to learn the foundational basics of OPC UA by creating a custom standalone hardware device from scratch.
- **No Professional Intent:** There is absolutely no intention for this codebase to be deployed in mission-critical environments, production facilities, or professional commercial installations.
- Provides a high-level B4R abstraction layer for the native C-based open62541 library engine.
- Offloads heavy TCP/IP layers and subscription socket polling entirely to **ESP32 Core 0 (Network Core)** using FreeRTOS tasks to guarantee zero timing jitter on your hardware loops.
- Keeps **ESP32 Core 1 (B4R Core)** completely fluid and responsive for low-level critical hardware execution, physical interrupts, and timing loops.
- Implements a strict FreeRTOS binary semaphore mutex (open62541Mutex) preventing data collisions or memory corruption during concurrent memory read/write cycles.
- Exposes a universal, type-agnostic string node interceptor payload framework capable of catching incoming String, Int, or Float writes natively over a robust B4R Byte() array block.

---

  
  
**rOpen62541** uses a simple, flat node hierarchy.  
[SPOILER="Node Hierarchy"]  
All application nodes are added directly below the root object:  

```B4X
Objects (ns=0;i=85)  
└── Factory_Floor (ns=1;s=Factory_Floor)  
    ├── Temperature  
    ├── Humidity  
    ├── Pump1_Status  
    ├── Pump1_Speed  
    ├── Valve1_Status  
    ├── Production_Count  
    └── Trigger
```

  
Folders and additional hierarchical levels are not supported by the current B4R wrapper.  
This is an intentional design choice to keep the B4R API simple and to minimize RAM usage and processing overhead on ESP32-class microcontrollers.  
  
For applications requiring a logical structure, *prefix naming* can be used to organize nodes while retaining the flat hierarchy.  
This is similar to the tag-naming approach commonly used in industrial automation systems:  
  

```B4X
Factory_Floor  
├── Tank1_Temperature  
├── Tank1_Level  
├── Tank1_Pressure  
├── Pump1_Status  
├── Pump1_Speed  
├── Pump2_Status  
└── Pump2_Speed
```

  
For example:  

```B4X
OPCUAServer.AddFloatNode("Tank1_Temperature", "Tank 1 Temperature", 22.5)  
OPCUAServer.AddFloatNode("Tank1_Level", "Tank 1 Level", 75.0)  
OPCUAServer.AddBooleanNode("Pump1_Status", "Pump 1 Status", False)
```

  
This approach provides a simple and predictable OPC UA address space while keeping the wrapper lightweight and well suited for embedded ESP32 applications.  
[/SPOILER]  
  

---

  
  
**Development Info**  
This B4R library is:  

- An [open62541](https://open62541.org) protocol stack wrapper using Git-Revision: *v1.2-rc1-20-g78a6721b-dirty*.
- Written in C++ using Arduino IDE 2.3.10+, Espressif ESP32 Arduino Core V3.x, and the standard *B4Rh2xml* / *XMLTool* parsing pipeline.
- **Mandatory Hardware Constraint:**
This library was developed and strictly tested with an **ESP32-S3-N16R8** developer kit (32-bit Xtensa lx7 dual-core chip with 16MB Flash and 8MB PSRAM). Due to memory allocation sizes and dual-core constraints, utilizing this specific hardware class is highly recommended or mandatory.- Tested with B4R 4.00 (64-bit).
- **Not supported over WAN directly:** Meant for local subnet networks (LAN/WLAN) where no external internet router firewall ports need to be exposed.

---

  
  
**Compatibility**  

- Supports Espressif ESP32-S3 high-memory microcontrollers (N16R8 format). Must ensure standard network lwIP socket frameworks are initialized.

---

  
**Verified Client Compatibility**  
The rOpen62541 server layer has been tested with the following OPC UA clients across different ecosystems:  

- **Node-RED** - Handled smoothly using the [node-red-contrib-opcua](https://github.com) palette node framework.
- **opcua-commander** - Fully responsive via the visual [Node.js Terminal-based Explorer](https://github.com/node-opcua/opcua-commander).
- **B4J with OPC UA Client** - Highly compatible with the B4J [SS\_OPCUAClient](https://b4x.com) industrial asset wrapper library.
- **B4J with PyBridge** - Verified handling data loops passing through Python-bridged socket integrations.

---

  
  
[SPOILER="Architectural Version Selection: Why open62541 v1.2?"]  
This library explicitly uses the open62541 v1.2 legacy branch (v1.2-rc1-20-g78a6721b-dirty) instead of v1.3+ or v1.5+ release lines.  
While modern versions introduce advanced enterprise desktop configurations, version 1.2 is carefully selected for the following critical engineering reasons:  

- Embedded-First Resource footprint: Version 1.2 compiles into a highly lightweight binary footprint. Newer versions contain massive auto-generated internal structures (such as updated Namespace 0 trees) that routinely hit compiler variable-tracking limits, causing the Xtensa compiler toolchain to freeze, link-crash, or hang the B4R IDE.
- Native lwIP Connection Abstraction: The network socket management layer in v1.2 seamlessly adapts to the ESP32’s native embedded FreeRTOS/lwIP stack out of the box. Newer versions introduce rigid desktop POSIX dependencies (such as <poll.h> and complex desktop mutex types) that create structural friction on microcontrollers.
- Streamlined Property Configuration: Version 1.2 exposes clean, low-level configuration functions like UA\_ServerConfig\_setCustomHostname(). Later versions completely refactor these into complex, deeply nested configuration allocation macros that are difficult to manage within an object-oriented B4R C++ wrapper interface.
- Perfect Functional Match: The v1.2 branch provides 100% of the industrial protocol features required for this proof of concept (including dynamic float, integer, string, and raw binary ByteString node arrays) without any unnecessary software bloat.

[/SPOILER]  

---

  
  
**Screenshot**  
  
![](https://www.b4x.com/android/forum/attachments/173620)  
  

---

  
  
**Installation**  
  
To install the library:  

- Download the codebase package directly from the link above.
- Copy the source sub-folder **rOpen62541** straight into your B4R *Additional Libraries* directory, keeping the folder layout fully intact.
- Copy the companion **rOpen62541.xml** definition file into your B4R *Additional Libraries* directory.

---

  
  
**Code Example (Snippet)**  
  

```B4X
Sub Process_Globals  
    Private VERSION             As String = "rOpen62541 EnvSim v20261012"  
    ' Communication  
    Public Serial1                 As Serial  
    Private WiFi                 As ESP8266WiFi                        ' Lib rESP8266WiFi  
    Private SSID                As String = "Zuse"  
    Private PW                     As String = "83425399897672098612"  
    ' Open62541  
    Private OPCUAServer            As Open62541                        ' Lib rOpen62541  
    Private PORT                 As Int = 4840  
    ' Nodes  
    Private NODEID_TEMPERATURE    As String = "ns=1;s=Temperature"  
    Private NODEID_HUMIDITY        As String = "ns=1;s=Humidity"  
    ' Timer simulating sensor data  
    Private AppTimer As Timer  
    Private APPTIMER_INTERVAL     As ULong = 5000  
    'Helper  
    Private bc As ByteConverter    'ignore  
End Sub  
  
Sub AppStart  
    Serial1.Initialize(115200)  
    Log(CRLF, "[AppStart] ", VERSION)  
    ' Init app timer to generate env data  
    AppTimer.Initialize("AppTimer_Tick", APPTIMER_INTERVAL)  
    ' Start after opc server has been initialized and nodes created  
    AppTimer.Enabled = False  
    ' Connect to the network first  
    If WiFi.Connect2(SSID, PW) Then  
        Log("[AppStart] WiFi connected > local ip=", WiFi.LocalIP)  
        ' [AppStart] WiFi connected. IP=192.168.1.68  
        RunNative("DisableWiFiSleep", Null)  
        RunNative("SetSystemClock", Null)  
        If InitOPCUAServer Then  
            AppTimer.Enabled = True  
            Log("[AppStart] OPC UA server & simulation started every ", APPTIMER_INTERVAL, "ms")  
        End If  
    Else  
        Log("[AppStart][E] WiFi Connection Failed")  
    End If  
End Sub  
  
Private Sub InitOPCUAServer As Boolean  
    Dim TimeoutCounter As Int = 0  
    Dim ServerBootFailed As Boolean = False  
    ' Init the OPC UA server no callbacks (set to null)  
    OPCUAServer.Initialize(WiFi.LocalIp, PORT, _                ' See log after boot which IP:Port  
                           "", "", _                             ' No auth  
                           Null, _                               ' No Trigger callback  
                           Null)                                ' No data write callback  
    ' Wait for the background thread layout initialization to complete!  
    Do While OPCUAServer.IsReady = False  
        Delay(100) ' 100ms yield ticks for the cooperative scheduler        
        TimeoutCounter = TimeoutCounter + 1  
        If TimeoutCounter >= 50 Then ' 50 ticks * 100ms = 5000ms (5 Seconds Timeout)  
            ServerBootFailed = True  
            Exit ' Break out of the endless loop safely!  
        End If  
    Loop  
    
    If ServerBootFailed Then  
        Log("[InitOPCUAServer][E] Failed with TIMEOUT! Core 0 failed.")  
        ' Optional: Run local emergency fallback routine or let local sensors run offline  
    Else  
        OPCUAServer.AddFloatNode(NODEID_TEMPERATURE, "Room Temperature", 20.0)  
        OPCUAServer.AddFloatNode(NODEID_HUMIDITY, "Room Humidity", 68.0)  
    End If  
    Return Not(ServerBootFailed)  
End Sub  
  
Sub AppTimer_Tick  
    If OPCUAServer.IsReady Then  
        Dim CurrentTemp As Float = 24.5 + Rnd(-2.0, 3.0)  
        Dim CurrentHum As Float = 68 + Rnd(-10.0, 11.0)  
        OPCUAServer.WriteFloat(NODEID_TEMPERATURE, CurrentTemp)  
        OPCUAServer.WriteFloat(NODEID_HUMIDITY, CurrentHum)  
        Log("[AppTimer] Sensor read complete > t=", CurrentTemp, " h=", CurrentHum)  
    End If  
End Sub  
  
#if C  
#include "esp_wifi.h"  
#include "time.h"  
  
// RunNative("DisableWiFiSleep", Null)  
void DisableWiFiSleep(B4R::Object* o) {  
    // Force Espressif lwIP stack to set Power Save to NONE  
    esp_wifi_set_ps(WIFI_PS_NONE);  
    ::Serial.println("[Hardware Engine] Wi-Fi Modem-Sleep forcefully disabled! Radio set to high-performance mode.");  
}  
  
// RunNative("SetSystemClock", Null)  
void SetSystemClock(B4R::Object* o) {  
    // Configures the system to poll pool.ntp.org with a standard global UTC offset  
    // Adjust the 3600 (seconds) based on your target local timezone offset (e.g. 3600 = UTC+1)  
    configTime(3600, 0, "pool.ntp.org", "time.nist.gov");  
    ::Serial.println("[SetSystemClock] SNTP Client started. Synchronizing baseline…");  
}  
#End If
```

  
  

---

  
  
**License**  

- **rOpen62541** Library - MIT License as stated in the LICENSE file provided with rOpen62541.
- **Open62541** Library - Mozilla Public License v2.0 as stated in the LICENSE file provided with open62541.

---

  
  
**Credits**  

- Developers, maintainers, and open-source contributors of the official [open62541 architecture framework](http://open62541.org/), providing an industrial-grade embedded C implementation of OPC UA.
- Anywhere software for the B4X suite of development tools.
- [USER=21400]@Peter Simpson[/USER] for the B4J library [SS\_OPCUAClient](https://www.b4x.com/android/forum/threads/opc-ua-industrial-client-library-connect-to-servers-devices.171977/).
- AI for engineering collaboration.

---

  
  
**Disclaimer**  

- All product names, logos, protocols, and brands are property of their respective owners.
- This B4R library is an independent open-source wrapper tracking standard open62541 architectures.
It is neither officially endorsed nor maintained by the primary open62541 project core maintainers.- This codebase represents a strict standalone proof-of-concept / learning exercise and is explicitly **not intended for professional, commercial, or critical industrial application**.
- This wrapper, its cross-core FreeRTOS mutex mappings, and its data type interceptor routines were designed and polished with the specialized interactive assistance of an AI engineering collaborator, achieving optimal compatibility with the B4R pre-compiler stack.

---