### Ngrok and B4J Servers by icakinser
### 05/10/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/117542/)

[SIZE=6]**Introduction to Ngrok**[/SIZE]  
This works because Ngrok is calling outbound, and meeting its other side on the internet.  
  
[ngrok](https://ngrok.com/) is an application that gives you external (internet) access to your private systems that are hidden behind NAT or a firewall. It’s basically a super slick, encrypted TCP tunnel that provides an internet-accessible address that anyone can get to, and then links the other side of that tunnel to functionality running local.  
  
Here’s what it does:  
  

1. You run ngrok from a local system with a service you want to make available to people on the internet
2. Just run the command and give it the protocol you want to use, along with the local port it’s listening on
3. Ngrok then creates an address in the cloud that people can get to
4. It then connects those two things over an encrypted tunnel, so when you hit the Internet address, you land on your local service automagically!

Just because hackers use something doesn’t make it automatically malicious.  
  
Two of the examples they give on the site include: 1) public URLs for sending previews to clients, and 2) demoing local functionality with external people.  
  
Ngrok simplifies what used to require lots of trickery, usually involving SSH.  
  
The other cool thing about Ngrok is that it allows you to see the HTTP traffic that’s being tunneled over it via a separate interface, which is by default hosted on <http://127.0.0.1:4040>. This especially helps the normies that are using it legitimately for testing and troubleshooting (?).  
  
I have tested this on my Mac, PC, and a RaspberryPie Zero W and it works great! The only downside is the free version changes the public URL to a random node each time its restarted.