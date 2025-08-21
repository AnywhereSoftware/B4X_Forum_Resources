### JarCaller - Run and kill B4J jars by Erel
### 08/19/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/168284/)

This class provides two features:  
  
1. Running ui and non-ui B4J jars programmatically.  
2. Killing Java processes based on the jar name or the main class name.  
  
Both features are compatible with the host being built as a standalone package. This was not trivial to implement. jCore v10.31+ is required: <https://www.b4x.com/android/forum/threads/updates-to-internal-libaries.48274/post-1031509>  
  
Notes:  
- Tested on Windows only.  
  
Standalone package hosts:  
The target app runs with the custom image created for the host.  
1. Make sure to use a different package name for the target app. Better not one with the same prefix as the host.  
2. For most non-b4xlibs, you will need to include the library when compiling the host. Use the run\_debug.bat to find errors related to missing libraries.  
  
  
![](https://www.b4x.com/android/forum/attachments/166123)  
  
Updates:  
v2.00 - Adds support for UI apps.  
v1.01 - Powershell is only used if JPS isn't found (standalone packages). You can also copy jps.exe to the bin folder of the standalone package if needed.