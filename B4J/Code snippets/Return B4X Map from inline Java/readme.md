### Return B4X Map from inline Java by tchart
### 10/07/2020
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/123221/)

Example below shows how to return a B4X Map from inline Java.  
  
NOTE: Inline java must be in a Class module (it wont work in Main)  
  

```B4X
Sub Class_Globals  
      
End Sub  
  
'Initializes the object. You can add parameters to this method if needed.  
Public Sub Initialize  
      
End Sub  
  
Sub getJVMSystemProperties As Map  
    Dim obj As JavaObject = Me     
    Return obj.RunMethod("getJVMSystemProperties", Null)  
End Sub  
  
#If JAVA  
import anywheresoftware.b4a.objects.collections.Map.MyMap;  
  
// Return VM system properties  
    public MyMap getJVMSystemProperties() {  
        java.util.Map<String,String> mSystemProperties = java.lang.management.ManagementFactory.getRuntimeMXBean().getSystemProperties();  
      
        MyMap mResult = new MyMap();  
          
        for (java.util.Map.Entry<String, String> entry : mSystemProperties.entrySet())  
        {  
            mResult.put(entry.getKey(), entry.getValue());  
        }  
          
        return mResult;  
    }  
#End If
```