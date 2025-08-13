### GPS / GNSS tutorial by Erel
### 03/13/2025
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/6592/)

The GNSS library replaces the old GPS library. The GNSS library is available here: <https://www.b4x.com/android/forum/threads/gnss-library-an-updated-gps-library.109110/#content>  
  
  
![](https://www.b4x.com/android/forum/attachments/162530)  
  
Using it is quite simple:  
1. Checking whether location services are available. If not take the user to the settings.  
2. Request permission.  
  
If the purpose is to get the user location then the FusedLocationProvider might be a better option: <https://www.b4x.com/android/forum/threads/fusedlocationprovider-resolution-dialog.111652/#content>