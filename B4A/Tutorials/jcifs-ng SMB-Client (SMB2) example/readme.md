### jcifs-ng SMB-Client (SMB2) example by MrKim
### 04/10/2025
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/166535/)

**Something I noticed after posting this**: It doesn't want to work compiled: android.os.NetworkOnMainThreadException  
you need to use threading or this workaround<https://www.b4x.com/android/forum/threads/workaround-the-networkonmainthread-exception.44760/#content>.  
Which I have been using for years with no issues on DEDICATED tablets (tablets dedicated to my app).  
Thanks again to [USER=42649]@DonManfred[/USER] for this lib: <https://www.b4x.com/android/forum/threads/jcifs-ng-smb-client-smb2.104560/> as a dumb database programmer just trying to get things done I am always in awe of the people who actually understand what is going on in the background.  
  
After the usual monkeys and typewriters work I got it do do what I need so that is where I stop. I hope this can help someone.  
  
This is an extension of Don Manfred's example The code is crap but it does work. It uses his original code to list the dir specified and if you select a picture file from the list, it will display it locally then copy it back to windows under a different name in the same directory it came from.  
![](https://www.b4x.com/android/forum/attachments/163300)  
**Not tested with a domain**.  
The one gotcha that threw me is MAKE SURE you include the last "/" on the dir. If you leave it off on the listfiles it will happily return the correct list but concatenate the last dir with the file name - no error. When copying to windows if you leave off the last "/" it it put the file UP one dir with, again, the filename concatenated to the last dir. Again no error.  
Properties for the desired directory are set as below:  
![](https://www.b4x.com/android/forum/attachments/163299)