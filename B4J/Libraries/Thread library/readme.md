### Thread library by tummosoft
### 02/07/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/170208/)

This library lets you run Basic4android Subs on separate threads to the main GUI thread.  
- Source: <https://github.com/tummosoft/ThreadB4A>  
  

```B4X
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
    Private Button1 As B4XView  
    Dim thread1 As Thread  
    Dim thread2 As Thread  
    Dim thread3 As Thread  
    Dim helpMe As Helper  
    Private Label1 As Label  
    Private time As Long = 999  
    Private Button2 As Button  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    MainForm.Show  
    thread1.Initialise("thread1")  
    thread2.Initialise("thread2")  
    
    thread3.Initialise("thread2")  
            
    helpMe.Initialize  
    
End Sub  
  
Sub Button1_Click  
    thread1.start("test1")  
        
    thread2.start("test2")    
    
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
  
Sub add(a As Int) As Int  
    Log("add———————-")  
    Dim rs As Int = a + 10  
    Return rs  
End Sub  
  
Private Sub Button2_Click  
    'helpMe.startThread  
    Dim obj As Object = thread3.Start2("add", "int", 15)  
    
    Log(obj)  
End Sub
```