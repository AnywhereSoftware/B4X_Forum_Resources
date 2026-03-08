###  List to array by Erel
### 03/05/2026
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/170506/)

B4X compiler automatically casts arrays to lists.  
You can use this code in the rare case where you want to convert a list to an array of objects:  

```B4X
Public Sub ListToArray(Items As List) As Object()  
    #if B4A or B4J  
    Return Items.As(JavaObject).RunMethod("toArray", Null)  
    #Else  
    Dim b(Items.Size) As Object  
    For i = 0 To Items.Size - 1  
        b(i) = Items.Get(i)  
    Next  
    Return b  
    #End If  
End Sub
```