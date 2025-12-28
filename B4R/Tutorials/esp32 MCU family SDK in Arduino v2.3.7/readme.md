### esp32 MCU family SDK in Arduino v2.3.7 by peacemaker
### 12/24/2025
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/169829/)

The new esp32 SDK is got of very huge size and the downloading (and + unpacking + installation) is failed due to the timeout is out.  
Add\edit the "connection\_timeout" parameter in the settings file %system\_drive%:\Users\%PC\_name%\arduinoIDE\arduino-cli.yaml:  
  

```B4X
network:  
  connection_timeout: 7700s
```

  
  
1700s was not enough !  
  
![](https://www.b4x.com/android/forum/attachments/169005)