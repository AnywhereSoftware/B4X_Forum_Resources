### A cross-platform B4XPages class to display a network of nodes connected by arrows. by William Lancee
### 09/21/2022
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/143069/)

'WiLNetChart' features:  
  
A. There are three different ways of specifying the net chart.  
  
1. Using the internal designer plus extensions to define nodes and connections.  
  
![](https://www.b4x.com/android/forum/attachments/133902)  
2. Specifying only connections and letting the algorithm define the nodes (works if all nodes have one parent)  
![](https://www.b4x.com/android/forum/attachments/133900)  
3. A string that specifies the nodes and connectors  
![](https://www.b4x.com/android/forum/attachments/133901)  
  
  
  
B. You can redefine the default styles of nodes and connectors, they can also be individually styled.  
  
C. You can now use a prefix "RT\" in the node text to specify rich text which uses a BBCodeView instead of a label.  
  
D. There is a callback to the calling context as a response to touches on the chart.  
In the demo the style of nodes and arrows are changed by MainPage when they are touched.  
  
E. This version will also work on B4A. Platform specific code is for event handler, font, and scroll pane.  
All development was done with B4J.  
  
F. I was tempted to add an editor, but I think it is unnecessary as the definition of the diagram is easily changed in code.  
However, the class could be used as a basis for a complete App that allows the end user to change the design interactively.  
Feel free to use the class any way you want.  
  
G. There are a few features that are a result of my experimentation with screen-adaptable font size and screen orientation.  
You may be interested in examining the code in the demo and the class. Remove them if you don't like my solution.  
  
H. The 'WiLNetChart' class is dependent on the 'Arrow' class [Here](https://www.b4x.com/android/forum/threads/b4x-a-class-to-draw-on-canvas-many-types-of-arrows-at-any-angle.142539/)  
The class is included in the demo below.  
  
Even with all these features, the class size is only about 450 lines of code.  
I keep being impressed by the power and functionality of B4X.