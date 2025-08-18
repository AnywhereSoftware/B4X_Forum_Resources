### [BANano] [SOLVED] What is the right way to pass arrays to functions? by Mashiane
### 09/22/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/122624/)

Ola  
  
My code is returning NAN, however if I hard code the array elements it works and returns 1. What am I doing wrong?  
  

```B4X
'find the min of the list elements  
Sub min1(args As List) As Double  
    'this does not work  
    Dim rslt As Double = math.GetFunction("min").Execute(args).Result  
    'this works  
    'Dim rslt As Double = math.GetFunction("min").Execute(Array As Int(1,2,3,4,5)).Result  
    Return rslt  
End Sub
```

  
  
Usage:  
  

```B4X
Sub Init  
    'initialize the math object  
    math.Initialize("Math")  
    '  
    Dim res As Double = min1(Array As Int(1, 2, 3, 4, 5))  
    banano.Alert(res)  
End Sub
```

  
  
Source code attached, can I get help please.  
  
Thanks.