### Raspberry PI - setup as WiFi Access Point and Client by Chris2
### 07/07/2020
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/119894/)

I've been working on a Rapsberry PI based device and wanted the PI to have a WiFi access point so I could run a server on it to allow configuration of the device through a web app.  
I also needed the PI to simultaneously connect to local WiFi &/or Ethernet for an internet connection.  
  
The attached script from <https://github.com/idev1/rpihotspot> did exactly what I needed and I thought it might be useful for others too.  
  
I have this working on a PI 3B+  
The only change I've made is at the lines marked with '#NOTE'. This change is specific to my application to block access to the WAN/LAN through the AP.  
  
Credit goes to Pankaj Shelare and the other contributors at the link above. It looks like the script is still being maintained also, so although I've attached a copy here I'd suggest getting the latest version from github.  
This is shared under the MIT license.