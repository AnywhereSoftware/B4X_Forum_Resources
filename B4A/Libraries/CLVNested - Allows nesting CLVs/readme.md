### CLVNested - Allows nesting CLVs by Erel
### 09/20/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/107742/)

![](https://www.b4x.com/basic4android/images/firefox_e9gvxSKgTH.png)  
  
Putting a CLV inside another one will not work out of the box. The inner list will not be scrollable.  
  
CLVNested makes it possible.  
  
Limitations:  
  
- One list per item.  
- The user will not be able to interact with views added to the inner list. The basic features of the inner list will work.  
- Will not work with other extensions that "steal" the touch events such as CLVSwipe.  
  
Usage:  
  
1. Initialize the CLVNested object.  
2. Load the layout with the main list to nested.base.  
3. Set the main list with:  

```B4X
nested.CLV = CustomListView
```

  
  
4. Add the items. If you want to add items with inner lists then you need to set the panel's tag to point to the list.  
  
Complete example:  

```B4X
Sub Globals  
   Private CustomListView1 As CustomListView  
   Private clvItem As CustomListView  
   Private xui As XUI  
   Private nested As CLVNested  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
   nested.Initialize(Activity)  
   nested.base.LoadLayout("1")  
   nested.CLV = CustomListView1  
   For i = 1 To 10  
       CustomListView1.AddTextItem($"*** TITLE (${i}) ***"$, "")  
       Dim p As B4XView = xui.CreatePanel("")  
       p.SetLayoutAnimated(0, 0, 0, 100%x, 200dip)  
       p.LoadLayout("Item")  
       p.Tag = clvItem 'must set the Panel tag like this  
       FillInnerList  
       CustomListView1.Add(p, "")  
   Next  
End Sub  
  
Sub FillInnerList  
   For x = 1 To 10  
       clvItem.AddTextItem($"Item #${x}"$, x)  
   Next  
End Sub
```

  
  
Depends on ViewsEx library.  
  
Note that such solution is not required in B4i or B4J. The standard xCLV will suffice.  
  
**Updates**  
  
v1.10 - Adds support for nested horizontal CLVs.