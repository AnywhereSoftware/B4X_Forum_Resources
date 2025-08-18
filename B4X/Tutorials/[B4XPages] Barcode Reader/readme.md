###  [B4XPages] Barcode Reader by Erel
### 07/12/2021
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/120417/)

![](https://www.b4x.com/android/forum/attachments/97444) ![](https://www.b4x.com/basic4android/images/i_view64_HkncBfNNKe.png)  
  
B4A + B4i barcode reader.  
  
Don't miss:  
  
- #PlistExtra in B4i.  
- Manifest code + #AdditionalJar in B4A  
  
Depends on BCToast: <https://www.b4x.com/android/forum/threads/b4x-bctoast-cross-platform-custom-toast-message.111046/#content>  
(BCToast will be an internal library in the near future)  
  
While the camera related code is platform specific, the main program logic can still be shared. In this case there isn't too much logic but in real usage the benefit of implementing it like this will be higher.  
  
Requires Android 5+.  
  
Supported formats:  
B4A - <https://developers.google.com/android/reference/com/google/android/gms/vision/barcode/Barcode#constant-summary>  
B4i - TYPE\_QR, TYPE\_UPCE, TYPE\_39, TYPE\_39Mod43, TYPE\_EAN13, TYPE\_EAN8, TYPE\_93, TYPE\_128, TYPE\_PDF417  
  
Updates:  
  
B4i iBarcode v1.21 - Adds support for setting the scan window: <https://www.b4x.com/android/forum/threads/ibarcode-library.47354/post-836360>