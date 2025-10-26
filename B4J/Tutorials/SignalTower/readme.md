### SignalTower by Johan Schoeman
### 10/24/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/169125/)

It comes [**from here**](https://github.com/HanSolo/Enzo/tree/master/src/main/java/eu.hansolo.enzo/signaltower). Have compiled it to a Jar (no XML) and using it with JavaObject. The Tower lights are switched via a B4J Timer. Switch them on whatever condition(s) you want them to be switched and whenever you want - just set the booleans:  
  

```B4X
st.RunMethod("setColors", Array(False, False, False))
```

  
  
Attached sample project and the JAR. Copy the Jar to your additional library folder. The CSS file was added to the compiled JAR with 7-zip.  
  
Sample code:  

```B4X
#Region Project Attributes  
    #MainFormWidth: 600  
    #MainFormHeight: 600  
#End Region  
  
#AdditionalJar: signalTower  
'#AdditionalJar: javafx.base  
'#AdditionalJar: javafx.controls  
'#AdditionalJar: javafx.graphics  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
     
    Dim st As JavaObject  
    Dim stb As JavaObject  
     
    Dim t As Timer  
  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    MainForm.Show  
     
    st.InitializeNewInstance("eu.hansolo.enzo.signaltower.SignalTower" , Null)  
    stb.InitializeStatic("eu.hansolo.enzo.signaltower.SignalTowerBuilder")  
     
    st = stb.RunMethodJO("create", Null).RunMethod("build", Null)  
     
    MainForm.RootPane.AddNode(st, 2dip, 2dip, 150dip, 300dip)  
     
    st.RunMethod("setColors", Array(False, False, False))  
     
    t.Initialize("t", 1000)  
     
    t.Enabled = True  
     
End Sub  
  
  
Sub t_tick  
     
    Dim a, b, c As Int  
    a= Rnd(0,2)  
    b= Rnd(0,2)  
    c=Rnd(0,2)  
  
    Dim onoffA As Boolean  
    Dim onoffB As Boolean  
    Dim onoffC As Boolean  
     
'    If a = 0 Then onoffA = False Else onoffA = True  
     
    onoffA = IIf(a=0, False, True)  
    onoffB = IIf(b=0, False, True)  
    onoffC = IIf(c=0, False, True)  
  
    st.RunMethod("setColors", Array(onoffA, onoffB, onoffC))  
  
     
End Sub
```

  
  
![](https://www.b4x.com/android/forum/attachments/167992)![](https://www.b4x.com/android/forum/attachments/167993)