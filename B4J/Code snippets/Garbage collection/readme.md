### Garbage collection by Jmu5667
### 11/16/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/102083/)

Hello  
  
For those of you interested in GC here is a class I have in a B4J server:  
  

```B4X
Sub Class_Globals  
   
   Private tmrHook           As Timer  
   Private gcTime           As Long  
   Private freq_gc           As Int = 1  
   
End Sub  
  
Public Sub Initialize  
   
   
   ' // 3 seconds  
   tmrHook.Initialize("tmrHook", 3000)  
   tmrHook.Enabled = True  
   threadName = getcurrentThreadName  
   
   ' // set the initial GC time  
   gcTime =DateTime.Now + (DateTime.TicksPerMinute * freq_gc)  
   writelog("Background Hello Helper Thread Started, GC Frequency Check Every " &  freq_gc & " Minutes" )  
   
   StartMessageLoop '<- don't forget!  
   
End Sub  
  
Sub tmrHook_Tick  
   
   ' // do GC  
   If gcTime < DateTime.Now Then  
       process_gc  
       ' // set next time  
       gcTime =DateTime.Now + (DateTime.TicksPerMinute * freq_gc)  
   End If  
   
End Sub  
  
Sub process_gc  
   
   Dim jo As JavaObject = Me  
   
   
   log("Total designated memory " & jo.RunMethod("getTotal",Null))  
   log("Before GC, Java heap currently used by instantiated objects " & jo.RunMethod("getUsed",Null))  
   log("Before GC, Current allocated free memory " & jo.RunMethod("getAllocatedFree",Null))  
   jo.RunMethod("do_garbage_collection",Null)  
   log("After GC, Current allocated free memory " & jo.RunMethod("getAllocatedFree",Null))  
   log("After GC, Java heap currently used by instantiated objects " & jo.RunMethod("getUsed",Null))  
   
End Sub  
  
Sub getcurrentThreadName As String  
      
    Dim t As JavaObject  
    Return t.InitializeStatic("java.lang.Thread").RunMethodJO("currentThread", Null).RunMethod("getName", Null)  
      
End Sub  
  
#if java  
  
   import java.util.*;  
   
   public void do_garbage_collection()   {          
       Runtime rs = Runtime.getRuntime();  
       rs.gc();  
     }  
      
   public long getAllocatedFree() {  
       Runtime rs = Runtime.getRuntime();  
        return rs.freeMemory();  
    }  
   
   public long getAllocatedTotal() {  
       Runtime rs = Runtime.getRuntime();  
        return rs.totalMemory();  
    }  
   
   public long getUsed() {  
       Runtime rs = Runtime.getRuntime();  
        return rs.totalMemory() - rs.freeMemory();  
    }  
   
   public long getTotal() {  
       Runtime rs = Runtime.getRuntime();  
        return rs.maxMemory();  
    }  
   
#End If
```

  
  
  
Regards  
  
John.  
  
EDIT: Please note that in this example the frequency is set to 1 minute, this is just to allow you see the memory metrics. I don't recommend that you use this frequency in a production environment.