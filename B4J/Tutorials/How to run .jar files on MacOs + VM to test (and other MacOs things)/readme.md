### How to run .jar files on MacOs + VM to test (and other MacOs things) by jmon
### 07/20/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/132736/)

Hi,  
  
I had to make my application (PostChat) available on MacOs. I had no problems porting the app to Linux, but I found the port to MacOs very annoying, and had lots of issues. So I'm posting here what worked for me.  
  
  
**1) Creating a MacOs Virtual Machine:**  
This was quite straight forward, I followed this tutorial:  
<https://macosvmware.tech.blog/>  
  
To make the VMWare work with B4j-Bridge, I had to change the network adapter to **"Bridged"**. This way, the VMWare and your computer have different IP addresses, and you can connect B4j-bridge.  
  
  
  
**2) Installing B4j-Bridge:**  
Download B4j-bridge:  
[Remote debugging with B4J-Bridge | B4X Programming Forum](https://www.b4x.com/android/forum/threads/remote-debugging-with-b4j-bridge.38804/)   
  
  
  
**3) Installing a version of Java that includes JavaFX.**  
This is the part that took me the most time. To run b4j-bridge jar file, we need to find a version of Java that includes Javafx, that simplifies a lot the command line / terminal (like [this](https://www.b4x.com/android/forum/threads/how-to-execute-jar-file-with-java-11-javafx-components-missing.109247/) and didn't work for me on macOs but was working on Linux)  
I found that this package includes Java & JavaFX in a single installer:  
[Java Download | Java 8, Java 11, Java 13 - Linux, Windows & macOS (azul.com)](https://www.azul.com/downloads/?version=java-11-lts&os=macos&package=jdk-fx)  
  
Make sure you select the Java package **"JDK FX"** for MacOS:  
  
![](https://www.b4x.com/android/forum/attachments/116722)  
  
  
  
  
  
**4) Install Azul JDK FX package**  
I downloaded as .DMG package, and run the installation with default parameters.  
  
  
  
**5) Run B4j-Bridge**  
B4j-Bridge can now be run either as double-click on the jar, or with this command in the terminal:  

```B4X
java -jar b4j-bridge.jar
```

  
  
  
  
**Note with double-clicking the JAR files (i.e. with B4j-Bridge or your app):**  
If you run b4j-bridge with a double-click, an error will pop-up:  
  
![](https://www.b4x.com/android/forum/attachments/116723)  
  
The application is locked. You need to go to the System preferences / Security & Privacy / Open Anyway  
  
![](https://www.b4x.com/android/forum/attachments/116724)  
  
![](https://www.b4x.com/android/forum/attachments/116725)  
  
  
  
**Note regarding the home Folder:**  
If you want to go to your documents directory (for example) the tilde sign "~" doesn't work in B4j.  
It doesn't work as in the terminal:  

```B4X
Dim DOCUMENTS_PATH_MACOS As String = "~/Documents/"
```

  
use this instead:  

```B4X
Dim DOCUMENTS_PATH_MACOS As String = GetSystemProperty("user.home", "") & "/Documents/"
```