### USB Serial Port + AsyncStreams + B4XBytesBuilder by rtek1000
### 03/19/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/128824/)

Attached project code:  

```B4X
#Region Project Attributes  
    #MainFormWidth: 600  
    #MainFormHeight: 600  
#End Region  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
    Private Button1 As B4XView  
      
    Private sp As Serial  
    Private astream As AsyncStreams  
      
    Dim timer1 As Timer  
      
    Dim counter1 As Int = 0  
      
    Dim bytesSec As Int = 0  
      
    'Dim SerialBuffer As String ' replaced by B4XBytesBuilder  
      
    Dim bBuilder As B4XBytesBuilder  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    MainForm.Show  
      
    timer1.Initialize("timer1", 1000)  
    timer1.Enabled = True  
      
    sp.Initialize("sp")  
   
    Log(sp.ListPorts)  
   
    'SerialBuffer = ""  
    bBuilder.Initialize  
    bBuilder.Clear  
      
    If sp.ListPorts.Size > 0 Then  
        sp.Open(sp.ListPorts.Get(0))  
        sp.SetParams(500000, 8, 1, 0) ' baud: 9600, 115200, 500000  
   
        astream.Initialize(sp.GetInputStream, sp.GetOutputStream, "astream")  
    Else  
        Log("No serial port found")  
    End If  
   
End Sub  
  
Sub Button1_Click  
    xui.MsgboxAsync("Hello World!", "B4X")  
End Sub  
  
Sub timer1_tick  
    bytesSec = counter1  
    counter1 = 0  
      
    Log("bytes/Sec: " & bytesSec)  
End Sub  
  
Sub AStream_NewData (Buffer() As Byte)  
  
    ' Old way to avoid breaking the message (replaced by B4XBytesBuilder):  
      
    '    SerialBuffer =  SerialBuffer & BytesToString(Buffer, 0, Buffer.Length, "UTF8")  
    '     
    '    If SerialBuffer.IndexOf(Chr(10)) > 0 Then  
    '        Dim SerialBuffer_tmp As String = SerialBuffer.SubString2(0, SerialBuffer.IndexOf(Chr(10)))  
    '        If SerialBuffer.Length >= SerialBuffer.IndexOf(Chr(10)) + 1 Then  
    '            SerialBuffer = SerialBuffer.SubString(SerialBuffer.IndexOf(Chr(10)) + 1)  
    '        End If  
    '         
    '        Log(SerialBuffer_tmp)  
    '    Else  
    '        Log("NewData")  
    '    End If  
  
  
    ' New way to avoid breaking the message:  
      
    counter1 = counter1 + Buffer.Length  
      
    bBuilder.Append(Buffer)  
      
    '10 = line feed (\n); 13 = carriage return (\r); 13+10 = new line (\r\n)  
    Dim searchFor() As Byte = Array As Byte(13, 10)  
      
    If bBuilder.IndexOf(searchFor) > 0 Then  
        Dim buffer_tmp() As Byte = bBuilder.SubArray2(0, bBuilder.IndexOf(searchFor))  
          
        If bBuilder.Length >= (bBuilder.IndexOf(searchFor) + 1) Then  
            bBuilder.Remove(0, bBuilder.IndexOf(searchFor) + 1)  
        End If  
          
        ' buffer_tmp —> Complete message ready to use  
        Log(BytesToString(buffer_tmp, 0, buffer_tmp.Length, "UTF8"))  
    Else  
        Log("NewData")  
    End If  
  
End Sub
```

  
  
Test code for Arduino (Atmega328 - Arduino Nano with integrated FTDI USB converter):  

```B4X
int cnt1 = 0;  
  
void setup() {  
  // put your setup code here, to run once:  
  Serial.begin(500000);  
  
  Serial.println();  
  
  Serial.println("Start");  
}  
  
void loop() {  
  // put your main code here, to run repeatedly:  
  Serial.print(F("Complete message ready to use - "));  
  Serial.println(cnt1, DEC);  
  
  cnt1++;  
}
```

  
  
