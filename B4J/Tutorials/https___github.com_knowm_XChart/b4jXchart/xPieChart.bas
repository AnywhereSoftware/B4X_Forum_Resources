B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.3
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
	
	Dim nativeMe As JavaObject
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
	nativeMe = Me
	
End Sub

public Sub drawPieChart As JavaObject
	
	Return nativeMe.RunMethod("drawChart", Null)
	
End Sub



#If Java

import org.knowm.xchart.PieChart;
import org.knowm.xchart.PieChartBuilder;
import org.knowm.xchart.SwingWrapper;
import org.knowm.xchart.style.Styler;
import javafx.scene.Node;
import javax.swing.JPanel;

import org.knowm.xchart.QuickChart;
import org.knowm.xchart.XChartPanel;
import org.knowm.xchart.XYChart;
import org.knowm.xchart.XYChartBuilder;
import org.knowm.xchart.XYSeries.XYSeriesRenderStyle;
import org.knowm.xchart.internal.chartpart.Chart;
import org.knowm.xchart.style.Styler.LegendPosition;
import javafx.embed.swing.SwingNode;


/*	public SwingNode drawChart() {
	    PieChart chart =
	        new PieChartBuilder().width(800).height(600).title(getClass().getSimpleName()).build();

	    // Customize Chart
	    chart.getStyler().setCircular(false);
	    chart.getStyler().setLegendPosition(Styler.LegendPosition.OutsideS);
	    chart.getStyler().setLegendLayout(Styler.LegendLayout.Horizontal);

	    // Series
	    chart.addSeries("Pennies", 100);
	    chart.addSeries("Nickels", 100);
	    chart.addSeries("Dimes", 100);
	    chart.addSeries("Quarters", 100);
		
		JPanel chartPanel = new XChartPanel<Chart>(chart);
		SwingNode swingNode = new SwingNode();
        swingNode.setContent(chartPanel);

	    return swingNode;
	
	} */



#End If