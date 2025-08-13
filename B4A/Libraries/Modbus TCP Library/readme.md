### Modbus TCP Library by Walter95
### 11/09/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/144028/)

Hello everyone,  
Given the difficulties in finding a "ready-made" library for Modbus TCP communication.  
I have decided to create a library, adapted for my needs, i decide to publish because maybe useful to someone, maybe someone want to improve on it in this forum.  
  
I attach the library, the library project and a test project.  
  
**The available functions**:  

- FC01 - Read Coil
- FC03 - Read Holding
- FC05 - Write Single Coil
- FC06 - Write Single Holding
- FC16 - Write Multiple Holding

  
  
**How it works:**  
  
From code you create Query to indicate the function you want to execute cyclically.  
Before recording it in a list, it analyses the "Count" parameter (this is because I have noticed that I can request data up to a maximum of 125)  
Adapts the query and eventually creates as many queries as necessary to satisfy the initial request.  
  
The list of "Queries" proceed cyclically and it advances only if the server responds to that Query  
(My idea was: "No need to continue, if server can't reply to me")  
  
All code run in background.  
  
**ModbusTCP  
[SIZE=4]Author: [/SIZE]**[SIZE=4]Walter Maniero  
**Version:** 2.20[/SIZE]  
  

- [SIZE=4]**Functions/Routines:**[/SIZE]

- **Initialize**(Caller As Object,EventName As String, unitId As Byte)
- [SIZE=4]**CreateConnection**(IPaddress As String, Port As Int, Timeout As Int, ReadTime As Int) As ConnectionParams
*Return the type ConnectionParams that simply contain all informations*[/SIZE]- [SIZE=4]**CreateQuery**(Function As Short, StartAddress As Short, Count As Short) As ModbusQuery
Create and return the query to add in list[/SIZE]- [SIZE=4]**AddToQuery**(Value As ModbusQuery)[/SIZE]
- [SIZE=4]**AddToQuery2**(Value() As ModbusQuery)[/SIZE]
- [SIZE=4]**RemoveFromQuery**(Key As Short)
Each query in list has a name, this name is Id field inside ModbusQuery[/SIZE]- [SIZE=4]**ResetQueryList**()
Clear the list[/SIZE]- [SIZE=4]**CreateNewQueryList**()
If you change the list in runtime, you need to apply the changes with this sub[/SIZE]- **StartCOM**(COM As ConnectionParams)
- **StopCOM**()
- **SetCoil**(Address As Short, Value As Boolean)
- **SetHold**(Address As Short, Value As Short)
- **SetMultipleHold**(Address As Short, Value() As Short)
- **GetCoil**() As Boolean()
*Coil(65536) As Boolean*- **GetHolds**() As Short()
*Holds(65536) As Short*
- **Type:**

- **ModbusQuery**
- **ConnectionParams**

- **Eventi:**

- **ServiceState**(State As Boolean)

---

  

```B4X
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
    Private xui As XUI  
    Private ModbusClient As ModbusTCP  
    Private COMParameters As ConnectionParams  
    Private ModbusState As Boolean = False  
End Sub  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("Layout")  
    ModbusClient.Initialize(Me,"ModbusClient",1)  
    COMParameters.Initialize  
    COMParameters = ModbusClient.CreateConnection("192.168.178.42",502,3600,200)  
    SetQuery  
End Sub  
  
Sub SetQuery()  
    Dim Myquery1 As ModbusQuery = ModbusClient.CreateQuery(1,0,100)  
    Dim Myquery2 As ModbusQuery = ModbusClient.CreateQuery(3,0,100)  
    ModbusClient.AddToQuery(Myquery1)  
    ModbusClient.AddToQuery(Myquery2)  
End Sub  
  
Sub ModbusClient_ServiceState(State As Boolean)  
    ModbusState = State  
End Sub  
  
Sub Activity_Resume  
    If ModbusState = False Then  
        ModbusClient.StartCOM(COMParameters)  
    End If  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
    If UserClosed Then  
        ModbusClient.StopCOM  
    End If  
End Sub  
  
Sub Button1_Click  
    Dim MyCoils() As Boolean = ModbusClient.GetCoil()  
    Dim MyHolds() As Short = ModbusClient.GetHolds()  
    ModbusClient.SetCoil(0,Not(MyCoils(0)))  
    Dim Value(10) As Short  
    For i = 0 To Value.Length - 1  
        Value(i) = MyHolds(i) + 1  
    Next  
    ModbusClient.SetMultipleHold(1,Value)  
End Sub
```