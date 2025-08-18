### B4x on Mac M1with Parallels and Windows 11 Arm by ThorstenStueker
### 12/18/2021
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/136934/)

The native use of B4x on M1 CPU is not possible. But using Parallels and Windows 11 Arm makes it possible to have a perfect working development environment. With one problem: there is no JavaFX for Windows Arm. That makes a problem: B4J Applications need a pipeline for graphics rendering. That is not working. But there is a workaround: use the B4J Bridge. Install JDK11 on your Mac and open the B4J Bridge on your Mac. Copy the IP the Bridge gives out, paste it to the IDE Settings for the Bridge and all works perfect.  
  
The same with IOS Bridge. It works perfect with the XCODE Simulator even if it is the same host.