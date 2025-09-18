### OdoMeter with JavaObject by Johan Schoeman
### 09/15/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/168650/)

[It is based on the Github project posted here.....](https://github.com/HanSolo/odometer)  
  
I will elaborate on this a bit later in the same thread - was really frustrating to get to a "workable solution in the last 3 days" using JavaObject as the original project extend Region that for some reason jut not want to show the UI "control". So, have edited the original Java code and short-circuited it to get into method "init" and then also got rid of the unnecessary CSS file as it basically contained sweet nothing and then compiled the code into a new Jar pointing using Java 19 with SLC.  
  
You need to copy the attached Jar to your B4J additional libs folder  
  
Run the attached B4J project - sure you will figure out the code in the Jar and then add additional methods using JavaObject including events.  
  
I don't know what the possible repercussions of my short circuit could be but the Java experts on this forum can comment on it. But other control added (buttons) are responsive when clicked.  
  
Looking forward to your comments and suggestions.  
  
Sample Code:  

```B4X
#Region Project Attributes  
    #MainFormWidth: 600  
    #MainFormHeight: 600  
  
#End Region  
  
#AdditionalJar: OdoMeterJHS  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
   
    Dim om As JavaObject  
   
    Dim t As Timer  
   
    Dim val As Double  
    Private Button1 As Button  
    Private Button2 As Button  
    Private Button3 As Button  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    MainForm.Show  
   
    om.InitializeNewInstance("eu.hansolo.fx.odometer.Odometer", Array(8,1))  
   
    Form1.RootPane.AddNode(om, 2dip, 2dip, 300dip, 50dip)  
  
    t.Initialize("t", 5)  
  
    val = 0.0  
    om.RunMethodJO("setValue", Array(val))  
   
End Sub  
  
Sub t_tick  
    val = val + 0.001  
    om.RunMethodJO("setValue", Array(val))  
End Sub  
  
Private Sub Button1_Click  
   
    t.Enabled = True  
   
End Sub  
  
Private Sub Button2_Click  
   
    t.Enabled = False  
   
End Sub  
  
Private Sub Button3_Click  
   
    val = 0.0  
    om.RunMethodJO("setValue", Array(val))  
   
End Sub
```

  
  
  
 ![](https://www.b4x.com/android/forum/attachments/166887)