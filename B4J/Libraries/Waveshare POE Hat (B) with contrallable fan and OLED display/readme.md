### Waveshare POE Hat (B) with contrallable fan and OLED display by sorex
### 11/15/2021
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/136054/)

Hello,  
  
A few weeks ago I bought a POE hat for my Raspberry Pi 3B+.  
  
For those who don't know what it is…  
  
It's just a way to power devices over UTP wires by either using a POE injector or POE switch.  
So you don't need an extra power socket near your device just an UTP cable.  
  
Here you'll have the official page about it:  
  
<https://www.waveshare.com/wiki/PoE_HAT_(B)>  
  
  
Attached you can find the code to get this working with B4J on a Pi.  
  
This includes controlling the fan and the mini OLED display where you can display a few things without the need to buy an extra display.  
  
  
The fan can be set to always on (EN) or to code controlled (P0) by using the mini switch on the board which you can see here at the top left of the board.  
![](https://www.b4x.com/android/forum/attachments/121721)  
In code controlled mode the temperature is checked every 5 seconds for a threshold if it hits that it will turn on the fan untill it goes below the threshold and swithes off again.  
You can change the timer setting in the FAN code module or recode it to your own needs.  
  
I also included a seperate display test program where you easily test some text printing or drawings by using [USER=17287]@madru[/USER] 's excellent oled lib which was slightly modified to work with this.  
  
Big thanks for that, Madru.  
  
![](https://www.b4x.com/android/forum/attachments/121724)  
  
Notice that to get this working you'll need to compile this with a java version 1.8.xxx so modify the JavaCompilerPath setting in the source to where your javac.exe file is.  
Also install 1.8 on the Pi.  
  
Connect the bridge, compile and you'll probably get an error when using another (open jdk) runtime on the pi because you need to run the bridge with that but that's ok.  
  
just open a console windows and use  
  

```B4X
cd tempjars/
```

  
  
then  
  

```B4X
java -jar AsyncInput1
```

  
  
or  
  

```B4X
java -jar AsyncInput2
```

  
  
(the digit switches when compiling to the pi) and it will work fine.