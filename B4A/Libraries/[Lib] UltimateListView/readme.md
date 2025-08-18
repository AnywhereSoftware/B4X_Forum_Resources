### [Lib] UltimateListView by Informatix
### 05/04/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/22736/)

I've been working on this project for a long time and I'm very proud to release the version 4 today.  
  
The UltimateListView is, as its pompous name says, THE ListView.  
  

- It can handle very long lists. This is a screenshot of a list with 245813 items, all different:
![](https://www.b4x.com/android/forum/attachments/18467)- It can mix different layouts (and they can be changed dynamically). You can use it as an expandable ListView:
![](https://www.b4x.com/android/forum/attachments/14357)- It has a low memory footprint and is very fast (this report comes from the Performance demo where the list has to display 128901 distinct words read from a database and the used device is a Huawei Honor single core 1.4 Ghz):
![](https://www.b4x.com/android/forum/attachments/21236)- It can scroll in both directions thanks to its swipe detector:
![](https://www.b4x.com/android/forum/attachments/14361)- The swipe detector can also be used to implement a swipe-to-dismiss or a swipe-to-reveal:
![](https://www.b4x.com/android/forum/attachments/21240)- You can easily add editors to your table to change its content:
![](https://www.b4x.com/android/forum/attachments/14356)- You can animate the items when they are added, removed, replaced or when the list is scrolled (with your own custom animation):
![](https://www.b4x.com/android/forum/attachments/21238)- It can stack items from the bottom:
![](https://www.b4x.com/android/forum/attachments/16150)- It supports drag & drop operations (internal & external):
![](https://www.b4x.com/android/forum/attachments/21235)- You can synchronize lists with different item heights:
![](https://www.b4x.com/android/forum/attachments/50630)
The examples will show you how to implement a Pull-to-Refresh, create sticky headers or combine several lists to make a wheel. One of the examples is an improved version of my File Explorer class.  
  
All texts and images can be loaded asynchronously (from Internet, from a database or from a local folder), so you can scroll even if the data are not fully loaded.  
  
The list has its own state manager.  
  
**Since September 2018, ULV is available for free. You can still donate for it if you wish.**  
To send the money, just click on the Donate button below (the amount to enter is in euros):  
[![](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=UX9WAWBVPGCUQ&lc=US&item_name=Fr%c3%a9d%c3%a9ric%20Leneuf%2dMagaud&currency_code=EUR&bn=PP%2dDonationsBF%3abtn_donateCC_LG%2egif%3aNonHosted)  
  
Note that UltimateListView is not a wrapper around the work of someone else. It is 100% my own code and it is based upon the standard Java ListView of Android.  
  
*The UltimateListView does not work with Android versions < 2. **It cannot work with B4J or B4i.***  
  
**Current version: 4.50  
  
**DOWNLOAD HERE:**  
**[MEDIA=googledrive]1PwEKYcNAf4u3Y5vdFrp\_odynP0yxLKlj[/MEDIA]****