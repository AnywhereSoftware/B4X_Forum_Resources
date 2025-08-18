### Connect B4A to Bluestacks 5 by Random.Information
### 06/22/2022
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/141349/)

Step 1. Copy the adb file path  
  
- Locate the adb file in the SDK folder.  
- Copy the adb file path  
  
Path example: C:\B4A\sdk\platform-tools  
  
Step 2. Connect the B4A adb with the emulator IP  
  
- Open CMD as administrator  
- Go to the path inside the CMD  
- Carry out the command that connects the adb with the IP address of the emulator.  
  
Command  
  
) C:\B4A\sdk\platform-tools  
) adb connect 127.0.0.1:555  
  
The emulator IP is 127.0.0.1:5555  
I don't know if it changes. If so, mention it in the comments and I'll show you where to see the emulator's IP.  
  
Step 3. Activate the Android ADB debugging bridge  
  
- Open the emulator  
- Open the settings and go to the advanced section.  
- Activate the option: Android ADB debugging bridge  
- Save the changes.  
  
Step 6. Start the connection with the IP from B4A  
  
- Open B4A  
- Open the Logs window  
- Click on connect  
  
Step 7. Recommendation  
  
Make sure Bluestacks is open when you click release.  
I tried clicking release when bluestacks is closed. But it doesn't open bluestacks.  
  
Tutorial on youtube:  
[MEDIA=youtube]yfZRTT3D4Y8[/MEDIA]