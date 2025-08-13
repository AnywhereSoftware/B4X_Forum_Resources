### [PyBridge] LGPIO - Raspberry Pi GPIO by Erel
### 03/11/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/166064/)

Based on: <https://abyz.me.uk/lg/py_lgpio.html>  
Tested on RPi 5. It should be compatible with most boards.  
With the latest version of Raspbian, everything needed is preinstalled (Python and lgpio).  
  
For now the GPIO related features are wrapped.  
  
![](https://www.b4x.com/android/forum/attachments/162438)![](https://www.b4x.com/android/forum/attachments/162439)  
  
  
The attached example demonstrates the simple usage. The LGPIO class is inside the example.  
  
Make sure to call gpio.Close before ending the program. Otherwise, the GPIO will remain locked for some time. This means that you shouldn't kill the app from the IDE, but rather close it from the window (or add a different way to properly call close before killing the process).  
  
Getting started with RPi 5: <https://www.b4x.com/android/forum/threads/raspberry-pi-5-first-steps.166049/#content>