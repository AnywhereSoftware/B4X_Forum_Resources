### Now you can debug android app directly under Windows11 by laomms
### 10/21/2021
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/135314/)

Intel's Bridge technology will allow Android apps to run natively on Windows 11, now Microsoft released the beta version。  
  
1. download windows11 from <https://www.microsoft.com/en-us/software-download/windows11> and installed.  
  
![](https://www.b4x.com/android/forum/attachments/120587)  
2. open <https://store.rg-adguard.net>, and input:<https://www.microsoft.com/store/productId/9P3395VX91NR>, select slow channel,download "[MicrosoftCorporationII.WindowsSubsystemForAndroid\_1.7.32815.0\_neutral\_~\_8wekyb3d8bbwe.msixbundle](http://tlu.dl.delivery.mp.microsoft.com/filestreamingservice/files/433b1665-c732-486a-99ee-e2c610cd10d4?P1=1634818296&P2=404&P3=2&P4=PNOpT%2fpBMfe7IXnOOFRUURe1cUl0gx1WDEum%2fyhC5%2bLXGgfyXLC95VKZPAM1AzHURhxtkBrDi97p9voF%2bYMaFQ%3d%3d)" pakage.  
  
![](https://www.b4x.com/android/forum/attachments/120582)  
  
![](https://www.b4x.com/android/forum/attachments/120586)  
3. Administrator runs the Powershell and install the pakage:  

```B4X
Add-AppxPackage -Path D:\MicrosoftCorporationII.WindowsSubsystemForAndroid_1.7.32815.0_neutral_~_8wekyb3d8bbwe.msixbundle
```

  
4. Open the developer mode in the installed pakage: Windows Subsystem for Android  
![](https://www.b4x.com/android/forum/attachments/120592)  
  
5. Install the B4A-Bridge.apk(<https://www.b4x.com/android/files/b4a_bridge.apk>) use adb(you can download adb from:<https://www.b4x.com/b4a.html#installation>):  
run cmd under X:\Android\Sdk\platform-tools:  

```B4X
adb connect 127.0.0.1:58526
```

  
install B4A-Bridge.apk use command:  

```B4X
adb install D:\b4a_bridge.apk
```

  
![](https://www.b4x.com/android/forum/attachments/120593)  
  
or you can make a batch, drag app to the batch  

```B4X
@echo off  
  
adb.exe connect 127.0.0.1:58526  
  
adb.exe -s 127.0.0.1:58526 install %1  
  
pause
```

  
  
that's all, now you can debug your app directly under Windows11.  
  
![](https://www.b4x.com/android/forum/attachments/120583)  
  
![](https://www.b4x.com/android/forum/attachments/120584)  
  
![](https://www.b4x.com/android/forum/attachments/120585)