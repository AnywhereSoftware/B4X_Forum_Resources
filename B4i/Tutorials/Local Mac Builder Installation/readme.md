### Local Mac Builder Installation by Erel
### 11/04/2025
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/46402/)

iOS compilation requires an Apple Mac computer. Developers have two options with B4i:  
- Use a local Mac machine connected over the local network.  
- Use our hosted builder rental service.  
  
These instructions explain how to install the builder on a local Mac machine.  
  
1. Download OpenJDK 19.0.1: <https://jdk.java.net/archive/> (Mac/AArch64 for Arm based Mac or Mac/x64 for Intel based Mac).  
2. Install **Xcode 26** from the app store or**:** <https://developer.apple.com/download/all/?q=xcode+26>  
3. You need to run Xcode at least once. Approve installation of additional components when asked.  
4. Download and unzip the B4i-Builder.  
5. Open a terminal and navigate to B4i-Builder folder.  
6. Start it with:  

```B4X
<path to java>/jdk-19.0.1.jdk/Contents/Home/bin/java-jar B4iBuildServer.jar
```

  
7. Install Apple Configurator from the app store.  
8. Run Apple Configurator and select "Install Automation Tools" in the top left menu.  
9. Set the builder IP address in the IDE under Tools - Build Server - Server Settings  
10. You might be asked for a password during a build (codesign step). The password is 111111  
Click on the "Always allow" button. This will be fixed in the next update.  
  
**Notes & Tips  
  
-** By default ports numbers 51041 (http) and 51042 (https) are used.  
- The firewall should be either disabled or allow incoming connections on these two ports.  
- You can test that the server is running by going to the following link: [plain]http://<server ip>:51041/test[/plain]  
- You can kill the server with: [plain]http://<server ip>:51041/kill[/plain]  
- It is recommended to set your Mac server ip address to a static address. This can be done in your router settings or in the Mac under Network settings.  
- A single Mac builder can serve multiple developers as long as they are all connected to the same local network.  
  
  
**Troubleshooting**  
  
Check the "Test" page: <Mac ip>:51041/test