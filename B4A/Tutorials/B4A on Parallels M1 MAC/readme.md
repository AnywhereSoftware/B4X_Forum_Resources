### B4A on Parallels M1 MAC by Robert Zmrzli
### 04/20/2021
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/129912/)

B4A works fine in Parallels windows on M1 MAC.  
Here are compilation times for same, fairly large project:  
Could Erel comment on significant differences in time execution of various parts.  
In particular:  
M1 MAC: Building folders structure. (11.50s) Convert byte code - optimized dex. (25.41s)  
PC: Building folders structure. (0.66s). Convert byte code - optimized dex. (3.54s)  
  
Same project was opened from Synology Diskstation over network…  
  
On Mac:  
B4A Version: 10.70  
Parsing code. (0.51s)  
 Java Version: 11  
Building folders structure. (11.50s)  
Compiling code. (10.83s)  
Compiling layouts code. (3.30s)  
Organizing libraries. (0.00s)  
 (AndroidX SDK)  
Running custom action. (1.06s)  
Compiling resources (1.80s)  
Linking resources (5.27s)  
Compiling debugger engine code. (2.10s)  
Compiling generated Java code. (1.40s)  
Convert byte code - optimized dex. (25.41s)  
Copying libraries resources (2.55s)  
ZipAlign file. (0.58s)  
Signing package file (debug key). (1.92s)  
Installing file to device.  
  
On PC:  
B4A Version: 10.70  
Parsing code. (0.61s)  
 Java Version: 8  
Building folders structure. (0.66s)  
Compiling code. (3.27s)  
Compiling layouts code. (0.19s)  
Organizing libraries. (0.00s)  
 (AndroidX SDK)  
Running custom action. (0.59s)  
Compiling resources (6.16s)  
Linking resources (3.48s)  
Compiling debugger engine code. (8.05s)  
Compiling generated Java code. (10.23s)  
Convert byte code - optimized dex. (3.54s)  
Copying libraries resources (1.74s)  
ZipAlign file. (1.10s)  
Signing package file (debug key). (3.26s)  
Installing file to device. Error  
No device found.