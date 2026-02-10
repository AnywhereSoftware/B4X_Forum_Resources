### Thread library by tummosoft
### 02/04/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/170208/)

This library lets you run Basic4android Subs on separate threads to the main GUI thread.  
  

```B4X
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
    Private Button1 As B4XView  
    Dim thread1 As Thread  
    Dim thread2 As Thread  
    Private Label1 As Label  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    MainForm.Show  
    thread1.Initialise("thread1")  
    thread2.Initialise("thread2")  
    thread1.newThread("com.tummosoft.main", "test1")  
    thread2.newThread("com.tummosoft.main", "test2")  
End Sub  
  
Sub Button1_Click  
    thread1.start  
      
    thread2.Daemon = True  
    thread2.Name = "thread2"  
    thread2.start  
End Sub  
  
Sub Test1()  
    For i=0 To 2000000  
        Log("thread 1 = " & i)  
          
    Next  
End Sub  
  
Sub Test2()  
    For i=0 To 2000000  
        Log("thread 2 = " & i)  
    Next  
End Sub
```