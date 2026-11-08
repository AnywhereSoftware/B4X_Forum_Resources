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

import eu.hansolo.fx.charts.ConcentricRingChart;
import eu.hansolo.fx.charts.ConcentricRingChartBuilder;
import eu.hansolo.fx.charts.data.ChartItem;
import eu.hansolo.fx.charts.data.ChartItemBuilder;
import eu.hansolo.fx.charts.tools.NumberFormat;
import eu.hansolo.fx.charts.tools.Order;
import javafx.animation.AnimationTimer;
import javafx.application.Application;
import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.layout.StackPane;
import javafx.scene.paint.Color;
import javafx.stage.Stage;

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
    private ConcentricRingChart chart;
    private long                lastTimerCall;
    private AnimationTimer      timer;


    public void init() {
        chart1Data1 = ChartItemBuilder.create().name("Item 1").fill(Color.web("#3552a0")).textFill(Color.WHITE).animated(true).build();
        chart1Data2 = ChartItemBuilder.create().name("Item 2").fill(Color.web("#45a1cf")).textFill(Color.WHITE).animated(true).build();
        chart1Data3 = ChartItemBuilder.create().name("Item 3").fill(Color.web("#45cf6d")).textFill(Color.WHITE).animated(true).build();
        chart1Data4 = ChartItemBuilder.create().name("Item 4").fill(Color.web("#e3eb4f")).textFill(Color.BLACK).animated(true).build();
        chart1Data5 = ChartItemBuilder.create().name("Item 5").fill(Color.web("#efb750")).textFill(Color.WHITE).animated(true).build();
        chart1Data6 = ChartItemBuilder.create().name("Item 6").fill(Color.web("#ef9850")).textFill(Color.WHITE).animated(true).build();
        chart1Data7 = ChartItemBuilder.create().name("Item 7").fill(Color.web("#ef6050")).textFill(Color.WHITE).animated(true).build();
        chart1Data8 = ChartItemBuilder.create().name("Item 8").fill(Color.web("#a54237")).textFill(Color.WHITE).animated(true).build();

        chart = ConcentricRingChartBuilder.create()
                                          .prefSize(400, 400)
                                          .items(chart1Data1, chart1Data2, chart1Data3, chart1Data4,
                                                 chart1Data5, chart1Data6, chart1Data7, chart1Data8)
                                          .sorted(false)
                                          .order(Order.DESCENDING)
                                          //.barBackgroundColor(Color.BLACK)
                                          .numberFormat(NumberFormat.PERCENTAGE_1_DECIMAL)
                                          .itemLabelFill(Color.BLACK)
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





