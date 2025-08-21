### Convert Integer to DIP by JonPM
### 07/09/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/18800/)

Saw a request for this so I thought I'd share. Below you will find a way of converting an integer to a DIP (Density Independent Pixel). This may be useful in situations where you have a variable that you would like to use as width/height of a view in [DIP](https://www.b4x.com/glossary/dip/).   
  
IMPORTANT: [Relfection](http://www.b4x.com/forum/additional-libraries-official-updates/6767-reflection-library.html#post39256) library is required  
  
Copy this code into your project (either into Main module or a code module)  

```B4X
Sub IntToDIP(Integer As Int) As Int  
   Dim r As Reflector  
   Dim scale As Float  
   r.Target = r.GetContext  
   r.Target = r.RunMethod("getResources")  
   r.Target = r.RunMethod("getDisplayMetrics"))  
   scale = r.GetField("density")  
    
   Dim DIP As Int  
   DIP = Integer * scale + 0.5  
   Return DIP  
End Sub
```

  
  
Example usage:  

```B4X
myRandomVar = 192  
myLabel.width = IntToDip(myRandomVar)
```

  
  
I only have a couple devices to test it on, and it seems to be working correctly. Please reply here if you have any problems.