### Run jRDC2 as a service... by MrKim
### 10/29/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/135558/)

GET nssm.exe HERE: <https://nssm.cc/> and this is your source for all the details.  
I have found this to be very reliable on my plain vanilla windows 10 machine. (not even pro)  
I learned quite a bit making this work and thought I would share.  
Three batch files and jRDC2ASService-README.txt. **Make sure you read the txt file, there are number of gotchas** but here are some highlights.  
Right click run jRDC2ASService-Create.bat as administrator or it will fail.  
DO NOT Right click run jRDC2ASService-Remove.bat as administrator or it will fail (go figure).  
You need to edit all 3 batch files if the name of your service is not jRDC2 - the name can be anything you want and will be what displays in Windows services.  
**You MUST edit** jRDC2ASService-Create,bat - see the README for details.  
After creating the service you MUST Start it. (Windows Key - type 'Services' find your service and start it.)  
Before or after DELETING the service you must STOP it manually or it will not go away.  
  
I did this as batch files as opposed to the the GUI because we need to install this in a number of places.  
  
If you have questions post them here and I will try to help.