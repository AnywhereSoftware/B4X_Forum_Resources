### DoSFilter Request Timeout by Erel
### 04/27/2020
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/70426/)

The DoSFilter helps with protection against denial of service attacks. It has various configuration options which are listed here: <https://www.eclipse.org/jetty/documentation/current/dos-filter.html>  
  
I was investigating a timeout issue with B4i OTA tool: <https://www.b4x.com/android/forum/threads/tool-ota-deployer-easily-distribute-your-app-to-beta-testers.61672/#content>  
  
Took me a while to understand that it is the DoSFilter that is responsible for closing the connection after 30 seconds.  
  
Setting the timeout to a different value:  

```B4X
srvr.AddDoSFilter("/*", CreateMap("maxRequestMs": 5 * 60 * 1000)) '5 minutes
```

  
  
Tags: server, DosFilter, timeout, InterruptedException