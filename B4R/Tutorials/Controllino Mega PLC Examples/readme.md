### Controllino Mega PLC Examples by Johan Schoeman
### 03/30/2024
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/160192/)

Attached is a B4R project (using inline C) to manipulate the ports of the Controllino Mega. In this project we do the following:  
1. Toggle the OVL (over voltage) LED of the PLC between on/off every second (Port E) via a timer  
2. Toggle pins DO12 to DO19 (all on Port L) every second via the timer - split into 2 x groups of 4 DO's i.e DO 12, 13, 14, 15 switches ON/OFF immediately at the same time and DO 16, 17, 18, 19 switches OFF/ON immediately at the same time.  
  
(2) above is useful if one wants to directly drive for eg a 24V DC motor in forward and reverse direction. It allows one to use for eg 2 (or more) x DO pins simultaneously to increase the available current to a DC motor. The pins need to be from the same PORT. See this posting about port manipulation (<https://www.controllino.com/port-manipulation/>)  
  
![](https://www.b4x.com/android/forum/attachments/152335)  
  
![](https://www.b4x.com/android/forum/attachments/152336)  
  
Sample Code:  
  

```B4X
Sub Process_Globals  
    Public Serial1 As Serial  
     
    Dim t As Timer  
     
    Dim cnt As Int  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("AppStart")  
    cnt = 0  
    t.Initialize("t_tick", 1000)  
    RunNative("initDDRL", 0xff)  
    RunNative("initDDRE", 0x80)  
     
    t.Enabled = True  
     
End Sub  
  
Sub t_tick  
  
    If cnt Mod 2 = 0 Then  
        RunNative("ClearPortL", 0x00)  
        RunNative("SetPortL", 0x0f)  
        RunNative("SetPortE", 0x80)  
    Else  
        RunNative("ClearPortL", 0x00)  
        RunNative("SetPortL", 0xf0)  
        RunNative("ClearPortE", 0x7f)  
    End If  
     
    cnt = cnt + 1  
End Sub  
  
#if C  
#define clear_port_bit(reg, bitmask) *reg &= ~bitmask  
#define set_port_bit(reg, bitmask) *reg |= bitmask  
#define pulse_high(reg, bitmask) clear_port_bit(reg, bitmask); set_port_bit(reg, bitmask);  
#define pulse_low(reg, bitmask) set_port_bit(reg, bitmask); clear_port_bit(reg, bitmask);  
#define clear_port(port, data) port &= data  
#define set_port(port, data) port |= data  
  
void initDDRA (B4R::Object* o) {  
     DDRA |= o->toULong();  
}  
  
void initDDRB (B4R::Object* o) {  
     DDRB |= o->toULong();  
}  
  
void initDDRC (B4R::Object* o) {  
     DDRC |= o->toULong();  
}  
  
void initDDRD (B4R::Object* o) {  
     DDRD |= o->toULong();  
}  
  
void initDDRE (B4R::Object* o) {  
     DDRE |= o->toULong();  
}  
  
void initDDRF (B4R::Object* o) {  
     DDRF |= o->toULong();  
}  
  
void initDDRG (B4R::Object* o) {  
     DDRG |= o->toULong();  
}  
  
void initDDRH (B4R::Object* o) {  
     DDRH |= o->toULong();  
}  
  
void initDDRJ (B4R::Object* o) {  
     DDRJ |= o->toULong();  
}  
  
void initDDRK (B4R::Object* o) {  
     DDRK |= o->toULong();  
}  
  
void initDDRL (B4R::Object* o) {  
     DDRL |= o->toULong();  
}  
  
void ClearPortA (B4R::Object* o) {  
  clear_port(PORTA, o->toULong());  
}  
void SetPortA (B4R::Object* o) {  
  set_port(PORTA, o->toULong());  
}  
  
void ClearPortB (B4R::Object* o) {  
  clear_port(PORTB, o->toULong());  
}  
void SetPortB (B4R::Object* o) {  
  set_port(PORTB, o->toULong());  
}  
  
void ClearPortC (B4R::Object* o) {  
  clear_port(PORTC, o->toULong());  
}  
void SetPortC (B4R::Object* o) {  
  set_port(PORTC, o->toULong());  
}  
  
void ClearPortD (B4R::Object* o) {  
  clear_port(PORTD, o->toULong());  
}  
void SetPortD (B4R::Object* o) {  
  set_port(PORTD, o->toULong());  
}  
  
void ClearPortE (B4R::Object* o) {  
  clear_port(PORTE, o->toULong());  
}  
void SetPortE (B4R::Object* o) {  
  set_port(PORTE, o->toULong());  
}  
  
void ClearPortF (B4R::Object* o) {  
  clear_port(PORTF, o->toULong());  
}  
void SetPortF (B4R::Object* o) {  
  set_port(PORTF, o->toULong());  
}  
  
void ClearPortG (B4R::Object* o) {  
  clear_port(PORTG, o->toULong());  
}  
void SetPortG (B4R::Object* o) {  
  set_port(PORTG, o->toULong());  
}  
  
void ClearPortH (B4R::Object* o) {  
  clear_port(PORTH, o->toULong());  
}  
void SetPortH (B4R::Object* o) {  
  set_port(PORTH, o->toULong());  
}  
  
void ClearPortJ (B4R::Object* o) {  
  clear_port(PORTJ, o->toULong());  
}  
void SetPortJ (B4R::Object* o) {  
  set_port(PORTJ, o->toULong());  
}  
  
void ClearPortK (B4R::Object* o) {  
  clear_port(PORTK, o->toULong());  
}  
void SetPortK (B4R::Object* o) {  
  set_port(PORTK, o->toULong());  
}  
  
void ClearPortL (B4R::Object* o) {  
  clear_port(PORTL, o->toULong());  
}  
void SetPortL (B4R::Object* o) {  
  set_port(PORTL, o->toULong());  
}  
  
#end if
```

  
  

```B4X
MEGA:  
1st group: D0, D1, D3  
2nd group: D2  
3rd group: D4, D5, D6, D7  
4th group: D8, D9, D10, D11  
5th group: D12, D13, D14, D15, D16, D17, D18, D19  
6th group: D20, D21, D22  
7th group: D23
```