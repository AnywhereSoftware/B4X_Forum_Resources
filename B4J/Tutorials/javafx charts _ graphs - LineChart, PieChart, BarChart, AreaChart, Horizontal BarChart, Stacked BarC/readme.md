### javafx charts / graphs - LineChart, PieChart, BarChart, AreaChart, Horizontal BarChart, Stacked BarChart, Stacked AreaChart by Johan Schoeman
### 05/03/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/129860/)

This is an "inline java code" example for the javafx line chart. It has very basic functionality at present.  
  
You will need **javafx.controls.jar**. I found the jar on my computer at:  
*C:\Java\jdk-11.0.1\jdk-11.0.1\javafx\lib  
  
You can download  **javafx.controls.jar** from here:*  
[MEDIA=googledrive]1lGvAUmR4EPs7ZIW0BQId-g7QkifQT6WQ[/MEDIA]  
  
Find it on your computer and copy it to your B4J additional libs folder.  
The attached project will draw the below line chart (provision for 5 x series to be added)  
*You can add all the other charts in a similar way (bar charts, pie charts, etc, etc - browse the web to see what other chats are available via javafx.*  
Check the **linechartcolors.css** file in the **/Files** folder of the project - it adds the styling used in this example.  
  
Please note: *I have no intention to take this project any further (other than for personal use).* Change it and add additional features and classes to your liking  
  
Probably not the best way to do the javafx charts. Best will probably be to do a *fully fledged* wrapper for it. But it is working…..  
  
Enjoy….;)  
  
