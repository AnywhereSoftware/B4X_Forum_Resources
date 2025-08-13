### Local Mac Builder Installation by Erel
### 09/05/2023
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/46402/)

**Edit: Apple Configurator 2 must be used when using a local Mac:** <https://www.b4x.com/android/forum/threads/installing-apps-with-apple-configurator-2.128397/#content>  
  
iOS compilation requires an Apple Mac computer. Developers have two options with B4i:  
- Use a local Mac machine connected over the local network.  
- Use our hosted builder rental service.  
  
These instructions explain how to install the builder on a local Mac machine.  
  
1. Install Java JDK 8: <http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html>  
OpenJDK 11+ is also good (link is available here: <https://www.b4x.com/android/forum/threads/b4jpackager11-the-simplest-way-to-distribute-ui-apps.99835/#content>)  
  
2. Install **Xcode 14:** <https://developer.apple.com/download/all/?q=xcode+14>  
  
2.5. You need to run Xcode at least once. Approve installation of additional components when asked.  
3. Download and unzip the B4i-Builder.  
4. Open a terminal and navigate to B4i-Builder folder.  
5. Run it with: java -jar B4iBuildServer.jar  
6. Set the builder IP address in the IDE under Tools - Build Server - Server Settings  
7. Install Apple configurator 2: <https://www.b4x.com/android/forum/threads/installing-apps-with-apple-configurator-2.128397/#content>  
**It is not possible to make an over the air installation with the local builder.**  
8. You might be asked for a password during a build (codesign step). The password is 111111  
  
**Notes & Tips  
  
-** By default ports numbers 51041 (http) and 51042 (https) are used.  
- The firewall should be either disabled or allow incoming connections on these two ports.  
- You can test that the server is running by going to the following link: [plain]http://<server ip>:51041/test[/plain]  
- You can kill the server with: [plain]http://<server ip>:51041/kill[/plain]  
- It is recommended to set your Mac server ip address to a static address. This can be done in your router settings or in the Mac under Network settings.  
- A single Mac builder can serve multiple developers as long as they are all connected to the same local network. Note that you are not allowed to host builders for developers outside of your organization.  
  
  
**Troubleshooting**  
  
BuildServer v1.02 includes a new test page which provides information about the server, including the SSL key ip address and the libraries versions.  
You can access this page with: <Mac ip>:51041/test