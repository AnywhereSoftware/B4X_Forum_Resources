### Mini Weather Station with LCD by rwblinn
### 04/19/2022
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/67873/)

Hi,  
  
a **Mini Weather Station** experiment displaying on a 16x2 LCD the Temperature + Humidity (Line1) and Pressure + Altitude (Line2).  
In addition, a trendindicator (=,+,-) is shown for each measure.  
A timer updates the measures every 5 seconds.  
The LCD brightness is set with the poti.  
  
**Components**  
Arduino UNO, LCD Display 16x2, BMP180 Sensor (Barometer), DHT11 Sensor (Temperature + Humidity)  
**Libraries**  
rLiquidCrystal, rSFE\_BMP180 (thanks to [USER=1]@Erel[/USER]), rDHT (thanks to [USER=64593]@inakigarm[/USER])  
  
**Circuit**  
![](https://www.b4x.com/android/forum/attachments/44938)  
  
**Code**  
The B4R documented code is attached. Overall pretty simple.  
The wiring connections are listed in the B4R project file.  
  
**Prototype** = bit of wire jungle ;) as it also contains LEDs and RTC (but not used for this experiment)  
![](https://www.b4x.com/android/forum/attachments/44974)  
  
**Updates**  
2016-06-14: Trend Indicator using special characters (Arrow Up, Down, Equal)