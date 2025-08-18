### Be careful with IF number=number! by Midimaster
### 10/06/2020
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/123161/)

I work on a swaping xCustomListview and spent half an hour to find a bug. At the end I recognized that the bug was no logic error. The code was correct. But it was a casting prolem:  

```B4X
Value as int=3  
Panel.Tag=Value  
  
'this throws FALSE:  
If Panel.Tag=Value Then  
    log(" once TRUE")  
Else  
    log(" FALSE ???")  
End If  
  
'this throws TRUE:  
If Value = Panel.Tag Then  
    log("again TRUE")  
End If
```

  
  
be careful to think about what you position first in a IF statement. This effects the casting!!!