### Ethernet ENC28J60 solution by Nator
### 10/10/2022
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/143429/)

Hello Guys, after a lot of searching to make the ENC28J60 Ethernet module work from arduino or with esp8266, I have discovered a library , which takes advantage of the rEthernet library that is only designed for W5X00  
once you install the library in arduino ide you should go to the rEthernet.xml file and change Ethernet.h to  

```B4X
 <dependsOn>&lt;EthernetENC.h&gt;</dependsOn>
```

and that's all it should work perfect.  
according to the author it worked well with esp8266 nodemcu I still haven't tried it  
  
[Esquema Arduino ENC28J60](https://www.luisllamas.es/wp-content/uploads/2017/05/arduino-ethernet-ENC28J60-esquema.png)  
[EthernetENC](https://github.com/JAndrassy/EthernetENC)