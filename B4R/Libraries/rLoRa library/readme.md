### rLoRa library by candide
### 06/20/2022
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/141306/)

it is a wrapper for LoRa library from Sandeep Mistry  
<https://github.com/sandeepmistry/arduino-LoRa>  
  
in March, i was working on a wrapper for LoRa library, and some tests were done by ehsan gilassi, but both call-back were not working.  
  
after a few modifications, i have this library working for B4R.  
  
all functions available in arduino library are available with B4R  
  
both call-back OnReceive and OnRxDone are working, but this library can be used also without callback  
  
3 examples B4R are available,  
 - Duplex messages with OnReceive callback  
 - Duplex messages with OnTxDone callback  
 - Duplex messages without callback  
  
tests were done with 2 SX1278, Ra-01 M modules and one esp8266 + one esp32.  
  
more information on all functions available can be found in Sandeep Mistry site