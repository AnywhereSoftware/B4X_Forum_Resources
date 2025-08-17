### [PyBridge] Tips to make life easier by Daestrum
### 02/17/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/165658/)

1, Download VSCode to edit the Python source files (you get hints etc)  
2, Put the Python source code in files directory. (set external tool to VSCode for easy editing)  
3, Run the code from File.DirAssets folder. Your B4J code will look much cleaner without the Code = $"…"$ lines.  

```B4X
Dim res As PyWrapper = Py.RunCode("func1",Array(a,b),File.ReadString(File.DirAssets,"First_Python.py"))
```

  
  

```B4X
def func1(a, b):  
    print(f"a = {a}  {type(a)} , b = {b}  {type(b)}")  
    if isinstance(a, int) and isinstance(b, int):  
        return int(a + b)  
    else:  
        return f"Numbers were not integers"
```