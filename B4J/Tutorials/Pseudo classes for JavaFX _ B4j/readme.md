### Pseudo classes for JavaFX / B4j by stevel05
### 08/23/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/149757/)

If you are creating a Javafx / B4j project with multiple themes & stylesheets, then you need this. You can create your own Pseudo classes for use in the stylesheets. Sorry, this one is definitely not cross platform.  
  
I thought it was going to be cumbersome, but it came down to 5 lines of code.  
  
It is simple to use:  
  

```B4X
' Declare a global variable for the pseudo class  
Private AltColorPseudoClass As PseudoClass  
.  
.  
.  
'Initialize the class in AppStart with the name of the PseudoClass  
AltColorPseudoClass.Initialize("altcolor")  
  
'Then find an appopriate place to update it  
  
Private Sub Label1_MouseEntered (EventData As MouseEvent)  
    AltColorPseudoClass.SetState(Label1,True)  
   
End Sub  
Private Sub label1_MouseExited (EventData As MouseEvent)  
    AltColorPseudoClass.SetState(Label1,False)  
End Sub
```

  
  
And in the stylesheet:  

```B4X
.label:altcolor{  
    -fx-background-color:Blue;  
}
```

  
  
The example project shows it's use with a Button, Label and B4xPlusMinus view. There is also a B4xLib with all 5 lines of code.  
  
There are no external dependencies.  
  
Enjoy.