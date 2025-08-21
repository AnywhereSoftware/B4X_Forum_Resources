### [BANanoVueMaterial] Handling Events by Mashiane
### 04/03/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/115831/)

Ola  
  
[Download](https://github.com/Mashiane/BANanoVuetify)  
  
This thread is to be about handling events in BANanoVueMaterial (aka BANanoVuetify). This is something that has been requested for me to explain some more.  
  
So I will start by addressing the question I was asked. How to detect changes in the stepper control.  
  
**Steppers  
  
![](https://www.b4x.com/android/forum/attachments/91188)  
  
1. Initialize the stepper and add the .SetOnChange event**  
  

```B4X
Dim stepper As VMStepper = vm.CreateStepper("a", Me).SetOnChange(Me, "stepperChange")
```

  
  
**2. Define the event handler**  
  

```B4X
Sub stepperChange(numx As Int)        'ignore  
    vm.ShowSnackBar(numx)  
End Sub
```