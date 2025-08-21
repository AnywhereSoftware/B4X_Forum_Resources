### Using the second core on an ESP32 by Tron71
### 06/03/2020
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/118614/)

Get the most out of the ESP32 by running code in Core 0 as well as the default Core 1.   
  
Arduino runs all code in Core 1 and Core 0 is left idle. Use this code to utilize Core 0. Not sure how stable this is but its hasn't given me any trouble yet!  
  

```B4X
'Sample code to use the second core of an ESP32 from within B4R. B4R code will run in Core 1 and in this example some code can be forced to run in Core 0.  
'Created May 2020 - Tron71  
  
#Region Project Attributes  
    #AutoFlushLogs: True  
    #CheckArrayBounds: True  
    #StackBufferSize: 1200  
#End Region  
  
Sub Process_Globals  
    Public Serial1 As Serial  
  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("Dual Core Sample AppStart")  
      
    RunNative("setup", Null)  
    RunNative("CheckCore", Null)  
    Delay(500)  
    RunNative("CoreZeroSetup", Null)  
    Dim x As Int = 0  
      
    For x = 0 To 255  
        Log("Loop running on core 1 - ", x , " times")  
        Delay(650)  
    Next  
      
End Sub  
  
  
#if C  
  
TaskHandle_t RunInCore0;        //Create a Task handle  
  
void setup(B4R::Object* o) {  
    Serial.begin(115200);  
  
}  
  
void CoreZero( void * pvParameters ){  
      Serial.print("This code is running on core ");  
      Serial.println(xPortGetCoreID());                     //Returns the core used  
      
      // Code placed here will be run in Core 0. All other code will be run in Core 1  
      
    for (int i = 0; i <= 255; i++) {  
    Serial.print("Loop running on core 0 - ");  
    Serial.print(i);  
    Serial.print(" times \n");  
    delay(350);  
     }  
      
  vTaskDelete(NULL); //Kill the task when finished unless you are running a continuous loop. Tasks cannot return!  
}  
  
void CoreZeroSetup(B4R::Object* o) {  
    //create a task that will be executed in the CoreZero() function, with priority 1 and executed on core 0  
    xTaskCreatePinnedToCore(CoreZero,"RunInCore0",4096,0,1,&RunInCore0,0);      //More info on https://docs.espressif.com/projects/esp-idf/en/latest/esp32/api-reference/system/freertos.html  
                                                                //     ^ This value specifies the core to use (0 or 1)  
      
    delay(500);  
}  
  
  
void CheckCore( void * pvParameters ){        //Call to check where main is running from  
  Serial.print("Running on core ");  
  Serial.println(xPortGetCoreID());  
}  
  
#End if
```