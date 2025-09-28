### SixteenSegment by Johan Schoeman
### 09/24/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/168778/)

It comes from [**this Github posting**](https://github.com/HanSolo/Enzo/tree/master/src/main/java/eu.hansolo.enzo/sixteensegment).  
Copy the attached Jar to your B4J library folder.  
B4J Sample project attached  
  
Add more of the same, you can make it for eg scroll via a timer from left to right or from right to left.  
  
View the attached Jar with a suitable Jar viewer to see what else you can change.  
  
The attached B4J project will display your PC/laptop system time in the 8 x SixteenSegment controls that have been added to the MainForm.  
  
Enjoy!  
  
Sample Code:  
  

```B4X
#Region Project Attributes  
    #MainFormWidth: 600  
    #MainFormHeight: 600  
#End Region  
  
#AdditionalJar: SixteenSegment  
#AdditionalJar: javafx.base  
#AdditionalJar: javafx.controls  
#AdditionalJar: javafx.graphics  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
      
    Dim ssb As JavaObject  
    Dim ss0, ss1, ss2, ss3, ss4, ss5, ss6, ss7 As JavaObject  
      
    Dim t As Timer  
  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    MainForm.Show  
      
    t.Initialize("t", 1000)  
      
    ssb.Initializestatic("eu.hansolo.enzo.sixteensegment.SixteenSegmentBuilder")  
      
    Dim segstyle As JavaObject  
    segstyle.InitializeStatic("eu.hansolo.enzo.sixteensegment.SixteenSegment.SegmentStyle")  
      
'    RED("red"),  
'    GREEN("green"),  
'    BLUE("blue"),  
'    YELLOW("yellow"),  
'    ORANGE("orange"),  
'    CYAN("cyan"),  
'    MAGENTA("magenta"),  
'    WHITE("white"),  
'    BLACK("black");  
      
    ss0 = ssb.RunMethodJO("create", Null).RunMethodJO("character", Array("1")).runmethodJO("segmentStyle", Array(segstyle.GetField("WHITE"))).RunMethod("build", Null)  
    ss1 = ssb.RunMethodJO("create", Null).RunMethodJO("character", Array("1")).runmethodJO("segmentStyle", Array(segstyle.GetField("WHITE"))).RunMethod("build", Null)  
    ss2 = ssb.RunMethodJO("create", Null).RunMethodJO("character", Array("-")).runmethodJO("segmentStyle", Array(segstyle.GetField("BLUE"))).RunMethod("build", Null)  
    ss3 = ssb.RunMethodJO("create", Null).RunMethodJO("character", Array("0")).runmethodJO("segmentStyle", Array(segstyle.GetField("YELLOW"))).RunMethod("build", Null)  
    ss4 = ssb.RunMethodJO("create", Null).RunMethodJO("character", Array("0")).runmethodJO("segmentStyle", Array(segstyle.GetField("YELLOW"))).RunMethod("build", Null)  
    ss5 = ssb.RunMethodJO("create", Null).RunMethodJO("character", Array("-")).runmethodJO("segmentStyle", Array(segstyle.GetField("BLUE"))).RunMethod("build", Null)  
    ss6 = ssb.RunMethodJO("create", Null).RunMethodJO("character", Array("0")).runmethodJO("segmentStyle", Array(segstyle.GetField("RED"))).RunMethod("build", Null)  
    ss7 = ssb.RunMethodJO("create", Null).RunMethodJO("character", Array("0")).runmethodJO("segmentStyle", Array(segstyle.GetField("RED"))).RunMethod("build", Null)  
      
    MainForm.RootPane.AddNode(ss0, 2dip, 10dip, 50dip, 50dip)  
    MainForm.RootPane.AddNode(ss1, 53dip, 10dip, 50dip, 50dip)  
    MainForm.RootPane.AddNode(ss2, 104dip, 10dip, 50dip, 50dip)  
    MainForm.RootPane.AddNode(ss3, 155dip, 10dip, 50dip, 50dip)  
    MainForm.RootPane.AddNode(ss4, 206dip, 10dip, 50dip, 50dip)  
    MainForm.RootPane.AddNode(ss5, 257dip, 10dip, 50dip, 50dip)  
    MainForm.RootPane.AddNode(ss6, 308dip, 10dip, 50dip, 50dip)  
    MainForm.RootPane.AddNode(ss7, 359dip, 10dip, 50dip, 50dip)  
      
    ss1.RunMethod("setDotOn", Array(True))  
    ss4.RunMethod("setDotOn", Array(True))  
  
    t.Enabled = True  
      
End Sub  
  
  
Sub t_tick  
      
    Dim hr As String = DateTime.GetHour(DateTime.Now)  
    If hr.Length < 2 Then hr = "0" & hr  
    Dim minute As String = DateTime.GetMinute(DateTime.Now)  
    If minute.Length < 2 Then minute = "0" & minute  
    Dim second As String = DateTime.GetSecond(DateTime.Now)  
    If second.Length < 2 Then second = "0" & second  
      
    ss0.RunMethod("setCharacter", Array(hr.SubString2(0,1)))  
    ss1.RunMethod("setCharacter", Array(hr.SubString(1)))  
      
    ss3.RunMethod("setCharacter", Array(minute.SubString2(0,1)))  
    ss4.RunMethod("setCharacter", Array(minute.SubString(1)))  
      
    ss6.RunMethod("setCharacter", Array(second.SubString2(0,1)))  
    ss7.RunMethod("setCharacter", Array(second.SubString(1)))  
  
    Log(hr & " " & minute & " " & second)  
      
End Sub
```

  
  
![](https://www.b4x.com/android/forum/attachments/167226)