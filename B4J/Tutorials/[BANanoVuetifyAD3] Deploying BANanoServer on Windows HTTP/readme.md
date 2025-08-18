### [BANanoVuetifyAD3] Deploying BANanoServer on Windows HTTP by Mashiane
### 11/05/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/135766/)

Ola  
  
The BANanoVuetifyAD3 BANanoServer kitchen sink was updated yesterday to favour HTTPS connections. This tutorial is necessary due to that otherwise if you have the old version of BVAD3 BANanoServer, it will run without issues.  
  
**NB: Please note that you don't need the ABJSKStore for this process to work, however if you would want to change to HTTPS in the future, you might as well just get the resources, but again you can just comment the JSK code out on the Main Module.**  
  
Step 1: Follow the instructions on this post  
  
[HEADING=2]**<https://www.b4x.com/android/forum/threads/bananovuetifyad3-deploying-bananoserver-on-windows-https.135745/#post-858462>**[/HEADING]  
[HEADING=2][/HEADING]  
Step 2: After compiling the B4XLib from the BVAD3 Library source code, open the BVAD3Server project, open the BrowserIndex page and update like 143 to.  
  

```B4X
ws.Initialize("ws://" & BANano.Location.GetHost & "/ws/" & BANano.StaticFolder & "/index")
```

  
  
This was the original code from Alains BANano.zip download and was changed to be "wss" for the HTTPS connection.  
  
Step 3: In the Files Tab, open the config.properties file, and update it to  
  

```B4X
Host=http://localhost  
Port=55056  
PortSSL=0
```

  
  
Step 4: Save the file, run your project, you might have to do a HARD REFRESH on your browser to reflect new changes.  
  
![](https://www.b4x.com/android/forum/attachments/121271)  
  
This has been tested on Chrome, Edge and Brave.  
  
Ta!