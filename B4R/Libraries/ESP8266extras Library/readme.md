### ESP8266extras Library by Starchild
### 03/27/2020
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/72186/)

I wanted to be able to assign a new IP address when running the ESP8266 in AP mode so I started to look into writing a library for B4R. Once I started to look inside the ESP and WIFI classes in Arduino I realised that there are many interesting and useful functions available.  
  
I started with the ESP8266 library provided in B4R v1.20 and wrapped a lot of these extra functions together with a little extra code to make some of them easier to use.  
  
ConfigAP  
GetMacAddress  
DeepSleep  
ResetReason  
UniqueID  
and many other.  
  
Have a look at the test code below to see the extra functions available.  
  

```B4X
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
    Public Serial1 As Serial  
    Private esp As ESP8266extras  
    Private Wifi As ESP8266WiFi  
    Private EE As EEPROM  
    Private ip(4) As Byte  
    Private mac(6) As Byte  
    Private bc As ByteConverter  
    Private count As Long  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("                               ")  
    Log("AppStart: ",count)  
    count = count + 1  
  
    Log("Reset: ",esp.ResetReason," - ",esp.ResetReasonMessage)  
    esp.GetAPIP(ip)  
    Log("Original AP IP: ",esp.IP2str(ip))  
    esp.ConfigAP("192.168.110.12","0.0.0.0","255.255.255.0")  
    Wifi.StartAccessPoint("ABC")  
    esp.GetAPIP(ip)  
    Log("New AP IP: ",esp.IP2str(ip))  'same as Wifi.AccessPointIp  
    Log("Local IP: ",Wifi.LocalIp)  
    Log("UniqueID: ",esp.UniqueID)  
    Log("EEPROM Size: ",EE.Size)  
    Log("FlasfID: ",esp.FlashChipId)  
    Log("FlahsSize: ",esp.FlashChipSize)  
    Log("FlashSpeed: ",esp.FlashChipSpeed)  
    Log("CPU Speed MHz: ",esp.CpuFreqMHz)  
    Log("Program Size: ",esp.SketchSize)  
    Log("Free Space: ",esp.FreeSketchSpace)  
    Log("CycleCount: ",esp.CpuCycleCount)  
    Log("HeapSpace: ",esp.FreeHeapSpace)  
    esp.GetMacAddress(mac)  
    Log("MAC: ",bc.HexFromBytes(mac))  
    Log("")  
    esp.DeepSleep(5000000,esp.WAKE_RFCAL)    'every 5sec  
    Log("NEVER CONTINUES")  
End Sub
```

  
  
I hope it's of use to others.  
  
PS. The DeepSleep function causes a RESET when it wakes up. B4R currently starts again clearing all variables and structures making a Sleep mode little more function than just power savings. You would currently need to hold values in EEPROM to remember information after waking up. It needs looking into further.  
  
Some useful reference links I have found are:  
<https://github.com/esp8266/Arduino/blob/master/cores/esp8266/Esp.cpp>  
<http://arduino-kit.ru/userfiles/image/Kolbans-Book-on-the-ESP8266-October-2015_b.pdf>  
<http://www.esp8266.com/wiki/doku.php?id=esp8266_power_usage>  
  
Library now updated to v1.07  
see posts below for details.