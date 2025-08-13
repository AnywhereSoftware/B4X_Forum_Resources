### B4j Print JavaFX8 Create custom paper by stevel05
### 09/28/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/143173/)

I came across this snippet when helping a user on the forum and thought it may be more widely useful:  
  
Create a Paper instance,  

```B4X
'Create a new Paper  
'Units should be one of MM, INCH or POINT  
Public Sub CreatePaper(Name As String, Width As Double, Height As Double, Units As String) As Paper  
    Dim tUnits As JavaObject  
    tUnits.InitializeStatic("com.sun.javafx.print.Units")  
    Dim PrintH As JavaObject  
    PrintH.InitializeStatic("com.sun.javafx.print.PrintHelper")  
    Dim P As Paper  
    P.Initialize  
    P.SetObject(PrintH.RunMethod("createPaper",Array(Name,Width,Height,tUnits.GetField(Units.ToUpperCase))))  
    Return P  
End Sub
```

  
  
To use in Java 9+ you will need to add to the top of your Main Module:  

```B4X
#VirtualMachineArgs: –add-opens javafx.graphics/javafx.print=ALL-UNNAMED  
#VirtualMachineArgs: –add-opens javafx.graphics/com.sun.javafx.print=ALL-UNNAMED
```

  
  
To package the app you will also need:  

```B4X
#PackagerProperty : VMArgs = –add-opens  javafx.graphics/javafx.print=b4j  
#PackagerProperty : VMArgs = –add-opens  javafx.graphics/com.sun.javafx.print=b4j
```

  
  
The classes are com.sun classes and I can't find documentation for them - see post #2.  
  
This should be used with caution of course, there is no guarantee that a printer will honour a paper size that it does not support with possible unforeseeable consequences.