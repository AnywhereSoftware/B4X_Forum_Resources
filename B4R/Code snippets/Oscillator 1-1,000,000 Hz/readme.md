### Oscillator 1-1,000,000 Hz by moty22
### 06/21/2021
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/131840/)

Using 16b TIMER 1 and inline C to get oscillating output at PIN 9 (Arduino Uno). the frequency can be set to 1Hz up to 1MHz, the output is set by division of the 16MHz crystal.  
When the frequency is power of 2 the output is accurate, otherwise the error can be up to 0.04%.  
   

```B4X
Sub Process_Globals  
    Public Serial1 As Serial  
    Private frequency As ULong  
    Public divide As UInt  
    Public prescale As Byte  
    Private out As Pin  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("AppStart")  
      
    frequency=500    'enter requency 1Hz to 1MHz  
      
    If frequency>1000 Then  
        prescale=0x1A    '0b11010  
        divide=1000000/frequency-1  
        Else  
            prescale=0x1C    '0b11100  
            divide=31250/frequency-1  
    End If  
    RunNative("osc", Null)  
    out.Initialize(9, out.MODE_OUTPUT)    '11  
End Sub  
  
  
#if C  
void osc (B4R::Object* o) {  
      //  set timer1  
    TCCR1A = 0b1000011;   
    TCCR1B = b4r_main::_prescale;  
    OCR1A = b4r_main::_divide;  
}  
#End if
```