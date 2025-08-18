### Setting a dynamic address IP in namecheap. Program + source by MichalK73
### 08/24/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/133702/)

Hello.  
[Namecheap.com](http://Namecheap.com) is probably known to many as a domain provider. You can buy an interesting domain for our project for pennies. Some time ago I put my own small OpenMediaValue server on the old equipment at home and I needed to connect to the domain to be visible on the Internet. Namecheap has a dynamic IP address assignment service. They have their client for Windows. I needed it for Linux. Originally I wrote in Python and now I have converted to B4J.  
The package includes a ready compiled program and sources as if someone would like to change something for themselves. In Cron Linux I set myself to run a program from time to time that would set my home IP address to my domain.  
In the package there is a small 'token' file in which we enter our own data:  

```B4X
password=your_password_for_domain  
domain=mydomain.com  
host=@
```

  
In addition, I share what the namechep panel looks like and what to set up to make it work.  
It is also known that everyone on their own must set up a redirection on their own router from the outside to the given IP address of their server inside the network.  
The condition is that your ISP provides you with an external ip address.  
  
![](https://www.b4x.com/android/forum/attachments/118203) ![](https://www.b4x.com/android/forum/attachments/118204) ![](https://www.b4x.com/android/forum/attachments/118205)  
  
  
[Link to the program package + sources](https://michal.cloudtb.online/namecheap/dynamicip.zip)  
Compiled in JAVA11