### controlling the build in RGB led on the ESP32-S3 Wroom dev board by MbedAndroid
### 11/26/2024
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/164299/)

on the esp32-s3 WROOM there is an rgb led.   
The Chineese clones like this: <https://nl.aliexpress.com/item/1005005051294262.html?spm=a2g0o.order_list.order_list_main.32.47d279d2bBQCyh&gatewayAdapt=glo2nld>  
  
This led cannot be controlled with the neopixel lib (crashes).   
In arduino there is an example code ESP32->GPIO->rgbled which uses the function **rgbLedWrite(RGB\_BUILTIN,red,green,blue);**  
With build in C#, this function can be called.  
Example:  

```B4X
#if C  
void rgbled (B4R::Object* o) {  
    int    red=b4r_main::_red;  
    int    green=b4r_main::_green;  
    int    blue=b4r_main::_blue;  
    rgbLedWrite(RGB_BUILTIN,red,green,blue);  
}  
#End if
```

  
example to call:  

```B4X
    red=255  
    green=0  
    blue=0  
    RunNative("rgbled",Null)
```

  
—>do not forget to solder the pad close to the RGB LED (gpio48) There is a small solder pad connection next to it labelled RGB, you need to bridge the pads with solder. It will then be connected to either pin 38 or 48 depending on which version of the board you have.