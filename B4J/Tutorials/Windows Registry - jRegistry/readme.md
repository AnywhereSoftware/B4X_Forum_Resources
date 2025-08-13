### Windows Registry - jRegistry by tchart
### 04/27/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/147602/)

This is a very quick wrap of the Windows registry library SimpleRegistry  
  
<https://github.com/RalleYTN/SimpleRegistry>  
  
I needed to extract a registry value on Windows. I looked at many libraries and code samples on the forum and out on the internet. Unfortunately WIndows Registry and Java dont seem to work well together and the only options using pure Java seem to use one of the following options;  
  
1. Use reflection and setting of "preference" private methods to public - these dont appear to work in Java 11+  
2. Use JNI to call Windows DLLs - a bit "clunky" and unreliable  
3. Calling the "reg" console app - although not ideal this approach seemed the best  
  
After testing the various libraries and not having any luck I settled on #3 with the SimpleRegistry library. The authors apoproach is simple yet effective.  
  
I realise I could have written my own code to use jShell to call the "reg" console app but it was much quicker to simply compile SimpleRegistry using SLC and make it B4J compatible.  
  
NOTE I have not tested every method and some methods return native types instead of B4J types eg the RegistryKey Values method needs to be cast as a list to iterate.  
  
NOTE You will get access denied if you are trying to set values in HKEY\_LOCAL\_MACHINE unless you are running as admin.  
  
Really quick example to read a registry key;  
  

```B4X
Dim reg As jRegistry  
reg.Initialize  
FME_SERVER_HOME = reg.getValue("HKEY_LOCAL_MACHINE\SOFTWARE\Safe Software Inc.\Feature Manipulation Engine","FME_SERVER_HOME").As(RegistryValue).Value
```

  
  
Another example, list all values under a key.  
  

```B4X
Dim reg As jRegistry  
reg.Initialize  
  
Dim rk As RegistryKey = reg.getKey("HKEY_LOCAL_MACHINE\SOFTWARE\ESRI\ArcGISPro")  
   
For Each v As RegistryValue In rk.Values.As(List)  
    Log(v.Name)  
    Log(v.Value)  
Next
```

  
  
Create new key and set value  
  

```B4X
Dim reg As jRegistry  
reg.Initialize  
reg.setValue("HKEY_CURRENT_USER\SOFTWARE\Peppe","Version",reg.REG_SZ,"","1.2.3")
```