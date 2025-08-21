### Modbus TCP server - slave - restricted functionality by Coldrestart
### 08/26/2019
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/109031/)

Hello everyone,  
  
Here a small quick and dirty implementation of the modbus TCP protocol in B4J as a server / slave.  
Please note that this is not a complete library!  
The following limitations are:  
-Only READING (not writing) of holding registers possible by modbus master(function code 03) from 0-200  
-Example in NON gui application  
-No error code implementation (send to master), only some error info in the logs locally  
  
I made it just to get some data out of a raspberry pi.