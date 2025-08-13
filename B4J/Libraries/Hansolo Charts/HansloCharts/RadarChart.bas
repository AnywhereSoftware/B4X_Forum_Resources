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

import eu.hansolo.fx.charts.ChartType;
import eu.hansolo.fx.charts.Category;
import eu.hansolo.fx.charts.YPane;
import eu.hansolo.fx.charts.YChart;
import eu.hansolo.fx.charts.data.YChartItem;
import eu.hansolo.fx.charts.series.YSeries;
import javafx.animation.AnimationTimer;
import javafx.animation.KeyFrame;
import javafx.animation.KeyValue;
import javafx.animation.Timeline;
import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.layout.StackPane;
import javafx.scene.paint.Color;
import javafx.scene.paint.CycleMethod;
import javafx.scene.paint.RadialGradient;
import javafx.scene.paint.Stop;
import javafx.stage.Stage;
import javafx.util.Duration;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

    private static final Random               RND        = new Random();
    private static final long                 INTERVAL   = 1_000_000_000l;
    private static final double               ANIM_TIME  = INTERVAL / 10_000_000;
    private static final int                  ELEMENTS   = 30;
    private static final ChartType            CHART_TYPE = ChartType.SMOOTH_RADAR_POLYGON;
    private              YSeries<YChartItem> series1;
    private              YSeries<YChartItem> series2;
    private              YSeries<YChartItem> series3;
    private              YChart<YChartItem>  chart;
    private              Timeline            timeline;
    private              long                lastTimerCall;
    private              AnimationTimer      timer;


    public void init() {
        List<YChartItem> item1 = new ArrayList<>(ELEMENTS);
        List<YChartItem> item2 = new ArrayList<>(ELEMENTS);
        List<YChartItem> item3 = new ArrayList<>(ELEMENTS);
        for (int i = 0 ; i < ELEMENTS ; i++) {
            YChartItem dataPoint;

            dataPoint = new YChartItem(RND.nextDouble() * 100, "P" + i);
            item1.add(dataPoint);

            dataPoint = new YChartItem(RND.nextDouble() * 100, "P" + i);
            item2.add(dataPoint);

            dataPoint = new YChartItem(RND.nextDouble() * 100, "P" + i);
            item3.add(dataPoint);
        }

        series1 = new YSeries(item3, CHART_TYPE, new RadialGradient(0, 0, 0, 0, 1, true, CycleMethod.NO_CYCLE, new Stop(0.0, Color.rgb(0, 255, 255, 0.25)), new Stop(0.5, Color.rgb(255, 255, 0, 0.5)), new Stop(1.0, Color.rgb(255, 0, 255, 0.75))), Color.TRANSPARENT);
        series2 = new YSeries(item1, CHART_TYPE, new RadialGradient(0, 0, 0, 0, 1, true, CycleMethod.NO_CYCLE, new Stop(0.0, Color.rgb(255, 0, 0, 0.25)), new Stop(0.5, Color.rgb(255, 255, 0, 0.5)), new Stop(1.0, Color.rgb(0, 200, 0, 0.75))), Color.TRANSPARENT);
        series3 = new YSeries(item2, CHART_TYPE, new RadialGradient(0, 0, 0, 0, 1, true, CycleMethod.NO_CYCLE, new Stop(0.0, Color.rgb(0, 255, 255, 0.25)), new Stop(0.5, Color.rgb(0, 255, 255, 0.5)), new Stop(1.0, Color.rgb(0, 0, 255, 0.75))), Color.TRANSPARENT);
        series2.setWithWrapping(true);

        List<Category> categories = new ArrayList<>();
        for (int i = 0 ; i < ELEMENTS ; i++) {
            categories.add(new Category("P" + i));
        }

        chart = new YChart(new YPane(categories, series1, series2, series3));
        chart.setPrefSize(600, 600);

        timeline      = new Timeline();
        lastTimerCall = System.nanoTime();
        timer         = new AnimationTimer() {
            @Override public void handle(final long now) {
                if (now > lastTimerCall + INTERVAL) {
                    animateData();
                    long delta = System.nanoTime() - now;
                    timeline.play();
                    lastTimerCall = now + delta;
                }
            }
        };

        registerListener();
    }
	
	
    private void registerListener() {
        timeline.currentTimeProperty().addListener(o -> chart.refresh());
    }
	
    public StackPane start() {
        StackPane pane  = new StackPane(chart);
//        Scene     scene = new Scene(pane);

//        stage.setTitle("RadarChart");
//        stage.setScene(scene);
//        stage.show();

        timer.start();
		
		return pane;
    }		
	
	
    private void animateData() {
        List<KeyFrame> keyFrames = new ArrayList<>();
        animateSeries(series1, keyFrames);
        animateSeries(series2, keyFrames);
        animateSeries(series3, keyFrames);
        timeline.getKeyFrames().setAll(keyFrames);
    }

    private void animateSeries(final YSeries<YChartItem> SERIES, final List<KeyFrame> KEY_FRAMES) {
        SERIES.getItems().forEach(item -> {
            KeyValue kv0 = new KeyValue(item.yProperty(), item.getY());
            KeyValue kv1 = new KeyValue(item.yProperty(), RND.nextDouble() * 100);
            KeyFrame kf0 = new KeyFrame(Duration.ZERO, kv0);
            KeyFrame kf1 = new KeyFrame(Duration.millis(ANIM_TIME), kv1);
            KEY_FRAMES.add(kf0);
            KEY_FRAMES.add(kf1);
        });
    }	




#End If