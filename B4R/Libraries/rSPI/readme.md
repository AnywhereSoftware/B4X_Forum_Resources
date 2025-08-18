### rSPI by hatzisn
### 10/27/2021
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/127250/)

Hi all,  
  
yesterday I was watching a tutorial about using spi library in Arduino. I tried to port this in B4R. I think I succeeded but someone more experienced should check it and let me know if everything works ok. There is the necessary needed functionality in the Code Module but there are also some additions. Please check and let me know if everything is ok.  
  
Please take under note that (as described in this tutorial) not all boards support the begin transaction command (that this library uses):  
  
<https://arduino.stackexchange.com/questions/79728/when-is-spi-begintransaction-required>  
  
and you must check it.  
  
Further more you must be aware that this impementation transfers a byte and receives a byte and if your device communication implementation (protocol) requires multiple bytes transfer (as it is mentioned in several online videos) it will not work. Be aware also that you must know the frequency of communications (MAX = 20000000) and also if it is MSBFIRST or LSBFIRST and at last the SPI\_MODEx where x=0,1,2,3 in order to make it work.  
  
See the attached example. Feel free to post corrections. **Please note that until today (25/10/2021) the library works only for Arduino and ESP8266.  
  
(21-9-2021)** Four new functions have been added:  
  

```B4X
'This command will write to the logs "–" if the board is not supported  
'and "-You can use this library with your board-" if your board is supported  
SPI.CheckIfThisBoardIsSupported  
  
'Transfer Byte Array  
Dim iDimension As UInt = 3  
Dim bSend(iDimension) As Byte  
bSend(0) = SPI.GetByteFromString("11001100")  
bSend(1) = SPI.GetByteFromString("01100110")  
bSend(2) = SPI.GetByteFromString("00110011")  
Dim bRet(iDimension) As Byte  
SPI.Transfer_Byte_Array(bSend, bRet)  
   
'Disable Inerrupts  
SPI.DisableInterrupts  
  
'Enable Inerrupts  
SPI.EnableInterrupts
```

  
  
  
**(3-2-2021)** Two new functions have been added:  
  

```B4X
    Dim b as Byte  
    b = SPI.Transfer_Byte(SPI.GetByteFromString("01100111"))  
  
    'We are interested only in the last 4 bits  
    b = SPI.ApplyMask(b, SPI.GetByteFromString("00001111"))  
    Log(b)  
  
    'We want to know the value of the 2nd bit from right in the byte  
    Dim iBitInSecondPositionFromRight As UInt = SPI.GetBitAt(b, 2)  
    Log(iBitInSecondPositionFromRight)
```