### rESP32Watchdog by rwblinn
### 04/22/2025
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/166707/)

**B4R Library rESP32Watchdog  
  
Purpose**  
rESP32Watchdog is an open source ESP32 hardware watchdog.  
  
**Features**  

- A minimal and flexible ESP32 hardware watchdog implementation using B4R, complete with EEPROM-based crash reason logging and runtime test simulations.
- Hardware watchdog timer with configurable timeout.
- Periodic feeding of the watchdog in the main loop.
- Persistent logging of reset reason in EEPROM.
- Simulation of common failure modes:

- Infinite loops.
- Stack overflows.
- Explicit system crashes.

- Optional cloud communication using HTTP (for demonstration).

**Screenshot Example**  
  
![](https://www.b4x.com/android/forum/attachments/163565)  
  
**Development Information**  

- Library developed in CPP and compiled using the Arduino IDE 2.3.4 (or Arduino IDE 1.8.9) and the B4Rh2xml tool.
- Software: B4R 4.00 (64 bit), Arduino Board Manager ESP32 version 3.1.3.
- Hardware: Tested with ESP32-WROOM-32.
- This library has been developed for personal use only.

**Files**  
rESP32Watchdog.zip archive contains the library and sample projects.  
From the zip archive rESP32Watchdog.zip, copy the content of the library folder, to the B4R additional libraries folder keeping the folder structure.  
  
**Example Reset Reasons**  
1: Normal power-on reset  
4: System panic (e.g., stack overflow)  
6: Watchdog-triggered reset  
  
**B4R Cloud Server Example**  
1. Flash the B4R program to the ESP32.  
2. Set **TEST\_MODE** to trigger different simulated crashes.  
3. Monitor the serial output to verify watchdog behavior and reset reason logs.  
4. EEPROM keeps the last reset reason across restarts.  

```B4X
Sub Process_Globals  
    Private VERSION As String = "rESP32Watchdog CLOUDSERVER v20250422"  
    Private Serial1 As Serial  
    Private NETWORK_SSID As String        = "YourSSID"  
    Private NETWORK_PASSWORD As String    = "YourPassword"  
    Private CLOUD_URL As String            = "http://IP-CLOUD-SERVER:51042/cloud"  
    Private CLOUD_CONTENT As String        = "msg=HelloFromB4R"  
    Private WIFIMAXRETRIES As Byte = 2  
    Private WiFiRetriesCounter As Byte = 0  
    Private wifi As ESP8266WiFi  
    Private WATCHDOG_TIMEOUT As ULong = 5000  
    Private WATCHDOG As ESP32Watchdog  
    Private TimerCloudRequest As Timer  
    Private TIMERCLOUDREQUEST_INTERVAL As ULong = 5000  
    Private PIN_NR_ONBOARD_LED As Byte = 2  
    Private Pin_Onboard_Led As Pin  
    Private TEST_MODE As Byte = 0   ' 0=normal, 1=infinite loop, 2=skip watchdog, 3=http hang, 4=recursion crash  
    Private EEPROM_RESET_REASON_ADDRESS As Byte = 0  
    Private eeprom As EEPROM  
    Private bc As ByteConverter    'ignore  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log(CRLF, "[AppStart]", VERSION)  
  
    ' EEPROM reset reason (log and clear)  
    Dim lastReason As Byte = GetStoredResetReason  
    If lastReason > 0 Then  
        Log("[AppStart] Last reset reason (from EEPROM): ", lastReason)  
        StoreResetReason(0) ' Clear it  
    End If  
  
    ' Init GPIO  
    Pin_Onboard_Led.Initialize(PIN_NR_ONBOARD_LED, Pin_Onboard_Led.MODE_OUTPUT)  
    Pin_Onboard_Led.DigitalWrite(False)  
  
    ' Timer Periodic sender to cloud - enabled is set after wifi connected  
    TimerCloudRequest.Initialize("TimerCloudRequest_Tick", TIMERCLOUDREQUEST_INTERVAL)  
    TimerCloudRequest.Enabled = False  
   
    ' Connect to WiFi  
    If Not(WiFiConnect) Then  
        Return  
    End If  
  
    ' Start hardware watchdog with timeout 5000ms with event  
    WATCHDOG.Initialize(WATCHDOG_TIMEOUT, "WatchdogResetReason")  
   End Sub  
  
#Region Watchdog  
' Log and store the reason for the watchdog to trigger ESP reset.  
' This event is triggerd by the library.  
Private Sub WatchdogResetReason(reason As Int)  
    Log("[WatchdogResetReason] reason=", reason)  
    StoreResetReason(reason)  
End Sub  
#End Region  
  
#Region WIFI  
'Connect to the wifi using the credentials.  
'If connection OK, the onboard BLUE LED is on.  
Private Sub WiFiConnect As Boolean  
    Dim result As Boolean  
    TimerCloudRequest.Enabled = False  
   
    ' Connect with wifi by setting SSID and password  
    If wifi.Connect2(NETWORK_SSID, NETWORK_PASSWORD) Then  
        Log("[WiFiConnect] Connected to WiFi with local IP ", wifi.LocalIp)  
        WiFiRetriesCounter = 0  
        TimerCloudRequest.Enabled = True  
        Pin_Onboard_Led.DigitalWrite(True)  
        result = True  
    Else  
        'Connection failed, retry  
        WiFiRetriesCounter = WiFiRetriesCounter + 1  
        Log("[AppStart][ERROR] Failed to connect to WiFi. Retry ", WiFiRetriesCounter)  
        If WiFiRetriesCounter < WIFIMAXRETRIES Then  
            'Try to reconnect again  
            Delay(1000)  
            WiFiConnect  
        Else  
            'Max retries = abort  
            Log("[AppStart][ERROR] Failed to connect to WiFi. Check network parameter.")  
            TimerCloudRequest.Enabled = False  
            Pin_Onboard_Led.DigitalWrite(False)  
        End If  
        result = False  
    End If  
    Return result  
End Sub  
#End Region  
  
#Region HTTPCLOUD  
Sub TimerCloudRequest_Tick  
    Log("[TimerCloudRequest_Tick] TEST_MODE=", TEST_MODE)  
  
    ' Simulate 4 crash scenarios. Set to 0 for normal mode.  
    TEST_MODE = Rnd(0, 5)  
   
    Select TEST_MODE  
        Case 0  
            ' Normal mode  
            WATCHDOG.Feed  
            HttpJob.Initialize("cloudrequest")  
            HttpJob.AddHeader("Content-Type", "application/x-www-form-urlencoded")  
            HttpJob.Post(CLOUD_URL, CLOUD_CONTENT)  
  
        Case 1  
            ' Infinite loop (simulate freeze)  
            Log("[Simulate TEST_MODE=1] Infinite loop…")  
            Do While True  
            Loop  
  
        Case 2  
            ' Skip watchdog feed (simulate hang)  
            Log("[Simulate TEST_MODE=2] Skipping Watchdog.Feed")  
            HttpJob.Initialize("cloudrequest")  
            HttpJob.AddHeader("Content-Type", "application/x-www-form-urlencoded")  
            HttpJob.Post(CLOUD_URL, CLOUD_CONTENT)  
  
        Case 3  
            ' HTTP hang (invalid IP)  
            Log("[Simulate TEST_MODE=3] HTTP request to dead IP")  
            WATCHDOG.Feed  
            HttpJob.Initialize("cloudrequest")  
            HttpJob.Post("http://10.255.255.1:51042/cloud", CLOUD_CONTENT)  
  
        Case 4  
            ' Stack overflow (recursive call)  
            Log("[Simulate TEST_MODE=4] Recursive crash incoming…")  
            RecursiveCrash  
  
        Case Else  
            Log("[Unknown TEST_MODE] Running normal")  
            WATCHDOG.Feed  
    End Select  
End Sub  
  
Sub JobDone (Job As JobResult)  
    If Job.Success Then  
        Log("[JobDone][OK] name=", Job.JobName, ",success=", Job.Success, ",status=", Job.Status, ",response=", Job.Response)  
    Else  
        Log("[JobDone][ERROR] status=", Job.status, ", message=", Job.ErrorMessage, ",response=",Job.Response)  
    End If  
End Sub  
  
Private Sub RecursiveCrash  
    RecursiveCrash  
End Sub  
#End Region  
  
#Region EEPROM  
' Store the reset reason at byte pos 1.  
Private Sub StoreResetReason(Reason As Byte)  
    Dim b(1) As Byte  
    b(0) = Reason  
    eeprom.WriteBytes(b, EEPROM_RESET_REASON_ADDRESS)  
End Sub  
  
' Read the reset reason from first byte pos.  
Private Sub GetStoredResetReason As Byte  
    Dim b(1) As Byte  
    b = eeprom.ReadBytes(EEPROM_RESET_REASON_ADDRESS, 1)  
    Return b(0)  
End Sub  
#End Region
```

  
Customization  
The watchdog logic can be easily integrated into any other ESP32 project.  
  
**To-Do**  

- ESP8266 support.

**License**  
GNU General Public License v3.0.