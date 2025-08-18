### BLE CSC (cadence/speed) by MbedAndroid
### 09/07/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/122014/)

Based on Erel's Heartratemonitor this code can detect the BLE candence/speed sensors.  
Checked on Panobike sensor.  
Note: BT documentation about 0x1826 gives info that there should be 13 bytes  
1-byte flags  
4-bytes wheel total revolutions (u32)  
2-bytes wheel revolution time (1/1024 sec, u16))  
4-bytes cadence total revolutions (u32)  
2-bytes cadence revolution time (1/024 sec , u16)  
Panobike gives however 2 bytes total crankrevolutions, thus 11 bytes  
  
picture of test:  
  
  
![](https://www.b4x.com/android/forum/attachments/99690)