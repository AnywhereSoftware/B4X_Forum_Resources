### Magnetics Library by derez
### 12/20/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/16661/)

Magnetics calculates the magnetic variation, inclination and grid variation (the last for lat > 55 deg or < -55 deg).  
  
The WMMC.COF file is good for 5 years, the attached one is up to 2022. Hence you should put it in File.DirRootExternal & "/Magnetics", so the user will be able to replace it.  
  
Edit: Version 1.1 enables the developer to select where to store the WMMC.COF file. The initialization method includes the directory as a parameter.  
File.DirAssets cannot be supplied there. You must copy the file from there to another directory, for example:  

```B4X
File.Copy(File.DirAssets,"WMMC.COF",File.DirInternal,"WMMC.COF")  
mg.initialize(File.DirInternal)
```

  
  
Edit: The file WMMC.COF has been updated, I attach the new file here (open the zip). It is valid until 2022 ! The library files do not change.  
EDIT: A new WMMC.COF file is attached, valid until end of 2024. unzip and copy the WMMC.COF file.  
  
Edit: Updated to ver 1.2  
Edit: Uploaded ver 1.3, bug correction.  
  
Edit : WMMC.COF file replaced with a new file for 2025-2030