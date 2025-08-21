### Raise Your Own Exceptions by keirS
### 05/28/2020
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/118324/)

Currently writing a cross platform library and I want to throw my own exceptions for cases like division by zero etc.  
  

```B4X
Sub Class_Globals  
      
    #If B4i  
       Private Exception As NativeObject  
    #Else  
       Private Exception As JavaObject  
   #End If  
   Private ExceptionName As String  
   Private ExceptionReason As String  
   Private ExceptionModule As String  
   Private ExceptionSub As String  
   Private ClassModule As Boolean  
   Private ExceptionDescription As String  
     
      
End Sub  
  
'Initializes the object. You can add parameters to this method if needed.  
Public Sub Initialize(Name As String,Reason As String,Module As String,Method As String)  
    Dim SB As StringBuilder  
    ExceptionName = Name  
    ExceptionReason = Reason  
    ExceptionModule = Module  
    ExceptionSub = Method  
    SB.Initialize  
   
    SB.Append("Module: ").Append(ExceptionModule).Append(", ") _  
 .Append("Sub: ").Append(ExceptionSub).Append(", ") _  
 .Append("Reason: ").Append(ExceptionReason)  
   
 ExceptionDescription = SB.ToString  
    #If B4i  
       Exception.Initialize("NSException")  
   #Else  
      Exception = Me  
    #End If  
          
End Sub  
  
  
Public Sub Raise  
  
 #If B4J OR B4A  
    Exception.RunMethod("raiseException",Array(ExceptionDescription))  
  #Else  
     Exception.RunMethod("raise:format:",Array(ExceptionName,ExceptionDescription))  
  #End If  
      
      
End Sub  
  
#If Java  
  import java.lang.RuntimeException;  
    
  public void raiseException(String description)  {  
      java.lang.RuntimeException e = new RuntimeException(description);  
      throw e;  
     }  
#End IF
```

  
  
Usage:  
  

```B4X
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1") 'Load the layout file.  
    MainForm.Show  
    Dim Exception As B4XException  
    Exception.Initialize("Test","Test Exception","Main","AppStart")  
    Exception.Raise  
End Sub
```

  
  
Output:  
  
B4A/J  

```B4X
Caused by: java.lang.RuntimeException: Module: Main, Sub: AppStart, Reason: Test Exception
```

  
  
B4i  
  

```B4X
Error occurred on line: 47 (B4XException)  
Module: Main, Sub: Application_Start, Reason: Test Exception
```