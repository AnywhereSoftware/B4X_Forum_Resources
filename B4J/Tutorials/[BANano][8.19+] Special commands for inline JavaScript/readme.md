### [BANano][8.19+] Special commands for inline JavaScript by alwaysbusy
### 11/29/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/157693/)

In BANano 8.19+, there are some special commands that make it easier to integrate JavaScript code into your WebApp. Previously all this was (is still) possible with .RunMethod and .Get/SetField commands but in some cases it is just easier (especially for BANano Library makers) to integrate a snippet directly, and still have the power to manipulate things like variables. The new commands can be used together with .RunMethod and the .Get/SetField commands.  
  
**The commands:**  
  
BANano.JS($"…"$)  
BANanoObject.JS($"…"$)  
  
**Note on the usage of the B4J SmartString in the .JS() methods**:  
The SmartString parameter variables can have a prefix @. E.g. $"var a = **@${**VariableA**}**;"$ when used in the .JS() methods.  
  
A normal ${VariableA} will be treated as a normal B4J SmartString variable, while a @${VariableA} will be directly injected into the JavaScript code:  
  
Example of the difference in behaviour:  
$"var a = **${**VariableA**}**;"$ will be transpiled to: "var a = " **+** \_B.\_variablea **+** ";" (normal B4J SmartString behaviour, creating a 'String' concatination)  
  
while:  
$"var a = **@${**VariableA**}**;"$ will be transpiled to var a = \_B.\_variablea; (special .JS() SmartString behaviour)  
  
**Some example usage of the .JS methods:**  
These snippets come from a WebApp we wrote that uses the D3.js library to make a special spider chart.  
  

```B4X
' grab the D3 library object from JavaScript  
Dim D3 As BANanoObject  
D3.Initialize("d3")  
  
Dim D3Blinks As BANanoObject  
Dim D3Bnodes As BANanoObject  
Dim D3Btypes As BANanoObject  
…  
D3Blinks = data.Get("links")  
D3Bnodes = data.Get("nodes")  
D3Btypes = data.Get("types")
```

  
  
Previously, to create a color object, we could write:  

```B4X
Dim color As BANanoObject  
color = D3.RunMethod("scaleOrdinal", Array(D3Btypes, D3.GetField("schemeCategory10")))
```

  
  
Now we can also write:  

```B4X
Dim color As BANanoObject = D3.JS($".scaleOrdinal(@${D3Types}, @${D3}.schemeCategory10);"$)
```

  
  
There is not much gain in this case, but it shows the difference in writing the same line.  
  
But it becomes very benifical once you have complex objects that e.g. use ES6 arrow functions:  

```B4X
Dim simulation As BANanoObject  
simulation = D3.JS($"  
            .forceSimulation(@${D3Bnodes})  
            .force("link", @${D3}.forceLink(@${D3Blinks}).id((d) => d.id))  
            .force("charge", @${D3}.forceManyBody().strength(-1000))  
            .force('collide', d3.forceCollide(50))  
            .force("x", @${D3}.forceX())  
            .force("y", @${D3}.forceY())  
            .force("center", @${D3}.forceCenter(@${width / 2}, @${height / 2}))  
            "$)
```

  
  
Writing this with .RunMethod and .Get/Set would be doable, but being a rather complex and time consuming task.  
And sometimes, for readability, a mix is benifical:  
  
In this example we build a JavaScript zoomed function, using both BANano.JS() and BANanoObject.JS(), that we then use in the zoom object as a callback.  

```B4X
Dim g As BANanoObject  
g = svg.RunMethod("append", "g")  
  
Dim zoomed As BANanoObject  
zoomed = BANano.JS($"function zoomed({transform}) {"$)  
       g.JS($".attr("transform", transform);"$)                
zoomed.JS($"}"$)  
         
Dim zoom As BANanoObject  
zoom = D3 _  
      .RunMethod("zoom", Null) _  
      .RunMethod("scaleExtent", Array(Array(-10,40))) _  
      .RunMethod("on", Array("zoom", zoomed))
```

  
  
Another example of mixed usage (as it uses a not so easy to translate arrow syntax):  

```B4X
Dim link As BANanoObject  
link = g _  
            .RunMethod("append", "g") _  
            .RunMethod("attr", Array("fill", "none")) _  
            .RunMethod("selectAll", "path") _  
            .RunMethod("data", D3Blinks) _  
            .RunMethod("join", "path") _             
            .RunMethod("attr", Array("stroke", stroke)) _  
            .RunMethod("attr", Array("stroke-width", lineWidth)) _  
            .RunMethod("attr", Array("marker-end", BANano.JS("d => `url(${new URL(`#arrow-${d.type}`, location)})`"))) _  
            .RunMethod("style", Array("cursor", "alias")) _     
            .RunMethod("attr", Array("data-id", BANano.JS("(d) => d.source.id + ';' + d.target.id"))) _         
            .RunMethod("on", Array("click", DoClickLink))
```

  
  
Note that in this case we have not used a SmartString, but a normal string. This is because the D3.js library has its own ${} syntax for variables!  
the 'd' variable is a variable passed in the arrow method that has a property .type. It is NOT a B4J variable d.  

```B4X
 .RunMethod("attr", Array("marker-end", BANano.JS("d => `url(${new URL(`#arrow-${d.type}`, location)})`"))) _
```

  
  
These are all special examples do demonstrate the power of the new .JS() methods, but it can easily be of usage for much more simpler tasks too, like getting/setting properties to a B4J BANano Object:  

```B4X
Dim obj As BANanoObject  
…  
Dim s As Float = obj.JS($".source.data.x.calculateSlope(15,6);"$)
```

  
  
With only the GetField() method, it would look like this:  

```B4X
Dim obj As BANanoObject  
…  
Dim s As Float = obj.GetField("source").GetField("data").GetField("x").Runmethod("calculateSlope", Array(15,6))
```

  
  
Alwaysbusy