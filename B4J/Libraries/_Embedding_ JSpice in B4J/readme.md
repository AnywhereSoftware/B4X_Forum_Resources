### "Embedding" JSpice in B4J by Johan Schoeman
### 01/07/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/145314/)

It is based on this [**Github posting**](https://github.com/knowm/jspice) (JSpice) and the [**post that was placed here**](https://www.b4x.com/android/forum/threads/attempt-to-create-a-simulation-tool-for-electronic-components.130402/).  
  
"Waar daar 'n wil is, is daar 'n weg" - where there is a will, there is a way….  
  
The values in the TextArea and the Line Chart are 100% embedded in the attached B4J project. A bit of string manipulation to get the Xvalues and Yvalues extracted from the returned string to prepare them for the line chart - but it is working and the sample should be ample for those that want to fiddle around with JSpice.  
  
***Click on the line of the line chart - it will show the X/Y values at the bottom right of the chart***  
  
Get the Jar from here:  
<https://www.b4x.com/android/forum/threads/attempt-to-create-a-simulation-tool-for-electronic-components.130402/post-821012>  
  

```B4X
#Region Project Attributes  
    #MainFormWidth: 800  
    #MainFormHeight: 800  
#End Region  
  
#AdditionalJar: jspice-0.0.1.jar  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
    Private TextArea1 As TextArea  
  
    Private Pane1 As Pane  
   
    Dim lc1 As linechart  
  
    Dim myLineChart As JavaObject  
    Dim lclabel As Label  
   
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    MainForm.Show  
    TextArea1.Text = ""  
  
    Dim spice As JSpice  
    spice.Initialize  
   
    lclabel.Text = ""  
    lclabel.TextColor = fx.Colors.Red  
   
    'THIS IS EREL's EXAMPLE USING NETLISTBUILDER  
'    Dim builder As NetlistBuilder  
'    builder.Initialize  
'    builder.AddNetlistDCCurrent("a", 1, Array As String("0", "1")).AddNetlistResistor("R1", 10, Array As String("1", "0"))  
'    builder.AddNetlistResistor("R2", 1000, Array As String("1", "2")).AddNetlistResistor("R3", 1000, Array As String("2", "0"))  
'    Dim Netlist As JavaObject = builder.Build  
'    spice.Simulate(Netlist)  
  
''    'THIS IS EREL'S EXAMPLE USING IVR  
''    Dim netlist1 As IVR  
''    netlist1.Initialize  
''    Dim dcCurrent As Double = 1  
''    Dim R1 As Double = 10  
''    Dim R2 As Double = 1000  
''    Dim R3 As Double = 1000  
''    netlist1.addNetlistDCCurrent("a", dcCurrent, Array As String("0", "1"))  
''    netlist1.addNetlistResistor("R1", R1, Array As String("1", "0"))  
''    netlist1.addNetlistResistor("R2", R2, Array As String("1", "2"))  
''    netlist1.addNetlistResistor("R3", R3, Array As String("2", "0"))  
''    spice.Simulate(netlist1.build)  
''  
''    '*******************************************************************************************************************************  
''    'THIS IS WE SECOND EXAMPLE IN THE GITHUB POSTING / LINK  
''    Dim netlist2 As IVR                   'use for DC Current Source, DC Voltage Source, and Resistors  
''    netlist2.Initialize  
''    Dim dcCurrent As Double = 0.02  
''    netlist2.addNetlistDCCurrent("a", dcCurrent, Array As String("0", "4"))        'set the current source  
''    Dim dcVoltage As Double = 10  
''    netlist2.addNetlistDCVoltage("x", dcVoltage, Array As String("2", "5"))        'set the voltage source  
''  
''    Dim R1 As Double = 100  
''    netlist2.addNetlistResistor("R1", R1, Array As String("5", "0"))               'set the resistors  
''    Dim R2 As Double = 1000  
''    netlist2.addNetlistResistor("R2", R2, Array As String("0", "3"))  
''    Dim R3 As Double = 1000  
''    netlist2.addNetlistResistor("R3", R3, Array As String("2", "3"))  
''    Dim R4 As Double = 100  
''    netlist2.addNetlistResistor("R4", R4, Array As String("1", "2"))  
''    Dim R5 As Double = 1000  
''    netlist2.addNetlistResistor("R5", R5, Array As String("3", "0"))  
''    Dim R6 As Double = 10000  
''    netlist2.addNetlistResistor("R6", R6, Array As String("1", "4"))  
''  
''    spice.Simulate(netlist2.build)  
   
    '**********************************************************************************************************************************  
    'THIS IS AN EXAMPLE OF DC SWEEP ANALYSIS - IT WILL SHOW A GRAPH  
    spice.Initialize  
    Dim netlist3 As IVR  
    netlist3.Initialize  
    Dim dcVoltage As Double = 10  
    netlist3.addNetlistDCVoltage("x", dcVoltage, Array As String("1", "0"))        'set the voltage source  
    Dim R4 As Double = 100  
    netlist3.addNetlistResistor("R4", R4, Array As String("1", "2"))               'set the resistors  
    Dim R3 As Double = 1000  
    netlist3.addNetlistResistor("R3", R3, Array As String("2", "3"))               'set the resistors  
    Dim R2 As Double = 1000  
    netlist3.addNetlistResistor("R2", R2, Array As String("3", "0"))               'set the resistors  
    Dim R1 As Double = 100  
    netlist3.addNetlistResistor("R1", R1, Array As String("2", "0"))               'set the resistors  
   
    Dim startval As Double = 100  
    Dim endval As Double = 10000  
    Dim stepval As Double = 100  
   
    Dim dcSweepConfig As JavaObject  
    dcSweepConfig.InitializeNewInstance("org.knowm.jspice.simulate.dcsweep.DCSweepConfig", Array("R1", "V(3)", startval, endval, stepval))  
   
    Dim nl As JavaObject = netlist3.build  
    nl.RunMethod("setSimulationConfig", Array(dcSweepConfig))  
   
    spice.simulate(nl)  
   
    '***************************************************************************************************************************************  
   
End Sub  
  
Sub jspice_result(mystring As String)  
   
    Log("back in B4J")  
    Log(mystring)  
    TextArea1.Text = TextArea1.Text & mystring & CRLF  
   
   
    Dim yvals As String = mystring.SubString(mystring.LastIndexOf("["))  
    yvals = yvals.Replace("[", "")  
    yvals = yvals.Replace("]", "")  
    Log(yvals)  
   
    Dim xvalsBeginIndex As Int = mystring.IndexOf("[")  
    Dim xvalsEndIndex As Int = mystring.IndexOf("]")  
    Dim xvals As String = mystring.SubString2(xvalsBeginIndex + 8, xvalsEndIndex)  
    Log(xvals)  
   
    Dim yvalsarray() As String = Regex.Split("," , yvals)  
    Dim xvalsarray() As String = Regex.Split(",", xvals)  
  
  
    'START OF LINE CHART  
    'Initialize the chart  
    lc1.Initialize  
    'set the title - see the css file for setting the title color  
    lc1.Title = "DC Sweep Analysis"  
    lc1.YAxisTitle = "V(3)"  
   
    'set the x-axis "values"  
    lc1.Xvalues = xvalsarray  
    lc1.XAxisTitle = "R(R1)"  
  
    'set series 1 y-axis data  
    Dim yvalsfloat(yvalsarray.Length) As Float  
    For i = 0 To yvalsarray.Length - 1  
        yvalsfloat(i) = yvalsarray(i)  
    Next  
    lc1.Yvalues_1 = yvalsfloat  
    lc1.SeriesName_1 = "Series A"  
   
    lc1.YaxisMin = 2.3  
    lc1.YaxisMax = 5.0  
    lc1.YaxisStep = 0.5  
   
    lc1.ShowSymbols = False  
    lc1.ShowCrossHair = True  
  
    'draw the chart and then get it as a java object  
    myLineChart = lc1.drawLineChart  
    'add the line chart object to the root pane  
    Pane1.AddNode(myLineChart,Pane1.width * 0.025, Pane1.Height * 0.025, Pane1.Width * 0.95, Pane1.Height * 0.95)  
   
End Sub  
  
Sub linechart_value_clicked (mylist As List)  
   
    lclabel.Text = ""  
    For i = 0 To mylist.Size-1  
        lclabel.Text = lclabel.Text & mylist.get(i) & " "  
    Next  
   
End Sub
```

  
  
Class JSpice code (using inline Java):  

```B4X
Sub Class_Globals  
'    Private spice As JavaObject  
    Dim nativeMe As JavaObject  
End Sub  
  
'initialize the JSPICE object  
Public Sub Initialize  
'    spice.InitializeStatic("org.knowm.jspice.JSpice")  
    nativeMe = Me  
  
End Sub  
  
'simulate the circuit  
'a valid netlist needs to be passed for simulation purposes  
Public Sub Simulate (Netlist As JavaObject)  
  
'    spice.RunMethod("simulate", Array(Netlist))  
    nativeMe.RunMethod("simulate", Array(Netlist))  
   
End Sub  
  
'call back from the inline Java code with the result of simulation as a String  
'it will call sub jspice_result in Main and pass the String result to it so that the values can be used in the B4J UI  
Public Sub jspicecallback(mystring As String)  
'    Log("IN THE CALLBACK")  
  
'    Log("mystring = " & mystring)  
    CallSubDelayed2(Main,"jspice_result", mystring)  
    Sleep(1000)  
  
End Sub  
  
#if Java  
  
  
import java.io.FileNotFoundException;  
import java.io.FileOutputStream;  
import java.io.IOException;  
import java.io.PrintStream;  
  
import org.knowm.configuration.ConfigurationException;  
import org.knowm.configuration.ConfigurationFactory;  
import org.knowm.configuration.YamlConfigurationFactory;  
import org.knowm.configuration.provider.ConfigurationSourceProvider;  
import org.knowm.configuration.provider.FileConfigurationSourceProvider;  
import org.knowm.configuration.provider.ResourceConfigurationSourceProvider;  
import org.knowm.jackson.Jackson;  
import org.knowm.jspice.netlist.Netlist;  
import org.knowm.jspice.netlist.spice.SPICENetlistBuilder;  
import org.knowm.jspice.simulate.SimulationConfig;  
import org.knowm.jspice.simulate.SimulationPlotter;  
import org.knowm.jspice.simulate.SimulationResult;  
import org.knowm.jspice.simulate.dcoperatingpoint.DCOPConfig;  
import org.knowm.jspice.simulate.dcoperatingpoint.DCOperatingPoint;  
import org.knowm.jspice.simulate.dcoperatingpoint.DCOperatingPointResult;  
import org.knowm.jspice.simulate.dcsweep.DCSweep;  
import org.knowm.jspice.simulate.dcsweep.DCSweepConfig;  
import org.knowm.jspice.simulate.transientanalysis.TransientAnalysis;  
import org.knowm.jspice.simulate.transientanalysis.TransientConfig;  
import org.knowm.validation.BaseValidator;  
  
//public class JSpice {  
  
  private static boolean isFromCommandline = false;  
  private static String outFormat = "";  
  private static String fileName = "";  
  
/*  
  public static void main(String[] args) throws IOException, ConfigurationException {  
  
    if (args.length == 0) {  
      System.out.println("Proper Usage is: java -jar jspice <filename>");  
      System.exit(0);  
    }  
    isFromCommandline = true;  
    fileName = args[0];  
    simulate(args[0]);  
  
  }  
   
  */  
  
  public SimulationResult simulate(String fileName) throws IOException, ConfigurationException {  
  
    Netlist netlist = null;  
  
    // SPICE Netlist, must end in `.cir`  
    if (fileName.endsWith(".cir")) {  
  
      //      System.out.println("……………Executing netList…. " + fileName);  
  
      try {  
        netlist = SPICENetlistBuilder.buildFromSPICENetlist(fileName, new FileConfigurationSourceProvider());  
      } catch (FileNotFoundException e) {  
        // could not load from file, try from resources (for testing purposes usually)  
        netlist = SPICENetlistBuilder.buildFromSPICENetlist(fileName, new ResourceConfigurationSourceProvider());  
      }  
  
      // YAML file  
    } else {  
  
      ConfigurationFactory<Netlist> yamlConfigurationFactory = new YamlConfigurationFactory<Netlist>(Netlist.class, BaseValidator.newValidator(),  
          Jackson.newObjectMapper(), "");  
  
      ConfigurationSourceProvider provider = new FileConfigurationSourceProvider();  
  
      netlist = yamlConfigurationFactory.build(provider, fileName);  
    }  
  
    // 3. Run it  
    //    System.out.println("netList: \n" + netlist);  
  
    return simulate(netlist);  
  }  
  
//***********************************************************************************************  
    public String myresult;  
   
    public String getMyResult() {  
        return myresult;  
    }  
  
  public SimulationResult simulate(Netlist netlist) {  
      //BA.Log("IN SIMULATE");  
    myresult = "";  
  
    SimulationConfig simulationConfig = netlist.getSimulationConfig();  
  
    if (simulationConfig == null || simulationConfig instanceof DCOPConfig) {  
  
    //BA.Log("HERE 1");  
      DCOperatingPointResult dcOpResult = new DCOperatingPoint(netlist).run();  
      if (isFromCommandline) {  
  
      } else {  
        //System.out.println(dcOpResult.toString());  
     
        //BA.Log("HERE 2");  
        myresult = dcOpResult.toString();  
        ba.raiseEventFromUI(this, "jspicecallback", new Object[] {myresult});  
      }  
      return null;  
  
    } else if (simulationConfig instanceof DCSweepConfig) {  
  
      DCSweepConfig dcSweepConfig = (DCSweepConfig) simulationConfig;  
  
      // run DC sweep  
      DCSweep dcSweep = new DCSweep(netlist);  
      dcSweep.addSweepConfig(dcSweepConfig);  
      SimulationResult simulationResult = dcSweep.run(dcSweepConfig.getObserveID());  
      if (isFromCommandline) {  
  
      } else {  
          myresult = simulationResult.toString();  
        ba.raiseEventFromUI(this, "jspicecallback", new Object[] {myresult});  
        //System.out.println(simulationResult.toString());  
        //SimulationPlotter.plot(simulationResult, new String[]{dcSweepConfig.getObserveID()});  
      }  
      return simulationResult;  
  
    } else if (simulationConfig instanceof TransientConfig) {  
  
      TransientConfig simulationConfigTransient = (TransientConfig) simulationConfig;  
  
      // run TransientAnalysis  
      TransientAnalysis transientAnalysis = new TransientAnalysis(netlist, simulationConfigTransient);  
      SimulationResult simulationResult = transientAnalysis.run();  
  
      if (isFromCommandline) {  
  
        String format = netlist.getResultsFormat();  
        System.out.println("Results format: " + format);  
  
        // check the requested format of the results file  
        if (format.startsWith("RAW") || format.startsWith("raw")) {  
  
          // Raw format found so get the results filename passed on the .PRINT line of the netlist  
          String resFilename = netlist.getResultsFile();  
  
          // output as SPICE Raw  
          System.out.println("……………Writing simulation results to………." + resFilename);  
          String xyceRawString = simulationResult.toXyceRawString(netlist.getSourceFile());  
          System.out.println(xyceRawString);  
          try (PrintStream out = new PrintStream(new FileOutputStream(resFilename))) {  
            out.print(xyceRawString);  
          } catch (FileNotFoundException e) {  
            e.printStackTrace();  
          }  
        } else {  
          // output as Xyce STD  
          String xyceString = simulationResult.toXyceString();  
          System.out.println(xyceString = simulationResult.toXyceString());  
          try (PrintStream out = new PrintStream(new FileOutputStream(fileName + ".out"))) {  
            System.out.println("……………Writing simulation results to………." + fileName + ".out");  
  
            //try (PrintStream out = new PrintStream(new FileOutputStream(resFilename))) {  
            out.print(xyceString);  
          } catch (FileNotFoundException e) {  
            e.printStackTrace();  
          }  
        }  
        //        SimulationPlotter.plotTransientInOutCurve("I/V Curve", simulationResult, "V(Vmr)", "I(MR1)");  
      } else {  
  
        //System.out.println(simulationResult.toString());  
        //        System.out.println(simulationResult.toXyceString());  
  
        // plot  
        //        SimulationPlotter.plotAll(simulationResult);  
        //        SimulationPlotter.plot(simulationResult, "V(y)");  
        //        SimulationPlotter.plot(simulationResult, "R(MR2_X1)", "R(MR1_X1)");  
      }  
      return simulationResult;  
  
    } else {  
      return null;  
    }  
  }  
//}  
  
  
#End If
```

  
  

```B4X
Sub Class_Globals  
    Private netlist, netlistDCCurrent, netlistDCVoltage, NetlistResistor As JavaObject  
   
End Sub  
  
'initialize the Netlist object  
Public Sub Initialize  
    netlist.InitializeNewInstance("org.knowm.jspice.netlist.Netlist", Null)  
End Sub  
  
'id = id of the current source  
'val = value of the DC current source eg 0.02A  
'nodes() = array of string with the nodes between which the DC current source is connected  
'a node  = "0" is a ground node  
public Sub addNetlistDCCurrent (id As String, val As Double, nodes() As String) As IVR  
   
'    netlistDCCurrent.InitializeNewInstance("org.knowm.jspice.netlist.NetlistDCCurrent", Array("a", val, Array As String("0", "4")))  
    netlistDCCurrent.InitializeNewInstance("org.knowm.jspice.netlist.NetlistDCCurrent", Array(id, val, nodes))  
    netlist.RunMethod("addNetListComponent", Array(netlistDCCurrent))  
    Return Me  
   
End Sub  
  
'id = id of the DC voltage source  
'val = value of the voltage source eg 10V  
'nodes() = array of string with the nodes between which the DC voltage source is connected  
'a node  = "0" is a ground node  
public Sub addNetlistDCVoltage(id As String, val As Double, nodes() As String) As IVR  
   
'    netlistDCVoltage.InitializeNewInstance("org.knowm.jspice.netlist.NetlistDCVoltage", Array("x", val, Array As String("2", "5")))  
    netlistDCVoltage.InitializeNewInstance("org.knowm.jspice.netlist.NetlistDCVoltage", Array(id, val, nodes))  
    netlist.RunMethod("addNetListComponent", Array(netlistDCVoltage))  
    Return Me  
   
End Sub  
  
'id = id of the Resistor  
'val = value of the resistor eg 100 Ohms  
'nodes() = array of string with the nodes between which the resistor is connected  
'a node  = "0" is a ground node  
public Sub addNetlistResistor(id As String, val As Double, nodes() As String) As IVR  
   
'    NetlistResistor.InitializeNewInstance("org.knowm.jspice.netlist.NetlistResistor", Array("R1", val, Array As String("5", "0")))  
    NetlistResistor.InitializeNewInstance("org.knowm.jspice.netlist.NetlistResistor", Array(id, val, nodes))  
    netlist.RunMethod("addNetListComponent", Array(NetlistResistor))  
    Return Me  
   
End Sub  
  
'return the netlist so thst is can be passed on to jspice for simulatiln of the circuit  
public Sub build() As JavaObject  
  
    Return netlist  
  
End Sub
```

  
  

```B4X
Sub Class_Globals  
    Private fx As JFX  
    Dim nativeMe, lc As JavaObject  
    Dim mylist As List  
   
End Sub  
  
'Initializes the object. You can add parameters to this method if needed.  
Public Sub Initialize  
   
    nativeMe = Me  
    mylist.Initialize  
  
End Sub  
  
public Sub drawLineChart() As JavaObject  
   
    lc = nativeMe.RunMethod("DrawChart", Null)  
    Return lc  
   
End Sub  
  
public Sub setXvalues (xvals() As String)  
   
    nativeMe.RunMethod("setXvals", Array(xvals))  
   
End Sub  
  
public Sub setYvalues_1 (yvals_1() As Float)  
   
    nativeMe.RunMethod("setYvals_1", Array(yvals_1))  
   
End Sub  
  
public Sub setYvalues_2 (yvals_2() As Float)  
   
    nativeMe.RunMethod("setYvals_2", Array(yvals_2))  
   
End Sub  
  
public Sub setYvalues_3 (yvals_3() As Float)  
   
    nativeMe.RunMethod("setYvals_3", Array(yvals_3))  
   
End Sub  
  
public Sub setYvalues_4 (yvals_4() As Float)  
   
    nativeMe.RunMethod("setYvals_4", Array(yvals_4))  
   
End Sub  
  
public Sub setYvalues_5 (yvals_5() As Float)  
   
    nativeMe.RunMethod("setYvals_5", Array(yvals_5))  
   
End Sub  
  
public Sub setTitle(title As String)  
   
    nativeMe.RunMethod("setTitle", Array(title))  
   
End Sub  
  
public Sub setXAxisTitle(XAxisTitle As String)  
   
    nativeMe.RunMethod("setXaxisTitle", Array(XAxisTitle))  
   
End Sub  
  
public Sub setYAxisTitle(YAxisTitle As String)  
   
    nativeMe.RunMethod("setYaxisTitle", Array(YAxisTitle))  
   
End Sub  
  
public Sub setSeriesName_1 (sname As String)  
   
    nativeMe.RunMethod("setSeriesName_1", Array(sname))  
   
End Sub  
  
public Sub setSeriesName_2 (sname As String)  
   
    nativeMe.RunMethod("setSeriesName_2", Array(sname))  
   
End Sub  
  
public Sub setSeriesName_3 (sname As String)  
   
    nativeMe.RunMethod("setSeriesName_3", Array(sname))  
   
End Sub  
  
public Sub setSeriesName_4 (sname As String)  
   
    nativeMe.RunMethod("setSeriesName_4", Array(sname))  
   
End Sub  
  
public Sub setSeriesName_5 (sname As String)  
   
    nativeMe.RunMethod("setSeriesName_5", Array(sname))  
   
End Sub  
  
public Sub setYaxisMin (minval As Float)  
   
    nativeMe.RunMethod("setYaxisMinVal", Array(minval))  
   
End Sub  
  
public Sub setYaxisMax (maxval As Float)  
   
    nativeMe.RunMethod("setYaxisMaxVal", Array(maxval))  
   
End Sub  
  
public Sub setYaxisStep (ystep As Float)  
   
    nativeMe.RunMethod("setYaxisStep", Array(ystep))  
   
End Sub  
  
Public Sub setShowSymbols (show As Boolean)  
   
    nativeMe.RunMethod("setShowSymbols", Array(show))  
   
End Sub  
  
Public Sub setShowCrossHair (show As Boolean)  
   
    nativeMe.RunMethod("setShowCrossHair", Array(show))  
   
End Sub  
  
setShowCrossHair  
  
Private Sub linechartcallback  
    Dim seriesclicked As String = nativeMe.RunMethod("getSeriesClicked", Null)  
    mylist.Add(seriesclicked)  
    Dim xval As String = nativeMe.RunMethod("getXvalClicked", Null)  
    mylist.Add(xval)  
    Dim yval As String = nativeMe.RunMethod("getYvalClicked", Null)  
    mylist.Add(yval)  
   
    CallSubDelayed2(Main,"linechart_value_clicked", mylist)  
    Sleep(100)  
    mylist.Clear  
  
End Sub  
  
  
#if Java  
  
    import javafx.geometry.Insets;  
    import javafx.geometry.Side;  
    import java.awt.Color;  
    import javafx.collections.*;  
    import javafx.event.EventHandler;  
    import javafx.scene.*;  
    import javafx.scene.chart.*;  
    import javafx.scene.chart.XYChart.*;  
    import javafx.scene.input.MouseEvent;  
    import javafx.scene.control.ScrollPane;  
    import javafx.scene.control.Tooltip;  
  
    private static BA ba;  
    private static XYChart.Series series_1, series_2, series_3, series_4, series_5;  
  
    public LineChart DrawChart() {  
            final CategoryAxis xAxis = new CategoryAxis();  
     //     final NumberAxis xAxis = new NumberAxis();  
            final NumberAxis yAxis = new NumberAxis(yaxisMin,yaxisMax,yaxisStep);  
            xAxis.setLabel(xAxisTitle);  
            xAxis.setSide(Side.BOTTOM);  
            yAxis.setLabel(yAxisTitle);  
            //creating the chart  
            final LineChart<String,Number> lineChart =  
                    new LineChart(xAxis,yAxis);  
                 
            lineChart.setTitle(title);  
         
            //populating the series with data  
            if (xvals.length > 0) {  
  
                if (yvals_1 != null) {    
                    series_1 = new XYChart.Series();  
                    series_1.setName(seriesname_1);  
                    for (int i = 0; i < xvals.length; i++) {  
                        series_1.getData().add(new XYChart.Data(xvals, yvals_1));  
                    }  
                    lineChart.getData().add(series_1);  
                    series_1.getNode().setOnMouseClicked(e -> seriesclicked = seriesname_1);    
                }  
             
                if (yvals_2 != null) {  
                    series_2 = new XYChart.Series();  
                    series_2.setName(seriesname_2);            
                    for (int i = 0; i < xvals.length; i++) {  
                        series_2.getData().add(new XYChart.Data(xvals, yvals_2));  
                    }  
                    lineChart.getData().add(series_2);  
                    series_2.getNode().setOnMouseClicked(e -> seriesclicked = seriesname_2);                        
                }        
             
                if (yvals_3 != null) {  
                    series_3 = new XYChart.Series();  
                    series_3.setName(seriesname_3);            
                    for (int i = 0; i < xvals.length; i++) {  
                        series_3.getData().add(new XYChart.Data(xvals, yvals_3));  
                    }  
                    lineChart.getData().add(series_3);  
                    series_3.getNode().setOnMouseClicked(e -> seriesclicked = seriesname_3);                        
                }    
             
                if (yvals_4 != null) {  
                    series_4 = new XYChart.Series();  
                    series_4.setName(seriesname_4);            
                    for (int i = 0; i < xvals.length; i++) {  
                        series_4.getData().add(new XYChart.Data(xvals, yvals_4));  
                    }  
                    lineChart.getData().add(series_4);  
                    series_4.getNode().setOnMouseClicked(e -> seriesclicked = seriesname_4);                        
                }                
             
                if (yvals_5 != null) {  
                    series_5 = new XYChart.Series();  
                    series_5.setName(seriesname_5);            
                    for (int i = 0; i < xvals.length; i++) {  
                        series_5.getData().add(new XYChart.Data(xvals, yvals_5));  
                    }  
                    lineChart.getData().add(series_5);  
                    series_5.getNode().setOnMouseClicked(e -> seriesclicked = seriesname_5);                
                         
                }                        
            }  
         
           lineChart.setAnimated(true);  
           if (showcrosshair == true)  
                   lineChart.setCursor(Cursor.CROSSHAIR);  
           lineChart.setCreateSymbols(showsymbols);          //draw the little circles at each of the data points  
       
            lineChart.setOnMouseClicked(new EventHandler<MouseEvent>() {  
                  @Override  
                  public void handle(MouseEvent e) {  
                    Node chartPlotBackground = lineChart.lookup(".chart-plot-background");  
                    final double shiftX = xSceneShift(chartPlotBackground);  
                    final double shiftY = ySceneShift(chartPlotBackground);  
  
                    double x = e.getSceneX() - shiftX;  
                    double y = e.getSceneY() - shiftY;  
  
                    String xValue = xAxis.getValueForDisplay(x);  
                    Number yValue = yAxis.getValueForDisplay(y);  
  
                    //BA.Log("shiftX = " + shiftX + " shiftY: " + shiftY);  
                    //BA.Log("X value = "  
                    //     + xValue + " \nY value: " + yValue);  
                    xvalclicked = xValue;  
                    yvalclicked = "" + yValue;  
                    ba.raiseEventFromUI(this, "linechartcallback", null);  
                  }  
            });  
                     
           
           return lineChart;  
    }  
   
    public String seriesclicked = "";  
    public String getSeriesClicked() {  
        return seriesclicked;  
    }  
   
    public String xvalclicked = "";  
    public String getXvalClicked() {  
        return xvalclicked;  
    }  
   
    public String yvalclicked = "";  
    public String getYvalClicked() {  
        return yvalclicked;  
    }    
   
   
    //recursive calls  
    private double xSceneShift(Node node) {  
        return node.getParent() == null ? 0 : node.getBoundsInParent().getMinX() + xSceneShift(node.getParent());  
    }  
  
    private double ySceneShift(Node node) {  
        return node.getParent() == null ? 0 : node.getBoundsInParent().getMinY() + ySceneShift(node.getParent());  
    }  
  
    private static String[] xvals;  
    public void setXvals(String[] xvals) {  
        this.xvals = xvals;  
    }  
  
    private static String title = "";  
    public void setTitle(String title) {  
        this.title = title;  
    }  
  
    private static String seriesname_1 = "";  
    private static String seriesname_2 = "";  
    private static String seriesname_3 = "";  
    private static String seriesname_4 = "";  
    private static String seriesname_5 = "";  
  
    public void setSeriesName_1 (String seriesname_1) {  
        this.seriesname_1 = seriesname_1;  
    }  
  
    public void setSeriesName_2 (String seriesname_2) {  
        this.seriesname_2 = seriesname_2;  
    }  
  
    public void setSeriesName_3 (String seriesname_3) {  
        this.seriesname_3 = seriesname_3;  
    }  
  
    public void setSeriesName_4 (String seriesname_4) {  
        this.seriesname_4 = seriesname_4;  
    }  
  
    public void setSeriesName_5 (String seriesname_5) {  
        this.seriesname_5 = seriesname_5;  
    }  
  
    private static float[] yvals_1, yvals_2, yvals_3, yvals_4, yvals_5;  
  
    public void setYvals_1(float[] yvals_1) {  
        this.yvals_1 = yvals_1;  
    }  
  
    public void setYvals_2(float[] yvals_2) {  
        this.yvals_2 = yvals_2;  
    }  
  
    public void setYvals_3(float[] yvals_3) {  
        this.yvals_3 = yvals_3;  
    }  
  
    public void setYvals_4(float[] yvals_4) {  
        this.yvals_4 = yvals_4;  
    }  
  
    public void setYvals_5(float[] yvals_5) {  
        this.yvals_5 = yvals_5;  
    }  
  
    private static String xAxisTitle = "";  
    public void setXaxisTitle(String xAxisTitle) {  
        this.xAxisTitle = xAxisTitle;  
    }  
  
    private static String yAxisTitle = "";  
    public void setYaxisTitle(String yAxisTitle) {  
        this.yAxisTitle = yAxisTitle;  
    }  
   
    private static float yaxisMax = 0.0f;  
    public void setYaxisMaxVal (float yaxisMax) {  
        this.yaxisMax = yaxisMax;  
    }  
   
    private static float yaxisMin = 0.0f;  
    public void setYaxisMinVal (float yaxisMin) {  
        this.yaxisMin = yaxisMin;  
    }  
   
    private static float yaxisStep = 0.0f;  
    public void setYaxisStep (float yaxisStep) {  
        this.yaxisStep = yaxisStep;  
    }    
   
    private static boolean showsymbols = true;  
    public void setShowSymbols(boolean showsymbols) {  
        this.showsymbols = showsymbols;  
    }            
   
    private static boolean showcrosshair = false;  
    public void setShowCrossHair(boolean showcrosshair) {  
        this.showcrosshair = showcrosshair;  
    }            
  
#End If
```

  
  
![](https://www.b4x.com/android/forum/attachments/137830)  
  
It is the DC Sweep Analysis for this circuit:  
  
![](https://www.b4x.com/android/forum/attachments/137831)