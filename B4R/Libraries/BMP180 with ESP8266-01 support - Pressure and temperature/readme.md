### BMP180 with ESP8266-01 support - Pressure and temperature by Martin Larsen
### 03/18/2021
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/128774/)

This is a modified version of [Erel's BMP180 library](https://www.b4x.com/android/forum/threads/bmp180-pressure-and-temperature.67730/) with support for ESP8266-01.  
  
The tiny ESP-01 board does support I2C but the SDA and SCL pins are different from the bigger boards' so the standard library does not work. You will not get a reading from the sensor.  
  
Instead, this library exposes a new Initialize2 function which allows you to specify the SDA and SCL pins. For ESP-01 they are Pin 0 and Pin 2.  
  

```B4X
'SDA = Pin 0, SCL = Pin 2  
bmp180.Initialize2(0, 2)
```

  
  
For the bigger boards (WeMos, Arduino etc) just use the normal Initialize:  

```B4X
'Default I2C pins  
bmp180.Initialize
```