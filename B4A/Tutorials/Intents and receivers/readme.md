### Intents and receivers by Star-Dust
### 02/02/2023
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/145857/)

With the new imodules that allow you to work better with the **intent** and **receivers**, it is necessary to develop some examples of how to use them (even before it could be done but not in such a direct way).  
  
**SOME DETAILS**  
This B4A update handles static receivers not dynamic ones. Some intents no longer raise static receivers such as CONNECTIVITY\_CHANGE which due to the restrictions applied by Android 7+ need to be registered with dynamic receivers by code *(see [**here**](https://www.b4x.com/android/forum/threads/broadcastreceiver.12493/) for dynamics receivers)*  
Receivers can be raised by the OS listening to the intent or directly by an App calling the intent directly  
  

---

  
**SAMPLE: LISTEN USB PORT**   
I start with an example that through the use intent it is possible to 'hear' when a usb device is connected. In this case it is the operating system that manages the intents. Remember to place the filter XML file in the object/res/xml folder as it is in the example (You can customize the filter if you want)  
In this example, you can scan the USB port and see what devices are connected.  
Or wait for each time a device is connected to call the intent that updates the list and plays a warning sound together with a ToastMessage