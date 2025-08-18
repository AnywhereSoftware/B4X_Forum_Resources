### Retrieve the Apple device UDID from Windows by Star-Dust
### 07/24/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/132824/)

Finding the UDID of your iPhone or iPad can sometimes prove to be a challenge. Some software enters the certificates and allows you to see the UDID code, but sometimes they don't work if the certificates have expired and in other cases the App is suspended.  
(Here are some addresses that allow or allow UDID retrieval: <https://www.getudid.io/> or <https://webapp.diawi.com>)  
  
**So how do you go about it?**  
When you connect an Apple device to a Windows PC with the USB port, Windows creates a Registry Key with the device's UDID and can then be retrieved.  
But to avoid reading the entire log, I created a small app that retrieves all the UDIDs present in the system registry.  
  
  
Steps:  
1. Plug Apple device into USB port  
2. Unlock the device and have it recognized by Windows  
3. After recognition, disconnect it  
4. Start the B4J App and … *et voilà  
  
![](https://www.b4x.com/android/forum/attachments/116917)*