### [PyBridge] How to break out of async loop by Daestrum
### 02/26/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/165836/)

Further to Erels example of events using an async loop, the loop will run until the app terminates.  
  
You can 'break out' of the loops using RunNoArgsCode(…)  
  
Note: there may be better ways to do this.  
  
B4X Code  

```B4X
private Sub Py_Check (Args As Map)  
    Log("chk called")  
    globalcount = globalcount + 1  
    If globalcount = 2 Then  
        py.RunNoArgsCode("looper = False")  ' <– this is the code that sets the loop variable and cause termination of python code  
    End If  
End Sub  
  
Sub Py_stop(Args As Map)'ignore   
    Log(Args.Get("Reason"))  ' <–  Just gets a message for why it stopped  
    Sleep(1000)  
    py.KillProcess  
    StopMessageLoop  
End Sub  
  
Private Sub Py_Tick (Args As Map)  
    Dim time As String = Args.Get("time")  
    Log(time)  
End Sub  
  
Sub timer_update_test() As ResumableSub  
    wait for ((py.RunCodeAwait("TimerExample",Array(),File.ReadString(File.DirAssets,"event_test.py")))) Complete (res As PyWrapper)  
    Return True  
End Sub
```

  
  
Python Code  

```B4X
import asyncio  
from b4x_bridge.bridge import bridge_instance #type: ignore  
from datetime import datetime  
looper = True  
async def TimerExample ():  
    global looper  # This will be changed from B4J to end the loop  
    counter = 0  
    while looper:  
        await asyncio.sleep(1)  
        bridge_instance.raise_event("tick", {"time": str(datetime.now())})  
        counter += 1  
        if counter == 5:  
            bridge_instance.raise_event("check", {"check": str(counter)})  
            counter = 0  
    # the next line only executed after looper is set to False from B4J      
    bridge_instance.raise_event("stop", {"Reason": "Finished"}) # raise event to notify it has finished  
    print("End request sent to B4J")
```