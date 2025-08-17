### [Web][SithasoDaisy] Table Row Conditional Colors by Mashiane
### 03/19/2024
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/159989/)

Hi Fam  
  
Conditional table row coloring is a process of changing the color of a row in a table based on a condition.  
  
Currently one is able to set a row background color (of the visible rows) and or row text color, by executing  
  

```B4X
tb2.SetRowBackgroundColor(0, "red")
```

and  
  

```B4X
tb2.SetRowTextColor(0, "white")
```

  
  
Should you have multiple rows to color code, you will have to pass the index of each row for these calls. A more advanced approach is using **computed colors.**  
  
With computed colors, you assign a computed background color and or text color and this will be executed in all the pages in your table. The rows in your table are loaded each time one navigates. For example if your records per page is 10, only the first 10 pages will be added to the table, the rest only added when you navigate between the pages.  
  
In this example, we are doing 2 things, setting both the text & background color per row based on a condition. The white text color per row has been added for emphasis and making it more readable due to the red background.  
  
**NB: The "As Zebra" property should be turned off on the table properties.**  
  
![](https://www.b4x.com/android/forum/attachments/151938)  
  
In this example, we want to make the row color red each time a value of "Giacenza" / "Stock" is less than zero. This will work each time we navigate to each page.  
  
Let's look at our code.  
  

```B4X
'set the title of the table listing  
    tbltablecrud.Title = "Table Colors"  
    'define the callback for condition background color  
    tbltablecrud.SetComputeRowBackgroundColor("ComputeBackgroundColorNome")  
    'define the callback for the condition text color  
    tbltablecrud.SetComputeRowTextColor("ComputeTextColorNome")  
    '  
    tbltablecrud.AddColumnAction("vedo","View","fa fa-binoculars",app.COLOR_BLUE)  
    tbltablecrud.AddColumn("nome", "Articolo")  
    tbltablecrud.AddColumn("qta", "Giacenza")  
    tbltablecrud.AddDesignerColums
```

  
  
We have defined 2 callbacks,  
  

```B4X
    tbltablecrud.SetComputeRowBackgroundColor("ComputeBackgroundColorNome")
```

  
  
and  
  

```B4X
  tbltablecrud.SetComputeRowTextColor("ComputeTextColorNome")
```

  
  
For our table.  
  
Each of these callback receives the row data each time a record is added to the table. We use this row data to return the background color for that particular row being added to the table.  
  
Let's look at the sub routines to be called each time a row is added. We need to create these subs ourselves.  
  
**1. Computing the conditional background color of the row.**  
  
  

```B4X
'this receives the row data being added to the table  
Sub ComputeBackgroundColorNome(item As Map) As String  
    'read the qta and convert it to js float  
    Dim qta As Double = SDUIShared.CDbl(item.Get("qta"))  
    If qta < 0 Then  
        'red  
        Return "#FF0000"  
    Else  
        Return ""     
    End If  
End Sub
```

  
  
This gets the data of the row to be added, read the "qta" contents. Converts this into a JavaScript float value / b4x double. If the value is < 0 then return red.  
  
**2. Computing the conditional text color of the row.**  
  
Just like the example above, we also find out if the qta is< 0 then return a white color.  
  

```B4X
'this receives the row data being added to the table  
Sub ComputeTextColorNome(item As Map) As String  
    'read the qta and convert it to js float  
    Dim qta As Double = SDUIShared.CDbl(item.Get("qta"))  
    If qta < 0 Then  
        'white  
        Return "#FFFFFF"  
    Else  
        Return ""  
    End If  
End Sub
```

  
  
So instead of calling add SetRowBackgroundColor per table row (0..n), the colors are computed for you automatically.  
  
I have attached the source code here for clarity.