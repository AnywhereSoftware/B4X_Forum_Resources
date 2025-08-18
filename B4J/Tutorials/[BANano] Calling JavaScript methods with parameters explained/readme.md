### [BANano] Calling JavaScript methods with parameters explained by alwaysbusy
### 03/16/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/128691/)

Suppose we use the plotly library (<https://plotly.com>) as an example to add a chart.  
  
When we look at their example on how to use it:  

```B4X
Plotly.newPlot( "chart", [{  
    x: [1, 2, 3, 4, 5],  
    y: [1, 2, 4, 8, 16] }], {  
    margin: { t: 0 } }, {showSendToCloud:true} );
```

  
  
How would that translate to B4J and BANano?  
  
The newPlot function can have a variable number of parameters. But because b4J can not do that, we have to pass an Array() if we have a variable number of parameters.  
Literally typing **Array**() here is important in the runMethod call, see **(\*)** !  
  
Looking at their code we need 4 parameters in the newPlot() call:  
1. "chart"  
2. [{x: [1, 2, 3, 4, 5], y: [1, 2, 4, 8, 16] }]  
3. {margin: { t: 0 } }  
4. {showSendToCloud:true}  
  
So in B4J this would translate as:  

```B4X
Dim element As String = "chart" ' <— this is de ID of a div tag where we want the chart, see further  
Dim coords As List = Array(CreateMap("x": xData, "y": yData))  
Dim margin As Map = CreateMap("margin": CreateMap("t": 0))  
Dim settings As Map = CreateMap("showSendToCloud": True)
```

  
   
Now we can call:  

```B4X
plot.RunMethod("newPlot", Array(element, coords, margin, settings ))
```

  
   
**(\*)** You may be inclined to do the following but it transpiles to something different:  

```B4X
Dim params As List  
params.Initialize  
params.Add("chart")  
params.Add(Array(CreateMap("x": xData, "y": yData)))  
params.Add(CreateMap("margin": CreateMap("t": 0)))  
params.Add(CreateMap("showSendToCloud": True))  
  
plot.RunMethod("newPlot", params)
```

  
   
**This will not work!** Why? Just because we need a workaround for the variable number of parameters limitation. The array() in the parameters is important so the BANano transpiler knows it has to 'spread' all elements in the params variable as seperate parameters of the function.  
  
So this call:  

```B4X
plot.RunMethod("newPlot", Array(element, coords, margin, settings ))
```

  
   
will be transpiled to:  

```B4X
plot.newPlot(element, coords, margin, settings)  ' correct
```

  
   
While this call:  

```B4X
plot.RunMethod("newPlot", params)
```

  
   
will be transpiled to:  

```B4X
plot.newPlot([element,coords,margin,settings]) ' note the [], not correct
```

  
   
What would've worked is forcing a 'spread' of the parameters using **BANano.Spread()**:  

```B4X
plot.RunMethod("newPlot", BANano.Spread(params))
```

  
   
This would also have been transpiled to:  

```B4X
plot.newPlot(element, coords, margin, settings)  ' correct
```

  
   
BANano.Spread() forces the transpiler to 'spread' all the variables in Params. But in my view, this is a bit 'JavaScripty' so I prefer the more B4J way of using just seperate variables.  
  
My full code would be:  

```B4X
Sub Process_Globals  
    Dim plot as BANanoObject  
End Sub  
  
Sub AppStart(Form1 as Form, Args() as String)  
    …  
    BANano.Header.AddJavascriptFile("https://cdn.plot.ly/plotly-latest.min.js")  
End sub  
  
Sub BANano_Ready()  
    …  
    InitializePlotly(Array As Double(1, 2, 3, 4, 5),Array As Double(1, 2, 4, 8, 16))  
End Sub  
  
Public Sub InitializePlotly(xData() As Double, yData() As Double)  
    plot.Initialize("Plotly")  
  
    Dim body As BANanoElement  
    body.Initialize("#body")  
    body.Append($"<div id="chart" style="width:600px;height:250px;"></div>"$)  
  
    Dim element As String = "chart"  
    Dim coords As List = Array(CreateMap("x": xData, "y": yData))  
    Dim margin As Map = CreateMap("margin": CreateMap("t": 0))  
    Dim settings As Map = CreateMap("showSendToCloud": True)  
  
    plot.RunMethod("newPlot", Array(element, coords, margin, settings ))  
End Sub
```

  
  
Result:  
![](https://www.b4x.com/android/forum/attachments/109779)  
  
I hope this makes it a bit clearer how we can circumvent the variable parameters limitation and how to call such a function in B4J.  
  
Alwaysbusy