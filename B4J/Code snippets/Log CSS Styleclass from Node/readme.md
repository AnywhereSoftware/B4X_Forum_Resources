### Log CSS Styleclass from Node by stevel05
### 09/24/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/63201/)

**SubName**: LogClasses  
  
**Description**:  
  
If you are trying to style some items via CSS, the documentation can be difficult to track down. This Utility Sub will list all of the children of the Node and their style classes to the Log  
  

```B4X
Public Sub LogClasses(Target As JavaObject,NodeName As String)  
   
    Log("Children's sytles from " & NodeName & " **************************")  
    Dim T As Node = Target  
   
    Dim IndentLevel As Int = 0  
    Log(IndentLevel & " " & GetType(Target) & " : " & T.StyleClasses)  
    Dim Children As List = Target.RunMethod("getChildrenUnmodifiable",Null)  
    If Children.Size > 0 Then LogClassesChildren(IndentLevel + 1 ,Children)  
   
    Log("******************************************************************")  
End Sub  
Private Sub LogClassesChildren(IndentLevel As Int,Children As List)  
    Dim NJO As JavaObject  
    For Each N As Node In Children  
        LogClassesLine(IndentLevel, GetType(N) & " : " & N.StyleClasses)                           'ignore  
        NJO = N  
        Try  
            Dim TheirChildren As List = NJO.RunMethod("getChildrenUnmodifiable",Null)  
            If TheirChildren.Size > 0 Then LogClassesChildren(IndentLevel + 1,TheirChildren)  
        Catch  
            Return  
        End Try  
    Next  
End Sub  
Private Sub LogClassesLine(IndentLevel As Int,Line As String)  
    Dim TabSpace As Int = 4  
    Dim SpaceStr As String = "                                                                                                   "  
    Dim IndentStr As String  
    IndentStr = SpaceStr.SubString2(0,Min(IndentLevel * TabSpace,SpaceStr.Length - 1))  
    Log(IndentStr & ": " & IndentLevel & " " & Line)  
End Sub
```

  
  
**Use:**  

```B4X
Utils.LogClasses(ComboBox1,"Combobox")
```

  
  
  
**Depends On**: JavaObject  
  
**Tags:** B4j CSS Node Style Class