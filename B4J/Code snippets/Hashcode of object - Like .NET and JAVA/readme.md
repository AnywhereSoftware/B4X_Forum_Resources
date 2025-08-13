### Hashcode of object - Like .NET and JAVA by JakeBullet70
### 01/10/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/158363/)

In .NET and native JAVA you can get a hashcode of any object. (Think signature)  
Anyway, found myself in need of this so:  
  

```B4X
Private Sub GetHashCode(o As Object) As Int  
    Dim jo2 As JavaObject = o  
    Return jo2.RunMethod("hashCode", Null)  
End Sub
```

  
  
Not tested in B4A (Works in B4A)   
I would amigine B4I is way different.