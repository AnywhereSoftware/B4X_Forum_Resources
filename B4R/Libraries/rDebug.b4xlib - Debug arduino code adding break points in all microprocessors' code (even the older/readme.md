### rDebug.b4xlib - Debug arduino code adding break points in all microprocessors' code (even the older ones) by hatzisn
### 01/12/2023
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/145028/)

Merry Christmass to all Christian community of the forum. I have tried adding debugging in my B4R code and it worked.  
  
Tested in Arduino Nano (with old bootloader) and ESP8266.  
  
Add the b4xlib in additional libraries folder. Add the library in the project and use the code that follows. Then compile and when the app starts press disconnect in the logs tab and load the modified code of [USER=1]@Erel[/USER] 's B4R\_Serial\_Connector in B4J. Run the application connect to the port and press continue as many times as it is required (as seen in the following B4R code). The method is Debug.BP(….) which stands for Break Point and you can pass as an argument the variable you want to see its value or the string you want to display. You can pass all the native types available in B4R (int, long, uint, ulong, string, byte, ubyte, float, double) or null if you don't want it to print anything. It will display the variable value and stop temporarilly the code execution in this line until you press the [Continue] button in the B4J app. In the background, obviously, it does not stop the code execution in the microcontroller, but it gets in an endless loop waiting for input from the serial port and when it gets it, it continues. Thus, it acts like a breakpoint as seen from the outside.  
  
**(26-12-2022)** Added method Debug.BP2. New code follows.  
  

```B4X
#Region Project Attributes  
    #AutoFlushLogs: True  
    #CheckArrayBounds: True  
    #StackBufferSize: 300  
#End Region  
'Ctrl+Click to open the C code folder: ide://run?File=%WINDIR%\System32\explorer.exe&Args=%PROJECT%\Objects\Src  
  
Sub Process_Globals  
    Public Serial1 As Serial  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(9600)  
    Log("AppStart")  
    Dim i As Int = 1  
    Dim l As Long = 2  
    Dim b As Byte = 45  
    Dim ui As UInt = 31  
    Dim ul As ULong = 32  
    Dim f As Float = 51.45  
    Dim d As Double = 61.75  
   
   
   
    Debug.BP(i)  
    Debug.BP(l)  
    Debug.BP(b)  
    Debug.BP(ui)  
    Debug.BP(ul)  
    Debug.BP(Null)  
    Debug.BP(f)  
    Debug.BP(d)  
    Debug.BP2(Array As String("The value of the double variable is ", d, " and the value of the float is ", f))  
   
    Dim ii As Int = 0  
    Log("I start")  
    Debug.BP("Just before I add 1 in variable ii")  
    ii = ii + 1  
    Debug.BP2(Array As String("The value of the ii variable is ", ii))  
    ii = ii + 2  
    Debug.BP2(Array As String("The value of the ii variable is ", ii))  
    ii = ii + 3  
    Debug.BP2(Array As String("The value of the ii variable is ", ii))  
    Log("Ok Done")  
End Sub
```