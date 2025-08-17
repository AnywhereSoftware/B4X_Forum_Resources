### [B4J, B4XPages] B4J as an interactive backend for Python3 by William Lancee
### 05/25/2024
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/161305/)

Many of you already know how to do this, but I recently needed it and ran into some problems.  
In the end, I had a Class that others may find useful.  
  
My experience with this project:  
  
1. The current version of Python is 3.12.3. Python3 has quite a few differences from Python2, and is not backwards compatible.  
The PyUDP class attached is for Python3. When installing Python3, a launcher Py.exe can be accessed by a shortcut "py".  
  
2. The python-invocation examples from the Forum are now quite old, and not based on B4XPages.  
  
3. The interface used by this class, based on a UDP Socket, is finicky and unless everything is lined up, it does not work.  
  
4. If you put the Python script in a file with .py extension and invoke Python with jShell, you can read the StdOut string.  
But each time a dynamically created block of Python code is run, the Python interpreter has to be launched.  
This does not lend itself to effective interaction between the B4J code and the Python code.  
  
[USER=1]@Erel[/USER] posted an example of using a UDP Socket in Python.  
<https://www.b4x.com/android/forum/threads/rpi-piface-control-and-display-cad.62610/>  
  
It was for controlling the RPi CAD. I used the same principle.  
The idea is to launch Python only once, use it interactively, and finally kill it when not needed anymore.  
  
The flow is:  
 1. Define and initialize an instance of PyUDP  
 2. Write some Python code. There are several options (Notepad++, save file, read file), or write it in a smart string in the B4J IDE  
 3. Run the code as string, wait for results, respond appropriately - possibly by running more Python code  
 4. When Python is no more needed run .Kill  
  
Here are 2 examples:  
  

```B4X
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    B4XPages.AddPageAndCreate("SP", SP)        'Simple XY plot used in second example  
    B4XPages.AddPageAndCreate("Py", Py)  
    Wait for Py_Ready  
    Sleep(0)                                'Allow B4XMainPage to finish loading  
    B4XPages.ShowPage("Py")  
  
'Do Fibonacci sequence  
    Py.Run($"  
# Fibonacci numbers module  
import sys  
def fib(n):  
    result = []  
    a, b = 0, 1  
    while a < n:  
        result.append(a)  
        a, b = b, a+b  
    return result  
  
print(fib(100))  
print(fib(200))  
print(fib(300))  
print("")  
"$)  
    wait for Py_Complete  
  
'Without killing Py do Linear Regression  
  
    Dim x As String = "5,7,8,7,2,17,2,9,4,11,12,9,6"  
    Dim y As String = "99,86,87,88,111,86,103,87,94,78,77,85,86"  
  
    Py.Run($"  
# Linear Regression Module  
import numpy as np  
from scipy import stats  
  
x = np.array([${x}])  
y = np.array([${y}])  
n = x.size  
  
slope, intercept, r, p, std_err = stats.linregress(x, y)  
print("n, intercept, slope, r, p")  
print( n, intercept, slope, r, p, sep=", ")  
    "$)  
    wait for Py_Complete  
     
    plotResults(x, y, Py.GetResults)  
  
    Py.Kill  
End Sub
```

  
  
![](https://www.b4x.com/android/forum/attachments/153993)  
  
These examples using PyUDP illustrate the typical functions of a backend - the Python results are shown in a UI.  
  
Note 1: I expect that most of the logic and all of the standard input and standard output of Python code would be handled by B4J code.  
Standard input of a value like ans=input() would become ans=value; standard output stays the same as print()  
  
Note 2: The server uses 'exec' to execute served code. The input() function of Python is a security risk and is therefore disabled.  
It is not needed in this approach (see above note 1). Since all arguments in the server exec come directly from your B4J code,  
security is not at risk. The UDPServer.py file itself is deleted after the server is invoked - althought this is unnecessary.  
  
Note 3: It is important to kill the PyUDP server, since an already running Python prevents a new PyUDP from being created (things don't work)  
In the example code, the PyUDP is killed on a close request by B4MainPage.