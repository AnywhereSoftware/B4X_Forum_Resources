###  xCLV - lazy loading with text input by Erel
### 10/24/2019
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/110767/)

The attached B4J example demonstrates how to implement lazy loading with editable items.  
  
![](https://www.b4x.com/basic4android/images/java_nAZX0TSYJE.png)  
  
There are several interesting points:  
  
- Layouts are reused.  
- A custom type is used to store all of the relevant information for each item.  
- The important code is in the VisibleRangeChanged event:  

```B4X
Sub CustomListView1_VisibleRangeChanged (FirstIndex As Int, LastIndex As Int)  
   For i = 0 To CustomListView1.Size - 1  
       Dim cd As CellData = CustomListView1.GetValue(i)  
       Dim pnl As B4XView = CustomListView1.GetPanel(i)  
       If i >= FirstIndex - 2 And i <= LastIndex + 2 Then  
           'item should be visible  
           If cd.IsVisible = False Then  
               AddCellLayout(pnl)  
               cd.IsVisible = True  
               Dim content As B4XView = pnl.GetView(0)  
               content.GetView(0).Text = cd.Field1  
               content.GetView(1).Text = cd.Field2  
           End If  
       Else  
           'item should be invisible  
           If cd.IsVisible Then  
               Dim content As B4XView = pnl.GetView(0)  
               content.RemoveViewFromParent  
               Layouts.Add(content)  
               cd.IsVisible = False  
               cd.Field1 = content.GetView(0).Text  
               cd.Field2 = content.GetView(1).Text  
           End If  
       End If  
       btnList.RequestFocus 'remove the focus from the text fields.  
   Next  
End Sub
```

  
The loop goes over all items and checks whether there are items that should become visible or items that should become invisible. When items become invisible the text fields are "committed".  
  
- Listing all values is done with:  

```B4X
Sub btnList_Click  
   For i = 0 To CustomListView1.Size - 1  
       Dim cd As CellData = CustomListView1.GetValue(i)  
       Dim value1, value2 As String  
       If cd.IsVisible = False Then  
           value1 = cd.Field1  
           value2 = cd.Field2  
       Else  
           'we need to get the values from the views  
           Dim content As B4XView = CustomListView1.GetPanel(i).GetView(0)  
           value1 = content.GetView(0).Text  
           value2 = content.GetView(1).Text  
       End If  
       Log($"Value1: ${value1}, Value2: ${value2}"$)  
   Next  
End Sub
```