![](https://www.b4x.com/android/forum/attachments/111871)  
  
Main code:  

```B4X
#Region Project Attributes  
    #MainFormWidth: 600  
    #MainFormHeight: 600  
#End Region  
  
#AdditionalJar: javafx.controls  
  
'SEE THE CSS FILE IN THE /FILES FOLDER FOR STYLES THAT ARE USED FOR THE LINE CHART  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
  
    Dim lc1 As linechart  
    Dim myLineChart As JavaObject  
  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    MainForm.Show  
  
    'the name of the CSS file in use for the line chart is "linechartcolors.css"  
    MainForm.Stylesheets.Add(File.GetUri(File.DirAssets, "linechartcolors.css"))  
    'Initialize the chart  
    lc1.Initialize  
    'set the title - see the css file for setting the title color  
    lc1.Title = "Some Arbitrary Data"  
  
    'set the x-axis "values"  
    lc1.Xvalues = Array As String("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")  
    lc1.XAxisTitle = "Months of the year"  
  
    'set series 1 y-axis data  
    lc1.Yvalues_1 = Array As Float(153.7, 144.3, 198.5, 177.3, 145.8, 201.6, 113.8, 174.2, 112.5, 133.8, 199.7, 113.1)  
    lc1.SeriesName_1 = "Series A"  
  
    'set series 2 y-axis data  
    lc1.Yvalues_2 = Array As Float(443.7, 434.3, 488.5, 467.3, 435.8, 491.6, 453.8, 464.2, 42.5, 423.8, 489.7, 43.1)  
    lc1.SeriesName_2 = "Series B"  
  
    'set series 3 y-axis data  
    lc1.Yvalues_3 = Array As Float(-233.7, -224.3, -298.5, -257.3, -225.8, -281.6, -243.8, -254.2, -208.5, -213.8, -279.7, -207.1)  
    lc1.SeriesName_3 = "Series C"  
  
    'set series 4 y-axis data  
    lc1.Yvalues_4 = Array As Float(33.7, 24.3, 98.5, 57.3, 25.8, 81.6, 43.8, 54.2, 8.5, 13.8, 79.7, 7.1)  
    lc1.SeriesName_4 = "Series D"  
  
    'set series 5 y-axis data  
    lc1.Yvalues_5 = Array As Float(233.7, 224.3, 298.5, 257.3, 225.8, 281.6, 243.8, 254.2, 208.5, 213.8, 279.7, 207.1)  
    lc1.SeriesName_5 = "Series E"  
  
    'draw the chart and then get it as a java object  
    myLineChart = lc1.drawLineChart  
    'add the line chart object to the root pane  
    MainForm.RootPane.AddNode(myLineChart,0,0,600,500)  
  
End Sub
```

  
  
Code in class "***linechart***"  

```B4X
Sub Class_Globals  
    Private fx As JFX  
    Dim nativeMe, lc As JavaObject  
End Sub  
  
'Initializes the object. You can add parameters to this method if needed.  
Public Sub Initialize  
  
    nativeMe = Me  
  
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
  
#if Java  
  
    import javafx.application.Application;  
    import javafx.stage.Stage;  
    import javafx.geometry.Insets;  
    import javafx.geometry.Side;  
    import java.awt.Color;  
    import javafx.collections.*;  
    import javafx.event.EventHandler;  
    import javafx.scene.*;  
    import javafx.scene.chart.*;  
    import javafx.scene.chart.XYChart.Data;  
  
    private static XYChart.Series series_1, series_2, series_3, series_4, series_5;  
  
    public static LineChart DrawChart() {  
            final CategoryAxis xAxis = new CategoryAxis();  
     //     final NumberAxis xAxis = new NumberAxis();  
            final NumberAxis yAxis = new NumberAxis();  
            xAxis.setLabel(xAxisTitle);  
            xAxis.setSide(Side.TOP);  
            //creating the chart  
            final LineChart lineChart =  
                    new LineChart(xAxis,yAxis);  
                
            lineChart.setTitle(title);  
        
            //defining a series  
  
            //populating the series with data  
            if (xvals.length > 0) {  
  
                if (yvals_1 != null) {   
                    series_1 = new XYChart.Series();  
                    series_1.setName(seriesname_1);  
                    for (int i = 0; i < xvals.length; i++) {  
                        series_1.getData().add(new XYChart.Data(xvals, yvals_1));  
                    }  
                    lineChart.getData().add(series_1);  
                    series_1.getNode().setOnMouseClicked(e -> BA.Log("Clicked on 1st series"));           
                }  
            
                if (yvals_2 != null) {  
                    series_2 = new XYChart.Series();  
                    series_2.setName(seriesname_2);           
                    for (int i = 0; i < xvals.length; i++) {  
                        series_2.getData().add(new XYChart.Data(xvals, yvals_2));  
                    }  
                    lineChart.getData().add(series_2);  
                    series_2.getNode().setOnMouseClicked(e -> BA.Log("Clicked on 2nd series"));           
                }       
            
                if (yvals_3 != null) {  
                    series_3 = new XYChart.Series();  
                    series_3.setName(seriesname_3);           
                    for (int i = 0; i < xvals.length; i++) {  
                        series_3.getData().add(new XYChart.Data(xvals, yvals_3));  
                    }  
                    lineChart.getData().add(series_3);  
                    series_3.getNode().setOnMouseClicked(e -> BA.Log("Clicked on 3rd series"));           
                }   
            
                if (yvals_4 != null) {  
                    series_4 = new XYChart.Series();  
                    series_4.setName(seriesname_4);           
                    for (int i = 0; i < xvals.length; i++) {  
                        series_4.getData().add(new XYChart.Data(xvals, yvals_4));  
                    }  
                    lineChart.getData().add(series_4);  
                    series_4.getNode().setOnMouseClicked(e -> BA.Log("Clicked on 4th series"));           
                }               
            
                if (yvals_5 != null) {  
                    series_5 = new XYChart.Series();  
                    series_5.setName(seriesname_5);           
                    for (int i = 0; i < xvals.length; i++) {  
                        series_5.getData().add(new XYChart.Data(xvals, yvals_5));  
                    }  
                    lineChart.getData().add(series_5);  
                    series_5.getNode().setOnMouseClicked(e -> BA.Log("Clicked on 5th series"));           
                }                       
            }  
        
           lineChart.setAnimated(true);  
           lineChart.setCursor(Cursor.CROSSHAIR);  
           lineChart.setCreateSymbols(true);          //draw the little circles at each of the data points  
  
           return lineChart;  
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
  
#End If
```