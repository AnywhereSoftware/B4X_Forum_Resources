### ESP32 - Fix uploading sketch error problem by Hamied Abou Hulaikah
### 06/09/2021
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/131493/)

**Temporary solution:**  
After you start compiling and compiling log reachs uploading sketch stage, you should continuously press **BOOT** button on ESP32 board until uploading complete.  
**Permanent solution:**  
Add 10uF capacitor to ESP32 board:  
Positive pole to EN pin  
Negative pole to GND pin  
or as the following image:  
![](https://www.b4x.com/android/forum/attachments/114698)