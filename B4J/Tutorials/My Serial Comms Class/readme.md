### My Serial Comms Class by Starchild
### 09/15/2024
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/163090/)

My Serial Comms Class (as a library) is a wrapper for the standard serial comms (jSerail) and TCP networking (jNetwork) B4J libraries.  
I wrote it to more easily switch between physical RS232 (or RS485) serial comms and TCP network ports when controlling physical equipment.  
  
I have been writing microprocessor code since the mid 1970's and as such I have always considered data to be 8 bit bytes or ASCII characters.  
I know things in this new world are a little more complex, but it's always easier when communicating with external physical equipment to consider bytes and characters (interchangeable), essentially the same thing. My class generates a RxData() event (yep as a string of characters) and provides a TxData() method for sending strings of characters. Internally, I am using the "ISO-8859-1" character set to preserve the one byte / one character relationship.  
  
My class provides a test method for validating the presence of the desired equipment using a "DoValidationRequest" and a "AnalyseValidationResult" events. This lends itself for an "AUTO" mode for searching for equipment, by checking each of the available serial comm ports for the presence of the required equipment before generating the "Connected" event.  
  
I also included some extra functions like SetTcpNoDelay() for networking, and a "FlowControl()" function for enabling RTS/CTS or XOFF/XON data flow control in a serial comm port.  
  
I originally wrote this class for my own use. I am now releasing it for general use by B4J forum members. Use the License key **"starchild/b4x/free"** all lower case, to use my class unrestricted for both private and Commercial use.  
  

```B4X
Sub Process_Globals  
    Private fx As JFX  
    Private SP As Starchild_SerialCommsClass  
    Private TryAgainSubroutine As String  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    SP.Initialize(Me,"SP","starchild/b4x/free")  
    TryAgainSubroutine = ""  
  
    OpenSerialCommPortToEquipment  
    'OpenIpNetworkPortToEquipment  
End Sub  
  
'Search for an equipment that is connected to  
'any ONE of the available Serial Comm ports.  
'Validate the equipment is present by sending it  
'the text message "Hello".  
'On receiving a valid reply  
'(in this case loopbaqck of "Hello") the port  
'is then deemed to be Connected.  
'  
'if NO port is available, or the equipment does  
'not provide a valid response, then after 2 seconds  
'try searching again.  
Sub OpenSerialCommPortToEquipment  
    Log("OpenSerialCommPortToEquipment")  
    TryAgainSubroutine = "OpenSerialCommPortToEquipment"  
   
    'SP.Open("COM1",0,True,9600,8,1,SP.PARITY_NONE)  
    SP.Open("AUTO",0,True,9600,8,1,SP.PARITY_NONE)  
    SP.FlowControl(False,True)  'use Xon/Xoff flow control  
End Sub  
  
'Open an IP network port to the equipment and  
'validate the presence of the equipment.  
Sub OpenIpNetworkPortToEquipment  
    Log("OpenIpNetworkPortToEquipment")  
    TryAgainSubroutine = "OpenIpNetworkPortToEquipment"  
   
    SP.SetTcpNoDelay(True)  'disable Nagle's Algorithm for immediate data transmission  
    SP.Open("10.0.0.238",800,True,0,0,0,0)  
End Sub  
  
'Send a Command to get back an expected reply  
Sub SP_DoValidationRequest  
    Log("SP_DoValidationRequest")  
    SP.TxData("Hello")   'test for valid connected equipment  
End Sub  
  
'the returned reply  
Sub SP_AnalyseValidationResult(ReturnedData As String) As Boolean  
    Log("SP_AnalyseValidationResult")  
    Log("        ReturnedData: " & ReturnedData)  
    Return (ReturnedData = "Hello")   'a valid connection is established  
End Sub  
  
Sub SP_Connected(Success As Boolean)  
    If Success = True Then  
        Log("SP_Connected(" & SP.CURRENT_PORT & "): " & Success)  
    Else  
        Log("SP_Connected(): Equipment Not Found")  
        Log("    Last Error: " & SP.LastError)  
        Sleep(2000)  
        CallSub(Me,TryAgainSubroutine)  
    End If  
End Sub  
  
Sub SP_HasClosed(ErrorIfAny As String)  
    Log("Closed: " & ErrorIfAny)  
End Sub  
  
Sub SP_RxData(Data As String)  
    Log("RxData: " & Data)  
End Sub  
  
  
'Return true to allow the default exceptions handler to handle the uncaught exception.  
Sub Application_Error (Error As Exception, StackTrace As String) As Boolean  
    Return True  
End Sub
```

  
  
Anyway, I hope people find it useful.