### How to use NoxPlayer with B4A by knutf
### 01/12/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/112949/)

It's recomended to use a real device or the Android SDK included emulator.  
  
But if you for some reason want to use NoxPlayer as emulator it is easy!  
  
**Alternative 1 - Connect B4A IDE directly to NoxPlayer**  

1. Download and install NoxPlayer
2. Rename adb.exe in android SDK platform-tools directory (Usually C:\android-sdk\platform-tools\adb.exe)
3. Copy the adb.exe that came with the NoxPlayer to the SDK platform-tools directory.
(Usually it will be Copy C:\Program Files\Nox\bin\adb.exe to C:\android-sdk\platform-tools\)4. Restart B4A IDE and NoxPlayer

  
**Alternative 2 - connect with B4A-Bridge to NoxPlayer**  

1. Download and install NoxPlayer
2. Start NoxPlayer
3. Activate network bridge mode:

- Select "System settings"
![](https://www.b4x.com/android/forum/attachments/87412)- Select the "phone model & internet" tab
- Click on "Install" to Install the Bridge connection driver
![](https://www.b4x.com/android/forum/attachments/87411)- Click on Enable network bridge mode
- If you leave IP Mode in DHCP, the emulator will get its own IP Address from your LAN's DHCP server
- Click on Save settings, and then on Restart now

4. Start Play Store (In the Tools group) and install B4A-Bridge
5. Now you can connect to B4A-Bridge as normal in the B4A IDE