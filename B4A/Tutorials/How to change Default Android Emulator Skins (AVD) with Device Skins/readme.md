### How to change Default Android Emulator Skins (AVD) with Device Skins by mcqueccu
### 11/29/2023
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/157701/)

1. Download the skins from <https://github.com/larskristianhaga/Android-emulator-skins>  
  
**You can download skin for just one device or download all as an archive**  
![](https://www.b4x.com/android/forum/attachments/148180)  
  
2. Create a folder inside your android SDK folder and name it **Skins**  
3. Copy or Extract the files downloaded in Step 1 into the skins folder.  
  
![](https://www.b4x.com/android/forum/attachments/148181)  
  
  
4. Goto the B4AEmulator Folder inside the AndroidSDK, Choose the Emulator you want to change the skin for.  
Inside you will see Config.ini, open it with notepad.  
  
![](https://www.b4x.com/android/forum/attachments/148182)  
  
5. Locate **Skin.name** and **skin.path**, change the NAME and PATH respectively to the skin you want. Example From  
  

```B4X
skin.name = WVGA800  
skin.path = C:\androidsdk\platforms\android-28\skins\WVGA800
```

  
  
to this  
  

```B4X
skin.name = Pixel 7 Pro  
skin.path = C:\androidsdk\skins\pixel_7_pro
```

  
  
Start your Emulator. you should see the new skin implemented.  
  
6. Optional: If the emulator font seem small, CLOSE THE EMULATOR and Edit the Config Again, and change the  
**hw.lcd.width** and **hw.lcd.height**, and **hw.lcd.density** level.  
I prefer to use   
  

```B4X
hw.lcd.density = 440  
hw.lcd.height = 2400  
hw.lcd.width = 1080
```

  
  
  
  
[SIZE=7]BEFORE[/SIZE]  
![](https://www.b4x.com/android/forum/attachments/148188)  
  
  
[SIZE=7]AFTER  
![](https://www.b4x.com/android/forum/attachments/148189)[/SIZE]