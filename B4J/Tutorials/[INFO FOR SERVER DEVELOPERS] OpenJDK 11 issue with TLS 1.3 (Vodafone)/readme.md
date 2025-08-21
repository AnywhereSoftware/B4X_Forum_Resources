### [INFO FOR SERVER DEVELOPERS] OpenJDK 11 issue with TLS 1.3 (Vodafone) by nobbi59
### 06/05/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/118668/)

As I was developing a server application my client encountered problem when trying to connect to my server using cellular network. I wasnt able to find a solution for a whole week and I was near the point to say f\*ck it. So Im just informing anyone who may run into this issue.  
  
First: In my case the problem only exists for users that are using the ISP "Vodafone" on cellular network when trying to connect over HTTPS. Users get a timeout in Chrome browser and iOS says that its unable to create a secure connection after around 30 Seconds. It seems that its due to Vodafone breaking the SSL chain to filter illegal content (and pretty much performing a man in the middle attack?) and then "reproducing" the SSL encryption so you dont notice it. - I couldnt reproduce this error with any other ISP.  
  
The problem only exists in OpenJDK11. This seems to be a known issue but most users never have any problems (like me for over 1 year).  
  
To fix it, you should upgrade to atleast JDK 12. I upgraded to JDK14 on my server running ubuntu 18.04 - heres how to: <https://computingforgeeks.com/install-oracle-java-openjdk-14-on-ubuntu-debian-linux/>  
  
After the update everything is working fine.  
  
Where I found the fix: <https://webtide.com/openjdk-11-and-tls-1-3-issues/>