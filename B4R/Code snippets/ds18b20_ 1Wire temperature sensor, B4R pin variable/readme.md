### ds18b20: 1Wire temperature sensor, B4R pin variable by peacemaker
### 08/06/2025
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/168124/)

Finally reworked [code](https://www.b4x.com/android/forum/threads/initialization-inside-inline-c-from-b4r.150832) for the ds18b20 sensor, with the pin setting.  
  

```B4X
'Module name = "esp_ds18b20", © Peacemakerv  
'v.2  
'Libs: https://github.com/milesburton/Arduino-Temperature-Control-Library; https://github.com/PaulStoffregen/OneWire  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
    Private pin1wire As Pin  
    Public temperature_ds18b20 As Float    'centigrees  
    Private Timer1 As Timer  
    Dim Ready_flag As Boolean    'ignore  
End Sub  
  
Sub Start_ds18b20(pinNumber As Byte)  
    Log("Start reading ds18b20…")  
    pin1wire.Initialize(pinNumber, pin1wire.MODE_INPUT_PULLUP)  
    RunNative("setup_ds18b20", pinNumber)  
   
    Timer1.Initialize("Timer1_Tick", 1000)  
    Timer1.Enabled = True  
End Sub  
  
Sub Stop  
    Timer1.Enabled = False  
    Log("ds18b20 stopped")  
End Sub  
  
Private Sub Timer1_Tick  
    RunNative("read_ds18b20",Null)  
    Log("ds18b20 temp=", temperature_ds18b20)  
    Ready_flag = True  
End Sub  
  
#if C  
// Include the libraries  
#include <OneWire.h>  
#include <DallasTemperature.h>  
  
OneWire* oneWire = NULL;  
DallasTemperature* sensors_ds18b20 = NULL;  
  
void setup_ds18b20 (B4R::Object* o) {  
    byte pin = o->toLong();  
    if (oneWire == NULL) {  
        oneWire = new OneWire(pin);  
        sensors_ds18b20 = new DallasTemperature(oneWire);  
        sensors_ds18b20->begin();  
        sensors_ds18b20->setResolution(12); //ADC resulution 9…12  
    }  
}  
  
void read_ds18b20 (B4R::Object* unused) {  
    if (sensors_ds18b20 != NULL) {  
        sensors_ds18b20->requestTemperatures();  
        delay(20);  
        b4r_esp_ds18b20::_temperature_ds18b20 = sensors_ds18b20->getTempCByIndex(0);  
    }  
}  
#End if
```

  
  
BTW, [Adafruit\_SSD1306 library](https://www.b4x.com/android/forum/threads/esp32-oled-display-adafruit_ssd1306-library.168085/) can be used for temperature value displaying with the degree sign by such code:  
  

```B4X
Public bc As ByteConverter  
…  
    Dim multiLine As String  = JoinStrings(Array As String(NumberFormat(esp_ds18b20.temperature_ds18b20, 1, 1), bc.StringFromBytes(Array As Byte(247))))  
    RunNative("SSD1306_show_line", multiLine)  
    RunNative("SSD1306_updatedisplay", Null)
```

  
  
![](https://www.b4x.com/android/forum/attachments/165855)![](https://www.b4x.com/android/forum/attachments/165859)