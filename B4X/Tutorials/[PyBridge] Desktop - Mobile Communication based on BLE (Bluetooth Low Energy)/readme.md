###  [PyBridge] Desktop - Mobile Communication based on BLE (Bluetooth Low Energy) by Erel
### 03/09/2025
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/166028/)

I've posted in the past a few examples of a simple chat app based on BLE: <https://www.b4x.com/android/forum/threads/ble-chat-connecting-android-and-ios.66543/#content>  
A new version of this example is attached and B4J is now joining the party 🥳  
  
B4J, using the [Bleak library](https://www.b4x.com/android/forum/threads/pybridge-bleak-bluetooth-ble.165982), implements the central role and B4A or B4i implement the peripheral role. For simplicity the central connects to a single peripheral each time.  
  
Such solution can be useful in places where there is no wifi network, though the bandwidth is quite minimal.  
  
![](https://www.b4x.com/android/forum/attachments/162377) ![](https://www.b4x.com/android/forum/attachments/162378) ![](https://www.b4x.com/android/forum/attachments/162379)  
  
Make sure to use latest version of Bleak: <https://www.b4x.com/android/forum/threads/pybridge-bleak-bluetooth-ble.165982>  
And B4J v10.2 beta #4+  
  
For B4A and B4i, you also need to update to latest version of XUI Views: <https://www.b4x.com/android/forum/threads/b4x-xui-views-cross-platform-views-and-dialogs.100836/#content> (the example uses the new cross platform ProgressDialog).