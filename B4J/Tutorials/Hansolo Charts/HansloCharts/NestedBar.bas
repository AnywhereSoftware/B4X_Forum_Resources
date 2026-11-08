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
Public Sub Initialize()
	
	nativeMe = Me
	nativeMe.RunMethod("init", Null)
	
End Sub

'draw the graph
public Sub drawGraph() As Object
	
	Return nativeMe.RunMethod("drawGraph", Null)
	
End Sub



#if Java

import eu.hansolo.fx.charts.data.ChartItem;
import eu.hansolo.fx.charts.series.ChartItemSeries;
import javafx.application.Application;
import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.layout.StackPane;
import javafx.scene.paint.Color;
import javafx.stage.Stage;
import eu.hansolo.fx.charts.ChartType;
import eu.hansolo.fx.charts.NestedBarChart;

import static eu.hansolo.fx.charts.color.MaterialDesignColors.*;

   private NestedBarChart chart;

    public void init() {
	
        ChartItem p1Q1 = new ChartItem("Product 1", 16, CYAN_700.get());
        ChartItem p2Q1 = new ChartItem("Product 2", 8, CYAN_500.get());
        ChartItem p3Q1 = new ChartItem("Product 3", 4, CYAN_300.get());
        ChartItem p4Q1 = new ChartItem("Product 4", 2, CYAN_100.get());

        ChartItem p1Q2 = new ChartItem("Product 1", 12, PURPLE_700.get());
        ChartItem p2Q2 = new ChartItem("Product 2", 5, PURPLE_500.get());
        ChartItem p3Q2 = new ChartItem("Product 3", 3, PURPLE_300.get());
        ChartItem p4Q2 = new ChartItem("Product 4", 1, PURPLE_100.get());

        ChartItem p1Q3 = new ChartItem("Product 1", 14, PINK_700.get());
        ChartItem p2Q3 = new ChartItem("Product 2", 7, PINK_500.get());
        ChartItem p3Q3 = new ChartItem("Product 3", 3.5, PINK_300.get());
        ChartItem p4Q3 = new ChartItem("Product 4", 1.75, PINK_100.get());

        ChartItem p1Q4 = new ChartItem("Product 1", 18, AMBER_700.get());
        ChartItem p2Q4 = new ChartItem("Product 2", 9, AMBER_500.get());
        ChartItem p3Q4 = new ChartItem("Product 3", 4.5, AMBER_300.get());
        ChartItem p4Q4 = new ChartItem("Product 4", 2.25, AMBER_100.get());

        ChartItemSeries<ChartItem> q1 = new ChartItemSeries<>(ChartType.NESTED_BAR, "1st Quarter", CYAN_900.get(), Color.TRANSPARENT, p1Q1, p2Q1, p3Q1, p4Q1);
        ChartItemSeries<ChartItem> q2 = new ChartItemSeries<>(ChartType.NESTED_BAR, "2nd Quarter", PURPLE_900.get(), Color.TRANSPARENT, p1Q2, p2Q2, p3Q2, p4Q2);
        ChartItemSeries<ChartItem> q3 = new ChartItemSeries<>(ChartType.NESTED_BAR, "3rd Quarter", PINK_900.get(), Color.TRANSPARENT, p1Q3, p2Q3, p3Q3, p4Q3);
        ChartItemSeries<ChartItem> q4 = new ChartItemSeries<>(ChartType.NESTED_BAR, "4th Quarter", AMBER_900.get(), Color.TRANSPARENT, p1Q4, p2Q4, p3Q4, p4Q4);

        chart = new NestedBarChart(q1, q2, q3, q4);

        chart.setOnSelectionEvent(e -> BA.Log("" + e));

    }
	
	public StackPane drawGraph() {
		StackPane pane = new StackPane(chart);
	 	return pane;
	}
	
									

#End If