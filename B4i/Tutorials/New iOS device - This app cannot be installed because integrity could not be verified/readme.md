### New iOS device - This app cannot be installed because integrity could not be verified by Erel
### 12/01/2022
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/144525/)

I've just wasted a bit more time than expected, installing B4i-Bridge on a new iPhone.  
  
A few tips:  
1. Enable developer mode: Settings - Privacy & Security - scroll down - Developer Mode  
2. Don't forget to add the new device UDID to the list of devices on your Apple account, create a new provision profile and download it.  
3. You need to use a wildcard app id when building the bridge.  
4. I don't have a good explanation for this but when I first ran B4i-Bridge the IDE couldn't connect to the ip address. The device wasn't reachable over the network. Turning off and on wifi solved it.