### Debugging your app on real phone without USB cable or B4A bridge by Matt S.
### 10/16/2025
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/169051/)

Using a USB Cable for debugging apps is faster and easier than using B4A bridge. But as you know, being always connected to the USB port will decrease the battery life. With this instruction, you should use the USB port only once, and then you will get rid of that. Remember that your phone and your computer must use the same network.  
  
First, save these commands as a batch file, say connect.bat:  

```B4X
REM Connecting  
C:\Android\platform-tools\adb.exe tcpip 5555  
C:\Android\platform-tools\adb.exe connect x.x.x.x:5555  
pause
```

  
Find the right address of the "adb.exe" on your computer and replace it. Also, you must put your phone's IP4 address instead of x.x.x.x  
  
Now, do these steps each time you turn on the computer and decide to connect:  
1. Connect the mobile to the computer using a USB cable.  
2. Run the above batch file. if everything is OK, you will see this message: "connected to x.x.x.x:5555"  
3. Disconnect the USB cable  
4. Clean the project with Ctrl+P (or Tools->Clean project)  
Now you can start running the program; no need for a USB cable.  
  
You can also save these two batch files for disconnecting and for getting the list of connected devices.  

```B4X
REM Disonnecting  
C:\Android\platform-tools\adb.exe disconnect 192.168.2.16:5555  
pause
```

  
  

```B4X
REM List of Connected Devices  
C:\Android\platform-tools\adb.exe devices  
pause
```

  
  
Care