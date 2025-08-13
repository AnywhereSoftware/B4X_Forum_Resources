### [PyBridge][server] Using PyBridge in web apps by Erel
### 03/16/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/166154/)

PyBridge must be accessed from a single thread. In server solutions, each handler runs in its own thread so we need to add some barriers to ensure proper usage.  
  
The way to implement it is by adding a background worker dedicated to PyBridge. Other handlers make requests to this worker using CallSubDelayed and the worker responds with CallSubDelayed as well. This way the correct thread handles each part of the task.  
  
The attached example, uses python ascii magic (<https://github.com/LeandroBarone/python-ascii_magic>) to convert an uploaded image to ascii art.  
  
![](https://www.b4x.com/android/forum/attachments/162631)  
  
The file upload task is not trivial in WebSocket handlers and is based on the "server example".   
The example depends on: pip install ascii\_magic  
  
**Warning**  
  
Be careful with dynamic code and user input. It can lead to code injection executed by the server  

```B4X
'this is fine as the code isn't dynamic:  
Private Sub MethodName (Arg1 As Object) As PyWrapper  
    Dim Code As String = $"  
def MethodName (Arg1):  
    #python code here  
    return Arg1"$  
    Return py.RunCode("MethodName", Array(Arg1), Code)  
End Sub  
  
'This is dangerous:  
py.RunNoArgsCode($"print(${Arg1}"$)
```