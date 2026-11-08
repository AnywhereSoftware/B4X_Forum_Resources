B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
	
	Private nativeMe As JavaObject
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
	nativeMe = Me
	nativeMe.RunMethod("init", Null)
	
End Sub

Public Sub buildGraph() As Object

	Return nativeMe.RunMethod("start", Null)

End Sub

#if Java

import eu.hansolo.fx.charts.CoxcombChart;
import eu.hansolo.fx.charts.CoxcombChartBuilder;

import eu.hansolo.fx.charts.data.ChartItem;
import eu.hansolo.fx.charts.tools.Order;
import javafx.application.Application;
import javafx.geometry.Insets;
import javafx.scene.paint.Color;
import javafx.stage.Stage;
import javafx.scene.layout.StackPane;
import javafx.scene.Scene;


private CoxcombChart chart;


    public void init() {
        ChartItem[] items = {
            new ChartItem("Item 1", 27, Color.web("#96AA3B")),
            new ChartItem("Item 2", 24, Color.web("#29A783")),
            new ChartItem("Item 3", 16, Color.web("#098AA9")),
            new ChartItem("Item 4", 15, Color.web("#62386F")),
            new ChartItem("Item 5", 13, Color.web("#89447B")),
            new ChartItem("Item 6", 5, Color.web("#EF5780"))
        };
        chart = CoxcombChartBuilder.create()
                                   .items(items)
                                   .textColor(Color.WHITE)
                                   .autoTextColor(false)
                                   .equalSegmentAngles(true)
                                   .order(Order.ASCENDING)
                                   .build();
    }
	
	
    public StackPane start() {
        StackPane pane = new StackPane(chart);
        pane.setPadding(new Insets(10));


        chart.addItem(new ChartItem("New Item", 3, Color.RED));	
		
		return pane;
		
	}	


#End If