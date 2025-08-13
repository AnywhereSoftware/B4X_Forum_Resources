### [BANano]  (v7) Using Background Workers in your WebApps (introduction) by alwaysbusy
### 03/03/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/134544/)

The next release of BANano will have the possibility to use background workers in your WebApps. It can not be added in a BANanoLibrary, so it must be done in your final project. Background workers are actually Web Workers, but I prefer using the term 'Background Worker' as it is familiar to the B4J language.  
  
BackgroundWorkers are a simple means for web content to run scripts in background threads. The worker thread can perform tasks without interfering with the user interface. In addition, they can perform I/O using BANanoFetch. Once created, a worker can send messages to the main thread code (that created it) by posting messages with **BANano.SendFromBackgroundWorker()** to a **BANano\_MessageFromBackgroundWorker()** event handler specified by that code (and vice versa by using the **BANano.RunBackgroundWorkerMethod()**).  
  
**IMPORTANT NOTES:**  
1. BackgroundWorkers can **NOT** access:  
- The DOM: they cannot read or modify the HTML document. In addition, you cannot access global variables or JavaScript functions within the page  
- The window, the document and the parent objects  
  
2. Data send to BackgroundWorkers is **copied, NOT shared**. So changing the value of a variable (that you passed with **RunBackgroundWorkerMethod())** in a BackgroundWorker will NOT be changed in the caller class. You will have to pass on the new value to the caller class with **SendFromBackgroundWorker().**  
  
3. A worker can not be run directly from the filesystem. It can only be run via a server.  
  
**HOW IT WORKS:**  
1. Add a new BANano Background Worker Class, let's call it MyBackgroundWorker:  
![](https://www.b4x.com/android/forum/attachments/119532)  
  
Result:  

```B4X
'This is a BANano Background worker template class  
Sub Class_Globals  
    Private BANano As BANano 'ignore  
    Private mTimer As Timer  
    Private mTimerTickMs As Int = 1000  
End Sub  
  
' can have additional parameters  
Public Sub Initialize(TicksMs As Int)  
    ' additional javscript needed in the Worker  
    ' THESE CAN NOT CONTAIN JAVASCRIPT CODE THAT MANUPULATE THE DOM  
    ' BANano.DependsOnAsset("myCode.js")  
   
    mTimerTickMs = TicksMs  
    mTimer.Initialize("Timer", mTimerTickMs)  
    mTimer.Enabled = True  
   
End Sub  
  
' can have additional parameters  
Public Sub BANano_StopBackgroundWorker()  
    mTimer.Enabled = False  
   
End Sub  
  
Sub Timer_Tick  
    'do the work required  
   
   
    ' Send something back to the calling class  
    ' BANano.SendFromBackgroundWorker("SomeTag", Array(SomeValues), Null)     
   
End Sub
```

  
  
Now we can make it do something, e.g. we want it do run in the background every second and add +1 to a counter. When it reaches *counter mod 10,* send the current value back to the calling class. We also add a method AddToCounter to immidately add some value to the counter variable from the calling class. The Initialize method has been changed to accept an additional parameter Title too:  
  

```B4X
'This is a BANano Background worker template class  
Sub Class_Globals  
    Private BANano As BANano 'ignore  
    Private mTimer As Timer  
    Private mTimerTickMs As Int = 1000  
    Private mCounter As Int = 0  
    Private mTitle As String  
End Sub  
  
' can have additional parameters  
Public Sub Initialize(Title As String, TicksMs As Int)  
    ' additional javscript needed in the Worker, just to show the syntax, doesn't really do something in this example  
    ' THESE CAN NOT CONTAIN JAVASCRIPT CODE THAT MANUPULATE THE DOM  
    BANano.DependsOnAsset("myCode.js")  
   
    mTitle = Title  
    mTimerTickMs = TicksMs  
   
    mTimer.Initialize("Timer", mTimerTickMs)  
    mCounter = 0  
    mTimer.Enabled = True  
End Sub  
  
' can have additional parameters  
Public Sub BANano_StopBackgroundWorker()  
    mTimer.Enabled = False  
End Sub  
  
Sub Timer_Tick  
    'do the work required  
    mCounter = mCounter + 1  
    Log(mTitle & ": every " & mTimerTickMs & ", Counter: " & mCounter)  
    If mCounter Mod 10 = 0 Then  
        ' can only be used in a BackgroundWorker!  
        BANano.SendFromBackgroundWorker("Mod10", Array(mCounter), Null)     
    End If  
End Sub  
  
public Sub AddToCounter(value As Int)  
    mCounter = mCounter + value  
End Sub
```

  
  
Now, how to use our Background Worker?   
  
First me must create a couple of instances of the worker. This **MUST** be predefined in the AppStart() method. E.g. here, we are going to use two instances of our MyBackgroundWorker somewhere in our code later:  

```B4X
Sub AppStart (Form1 As Form, Args() As String)  
…  
    BANano.AddBackgroundWorker("worker1", "MyBackgroundWorker")  
    BANano.AddBackgroundWorker("worker2", "MyBackgroundWorker")  
…  
End Sub
```

  
  
When we need our Background Workers, we can start them like this, e.g. in BANano\_Ready():  

```B4X
' run de Start method of the Background Workers  
BANano.StartBackgroundWorker("worker1", Array("From Worker 1", 1000)) ' start Worker1, and in our Initialize of our MyBackgroundWorker we need two parameters (Title and TicksMs)  
BANano.StartBackgroundWorker("worker2", Array("From Worker 2", 2000))
```

  
  
Now all we have to do is add the event BANano\_MessageFromBackgroundWorker() to receive messages from our Background Workers. e.g. In MyBackgroundWorker, we do use a BANano.SendFromBackgroundWorker() call to send the current counter back to our calling class with a Tag "Mod10".  

```B4X
public Sub BANano_MessageFromBackgroundWorker(WorkerName As String, Tag As String, Value As Object, Error As Object)  
    ' the Tag will define the type of message send by the Background Worker  
    If Tag = "Mod10" Then  
        Log(WorkerName)  
        Log("Current Error: " & Error)  
        Log("Current Value: " & Value)  
    End If  
End Sub
```

  
  
Somewhere else in our code, e.g. by pressing a button, we can call the AddToCounter method from our class that initialized the workers to immidiately add 1000 to the counter:  

```B4X
Sub BtnAdd_Click (event As BANanoEvent)  
      BANano.RunBackgroundWorkerMethod("Worker1", "", "AddToCounter", Array(1000))  
End Sub
```

  
  
We can stop the Background Workers with:  

```B4X
' calls the BANano_StopBackgroundWorker event in the BackgroundWorker Class  
BANano.StopBackgroundWorker("worker1", Null)  
BANano.StopBackgroundWorker("worker2", Null)
```

  
  
This concludes the introduction to Background workers with BANano Web Apps. This didn't really do anything very useful, but I will see if I can get an example ready before the release where it does something useful like fetching a big JSON file, while the user can still interact with the WebApp.  
  
Alwaysbusy