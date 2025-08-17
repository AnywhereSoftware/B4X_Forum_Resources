### Pi4j for pi5 by MbedAndroid
### 02/23/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/165774/)

I recently bought a Pi5, not knowing that the GPIO is different (it uses a different chip), and so the existing Pi4J v2 and Pi4J v2b wrappers no longer work. This is all described on the Pi4J site:  
🔗 [Pi4J Documentation – Providers](https://www.pi4j.com/documentation/providers/)  
The Pi4J v2 wrappers are based on the **PiGpio** providers, which do not work on the Pi5.  
For GPIO, you need the new **GpioD** provider, but there is no SPI support. According to the documentation, you can use **LinuxFS** for I2C.  
I created a wrapper that works for GPIO, but I stopped development because the Pi5 is not useful for me. It is better to buy a Pi4 or Pi3 if you use the Gpio.  
  
I have attached the wrapper, both compiled and as source code in Java. It might be useful for someone else.  
  

```B4X
Sub AppStart ( Args() As String)  
    jo.InitializeStatic("Pi4JWrapper")  
    ' GPIO 17 als output instellen  
    Dim output As JavaObject = jo.RunMethod("createOutput", Array(4, False))  
    ' Zet GPIO 17 HIGH (aan)  
    output.RunMethod("high", Null)  
    output.RunMethod("low", Null)
```

  
  
compile with:  
sudo jdk11/bin/javac -cp Pi4JWrapper.java   
jar cf Pi4JWrapper.jar Pi4JWrapper.class  
  
**Note:** You need to download and install the new **Pi4J libraries (version >2.5)** on your Pi. The latest available version is **2.85**.