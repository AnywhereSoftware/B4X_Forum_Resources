### B4j Line Graph, Multiple Traces, Predetermined intervals by rodmcm
### 11/28/2020
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/124999/)

This program is an extension of a simpler one I did for B4a and uses some of the features I have also seen on other programs.   
  
It can plot 3 Y variables against the X axis. The Y axis range for each is determined from the data and the intervals of the graph divisions set to sensible whole numbers for each plot according to the individual plot data  
  
I have limited the max data value to 50,000 but this can easily be extended  
  
The objective of this program is to have X and Y axes that are meaningful with whole number intervals for any data input  
 As there are multiple plots on one graph the number of Y graph divisions has to be the same.  
  
Each graph can be selected or deselected and there is a cursor with values attached.  
  
As this was written for B4j it is necessary to delete the whole graph page and reformat if a plot is selected or deselected. This would be much easier in B4a as you can draw a transparent line over a plot to delete it.  
  
The plots are from 0 to the maximum data value  
  
I have yet to come up with an algorithm that gives sensible interval values between min and max values. Next coronovirus lockdown maybe… Any suggestions on how to do this or comments to this program gratefully accepted