B4J log for 500000 baud:  
> Waiting for debugger to connect…  
> Program started.  
> (ArrayList) [COM5]  
> �6YRr���H�1��H��q�ř�4�ue message ready to use - 22073  
> bytes/Sec: 62  
> bytes/Sec: 0  
> Com�  
> Start  
> Complete message ready to use - 0  
> Complete message ready to use - 1  
> Complete message ready to use - 2  
> Complete message ready to use - 3  
> Complete message ready to use - 4  
> Complete message ready to use - 5  
> Complete message ready to use - 6  
> bytes/Sec: 35712  
> Complete message ready to use - 7  
> Complete message ready to use - 8  
> Complete message ready to use - 9  
> Complete message ready to use - 10  
> Complete message ready to use - 11  
> Complete message ready to use - 12  
> Complete message ready to use - 13  
> Complete message ready to use - 14  
> Complete message ready to use - 15  
> Complete message ready to use - 16  
> Complete message ready to use - 17  
> Complete message ready to use - 18  
> Complete message ready to use - 19  
> bytes/Sec: 51584  
> Complete message ready to use - 20  
> Complete message ready to use - 21  
> Complete message ready to use - 22  
> Complete message ready to use - 23  
> Complete message ready to use - 24  
> Complete message ready to use - 25  
> Complete message ready to use - 26  
> Complete message ready to use - 27  
> Complete message ready to use - 28  
> Complete message ready to use - 29  
> Complete message ready to use - 30  
> Complete message ready to use - 31  
> Complete message ready to use - 32  
> bytes/Sec: 51584  
> Complete message ready to use - 33  
> Complete message ready to use - 34  
> Complete message ready to use - 35  
> Complete message ready to use - 36  
> Complete message ready to use - 37  
> Complete message ready to use - 38  
> Complete message ready to use - 39  
> Complete message ready to use - 40  
> Complete message ready to use - 41  
> Complete message ready to use - 42  
> Complete message ready to use - 43  
> Complete message ready to use - 44  
> bytes/Sec: 47616  
> Complete message ready to use - 45  
> Complete message ready to use - 46  
> Complete message ready to use - 47  
> Complete message ready to use - 48  
> Complete message ready to use - 49  
> Complete message ready to use - 50  
> Complete message ready to use - 51  
> Complete message ready to use - 52  
> Complete message ready to use - 53  
> Complete message ready to use - 54  
> Complete message ready to use - 55  
> Complete message ready to use - 56  
> Complete message ready to use - 57  
> bytes/Sec: 51584  
> Complete message ready to use - 58  
> Complete message ready to use - 59  
> Complete message ready to use - 60  
> Complete message ready to use - 61  
> Complete message ready to use - 62  
> Complete message ready to use - 63  
> Complete message ready to use - 64  
> Complete message ready to use - 65  
> Complete message ready to use - 66  
> Complete message ready to use - 67  
> Complete message ready to use - 68  
> Complete message ready to use - 69  
> bytes/Sec: 47616  
> Complete message ready to use - 70  
> Complete message ready to use - 71  
> Complete message ready to use - 72  
> Complete message ready to use - 73  
> Complete message ready to use - 74  
> Complete message ready to use - 75  
> Complete message ready to use - 76  
> Complete message ready to use - 77  
> Complete message ready to use - 78  
> Complete message ready to use - 79  
> Complete message ready to use - 80  
> Complete message ready to use - 81  
> Complete message ready to use - 82  
> bytes/Sec: 51584  
> Complete message ready to use - 83  
> Complete message ready to use - 84  
> Complete message ready to use - 85  
> Complete message ready to use - 86  
> Complete message ready to use - 87  
> Complete message ready to use - 88  
> Complete message ready to use - 89  
> Complete message ready to use - 90  
> Complete message ready to use - 91  
> Complete message ready to use - 92  
> Complete message ready to use - 93  
> Complete message ready to use - 94  
> Complete message ready to use - 95  
> Complete message ready to use - 96  
> bytes/Sec: 51584  
> Complete message ready to use - 97  
> Complete message ready to use - 98  
> Complete message ready to use - 99  
> Complete message ready to use - 100

  
B4J log for 115200 baud:  
> Waiting for debugger to connect…  
> Program started.  
> (ArrayList) [COM5]  
>  ready to use - 3180  
> bytes/Sec: 51  
> bytes/Sec: 0  
> Complete message ready to us�  
> bytes/Sec: 3968  
> Start  
> Complete message ready to use - 0  
> Complete message ready to use - 1  
> bytes/Sec: 11904  
> Complete message ready to use - 2  
> Complete message ready to use - 3  
> Complete message ready to use - 4  
> bytes/Sec: 11904  
> Complete message ready to use - 5  
> Complete message ready to use - 6  
> Complete message ready to use - 7  
> bytes/Sec: 11904  
> Complete message ready to use - 8  
> Complete message ready to use - 9  
> Complete message ready to use - 10  
> bytes/Sec: 11904  
> Complete message ready to use - 11  
> Complete message ready to use - 12  
> Complete message ready to use - 13  
> Complete message ready to use - 14  
> Complete message ready to use - 15  
> bytes/Sec: 11904  
> Complete message ready to use - 16  
> Complete message ready to use - 17  
> Complete message ready to use - 18  
> bytes/Sec: 11904  
> Complete message ready to use - 19  
> Complete message ready to use - 20  
> Complete message ready to use - 21  
> bytes/Sec: 11904  
> Complete message ready to use - 22  
> Complete message ready to use - 23  
> Complete message ready to use - 24  
> bytes/Sec: 11904  
> Complete message ready to use - 25  
> Complete message ready to use - 26  
> Complete message ready to use - 27  
> bytes/Sec: 11904  
> Complete message ready to use - 28  
> Complete message ready to use - 29  
> Complete message ready to use - 30  
> bytes/Sec: 11904  
> Complete message ready to use - 31  
> Complete message ready to use - 32  
> Complete message ready to use - 33  
> bytes/Sec: 11904  
> Complete message ready to use - 34  
> Complete message ready to use - 35  
> Complete message ready to use - 36  
> bytes/Sec: 11904  
> Complete message ready to use - 37  
> Complete message ready to use - 38  
> Complete message ready to use - 39  
> bytes/Sec: 11904  
> Complete message ready to use - 40  
> Complete message ready to use - 41  
> Complete message ready to use - 42  
> bytes/Sec: 11904  
> Complete message ready to use - 43  
> Complete message ready to use - 44  
> Complete message ready to use - 45  
> bytes/Sec: 11904  
> Complete message ready to use - 46  
> Complete message ready to use - 47  
> Complete message ready to use - 48  
> bytes/Sec: 11904  
> Complete message ready to use - 49  
> Complete message ready to use - 50  
> Complete message ready to use - 51  
> bytes/Sec: 11904  
> Complete message ready to use - 52  
> Complete message ready to use - 53  
> Complete message ready to use - 54  
> bytes/Sec: 11904  
> Complete message ready to use - 55  
> Complete message ready to use - 56  
> Complete message ready to use - 57  
> Complete message ready to use - 58  
> Complete message ready to use - 59  
> bytes/Sec: 11904  
> Complete message ready to use - 60  
> Complete message ready to use - 61  
> Complete message ready to use - 62  
> Complete message ready to use - 63  
> bytes/Sec: 11904  
> Complete message ready to use - 64  
> Complete message ready to use - 65  
> Complete message ready to use - 66  
> bytes/Sec: 11904  
> Complete message ready to use - 67  
> Complete message ready to use - 68  
> Complete message ready to use - 69  
> bytes/Sec: 11904  
> Complete message ready to use - 70  
> Complete message ready to use - 71  
> Complete message ready to use - 72  
> bytes/Sec: 11904  
> Complete message ready to use - 73  
> Complete message ready to use - 74  
> Complete message ready to use - 75  
> bytes/Sec: 11904  
> Complete message ready to use - 76  
> Complete message ready to use - 77  
> Complete message ready to use - 78  
> bytes/Sec: 11904  
> Complete message ready to use - 79  
> Complete message ready to use - 80  
> Complete message ready to use - 81  
> bytes/Sec: 11904  
> Complete message ready to use - 82  
> Complete message ready to use - 83  
> Complete message ready to use - 84  
> bytes/Sec: 11904  
> Complete message ready to use - 85  
> Complete message ready to use - 86  
> Complete message ready to use - 87  
> Complete message ready to use - 88  
> bytes/Sec: 11904  
> Complete message ready to use - 89  
> Complete message ready to use - 90  
> Complete message ready to use - 91  
> Complete message ready to use - 92  
> bytes/Sec: 11904  
> Complete message ready to use - 93  
> Complete message ready to use - 94  
> Complete message ready to use - 95  
> bytes/Sec: 11904  
> Complete message ready to use - 96  
> Complete message ready to use - 97  
> bytes/Sec: 7936  
> Complete message ready to use - 98  
> Complete message ready to use - 99  
> Complete message ready to use - 100

  
  
References:  
  
[[B4X] B4XCollections - More collections](https://www.b4x.com/android/forum/threads/b4x-b4xcollections-more-collections.101071/#content)  
  
[B4J jSerial initialization question](https://www.b4x.com/android/forum/threads/b4j-jserial-initialization-question.66692/)  
  
[USB Serial Port](https://www.b4x.com/android/forum/threads/usb-serial-port.107915/page-2)  
  
[Arduino Serial](https://www.arduino.cc/reference/en/language/functions/communication/serial/)