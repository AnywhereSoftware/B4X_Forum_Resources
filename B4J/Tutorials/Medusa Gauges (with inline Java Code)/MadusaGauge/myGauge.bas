B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.1
@EndOfDesignText@

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








