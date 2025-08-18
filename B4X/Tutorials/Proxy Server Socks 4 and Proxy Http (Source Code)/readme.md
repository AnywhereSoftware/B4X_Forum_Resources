###  Proxy Server Socks 4 and Proxy Http (Source Code) by Star-Dust
### 06/16/2021
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/131629/)

Many years ago I needed to sniff a connection and I didn't have a free sniffer available and I didn't know how to create one …. So after a long reflection I decided to create a Proxy Server in order to direct all the output of my pc to the server and sniff traffic.  
It was my first proxy server made in VB6. This was the beginning of the development of a series of Applications for the network … Alternative Clients (at the time there was MSN Messenger) etc …  
  
Today I wanted to recreate the Socks4 proxy server in B4X. Please find attached a simplified version that works.  
With this example you can spy on traffic or actually use it as a proxy server. It is also possible to modify the traffic or inject other data in order to alter it …. well the possibilities are many, it's up to your imagination.  
  
Don't forget to set up the proxy on your PC, in this way:  
![](https://www.b4x.com/android/forum/attachments/114928) ![](https://www.b4x.com/android/forum/attachments/114929) ![](https://www.b4x.com/android/forum/attachments/114922)  
  
**Attention** it also works for B4A and B4i but set an accessible port for mobile devices (for example 51051)  
For convenience I am ignoring the authentication that many proxy servers do not exist.  
the Socks4 protocol provides only the management of the TCP connection while the sock5 also UDP