### Referring back to properties and methods of an instance of a Class by William Lancee
### 03/22/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/115231/)

In part because I have lots of time on my hands.  
But also I was surprised at what I found. Probably lots of you won't be.  
  
I am working on a multi-platform project (B4A and B4J).  
As recommended, I made my actual App an single instance of a Class.  
That worked fine until I needed to instantiate another helper Class.  
How to reference back to the original App instance's properties and methods?  
  
CallSub was an option for methods, but what about properties (in B4A they can't be Process\_Globals)?  
See below, the magic is in casting the passed down "Me" to the original Class.  
It works in both B4A and B4J.  
  

```B4X
Sub Process_Globals  
    Public aNumber As Int = 999  
End Sub  
  
Sub Globals  
    Public theProgram As App  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)        'ignore  
    theProgram.Initialize  
End Sub
```

  
  

```B4X
'This is a class module App - but only one instance will created in Main  
Sub Class_Globals  
    Public myName As String = "William"  
End Sub  
  
Public Sub Initialize  
    Log("Referring back to Main " & Main.aNumber)  
    Main.aNumber = Main.aNumber + 1  
      
    'Initiate an instance of Utilities Class  
    Dim AUX As Utilities  
    AUX.Initialize(Me)  
    AUX.LogUtility  
End Sub  
  
Sub AppLog  
    Log("AppLog in instance of App Class")  
End Sub
```

  
  

```B4X
'This is the Utilities Class  
  
Sub Class_Globals  
    Dim theApp As App  
End Sub  
  
Public Sub Initialize (AppInstance As Object)  
    're-cast this object as class type App - here is the magic of this snippet  
    theApp = AppInstance  
End Sub     
  
Public Sub LogUtility  
    'can refer to properties and methods defined in App class  
    Log(theApp.myName)  
    theApp.AppLog  
      
    'can also refer to Process_Global variable in Main  
    Log(Main.aNumber)  
End Sub
```