### Feedback using Liberica JDK 11 for raspberry pi by Coldrestart
### 07/11/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/120065/)

Hello everyone.  
  
After spending some time to get a UI on my raspberry pi screen, here are my remarks, for who it can be useful:  
  
-Be careful when using only VNC to connect to your raspberry pi, when testing the javaFX lib, connect a screen on the HDMI port.  
(Yes there are libs that only show you app with a physical screen… :-s )  
  
-Use the same java version in B4J (Paths configuration in B4J), as on you device.  
  
-After testing the tutorial of Erel: <https://www.b4x.com/android/forum/threads/raspberry-pi-with-java-11.99606/#content>  
I have better results with a later version;  
[bellsoft-jdk11.0.7+10-linux-arm32-vfp-hflt-full.deb](https://github.com/bell-sw/Liberica/releases/download/11.0.7%2B10/bellsoft-jdk11.0.7+10-linux-arm32-vfp-hflt-full.deb)  
I use a raspberry pi 3, the cpu is an arm7, running Linux 8 "Jessie", with all the latest updates of today.  
  

```B4X
//Go to the standard location of your files, if you open the command prompt, normally you are there already  
$ cd /home/pi  
  
//Download the lib via the wget command  
$ wget LINK_TO_THE_LIBRARY  
  
//Install the debfile  
$ sudo dpkg -i THE_DEB_FILE_YOU_DOWNLOADED  
  
//Choose your default java version  
$ sudo update-alternatives –config javac  
$ sudo update-alternatives –config java  
  
//Check your active default java version  
$ java –version
```

  
  
The advantage to activate the java version as default, is that when you start your app or the bridge, you don't need to specify the location of the java version.  
$ sudo jdk-11/bin/java -jar b4j-bridge.jar  
becomes ->  
$ sudo java -jar b4j-bridge.jar  
  
Hopefully this post can help others to get a gui faster on a raspberry pi.  
Note that when you download the latest image of the Raspberry PI OS, from the raspberry website, you will get "Buster", that contains default openJDK11 already.  
  
Kind regards,  
Coldrestart.