### PWM with selection of frequency by moty22
### 06/20/2021
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/131813/)

Using inline C allows controlling TIMER 2 PWM output (analog output) to oscillate at selected frequencies of 61 Hz to 62,500 Hz.  
freq=1 to 7 select frequency, ana\_out set the duty cycle and output at pin 11 (OSC2A) of Arduino Uno. I haven't checked it with other Arduinos.  

```B4X
Sub Process_Globals  
    Public Serial1 As Serial  
    Private freq As Byte  
    Private ana_out As Byte  
    Private out As Pin  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("AppStart")  
    freq=4    '7=61Hz, 6=244Hz, 5=488Hz, 4=976Hz, 3=1953Hz, 2=7812Hz, 1=62500Hz   
    ana_out=190    'duty cycle 255=100%  
    RunNative("pwm", Null)  
    out.Initialize(11, out.MODE_OUTPUT)  
End Sub  
  
#if C  
void pwm (B4R::Object* o) {  
        //timer2 settings  
  OCR2A = b4r_main::_ana_out;  
  TCCR2A = 0b10000011;  //Normal Port Operation, fast PWM mode  
  TCCR2B = b4r_main::_freq;    //prescale  
}  
#End if
```