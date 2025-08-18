### ESP8266 yield() function by hatzisn
### 07/14/2021
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/132566/)

If it might have occured also to you to get a "Soft WDT Reset" error in an ESP8266 project then here is why this had happened and how to correct it:  
  
ESP8266 runs several background tasks that check the state of the integrated circuit (f.e. maintain WiFi connection and other stuff) and has two watchdogs one software based and one hardware based that want to give priority to the state checking. For more information please check this URL:  
<https://arduino-esp8266.readthedocs.io/en/latest/faq/a02-my-esp-crashes.html>  
  
In order to avoid triggering the WDT errors you will need to interrupt slightly (and repeatedly in each loop) long running procedures either with a **Delay(1)** command or with the **yield()** function.  
I have not found this function in the B4R available commands so I created an InLine function that can be called this way:  
  
  

```B4X
RunNative("yld", Null)  
  
#if C  
void yld(B4R::Object* o){  
    yield();  
}  
#End If
```