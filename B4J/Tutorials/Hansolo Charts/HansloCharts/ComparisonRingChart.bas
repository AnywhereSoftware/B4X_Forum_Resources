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

#If Java

import eu.hansolo.fx.charts.ComparisonRingChart;
import eu.hansolo.fx.charts.ComparisonRingChartBuilder;
import eu.hansolo.fx.charts.data.ChartItem;
import eu.hansolo.fx.charts.series.ChartItemSeries;
import eu.hansolo.fx.charts.series.ChartItemSeriesBuilder;
import eu.hansolo.fx.charts.tools.NumberFormat;
import eu.hansolo.fx.charts.tools.Order;
import javafx.animation.AnimationTimer;
import javafx.application.Application;
import javafx.geometry.Insets;
import javafx.scene.paint.Color;
import javafx.stage.Stage;
import javafx.scene.layout.StackPane;
import javafx.scene.Scene;

import java.util.Random;

    private static final Random RND = new Random();
    private ChartItem           chart1Data1;
    private ChartItem           chart1Data2;
    private ChartItem           chart1Data3;
    private ChartItem           chart1Data4;
    private ChartItem           chart1Data5;
    private ChartItem           chart1Data6;
    private ChartItem           chart1Data7;
    private ChartItem           chart1Data8;
    private ChartItem           chart2Data1;
    private ChartItem           chart2Data2;
    private ChartItem           chart2Data3;
    private ChartItem           chart2Data4;
    private ChartItem           chart2Data5;
    private ChartItem           chart2Data6;
    private ChartItem           chart2Data7;
    private ChartItem           chart2Data8;
    private ComparisonRingChart chart;
    private long                lastTimerCall;
    private AnimationTimer      timer;
	
	
	
	
    public void init() {
        chart1Data1 = new ChartItem("Item 1");
        chart1Data2 = new ChartItem("Item 2");
        chart1Data3 = new ChartItem("Item 3");
        chart1Data4 = new ChartItem("Item 4");
        chart1Data5 = new ChartItem("Item 5");
        chart1Data6 = new ChartItem("Item 6");
        chart1Data7 = new ChartItem("Item 7");
        chart1Data8 = new ChartItem("Item 8");

        ChartItemSeries<ChartItem> series1 = ChartItemSeriesBuilder.create()
                                                                   .name("Series 1")
                                                                   .items(chart1Data1, chart1Data2, chart1Data3, chart1Data4,
                                                                          chart1Data5, chart1Data6, chart1Data7, chart1Data8)
                                                                   .fill(Color.web("#2EDDAE"))
                                                                   .textFill(Color.WHITE)
                                                                   .animated(true)
                                                                   .animationDuration(1000)
                                                                   .build();

        chart2Data1 = new ChartItem("Item 1");
        chart2Data2 = new ChartItem("Item 2");
        chart2Data3 = new ChartItem("Item 3");
        chart2Data4 = new ChartItem("Item 4");
        chart2Data5 = new ChartItem("Item 5");
        chart2Data6 = new ChartItem("Item 6");
        chart2Data7 = new ChartItem("Item 7");
        chart2Data8 = new ChartItem("Item 8");

        ChartItemSeries<ChartItem> series2 = ChartItemSeriesBuilder.create()
                                                                   .name("Series 2")
                                                                   .items(chart2Data1, chart2Data2, chart2Data3, chart2Data4,
                                                                          chart2Data5, chart2Data6, chart2Data7, chart2Data8)
                                                                   .fill(Color.web("#1A9FF9"))
                                                                   .textFill(Color.WHITE)
                                                                   .animated(true)
                                                                   .animationDuration(1000)
                                                                   .build();

        chart = ComparisonRingChartBuilder.create(series1, series2)
                                          .prefSize(400, 400)
                                          .sorted(true)
                                          .order(Order.DESCENDING)
                                          .numberFormat(NumberFormat.FLOAT_1_DECIMAL)
                                          .build();

        lastTimerCall = System.nanoTime();
        timer = new AnimationTimer() {
            @Override public void handle(final long now) {
                if (now > lastTimerCall + 1_000_000_000l) {
                    chart1Data1.setValue(RND.nextDouble() * 20);
                    chart1Data2.setValue(RND.nextDouble() * 20);
                    chart1Data3.setValue(RND.nextDouble() * 20);
                    chart1Data4.setValue(RND.nextDouble() * 20);
                    chart1Data5.setValue(RND.nextDouble() * 20);
                    chart1Data6.setValue(RND.nextDouble() * 20);
                    chart1Data7.setValue(RND.nextDouble() * 20);
                    chart1Data8.setValue(RND.nextDouble() * 20);

                    chart2Data1.setValue(RND.nextDouble() * 20);
                    chart2Data2.setValue(RND.nextDouble() * 20);
                    chart2Data3.setValue(RND.nextDouble() * 20);
                    chart2Data4.setValue(RND.nextDouble() * 20);
                    chart2Data5.setValue(RND.nextDouble() * 20);
                    chart2Data6.setValue(RND.nextDouble() * 20);
                    chart2Data7.setValue(RND.nextDouble() * 20);
                    chart2Data8.setValue(RND.nextDouble() * 20);

                    lastTimerCall = now;
                }
            }
        };
    }	
	
	
    public StackPane start() {
        StackPane pane = new StackPane(chart);
        pane.setPadding(new Insets(10));

        timer.start();
		
		return pane;
    }	

#End If