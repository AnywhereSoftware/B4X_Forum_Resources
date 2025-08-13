### Log Characters by stevel05
### 04/11/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/166302/)

Updated Version can be found [here](https://www.b4x.com/android/forum/threads/log-utilities-log-characters-and-more.166587/)  
  
I just created these 3 subs to find unexpected characters in a string, They are useful to keep in your arsenal so you don't have to rewrite them each time.  
  

```B4X
Public Sub LogStringCharNames(Str As String)  
    LogStringCharNames2(Str,0xFFFFFFFF)  
End Sub  
  
Public Sub LogStringCharNames2(Str As String, Color As Int)  
    Log(" ")  
    LogColor("*** LogStringCharNames ***", Color)  
    LogColor("___________________________", Color)  
    LogColor(Str & " Length : " & Str.Length, Color)  
    LogColor("___________________________", Color)  
    For i = 0 To Str.Length - 1  
        LogColor(i & " : " & Str.CharAt(i) & " : " & Asc(Str.CharAt(i)) & " : " & GetCharName(Str.CharAt(i)),Color)  
    Next  
    LogColor("___________________________", Color)  
    LogColor("*** Done ***",Color)  
    Log(" ")  
End Sub  
  
Public Sub GetCharName(C As Char) As String  
    Dim Character As JavaObject  
    Character.InitializeStatic("java.lang.Character")  
    Dim Name As Object = Character.RunMethod("getName",Array(Asc(C)))  
    If Name = Null Then  
        Return "Undefined"  
    End If  
    Return Name  
End Sub
```

  
  
Usage:  

```B4X
Dev_Utils.LogStringCharNames2(Item.Name,XUI.Color_Yellow)
```

  
  
Sample Output:  

![](https://www.b4x.com/android/forum/attachments/162908)

  
  
Unrecognized characters will be reported as Undefined.