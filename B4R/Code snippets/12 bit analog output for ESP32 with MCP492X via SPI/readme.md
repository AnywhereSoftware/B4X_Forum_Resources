### 12 bit analog output for ESP32 with MCP492X via SPI by bussi04
### 01/31/2021
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/127160/)

Built in DAC of ESP32 has 8 bit resolution.  
My way to use: <https://www.b4x.com/android/forum/threads/analogwrite-pin-g25-on-esp32-for-true-analog-voltage-output-does-not-work.126928/#post-795752>  
  
If 12 bit resolution is needed MCP492X and SPI connection comes into play. Pin assignment using Arduino libs for ESP32 is kinda intransparent.  
So here is my solution:  
  

```B4X
#Region Project Attributes  
    #AutoFlushLogs: True  
    #CheckArrayBounds: True  
    #StackBufferSize: 600  
#End Region  
'Ctrl+Click to open the C code folder: ide://run?File=%WINDIR%\System32\explorer.exe&Args=%PROJECT%\Objects\Src  
  
Sub Process_Globals  
    Public Serial1 As Serial  
    Private astream As AsyncStreams  
    Public n1, n2, n3 As Int  ' reserved for inline C parameters  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200) ' (256000)  
    Log("AppStart")  
    astream.Initialize(Serial1.Stream, "Astream_NewData", "Astream_Error")  
     
    RunNative("iCsetup", Null)  
     
    Do While True  
        plot(2500,50)  
        plot(1200,1200)  
        plot(50,2500)  
    Loop         
    
End Sub  
  
Sub plot(x As Int,y As Int) As Int  
    n1=x  
    n2=y  
    RunNative("iCplot", Null)  
    Return n3  
End Sub  
  
Sub Astream_NewData (Buffer() As Byte)  
    Log("Received: ", Buffer)  
End Sub  
  
Sub AStream_Error  
    Log("error")  
End Sub  
  
#if C  
/* https://github.com/michd/Arduino-MCP492X/blob/master/README.md  
   https://lastminuteengineers.com/esp32-arduino-ide-tutorial/  
   https://docs.espressif.com/projects/esp-idf/en/latest/esp32/api-reference/peripherals/spi_master.html  
  
*          SPI2  SPI3 (used)  
* Pin Name GPIO  Number  
* CS0*      15     5+  
* SCLK      14    18+  
* MISO      12    19  
* MOSI      13    23+  
* QUADWP     2    22  
* QUADHD     4    21  
*   
*/  
  
#include <MCP492X.h> // Include the library  
  
#define PIN_SPI_CHIP_SELECT_DAC 5 // Or any pin you'd like to use  
  
MCP492X myDac(PIN_SPI_CHIP_SELECT_DAC);  
  
void iCsetup(B4R::Object* o) {  
  // put your setup code here, To run once:  
  myDac.begin();  
}  
  
void iCplot(B4R::Object* o) {  
  // put your main code here, To be called repeatedly:  
  
  // Write any value from 0-4095  
  myDac.analogWrite( b4r_main::_n1);  
  
  // If using an MCP4922, write a value To DAC B  
  myDac.analogWrite(1,  b4r_main::_n2);  
   
  b4r_main::_n3=0; // return code from inline function   
}  
  
#End if
```