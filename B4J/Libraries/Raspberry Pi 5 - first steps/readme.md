### Raspberry Pi 5 - first steps by Erel
### 03/10/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/166049/)

Getting the RPi 5 to work with B4J is very simple.  
  
I've tested it with the recommended 64 bit Raspbian OS (bookworm).  
  
1. Download and unpack the Linux ARM Full JDK (21): <https://download.bell-sw.com/java/21.0.6+10/bellsoft-jdk21.0.6+10-linux-aarch64-full.tar.gz>  
2. Download B4J-Bridge  

```B4X
wget www.b4x.com/b4j/files/b4j-bridge.jar
```

  
3. Run b4j-bridge:  

```B4X
jdk-21.0.6-full/bin/java -jar b4j-bridge.jar
```

  
  
I also recommend enabling RPi-Connect, which allows opening a remote session through the browser. The apps appear properly, and not full screen like in older versions.  
  
  
![](https://www.b4x.com/android/forum/attachments/162423)