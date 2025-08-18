B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.9
@EndOfDesignText@
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
			 	       series_1.getData().add(new XYChart.Data(xvals[i], yvals_1[i]));
					}
	        		lineChart.getData().add(series_1);
					series_1.getNode().setOnMouseClicked(e -> BA.Log("Clicked on 1st series"));				
				}	
				
				if (yvals_2 != null) {	
				    series_2 = new XYChart.Series();
	        		series_2.setName(seriesname_2);				
					for (int i = 0; i < xvals.length; i++) {
			 	       series_2.getData().add(new XYChart.Data(xvals[i], yvals_2[i]));
					}
	        		lineChart.getData().add(series_2);
					series_2.getNode().setOnMouseClicked(e -> BA.Log("Clicked on 2nd series"));				
				}			
				
				if (yvals_3 != null) {	
				    series_3 = new XYChart.Series();
	        		series_3.setName(seriesname_3);				
					for (int i = 0; i < xvals.length; i++) {
			 	       series_3.getData().add(new XYChart.Data(xvals[i], yvals_3[i]));
					}
	        		lineChart.getData().add(series_3);
					series_3.getNode().setOnMouseClicked(e -> BA.Log("Clicked on 3rd series"));				
				}		
				
				if (yvals_4 != null) {	
				    series_4 = new XYChart.Series();
	        		series_4.setName(seriesname_4);				
					for (int i = 0; i < xvals.length; i++) {
			 	       series_4.getData().add(new XYChart.Data(xvals[i], yvals_4[i]));
					}
	        		lineChart.getData().add(series_4);
					series_4.getNode().setOnMouseClicked(e -> BA.Log("Clicked on 4th series"));				
				}					
				
				if (yvals_5 != null) {	
				    series_5 = new XYChart.Series();
	        		series_5.setName(seriesname_5);				
					for (int i = 0; i < xvals.length; i++) {
			 	       series_5.getData().add(new XYChart.Data(xvals[i], yvals_5[i]));
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


