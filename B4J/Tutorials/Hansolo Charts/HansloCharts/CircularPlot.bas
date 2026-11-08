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

import eu.hansolo.fx.charts.data.PlotItem;
import eu.hansolo.fx.charts.CircularPlot;
import eu.hansolo.fx.charts.CircularPlotBuilder;
import javafx.application.Application;
import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.layout.StackPane;
import javafx.scene.paint.Color;
import javafx.stage.Stage;

import java.util.List;

private CircularPlot circluarPlot;






    public void init() {
        // Setup Data
        // Wahlberechtigte 61_500_000
        PlotItem australia = new PlotItem("AUSTRALIA", 1_250_000, Color.rgb(255, 51, 51));
        PlotItem india     = new PlotItem("INDIA", 750_000, Color.rgb(255, 153, 51));
        PlotItem china     = new PlotItem("CHINA", 920_000, Color.rgb(255, 255, 51));
        PlotItem japan     = new PlotItem("JAPAN", 1_060_000, Color.rgb(153, 255, 51));
        PlotItem thailand  = new PlotItem("THAILAND", 720_000, Color.rgb(51, 255, 51));
        PlotItem singapore = new PlotItem("SINGAPORE", 800_000, Color.rgb(51, 255, 153));

        // Travel flow
        australia.addToOutgoing(india, 150_000);
        australia.addToOutgoing(china, 90_000);
        australia.addToOutgoing(japan, 180_000);
        australia.addToOutgoing(thailand, 15_000);
        australia.addToOutgoing(singapore, 10_000);

        List<PlotItem> items = List.of(australia, india, china, japan, thailand, singapore );

        // Register listeners to click on connections and items
        items.forEach(item -> {
            item.addItemEventListener(e -> {
                switch (e.getEventType()) {
                    case CONNECTION_SELECTED_FROM: System.out.println("From    : " + e.getItem().getName()); break;
                    case CONNECTION_SELECTED_TO: System.out.println("To      : " + e.getItem().getName()); break;
                    case SELECTED     : System.out.println("Selected: " + e.getItem().getName()); break;
                }
            });
        });

        /*
        india.addToOutgoing(australia, 35_000);
        india.addToOutgoing(china, 10_000);
        india.addToOutgoing(japan, 40_000);
        india.addToOutgoing(thailand, 25_000);
        india.addToOutgoing(singapore, 8_000);
        china.addToOutgoing(australia, 10_000);
        china.addToOutgoing(india, 7_000);
        china.addToOutgoing(japan, 40_000);
        china.addToOutgoing(thailand, 5_000);
        china.addToOutgoing(singapore, 4_000);
        japan.addToOutgoing(australia, 7_000);
        japan.addToOutgoing(india, 8_000);
        japan.addToOutgoing(china, 175_000);
        japan.addToOutgoing(thailand, 11_000);
        japan.addToOutgoing(singapore, 18_000);
        thailand.addToOutgoing(australia, 70_000);
        thailand.addToOutgoing(india, 30_000);
        thailand.addToOutgoing(china, 22_000);
        thailand.addToOutgoing(japan, 120_000);
        thailand.addToOutgoing(singapore, 40_000);
        singapore.addToOutgoing(australia, 60_000);
        singapore.addToOutgoing(india, 90_000);
        singapore.addToOutgoing(china, 110_000);
        singapore.addToOutgoing(japan, 14_000);
        singapore.addToOutgoing(thailand, 30_000);
        */

        // Setup Chart
        circluarPlot = CircularPlotBuilder.create()
                                          .prefSize(500, 500)
                                          .items(items)
                                          .connectionOpacity(0.75)
                                          .decimals(0)
                                          .minorTickMarksVisible(false)
                                          .build();

        if (null != circluarPlot.getConnection(australia, japan)) {
            circluarPlot.getConnection(australia, japan).setFill(Color.BLUE);
        }
        circluarPlot.getConnections().forEach(connection -> {
            System.out.println(connection.getOutgoingItem().getName() + " -> " + connection.getIncomingItem().getName() + " : " + connection.getFill());
        });
    }
	
	
	    public StackPane start() {
        StackPane pane = new StackPane(circluarPlot);
		return pane;
    }	

#End If