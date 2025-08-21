### ModBus RTU by OGmac
### 03/18/2020
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/115115/)

![](https://www.b4x.com/android/forum/attachments/90263)  
  
 **Modbus Function Code Support**  
   
[TABLE]  
[TR]  
[TD]Function Code[/TD]  
[TD]Register Type[/TD]  
[/TR]  
[TR]  
[TD]1[/TD]  
[TD]Read Coil[/TD]  
[/TR]  
[TR]  
[TD]2[/TD]  
[TD]Read Discrete Input[/TD]  
[/TR]  
[TR]  
[TD]3[/TD]  
[TD]Read Holding Registers[/TD]  
[/TR]  
[TR]  
[TD]4[/TD]  
[TD]Read Input Registers[/TD]  
[/TR]  
[TR]  
[TD]5[/TD]  
[TD]Write Single Coil[/TD]  
[/TR]  
[TR]  
[TD]16[/TD]  
[TD]Write Multiple Holding Registers[/TD]  
[/TR]  
[/TABLE]  
  
  

```B4X
    ' initial Paramter  
    Modbus.Initial(5,6,2,9600)  
    ' Set Registers  
    Modbus.CO(0)  = True      ' Coil Register     00000  
    Modbus.DI(0)  = True      ' Discrete Input    10001  
    Modbus.IR(0)  = 25        ' Input Register    30001  
    Modbus.HR(0)  = 50        ' Holding Register  40001  
    Modbus.HR(7)  = 100       ' Holding Register  40008
```

  
  
You can use [**Radzio! Modbus Master Simulator**](http://en.radzio.dxp.pl/modbus-master-simulator/)  
  
![](https://www.b4x.com/android/forum/attachments/90270)