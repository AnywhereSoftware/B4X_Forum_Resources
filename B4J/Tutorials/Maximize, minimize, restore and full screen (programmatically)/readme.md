### Maximize, minimize, restore and full screen (programmatically) by rtek1000
### 03/17/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/128724/)

Based on this [post](https://www.b4x.com/android/forum/threads/full-screen.35775/#content) and in other internet searches:  
  
(Attached sample project)  
  

```B4X
#Region Project Attributes  
    #MainFormWidth: 600  
    #MainFormHeight: 600  
#End Region  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
    Private Button1 As B4XView  
    Private Button2 As B4XView  
    Private Button3 As B4XView  
    Private Button4 As B4XView  
    Private Button5 As B4XView  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    MainForm.Show  
End Sub  
  
Private Sub setFullscreen(value As Boolean)  
    Dim jmf As JavaObject = MainForm  
    Dim stage As JavaObject = jmf.GetField("stage")  
  
    stage.RunMethod("setFullScreen", Array As Object(value))  
End Sub  
  
Private Sub maximizeMe  
    Dim jmf As JavaObject = MainForm  
    Dim stage As JavaObject = jmf.GetField("stage")  
  
    stage.RunMethod("setMaximized", Array As Object(True))  
End Sub  
  
Private Sub restoreMe  
    Dim jmf As JavaObject = MainForm  
    Dim stage As JavaObject = jmf.GetField("stage")  
  
    stage.RunMethod("setMaximized", Array As Object(False))  
End Sub  
  
Private Sub minimizeMe  
    Dim jmf As JavaObject = MainForm  
    Dim stage As JavaObject = jmf.GetField("stage")  
  
    stage.RunMethod("setIconified", Array As Object(True))  
End Sub  
  
Private Sub Button1_Click  
    setFullscreen(True)  
End Sub  
  
Private Sub Button2_Click  
    setFullscreen(False)  
End Sub  
  
Private Sub Button3_Click  
    maximizeMe  
End Sub  
  
Private Sub Button4_Click  
    restoreMe  
End Sub  
  
Private Sub Button5_Click  
    minimizeMe  
End Sub
```