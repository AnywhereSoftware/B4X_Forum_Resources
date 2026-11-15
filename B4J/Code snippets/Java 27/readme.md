### Java 27 by Daestrum
### 11/06/2026
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/172501/)

Found a fun thing in java27 - all the hours spent trying to make title bar of form look cool - they coded it now  
  
![](https://www.b4x.com/android/forum/attachments/174710)  
  
Example code - (crappy code was just testing it)  
  

```B4X
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI   
    Private Button1 As B4XView  
    Dim button2 As TextField  
    Dim HeaderBar As JavaObject  
    Dim la As Label  
    Dim p As Pane  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.SetFormStyle("EXTENDED")  
    MainForm.RootPane.LoadLayout("Layout1")  
    la.Initialize("la")  
    la.Text = "Search here"  
    button2.Initialize("b2")  
    button2.Text = "?"  
    button2.SetSize(120,25)  
   
    p.Initialize("p")   
      
    p.AddNode(button2,70,0,-1,-1)  
    p.AddNode(la,-1,-1,-1,-1)  
    HeaderBar.InitializeNewInstance("javafx.scene.layout.HeaderBar",Null)  
    HeaderBar.RunMethod("setCenter",Array(p))  
    HeaderBar.Runmethod("setStyle",Array("-fx-background-color: linear-gradient(to right, pink, lightgreen);"))  
    MainForm.RootPane.AddNode(HeaderBar,0,0,MainForm.Width,-1)  
    MainForm.Show  
End Sub
```