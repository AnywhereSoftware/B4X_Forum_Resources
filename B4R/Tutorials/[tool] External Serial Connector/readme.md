### [tool] External Serial Connector by Erel
### 05/19/2020
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/65724/)

![](https://www.b4x.com/basic4android/images/SS-2016-04-12_15.23.57.png)  
  
This is a small B4J program that uses jSerial library to connect to an Arduino board.  
  
To see it working start with this simple B4R program:  

```B4X
Sub Process_Globals  
   Public Serial1 As Serial  
   Private astream As AsyncStreams  
End Sub  
  
Private Sub AppStart  
   Serial1.Initialize(115200)  
   Log("AppStart")  
   astream.Initialize(Serial1.Stream, "Astream_NewData", "Astream_Error")  
End Sub  
  
Sub Astream_NewData (Buffer() As Byte)  
   Log("Received: ", Buffer)  
End Sub  
  
Sub AStream_Error  
   Log("error")  
End Sub
```

  
  
  
![](https://www.b4x.com/basic4android/images/SS-2016-04-25_09.48.44.png)  
  
In this mode the IDE will send a message to the serial connector to close the serial port during compilation and to open it afterward.  
  
You can modify the code to send binary data instead of strings.  
  
**Updates**  
  
- v1.20 - Uses a small console app to get the ports description.  
  
![](https://www.b4x.com/basic4android/images/f5CT6pMMYn.png)