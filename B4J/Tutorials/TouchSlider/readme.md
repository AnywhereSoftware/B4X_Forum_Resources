### TouchSlider by Johan Schoeman
### 09/06/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/168549/)

It comes [**from here**](https://github.com/HanSolo/TouchSlider). Seems to me you need at least Java SDK 17. I have used 19 for this B4J project - all dome with JavaObject.  
Attached the Jar and the B4J project - copy the jar to your B4J additional Library folder.  
Values are logged in the IDE when you move the slider.  
Change it to your liking - view the JAR with a suitable JAR viewer.  
  
![](https://www.b4x.com/android/forum/attachments/166603)  
  

```B4X
#Region Project Attributes  
    #MainFormWidth: 600  
    #MainFormHeight: 600  
#End Region  
  
#AdditionalJar: TouchSlider-17.0.0  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    MainForm.Show  
      
    Dim vs As JavaObject  
    vs.InitializeNewInstance("eu.hansolo.fx.touchslider.TouchSlider", Null)  
    Dim tsb As JavaObject  
    tsb.InitializeStatic("eu.hansolo.fx.touchslider.TouchSliderBuilder")  
      
    Dim orient As JavaObject  
    orient.InitializeStatic("javafx.geometry.Orientation")  
      
    Dim jo As JavaObject = vs  
    Dim e As Object = jo.CreateEvent("eu.hansolo.fx.touchslider.TouchSliderObserver", "touchSlider", False)  
    
    Dim width, height, minvalue, range, zero As Double  
    width = 200  
    height = 600  
    minvalue = -100  
    range = 200  
    zero = 0  
    vs = tsb.RunMethodJO("create", Null) _  
            .RunMethodJO("prefSize", Array(width, height)) _  
            .RunMethodJO("name", Array("Volume")) _  
            .RunMethodJO("orientation", Array(orient.GetField("VERTICAL"))) _  
            .RunMethodJO("minValue", Array(minvalue)) _  
            .RunMethodJO("range", Array(range)) _  
            .RunMethodJO("formatString", Array("%.0f")) _  
            .RunMethodJO("barBackgroundColor", Array(fx.Colors.Yellow)) _  
            .RunMethodJO("barColor", Array(fx.Colors.Cyan)) _  
            .RunMethodJO("thumbColor", Array(fx.Colors.Magenta)) _  
            .RunMethodJO("showZero", Array(True)) _  
            .RunMethodJO("startFromZero", Array(True)) _  
            .RunMethodJO("valueTextColor", Array(fx.Colors.Green)) _  
            .RunMethodJO("nameTextColor", Array(fx.Colors.Black)) _  
            .RunMethodJO("valueVisible", Array(True)) _  
            .RunMethodJO("nameVisible", Array(True)) _  
            .RunMethodJO("zeroColor", Array(fx.Colors.WHITE)) _  
            .RunMethodJO("showZero", Array(True)) _  
            .RunMethodJO("startFromZero", Array(True)) _  
            .RunMethodJO("snapToZero", Array(True)) _  
            .RunMethodJO("sliderValue" , Array(zero)) _  
            .RunMethodJO("onTouchSliderEvent", Array(e)) _  
            .RunMethod("build", Null)  
              
    MainForm.RootPane.AddNode(vs, 2dip, 2dip, 100dip, 200dip)  
      
End Sub  
  
Sub touchSlider_Event (MethodName As String, Args() As Object) As Object  
    Dim result As JavaObject = Args(0)  
    Log(result.RunMethod("getValue", Null))  
      
    Return True  
End Sub
```