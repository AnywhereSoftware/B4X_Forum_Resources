###  An Inline Map Key Chooser - A Small Helper Class by William Lancee
### 02/14/2023
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/146156/)

If like me you keep having the annoying problem of the wrong case or the wrong spelling for keys, you might like this.  
The class (50 lines of code) is in the attached .zip It is simple to use, and easy to understand.   
  

```B4X
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
    MKC.Initialize(Root)  
End Sub  
  
Private Sub Button1_Click  
    'Private MKC As MapKeyChooser in Globals  
    Dim anyMap As Map = CreateMap()  
    For i = 1 To 10  
        anyMap.Put("Key" & i, "ABCDEFGHIJKLMNOP".CharAT(i -1))  
    Next  
    MKC.ChooseKey(anyMap, "anyMap")  
     
    'After choice, find on Log: anyMap.Get("Key5")  
End Sub
```