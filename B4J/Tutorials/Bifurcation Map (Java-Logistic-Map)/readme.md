### Bifurcation Map (Java-Logistic-Map) by Johan Schoeman
### 06/03/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/148302/)

A shortcut warp to kick-start [***this Github project***](https://github.com/ZAhmed95/Java-Logistic-Map) from B4J. Copy attached Jar to your additional libs folder. Run the attached B4J project  
  
Check this YouTube Video - it is related to what is explained in the video  
  
Change the values for A, 1st Initial Value, 2nd Initial Value  
  
[MEDIA=youtube]ovJcsL7vyrk[/MEDIA]  
  
![](https://www.b4x.com/android/forum/attachments/142562)  
  
**From the Github posting:**  
  
*Simulation of the logistic map function X(n+1) = A[X(n)][1 - X(n)], showing chaotic behavior for A values ~3.6 to 4  
  
Description: The logistic map is the function X(n+1) = A[X(n)][1 - X(n)], a time series plotting X(n) vs n. This function is a simple example of chaotic behavior, as for values of A in the range of ~3.6 to 4, the results quickly start to look scattered and random. A slight change in the initial value of X(0) can result in dramatic changes in the plot points. This kind of chaotic function is utilized for things like psuedo random number generation (although PRNGs use a bit more complex functions than this one).  
  
Files: Display.java Contains the main method, instantiates Graph objects to display data from logistic map. It creates 3 graphs: The first is a line graph, showing the behavior of the function towards the beginning, for small values of n. The second is a scatter plot showing the full range of points. High values of A close to 4 makes this scatter plot appear nearly random. The third is a phase diagram, which plots X(n+1) vs X(n), instead of X(n) vs n. The parabolic pattern seen here reveals that the apparently random output of the logistic map in fact is very deterministic. This class also creates a table to show the values of the logistic map, and includes text fields for the user to input values for A and 2 initial values.  
  
Graph.java Contains code to create the GUI. Creates the 3 types of graphs mentioned above.  
  
RandomNumbers.java Contains the code to generate the logistic map, in the psuedoRandomNumbers method, which creates 2 time series given the A value and 2 initial values, and returns them in a 2D array. Another method is phaseDiagram, which takes the previously created logistic map to create a phase diagram, as descibed above. Another minor method is checkDouble, which is used to ensure proper user input.*