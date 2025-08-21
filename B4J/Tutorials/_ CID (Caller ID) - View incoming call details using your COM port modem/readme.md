### ? CID (Caller ID) - View incoming call details using your COM port modem by Peter Simpson
### 04/06/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/115873/)

Hello All,  
After looking on the forum and finding basically nothing regarding using B4J for CID (Caller ID) via home or basic business phone lines, I took out my V.92 USB modem and created this simple tutorial for B4J developers to learn from.  
  
[SPOILER=">>> USB modem response in the logs <<<"]  
Picked up \_JAVA\_OPTIONS: -Xmx1024m -Xms1024m -XX:-UseGCOverheadLimit  
Waiting for debugger to connect…  
Program started.  
AT#CID=1  
OK  
RING  
DATE=0404  
TIME=0921  
NMBR=07931XXXXXX  
[/SPOILER]  
NMBR=07931XXXXXX actually displayed my full mobile phone number, I crossed out the last 6 digits with X's for obvious reasons.  
  
Libraries needed:  
![](https://www.b4x.com/android/forum/attachments/91242)  
  

```B4X
Sub Process_Globals  
    Private BC As ByteConverter  
    Private COMPort As Serial  
    Private AStream As AsyncStreams  
End Sub  
  
Sub AppStart (Args() As String)  
    InitializeModem  
    StartMessageLoop  
End Sub  
  
'Return true to allow the default exceptions handler to handle the uncaught exception.  
Sub Application_Error (Error As Exception, StackTrace As String) As Boolean  
    Return True  
End Sub  
  
Sub InitializeModem  
    Try  
        COMPort.Initialize(Null)  
        COMPort.Open("COM3")  
        COMPort.SetParams(COMPort.BAUDRATE_9600, COMPort.DATABITS_8, COMPort.STOPBITS_1, COMPort.PARITY_NONE)  
  
        AStream.Initialize(COMPort.GetInputStream, COMPort.GetOutputStream, "AStream")  
        AStream.Write(BC.StringToBytes($"AT#CID=1${Chr(10)}${Chr(13)}"$, "UTF-8"))  
    Catch  
        Log(LastException.Message)  
    End Try  
End Sub  
  
Sub AStream_NewData (Buffer() As Byte)  
    Log(BytesToString(Buffer, 0, Buffer.Length, "UTF-8"))  
End Sub
```

  
You should use Regex.Split in 'Sub AStream\_NewData' to separate the received data into individual DATE, TIME and NMBR strings.  
  
My V.92 USB modem looks something like this, it cost about £7.  
![](https://www.b4x.com/android/forum/attachments/91241)  
  
I tested initializing my V.92 USB modem for CID with AT codes AT#CID=1 and AT#CID=2, they worked flawlessly. According to my VS code, the following AT codes can be used to initialize CID depending on the modem hardware you are using.  
  
> //AT#CID=1  
>  //AT#CID=2  
>  //AT+VCID=1  
>  //AT+VCID=2  
>  //AT%CCID=1  
>  //AT%CCID=2  
>  //AT#CLS=8#CID=1  
>  //AT#CC1  
>  //AT\*ID1

  
To test if your modem supports CID, you could first try sending AT#CID=1 through terminal software to your modem, software like Windows Terminal will suffice. Hopefully when you send the AT command you will receive the response OK, if you receive the response FAIL then just move onto the next AT command above. If you have gone through all the AT commands and all the responses were FAIL, then sadly your modem probably does not support CID.  
  
  
**Enjoy…**