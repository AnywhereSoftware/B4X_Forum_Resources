### [ESP32] Internal Hall sensor (magnetic) by peacemaker
### 08/10/2023
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/149519/)

According to [this post](https://www.b4x.com/android/forum/threads/internal-thermometer-and-hall-effect-sensor-of-esp32.95526/) and <https://www.esp32.com/viewtopic.php?t=4963> info such code is prepared for practical usage:  
  

```B4X
'espinternal module name  
Private Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
    
    'https://www.esp32.com/viewtopic.php?t=4963  
    Dim HallOffset As Int = 50    'value to retract from Hall value  
    Dim HallMeasurement As Int = 0    'milliTesla output -300…+300 mT under a Neodymium magnet  
    Dim Temperature As Float = 0    'non-usable as always around +55 °С  
    Private Timer1 As Timer  
    Dim Flag_ready As Boolean  
End Sub  
  
Sub Start  
    Timer1.Initialize("Timer1_Tick", 300)  
    Timer1.Enabled = True  
End Sub  
  
Private Sub Timer1_Tick  
    RunNative("hallread", HallOffset)  
    Log("Hall sensor measurement: ", HallMeasurement)  
'    Temperature = 0  
'    RunNative("Temp",Null)  
'    Temperature = (Temperature- 32) / 1.8  
'    Log(JoinStrings(Array As String("Internal temperature = ", NumberFormat(Temperature, 0, 2), "°C")))  
    Flag_ready = True  
End Sub  
  
  
#If C  
void hallread(B4R::Object* o) {  
    int i;  
    long h;  
    int cycles;  
    int offset;  
    
    h=0;  
    cycles = 300;  
    offset = o->toLong();  
    for(i=0;i<cycles;i++)  
    {  
    h += hallRead();  
    delayMicroseconds(100);  
    }  
    h = h / cycles - offset;  
    
    b4r_espinternal::_hallmeasurement = h; //milliTesla output    // raw method: b4r_espinternal::_hallmeasurement=hallRead();  
}  
#End If  
  
#if C  
#ifdef __cplusplus  
extern "C" {  
#endif  
uint8_t temprature_sens_read();  
#ifdef __cplusplus  
}  
#endif  
uint8_t temprature_sens_read();  
void Temp (B4R::Object* o) {  
   //lower case variables  
   b4r_espinternal::_temperature=temprature_sens_read(); //also there is temperatureRead() function, but it returns wrong temperature  
}  
#End if
```

  
  
Internal temperature is useless, it's always high, as should be.  
But magnetic Hall sensor works OK in milliTesla: +/- 300 mT at +/-1 mT tolerance. But the sensor is at the center of ESP32 module, so it's very important to move the magnet source very close to the center.  
If 1…2 cm higher - no sensing already.  
  

```B4X
espinternal.Start
```