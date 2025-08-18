### Google Push notification over ipv6 by hatzisn
### 01/14/2022
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/137613/)

Yesterday I have found out something searching in Google and checking it, it seems that it worked for me (until ipv4 is deprecated). So this is by 50% a tutorial and by 50% a request for other B4Xers to check it. The thing that I have found out is that when your server communicates with Google for push notification by ipv6 there are delays (and sometimes failures - in my case at least) in the delivery of a Push notification. If you have private access to your server then remove the ipv6 capabilities and check if it works. To do this follow what is described bellow:  
  
**Windows**  
1. In the Windows Start Menu search for "Settings" and open it  
2. Go to "Network & Internet"  
3. Click on "Change adapter options"  
4. Right-click on your Network Interface and click "Properties"  
5. Uncheck option "Internet Protocol Version 6 (TCP/IPv6)" and press OK  
![](https://help.3cx.com/api/v1/attachments/9161)  
6. Reboot your Server  
7. After your Server boots back up, open a Command Line and run the command "ipconfig" and make sure that an IPv6 IP is no longer present.  
  
**Linux**  
1. Log in via SSH to you Linux machine and switch to 'root' user  
2. Edit the following file: nano /etc/sysctl.conf  
3. At the end of the file,add the following line:  
net.ipv6.conf.all.disable\_ipv6 = 1  
![](https://help.3cx.com/api/v1/attachments/9162)  
4. To save the file press Ctrl + X and then 'Y', followed by Enter to save the file  
5. Run command: sysctl -p  
6. Reboot your Server  
7. After your Server boots back up, log back in and run command: ip a  
8. Make sure that your Network Interface does not have an IPv6 IP