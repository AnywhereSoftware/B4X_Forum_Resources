### Android 16KB Page Size Compatibility Checker by mcqueccu
### 10/08/2025
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/168942/)

This script checks for all the necessary markers to be sure your APK/AAB/SO files are 16KB page size compatible.  
It has been simplified to easy usage.  
  
  
[HEADING=1]What Does This Check?[/HEADING]  
Starting with Android 15, devices may use 16KB memory page sizes instead of the traditional 4KB. Apps with improperly aligned native libraries will fail to load on these devices.  
  
This script performs **comprehensive validation** that goes beyond simple alignment checks:  
  

- ✅ **PT\_LOAD segment alignment** (p\_align >= 16384)
- ✅ **Virtual address alignment** (p\_vaddr % p\_align == 0)
- ✅ **File offset alignment** (p\_offset % p\_align == 0)
- ✅ **Congruence requirement** (p\_vaddr % p\_align == p\_offset % p\_align)
- ✅ **Android property note detection** (.note.gnu.property)

  
**STEPS**  
1. Make sure to download the NDK tools and extract to a location.Make sure to scroll down to get the latest version, v28 and above  
<https://developer.android.com/ndk/downloads>  
  
2. Download the SCRIPT: leafy-check-16kb.ps1  
  
3. Open Powershell at the location of the script, run the script,  
**Interactive Mode** (Easiest - script will prompt you for the NDK Path, and then prompt again for the path to APK/AAB/.So etc)  
Note: It remembers the NDK Path, so subsequent commands, just hit enter when it prompts for NDK Path  

```B4X
.\leafy-check-16kb.ps1
```

  
  
**Command Line Mode**:(You specify the apk path and ndkpath)  

```B4X
.\leafy-check-16kb.ps1 -Path "C:\path\to\your\app.apk" -NdkPath "C:\Android\Sdk\ndk\27.0.0"
```

  
  
  
4. If you get Policy Execution error,RUN powershell in Administrator mode and enter this  

```B4X
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

  
  
  
![](https://www.b4x.com/android/forum/attachments/167640)  
  
<https://github.com/LEAFECODES/Check-16kb-page-size-for-filetypes>