### [BANAno] Debugging your SPA-PWA on an Actual Device: Android Phones by Mashiane
### 10/30/2019
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/110915/)

Ola  
  
I recently had an issue. My app was working perfectly on the desktop and any other device except the mobile devices.  
  
Using google chrome i found this extension named **Inspect Devices**  
  
<https://chrome.google.com/webstore/detail/inspect-devices/pjpobmgdbnbegggcdgbljfgplleejmkb?hl=en>  
  
![](https://www.b4x.com/android/forum/attachments/85004)   
  
To see this working **on android devices**  
  
1. Go to device settings and activate developer mode.  
2. Turn on usb debugging.  
3. Install the above extension on Google Chrome  
4. Connect your device via USB  
5. Click Inspect Devices extension  
6. Accept the security prompt on your phone.  
7. Open the URL on your device that you wish to debug/test  
  
If all goes well now you should be seeing a screen like this…  
  
![](https://www.b4x.com/android/forum/attachments/85005)   
  
This is listing all the open tabs on my device in the google browser. You need to select the tab you need to inspect. To do so click "Inspect" under the tab you need.  
  
To demo this I will open the B4X page on my listing above..  
  
![](https://www.b4x.com/android/forum/attachments/85006)   
  
Now on the right section of the screen you can click 'Console' and see whatever is happening on the device console and then be able to debug your app.  
  
So what really happened?  
  
1. My app used php and on the desktop everything worked fine  
2. On my device each time I clicked the login button, it didnt fire at all. So Im facing a dilemna, the app works on the PC but not on the device. WT??  
3. Anyway this helped me find where the issue was. PHP was not loading on the device. Reason was:  
  

```B4X
BANano.PHPHost = $"http://localhost/${AppName}/"$
```

  
  
**NB: NEVER EVER USE localhost there. Why? You are going to get a connection refused error on mobile devices whilst your PC will work well.**  
  
As soon as I changed this to the IP address / Name of my server, the code on my device worked.  
  
I then remembered that in one of the tuts I did I mentioned this fact. I forgot, ha ha ha. Anyway that forgetting helped me find this "Inspect Devices" jewel.  
  
Happy Coding.