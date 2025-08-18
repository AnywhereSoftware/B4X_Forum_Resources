### Medusa Gauges (with inline Java Code) by Johan Schoeman
### 10/30/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/135592/)

You can draw up to 25 different Gauges with basically the same B4J code. You need to download [Medusa-8.0.jar](https://jar-download.com/artifacts/eu.hansolo/Medusa/8.0/source-code) and add it to your B4J additional library folder.  
  

```B4X
    Public Skin_DigitalSkin As String = "DigitalSkin"  
    Public Skin_Amp As String = "AmpSkin"  
    Public Skin_Bar As String = "BarSkin"  
    Public Skin_BulletChart As String = "BulletChartSkin"  
    Public Skin_Dashboard As String = "DashboardSkin"  
    Public Skin_H As String = "HSkin"  
    Public Skin_Battery As String = "BatterySkin"  
    Public Skin_Gauge As String = "GaugeSkin"  
    Public Skin_Indicator As String = "IndicatorSkin"  
    Public Skin_Kpi As String = "KpiSkin"  
    Public Skin_Level As String = "LevelSkin"  
    Public Skin_Linear As String = "LinearSkin"  
    Public Skin_Modern As String = "ModernSkin"  
    Public Skin_Quarter As String = "QuarterSkin"  
    Public Skin_Section As String = "SectionSkin"  
    Public Skin_SimpleDigital As String = "SimpleDigitalSkin"  
    Public Skin_SimpleSection As String = "SimpleSectionSkin"  
    Public Skin_Simple As String = "SimpleSkin"  
    Public Skin_Slim As String = "SlimSkin"  
    Public Skin_SpaceX As String = "SpaceXSkin"  
    Public Skin_TileKpi As String = "TileKpiSkin"  
    Public Skin_TileSparkine As String = "TileSparklineSkin"  
    Public Skin_TileTextKpi As String = "TileTextKpiSkin"  
    Public Skin_Tiny As String = "TinySkin"  
    Public Skin_V As String = "VSkin"
```

  
  
Sample Code:  

```B4X
#Region Project Attributes  
    #MainFormWidth: 600  
    #MainFormHeight: 600  
#End Region  
  
#AdditionalJar: Medusa-8.0  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
    
    Dim mg1, mg2, mg3, mg4, mg5, mg6, mg7, mg8 As myGauge                                             'a reference to class "myGauge"  
    Dim mgJVO1, mgJVO2, mgJVO3, mgJVO4, mgJVO5, mgJVO6, mgJVO7, mgJVO8 As JavaObject                                       'the class "myGauge" will return an Object and we will then add it to a Pane  
    Private Pane1, Pane2, Pane3, Pane4, Pane5, Pane6, Pane7, Pane8 As Pane  
    
    Dim t1 As Timer  
    
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
  
    MainForm.Initialize("frm", fx.PrimaryScreen.MaxX - fx.PrimaryScreen.MinX, fx.PrimaryScreen.MaxY - fx.PrimaryScreen.MinY)  
    MainForm.WindowWidth = fx.PrimaryScreen.MaxX - fx.PrimaryScreen.MinX           'set the screen to full width/height  
    MainForm.WindowLeft = fx.PrimaryScreen.MinX  
    MainForm.WindowHeight = fx.PrimaryScreen.MaxY - fx.PrimaryScreen.MinY  
    MainForm.WindowTop = fx.PrimaryScreen.MinY  
    
    MainForm.RootPane.LoadLayout("Layout1")  
    MainForm.Show  
    
    t1.Initialize("t1", 1000)  
    t1.Enabled = True  
    
    'GAUGE 1   
    
    mg1.Initialize(Me, "mg1")  
    
    mg1.Animanted = True  
    mg1.GaugeTitle = "Speed"  
    mg1.GaugeTitleColor = fx.Colors.Red  
    mg1.GaugeUnit = "Km/h"  
    mg1.GaugeUnitColor = fx.Colors.Magenta  
    mg1.GaugeDecimals = 1  
    mg1.GaugeAnimationDuration = 500  
    
    Dim gval As Double = 40.0  
    mg1.GaugeValue = gval  
    mg1.GaugeValueColor = fx.Colors.Blue  
    mg1.GaugeBarColor = fx.Colors.Green           
    mg1.GaugeNeedleColor = fx.Colors.Red  
    mg1.GaugeThresholdColor = fx.Colors.Yellow  
    mg1.GaugeMinValue = 0.0  
    mg1.GaugeMaxValue = 100.0  
    mg1.GaugeThresholdValue = 70  
    mg1.GaugeSubTitle = "Johan"  
    mg1.GaugeSubTitleColor = fx.Colors.Black  
    mg1.GaugeThresholdVisible = True  
    mg1.GaugeTickLabelColor = fx.Colors.Red  
    mg1.GaugeTickMarkColor = fx.Colors.Cyan  
    mg1.TickLabelOrientation = mg1.TickLabelOrientation_ORTHOGONAL  
    
    'SELECT THE GAUGE TYPE HERE *******************************************************  
    mg1.GaugeSkin = mg1.Skin_V     
    '**********************************************************************************  
    mgJVO1 = mg1.drawGauge  
  
    Pane1.AddNode(mgJVO1,Pane1.Width*0.15,Pane1.Height*0.15,Pane1.Width*0.7,Pane1.Height*0.7)                      'add the Gauge (java object) to the pane at the specified position within the Pane  
  
    'GAUGE 2  
    mg2.Initialize(Me, "mg2")  
    
    mg2.Animanted = True  
    mg2.GaugeTitle = "Speed"  
    mg2.GaugeTitleColor = fx.Colors.Red  
    mg2.GaugeUnit = "Km/h"  
    mg2.GaugeUnitColor = fx.Colors.Magenta  
    mg2.GaugeDecimals = 1  
    mg2.GaugeAnimationDuration = 500  
    
    gval = 40.0  
    mg2.GaugeValue = gval  
    mg2.GaugeValueColor = fx.Colors.Blue  
    mg2.GaugeBarColor = fx.Colors.Green  
    mg2.GaugeNeedleColor = fx.Colors.Red  
    mg2.GaugeThresholdColor = fx.Colors.Yellow  
    mg2.GaugeMinValue = 0.0  
    mg2.GaugeMaxValue = 100.0  
    mg2.GaugeThresholdValue = 70  
    mg2.GaugeSubTitle = "Johan"  
    mg2.GaugeSubTitleColor = fx.Colors.Black  
    mg2.GaugeThresholdVisible = True  
    mg2.GaugeTickLabelColor = fx.Colors.Red  
    mg2.GaugeTickMarkColor = fx.Colors.Cyan  
    mg2.TickLabelOrientation = mg2.TickLabelOrientation_ORTHOGONAL  
    
    'SELECT THE GAUGE TYPE HERE *******************************************************  
    mg2.GaugeSkin = mg2.Skin_Modern  
    '**********************************************************************************  
    mgJVO2 = mg2.drawGauge  
  
    Pane2.AddNode(mgJVO2,Pane2.Width*0.15,Pane2.Height*0.15,Pane2.Width*0.7,Pane2.Height*0.7)                      'add the Gauge (java object) to the pane at the specified position within the Pane  
  
  
    'GAUGE 3  
    mg3.Initialize(Me, "mg3")  
    
    mg3.Animanted = True  
    mg3.GaugeTitle = "Speed"  
    mg3.GaugeTitleColor = fx.Colors.Red  
    mg3.GaugeUnit = "Km/h"  
    mg3.GaugeUnitColor = fx.Colors.Magenta  
    mg3.GaugeDecimals = 1  
    mg3.GaugeAnimationDuration = 500  
    
    gval = 40.0  
    mg3.GaugeValue = gval  
    mg3.GaugeValueColor = fx.Colors.Blue  
    mg3.GaugeBarColor = fx.Colors.Green  
    mg3.GaugeNeedleColor = fx.Colors.Red  
    mg3.GaugeThresholdColor = fx.Colors.Yellow  
    mg3.GaugeMinValue = 0.0  
    mg3.GaugeMaxValue = 100.0  
    mg3.GaugeThresholdValue = 70  
    mg3.GaugeSubTitle = "Johan"  
    mg3.GaugeSubTitleColor = fx.Colors.Black  
    mg3.GaugeThresholdVisible = True  
    mg3.GaugeTickLabelColor = fx.Colors.Red  
    mg3.GaugeTickMarkColor = fx.Colors.Cyan  
    mg3.TickLabelOrientation = mg3.TickLabelOrientation_ORTHOGONAL  
    
    'SELECT THE GAUGE TYPE HERE *******************************************************  
    mg3.GaugeSkin = mg3.Skin_Quarter  
    '**********************************************************************************  
    mgJVO3 = mg3.drawGauge  
  
    Pane3.AddNode(mgJVO3,Pane3.Width*0.15,Pane3.Height*0.15,Pane3.Width*0.7,Pane3.Height*0.7)                      'add the Gauge (java object) to the pane at the specified position within the Pane  
  
  
    'GAUGE 4  
    mg4.Initialize(Me, "mg4")  
    
    mg4.Animanted = True  
    mg4.GaugeTitle = "Speed"  
    mg4.GaugeTitleColor = fx.Colors.Red  
    mg4.GaugeUnit = "Km/h"  
    mg4.GaugeUnitColor = fx.Colors.Magenta  
    mg4.GaugeDecimals = 1  
    mg4.GaugeAnimationDuration = 500  
    
    gval = 40.0  
    mg4.GaugeValue = gval  
    mg4.GaugeValueColor = fx.Colors.Blue  
    mg4.GaugeBarColor = fx.Colors.Green  
    mg4.GaugeNeedleColor = fx.Colors.Red  
    mg4.GaugeThresholdColor = fx.Colors.Yellow  
    mg4.GaugeMinValue = 0.0  
    mg4.GaugeMaxValue = 100.0  
    mg4.GaugeThresholdValue = 70  
    mg4.GaugeSubTitle = "Johan"  
    mg4.GaugeSubTitleColor = fx.Colors.Black  
    mg4.GaugeThresholdVisible = True  
    mg4.GaugeTickLabelColor = fx.Colors.Red  
    mg4.GaugeTickMarkColor = fx.Colors.Cyan  
    mg4.TickLabelOrientation = mg4.TickLabelOrientation_ORTHOGONAL  
    
    'SELECT THE GAUGE TYPE HERE *******************************************************  
    mg4.GaugeSkin = mg4.Skin_DigitalSkin  
    '**********************************************************************************  
    mgJVO4 = mg4.drawGauge  
  
    Pane4.AddNode(mgJVO4,Pane4.Width*0.15,Pane4.Height*0.15,Pane4.Width*0.7,Pane4.Height*0.7)                      'add the Gauge (java object) to the pane at the specified position within the Pane  
  
    'GAUGE 5  
    mg5.Initialize(Me, "mg5")  
    
    mg5.Animanted = True  
    mg5.GaugeTitle = "Speed"  
    mg5.GaugeTitleColor = fx.Colors.Red  
    mg5.GaugeUnit = "Km/h"  
    mg5.GaugeUnitColor = fx.Colors.Magenta  
    mg5.GaugeDecimals = 1  
    mg5.GaugeAnimationDuration = 500  
    
    gval = 40.0  
    mg5.GaugeValue = gval  
    mg5.GaugeValueColor = fx.Colors.Blue  
    mg5.GaugeBarColor = fx.Colors.Green  
    mg5.GaugeNeedleColor = fx.Colors.Red  
    mg5.GaugeThresholdColor = fx.Colors.Yellow  
    mg5.GaugeMinValue = 0.0  
    mg5.GaugeMaxValue = 100.0  
    mg5.GaugeThresholdValue = 70  
    mg5.GaugeSubTitle = "Johan"  
    mg5.GaugeSubTitleColor = fx.Colors.Black  
    mg5.GaugeThresholdVisible = True  
    mg5.GaugeTickLabelColor = fx.Colors.Red  
    mg5.GaugeTickMarkColor = fx.Colors.Cyan  
    mg5.TickLabelOrientation = mg5.TickLabelOrientation_ORTHOGONAL  
    
    'SELECT THE GAUGE TYPE HERE *******************************************************  
    mg5.GaugeSkin = mg5.Skin_TileKpi  
    '**********************************************************************************  
    mgJVO5 = mg5.drawGauge  
  
    Pane5.AddNode(mgJVO5,Pane5.Width*0.15,Pane5.Height*0.15,Pane5.Width*0.7,Pane5.Height*0.7)                      'add the Gauge (java object) to the pane at the specified position within the Pane  
  
    'GAUGE 6  
    mg6.Initialize(Me, "mg6")  
    
    mg6.Animanted = True  
    mg6.GaugeTitle = "Speed"  
    mg6.GaugeTitleColor = fx.Colors.Red  
    mg6.GaugeUnit = "Km/h"  
    mg6.GaugeUnitColor = fx.Colors.Magenta  
    mg6.GaugeDecimals = 1  
    mg6.GaugeAnimationDuration = 500  
    
    gval = 40.0  
    mg6.GaugeValue = gval  
    mg6.GaugeValueColor = fx.Colors.Blue  
    mg6.GaugeBarColor = fx.Colors.Green  
    mg6.GaugeNeedleColor = fx.Colors.Red  
    mg6.GaugeThresholdColor = fx.Colors.Yellow  
    mg6.GaugeMinValue = 0.0  
    mg6.GaugeMaxValue = 100.0  
    mg6.GaugeThresholdValue = 70  
    mg6.GaugeSubTitle = "Johan"  
    mg6.GaugeSubTitleColor = fx.Colors.Black  
    mg6.GaugeThresholdVisible = True  
    mg6.GaugeTickLabelColor = fx.Colors.Red  
    mg6.GaugeTickMarkColor = fx.Colors.Cyan  
    mg6.TickLabelOrientation = mg6.TickLabelOrientation_ORTHOGONAL  
    
    'SELECT THE GAUGE TYPE HERE *******************************************************  
    mg6.GaugeSkin = mg6.Skin_TileSparkine  
    '**********************************************************************************  
    mgJVO6 = mg6.drawGauge  
  
    Pane6.AddNode(mgJVO6,Pane6.Width*0.15,Pane6.Height*0.15,Pane6.Width*0.7,Pane6.Height*0.7)                      'add the Gauge (java object) to the pane at the specified position within the Pane  
  
  
    'GAUGE 7  
    mg7.Initialize(Me, "mg7")  
    
    mg7.Animanted = True  
    mg7.GaugeTitle = "Speed"  
    mg7.GaugeTitleColor = fx.Colors.Red  
    mg7.GaugeUnit = "Km/h"  
    mg7.GaugeUnitColor = fx.Colors.Magenta  
    mg7.GaugeDecimals = 1  
    mg7.GaugeAnimationDuration = 500  
    
    gval = 40.0  
    mg7.GaugeValue = gval  
    mg7.GaugeValueColor = fx.Colors.Blue  
    mg7.GaugeBarColor = fx.Colors.Green  
    mg7.GaugeNeedleColor = fx.Colors.Red  
    mg7.GaugeThresholdColor = fx.Colors.Yellow  
    mg7.GaugeMinValue = 0.0  
    mg7.GaugeMaxValue = 100.0  
    mg7.GaugeThresholdValue = 70  
    mg7.GaugeSubTitle = "Johan"  
    mg7.GaugeSubTitleColor = fx.Colors.Black  
    mg7.GaugeThresholdVisible = True  
    mg7.GaugeTickLabelColor = fx.Colors.Red  
    mg7.GaugeTickMarkColor = fx.Colors.Cyan  
    mg7.TickLabelOrientation = mg7.TickLabelOrientation_ORTHOGONAL  
    
    'SELECT THE GAUGE TYPE HERE *******************************************************  
    mg7.GaugeSkin = mg7.Skin_Gauge  
    '**********************************************************************************  
    mgJVO7 = mg7.drawGauge  
  
    Pane7.AddNode(mgJVO7,Pane7.Width*0.15,Pane7.Height*0.15,Pane7.Width*0.7,Pane7.Height*0.7)                      'add the Gauge (java object) to the pane at the specified position within the Pane  
  
  
    'GAUGE 8  
    mg8.Initialize(Me, "mg8")  
    
    mg8.Animanted = True  
    mg8.GaugeTitle = "Speed"  
    mg8.GaugeTitleColor = fx.Colors.Red  
    mg8.GaugeUnit = "Km/h"  
    mg8.GaugeUnitColor = fx.Colors.Magenta  
    mg8.GaugeDecimals = 1  
    mg8.GaugeAnimationDuration = 500  
    
    gval = 40.0  
    mg8.GaugeValue = gval  
    mg8.GaugeValueColor = fx.Colors.Blue  
    mg8.GaugeBarColor = fx.Colors.Green  
    mg8.GaugeNeedleColor = fx.Colors.Red  
    mg8.GaugeThresholdColor = fx.Colors.Yellow  
    mg8.GaugeMinValue = 0.0  
    mg8.GaugeMaxValue = 100.0  
    mg8.GaugeThresholdValue = 70  
    mg8.GaugeSubTitle = "Johan"  
    mg8.GaugeSubTitleColor = fx.Colors.Black  
    mg8.GaugeThresholdVisible = True  
    mg8.GaugeTickLabelColor = fx.Colors.Red  
    mg8.GaugeTickMarkColor = fx.Colors.Cyan  
    mg8.TickLabelOrientation = mg8.TickLabelOrientation_ORTHOGONAL  
    
    'SELECT THE GAUGE TYPE HERE *******************************************************  
    mg8.GaugeSkin = mg8.Skin_BulletChart  
    '**********************************************************************************  
    mgJVO8 = mg8.drawGauge  
  
    Pane8.AddNode(mgJVO8,Pane8.Width*0.15,Pane8.Height*0.15,Pane8.Width*0.7,Pane8.Height*0.7)                      'add the Gauge (java object) to the pane at the specified position within the Pane  
  
  
End Sub  
  
Sub t1_tick  
    
    Dim myval As Double = Rnd(0,101)  
    Sleep(0)  
    mg1.GaugeValue = myval  
    mg2.GaugeValue = myval  
    mg3.GaugeValue = myval  
    mg4.GaugeValue = myval  
    mg5.GaugeValue = myval  
    mg6.GaugeValue = myval  
    mg7.GaugeValue = myval  
    mg8.GaugeValue = myval  
End Sub
```

  
  
Class:  

```B4X
Sub Class_Globals  
    Private fx As JFX  
    Dim nativeMe, mg As JavaObject                                'mg holds the Gauge object  
    
    Private mEventName As String  
    Private mCallbackModule As Object  
    
    Public TickLabelOrientation_ORTHOGONAL As String = "ORTHOGONAL"  
    Public TickLabelOrientation_HORIZONTAL As String = "HORIZONTAL"  
    Public TickLabelOrientation_TANGENT As String = "TANGENT"  
    
    Public Skin_DigitalSkin As String = "DigitalSkin"  
    Public Skin_Amp As String = "AmpSkin"  
    Public Skin_Bar As String = "BarSkin"  
    Public Skin_BulletChart As String = "BulletChartSkin"  
    Public Skin_Dashboard As String = "DashboardSkin"  
    Public Skin_H As String = "HSkin"  
    Public Skin_Battery As String = "BatterySkin"  
    Public Skin_Gauge As String = "GaugeSkin"  
    Public Skin_Indicator As String = "IndicatorSkin"  
    Public Skin_Kpi As String = "KpiSkin"  
    Public Skin_Level As String = "LevelSkin"  
    Public Skin_Linear As String = "LinearSkin"  
    Public Skin_Modern As String = "ModernSkin"  
    Public Skin_Quarter As String = "QuarterSkin"  
    Public Skin_Section As String = "SectionSkin"  
    Public Skin_SimpleDigital As String = "SimpleDigitalSkin"  
    Public Skin_SimpleSection As String = "SimpleSectionSkin"  
    Public Skin_Simple As String = "SimpleSkin"  
    Public Skin_Slim As String = "SlimSkin"  
    Public Skin_SpaceX As String = "SpaceXSkin"  
    Public Skin_TileKpi As String = "TileKpiSkin"  
    Public Skin_TileSparkine As String = "TileSparklineSkin"  
    Public Skin_TileTextKpi As String = "TileTextKpiSkin"  
    Public Skin_Tiny As String = "TinySkin"  
    Public Skin_V As String = "VSkin"  
    
End Sub  
  
'Initializes the Gauge object  
Public Sub Initialize(CallbackModule As Object, EventName As String)  
    
    nativeMe = Me                                                 'initialize an instance of the Pie Chart object  
    mEventName = EventName  
    mCallbackModule = CallbackModule  
    nativeMe.RunMethod("initialize", Null)  
  
End Sub  
  
'Get the Gauge instance - you should add it to a pane  
public Sub drawGauge() As JavaObject  
    
    mg = nativeMe.RunMethod("drawGauge", Null)  
    Return mg  
    
End Sub  
  
'set the Gauge animation to true or false  
public Sub setAnimanted(animated As Boolean)  
    
    nativeMe.RunMethod("setAnimated", Array(animated))  
    
End Sub  
  
  
'set the Value to be displayed on the Gauge  
Public Sub setGaugeValue (value As Double)  
    
    nativeMe.RunMethod("setGaugeValue", Array(value))  
    
End Sub  
  
'set the color of the Value that is displayed on the Gauge  
Public Sub setGaugeValueColor (value As JavaObject)  
    
    nativeMe.RunMethod("setGaugeValueColor", Array(value))  
    
End Sub  
  
'set the Title of the Gauge  
Public Sub setGaugeTitle (value As String)  
    
    nativeMe.RunMethod("setTitle", Array(value))  
    
End Sub  
  
'set the Sub Title of the Gauge  
Public Sub setGaugeSubTitle (value As String)  
    
    nativeMe.RunMethod("setGaugeSubTitle", Array(value))  
    
End Sub  
  
'set the color of the Gauge's Sub Title  
Public Sub setGaugeSubTitleColor (value As JavaObject)  
    
    nativeMe.RunMethod("setGaugeSubTitleColor", Array(value))  
    
End Sub  
  
'set the Title color of the Gauge  
Public Sub setGaugeTitleColor (value As JavaObject)  
    
    nativeMe.RunMethod("setGaugeTitleColor", Array(value))  
    
End Sub  
  
'set the Units of the Gauge eg Km/h  
Public Sub setGaugeUnit (value As String)  
    
    nativeMe.RunMethod("setGaugeUnit", Array(value))  
    
End Sub  
  
'set the color of the Gauge's Units text  
'type must be javafx.scene.paint.Color  
Public Sub setGaugeUnitColor (value As JavaObject)  
    
    nativeMe.RunMethod("setGaugeUnitColor", Array(value))  
    
End Sub  
  
'set the color of the Gauge's Bar  
'type must be javafx.scene.paint.Color  
Public Sub setGaugeBarColor (value As JavaObject)  
    
    nativeMe.RunMethod("setGaugeBarColor", Array(value))  
    
End Sub  
  
'set the color of the Gauge's Needle  
'type must be javafx.scene.paint.Color  
Public Sub setGaugeNeedleColor (value As JavaObject)  
    
    nativeMe.RunMethod("setGaugeNeedleColor", Array(value))  
    
End Sub  
  
'set the number of decimals to display  
Public Sub setGaugeDecimals (value As Int)  
    
    nativeMe.RunMethod("setGaugeDecimals", Array(value))  
    
End Sub  
  
'set the animation duration of the gauge (milliseconds)  
Public Sub setGaugeAnimationDuration (value As Int)  
    
    nativeMe.RunMethod("setGaugeAnimationDuration", Array(value))  
    
End Sub  
  
'set the color of the Gauge's Threshold  
'for some selected skins the color will become this color if it crosses the threshold value  
Public Sub setGaugeThresholdColor (value As JavaObject)  
    
    nativeMe.RunMethod("setGaugeThresholdColor", Array(value))  
    
End Sub  
  
'set the maximum value of the Gauge  
Public Sub setGaugeMaxValue (value As Double)  
    
    nativeMe.RunMethod("setGaugeMaxValue", Array(value))  
    
End Sub  
  
'set the minimum value of the Gauge  
Public Sub setGaugeMinValue (value As Double)  
    
    nativeMe.RunMethod("setGaugeMinValue", Array(value))  
    
End Sub  
  
'set the threshold value of the Gauge  
public Sub setGaugeThresholdValue(value As Int)  
    
    nativeMe.RunMethod("setGaugeThresholdValue",Array(value))  
    
End Sub  
  
'set the threshold value of the Gauge  
public Sub setGaugeThresholdVisible(value As Boolean)  
    
    nativeMe.RunMethod("setGaugeThresholdVisible",Array(value))  
    
End Sub  
  
'set the color of the Gauge's tick labels  
Public Sub setGaugeTickLabelColor (value As JavaObject)  
    
    nativeMe.RunMethod("setGaugeTickLabelColor", Array(value))  
    
End Sub  
  
'set the color of the Gauge's tick marks  
Public Sub setGaugeTickMarkColor (value As JavaObject)  
    
    nativeMe.RunMethod("setGaugeTickMarkColor", Array(value))  
    
End Sub  
  
'set the tick label orientation  
Public Sub setTickLabelOrientation (value As String)  
    
    nativeMe.RunMethod("setTickLabelOrientation", Array(value))  
    
End Sub  
  
'set the tick label orientation  
Public Sub setGaugeSkin (value As String)  
    
    nativeMe.RunMethod("setGaugeSkin", Array(value))  
    
End Sub  
  
  
  
  
'INLINE JAVA CODE BELOW  
  
#if Java  
  
//START OF IMPORTS  
import eu.hansolo.medusa.Gauge;  
import eu.hansolo.medusa.skins.*;  
import javafx.scene.paint.Color;  
import eu.hansolo.medusa.TickLabelOrientation;  
import eu.hansolo.medusa.TickMarkType;  
//END OF IMPORTS  
  
//DECLARING VARIABLES  
private BA ba;  
private Gauge gauge;  
  
    
    public Gauge drawGauge() {                           
        return gauge;                                               //return the pie chart as an object - b4j code will add it to Pane 1  
    }  
    
    public void initialize() {  
        gauge = new Gauge();  
    }  
    
    public void setTitle(String title) {  
        gauge.setTitle(title);  
    }  
    
    public void setGaugeTitleColor (javafx.scene.paint.Color value) {  
        gauge.setTitleColor(value);  
    }  
    
    public void setGaugeUnit(String unit) {  
        gauge.setUnit(unit);  
    }  
    
    public void setGaugeUnitColor(javafx.scene.paint.Color value) {  
        gauge.setUnitColor(value);  
    }  
    
    public void setGaugeDecimals(int value) {  
        gauge.setDecimals(value);  
    }  
    
    public void setGaugeAnimationDuration(int value) {  
        gauge.setAnimationDuration(value);  
    }  
    
    public void setGaugeBarColor(javafx.scene.paint.Color value) {  
        gauge.setBarColor(value);  
    }  
    
    public void setGaugeNeedleColor(javafx.scene.paint.Color value) {  
        gauge.setNeedleColor(value);  
    }  
    
    public void setGaugeThresholdColor(javafx.scene.paint.Color value) {  
        gauge.setThresholdColor(value);  
    }  
    
    public void setGaugeMaxValue(double value) {  
        gauge.setMaxValue(value);  
    }  
    
    public void setGaugeMinValue(double value) {  
        gauge.setMinValue(value);  
    }   
    
    public void setGaugeThresholdValue(int value) {  
        gauge.setThreshold(value);  
    }  
    
    public void setGaugeSubTitle(String value) {  
        gauge.setSubTitle(value);  
    }  
    
    public void setGaugeSubTitleColor(javafx.scene.paint.Color value) {  
        gauge.setSubTitleColor(value);  
    }   
    
    public void setGaugeThresholdVisible(boolean value) {  
        gauge.setThresholdVisible(value);  
    }  
    
    public void setGaugeTickLabelColor(javafx.scene.paint.Color value) {  
        gauge.setTickLabelColor(value);  
    }  
    
    public void setGaugeTickMarkColor(javafx.scene.paint.Color value) {  
        gauge.setTickMarkColor(value);  
    }  
    
    
    public void setTickLabelOrientation(String value) {  
    
        if (value.equals("ORTHOGONAL"))  
            gauge.setTickLabelOrientation(TickLabelOrientation.ORTHOGONAL);  
  
        if (value.equals("HORIZONTAL")) {  
            gauge.setTickLabelOrientation(TickLabelOrientation.HORIZONTAL);   
        }       
            
        if (value.equals("TANGENT")) {  
            gauge.setTickLabelOrientation(TickLabelOrientation.TANGENT);  
        }           
    }  
    
        
    public void setAnimated(boolean value) {  
         gauge.setAnimated(value);  
    }  
    
    public void setGaugeValue (double value) {  
         gauge.setValue(value); //deafult position of needle on gauage  
    }  
    
    public void setGaugeValueColor(javafx.scene.paint.Color value) {  
        gauge.setValueColor(value);  
    }  
    
    public void setGaugeSkin(String value) {  
        if (value.equals("DigitalSkin"))  
            gauge.setSkin(new DigitalSkin(gauge));  
        if (value.equals("AmpSkin"))  
            gauge.setSkin(new AmpSkin(gauge));       
        if (value.equals("BarSkin"))  
            gauge.setSkin(new BarSkin(gauge));           
        if (value.equals("BulletChartSkin"))  
            gauge.setSkin(new BulletChartSkin(gauge));       
        if (value.equals("DashboardSkin"))  
            gauge.setSkin(new DashboardSkin(gauge));   
        if (value.equals("HSkin"))  
            gauge.setSkin(new HSkin(gauge));       
        if (value.equals("BatterySkin"))  
            gauge.setSkin(new BatterySkin(gauge));   
        if (value.equals("GaugeSkin"))  
            gauge.setSkin(new GaugeSkin(gauge));   
        if (value.equals("IndicatorSkin"))  
            gauge.setSkin(new IndicatorSkin(gauge));  
        if (value.equals("KpiSkin"))  
            gauge.setSkin(new KpiSkin(gauge));                                                                                                   
        if (value.equals("LevelSkin"))  
            gauge.setSkin(new LevelSkin(gauge));                           
        if (value.equals("LinearSkin"))  
            gauge.setSkin(new LinearSkin(gauge));                   
        if (value.equals("ModernSkin"))  
            gauge.setSkin(new ModernSkin(gauge));   
        if (value.equals("QuarterSkin"))  
            gauge.setSkin(new QuarterSkin(gauge));           
        if (value.equals("SectionSkin"))  
            gauge.setSkin(new SectionSkin(gauge));   
        if (value.equals("SimpleDigitalSkin"))  
            gauge.setSkin(new SimpleDigitalSkin(gauge));   
        if (value.equals("SimpleSectionSkin"))  
            gauge.setSkin(new SimpleSectionSkin(gauge));  
        if (value.equals("SimpleSkin"))  
            gauge.setSkin(new SimpleSkin(gauge));  
        if (value.equals("SlimSkin"))  
            gauge.setSkin(new SlimSkin(gauge));           
        if (value.equals("SpaceXSkin"))  
            gauge.setSkin(new SpaceXSkin(gauge));   
        if (value.equals("TileKpiSkin"))  
            gauge.setSkin(new TileKpiSkin(gauge));   
        if (value.equals("TileSparklineSkin"))  
            gauge.setSkin(new TileSparklineSkin(gauge));   
        if (value.equals("TileTextKpiSkin"))  
            gauge.setSkin(new TileTextKpiSkin(gauge));   
        if (value.equals("TinySkin"))  
            gauge.setSkin(new TinySkin(gauge));       
        if (value.equals("VSkin"))  
            gauge.setSkin(new VSkin(gauge));                                                                                                                                                                                                               
    }  
    
#End If
```

  
  
![](https://www.b4x.com/android/forum/attachments/120982)