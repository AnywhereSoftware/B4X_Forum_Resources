### Analog Input Pin values mapping by Hamied Abou Hulaikah
### 07/02/2023
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/148814/)

In many cases when reading analog input pin, we got a values not what we expect, but in real they are true values, so we need to map them to understandable values.  
This mapping function:  

```B4X
Public Sub floatMap(analouginputvalue As Float,in_min As Float,in_max As Float,out_min As Float,out_max As Float) As Float  
    Return (analouginputvalue - in_min) * (out_max - out_min) / (in_max - in_min) + out_min  
End Sub
```

  
For example: in a lot of analog input sensors, we got values between 0 and 1023, but we expect for example a value between 0 and 5, so we can call floatmap function as the following:  

```B4X
'for example analog input value =780  
dim realvalue as float = floatMap(780,0,1023,0,5)
```

  
  
Thanks