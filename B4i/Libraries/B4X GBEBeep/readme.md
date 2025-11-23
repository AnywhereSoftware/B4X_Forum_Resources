### B4X GBEBeep by Guenter Becker
### 11/21/2025
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/169401/)

Hello,  
This additional library may be used in **B4A**, **B4J** and **B4i** as well. It generates a beep sound.  
  
**Name**: GBEBeep.b4xlib  
**Version**: 1.0  
**(C)** G. Becker  
**Licence**: Royalty Free for all purpose  
  
**For All:**  

- Copy library file *GBEBeep.b4xlib* to the additional files folder. Recommend to use a sub Folder *B4X* there.
- Activate the library *GBEBeep*.
- Place #IgnoreWarnings: 32 in the Main Module
- Place Private Beeper as GBEBeep in the Globals Sub.

**For B4A:**   

- Activate internal *Audio* library
- Place Beeper.Initialize(Duration,Frequency) in the Activity or *B4XPage\_Created* Sub
Duration in Milliseconds, Frequency in Hz
  
**Usage:** Beeper.Beep  
  
**Notice:**   

- B4i Version is not tested due to have no Apple Environment.
- B4A tested on Samsung S21 and Emulator
- B4J tested on Windows Desktop
- B4J and B4i needs not initialization

  
May I ask for your help to test it in the different Environments. Any comment is wellcommed expecially if it works in B4i. Thankyou.