###  [XUI] CustomListView - lazy loading / virtualization by Erel
### 11/16/2023
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/87930/)

xCustomListView v1.50 adds an important new event named VisibleRangeChanged. This event is fired whenever the visible range of items changes.  
  
We can use this event to defer the items creation. This can significantly improve the performance of lists with complex items.  
  
As an example, if we try to create a list with 1000 cards with this code (based on <https://www.b4x.com/android/forum/threads/cards-list-with-customlistview.87720/#content>):  

```B4X
Sub FillList  
   Dim bitmaps As List = Array("pexels-photo-446811.jpeg", "pexels-photo-571195.jpeg", _  
       "pexels-photo-736212.jpeg", "pexels-photo-592798.jpeg")  
   Dim n As Long = DateTime.Now  
   For i = 1 To 1000  
       Dim content As String = $"Lorem ipsum dolor sit amet,  
consectetur adipiscing elit,  
sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.  
Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."$  
       CLV1.Add(CreateItem(CLV1.AsView.Width, $"This is item #${i}"$, bitmaps.Get((i - 1) Mod bitmaps.Size), content), "")  
   Next  
   Log("Loading cards took: " & (DateTime.Now - n) & "ms")  
End Sub
```

  
  
It takes almost 10 seconds. Not good enough…  
  
So instead we create empty cells and only load the items when they become visible:  
  
Global type:  

```B4X
Type CardData (Title As String, Content As String, BitmapFile As String)
```

  
  

```B4X
Sub FillList2  
   Dim bitmaps As List = Array("pexels-photo-446811.jpeg", "pexels-photo-571195.jpeg", _  
       "pexels-photo-736212.jpeg", "pexels-photo-592798.jpeg")  
   Dim n As Long = DateTime.Now  
   For i = 1 To 1000  
       Dim content As String = $"Lorem ipsum dolor sit amet,  
consectetur adipiscing elit,  
sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.  
Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."$  
       Dim cd As CardData  
       cd.Initialize  
       cd.Title = $"This is item #${i}"$  
       cd.Content = content  
       cd.BitmapFile = bitmaps.Get((i - 1) Mod bitmaps.Size)  
       Dim p As B4XView = xui.CreatePanel("")  
       p.SetLayoutAnimated(0, 0, 0, CLV1.AsView.Width, 280dip)  
       CLV1.Add(p, cd)  
   Next  
   Log("Loading cards took: " & (DateTime.Now - n) & "ms")  
End Sub  
  
Sub CLV1_VisibleRangeChanged (FirstIndex As Int, LastIndex As Int)  
   Dim ExtraSize As Int = 20  
   For i = Max(0, FirstIndex - ExtraSize) To Min(LastIndex + ExtraSize, CLV1.Size - 1)  
       Dim p As B4XView = CLV1.GetPanel(i)  
       If p.NumberOfViews = 0 Then  
           Dim cd As CardData = CLV1.GetValue(i)  
           '**************** this code is similar to the code in CreateItem from the original example  
           p.LoadLayout("Card1")  
           lblTitle.Text = cd.Title  
           lblContent.Text = cd.Content  
           SetColorStateList(lblAction1, xui.Color_LightGray, lblAction1.TextColor)  
           SetColorStateList(lblAction2, xui.Color_LightGray, lblAction2.TextColor)  
           ImageView1.SetBitmap(xui.LoadBitmapResize(File.DirAssets, cd.BitmapFile, ImageView1.Width, ImageView1.Height, True))  
       End If  
   Next  
End Sub
```

  
This time it takes 250ms for the list to be created. Scrolling the list is very smooth.  
  
![](https://www.b4x.com/basic4android/images/SS-2018-01-04_12.31.51.png)  
  
We can go another step and remove the invisible items. This can be relevant if the items include large bitmaps or other "heavy" UI elements.  
  

```B4X
Sub CLV1_VisibleRangeChanged (FirstIndex As Int, LastIndex As Int)  
   Dim ExtraSize As Int = 20  
   For i = 0 To CLV1.Size - 1  
       Dim p As B4XView = CLV1.GetPanel(i)  
       If i > FirstIndex - ExtraSize And i < LastIndex + ExtraSize Then  
           'visible+  
           If p.NumberOfViews = 0 Then  
               Dim cd As CardData = CLV1.GetValue(i)  
               p.LoadLayout("Card1")  
               lblTitle.Text = cd.Title  
               lblContent.Text = cd.Content  
               SetColorStateList(lblAction1, xui.Color_LightGray, lblAction1.TextColor)  
               SetColorStateList(lblAction2, xui.Color_LightGray, lblAction2.TextColor)  
               ImageView1.SetBitmap(xui.LoadBitmapResize(File.DirAssets, cd.BitmapFile, ImageView1.Width, ImageView1.Height, True))  
           End If  
       Else  
           'not visible  
           If p.NumberOfViews > 0 Then  
               p.RemoveAllViews '<— remove the layout  
           End If  
       End If  
   Next  
End Sub
```

  
  
You need to remember that you can no longer access UI elements of random items. If there is any state that needs to be preserved then you should add it to the custom type that is used as the item's value.  
  
As an example we will change the content color whenever an item is clicked:  

```B4X
Type CardData (Title As String, Content As String, BitmapFile As String, Color As Int) 'new Color field
```

  
  

```B4X
Sub CLV1_ItemClick (Index As Int, Value As Object)  
   UpdateItemColor(Index, Rnd(0xff000000, 0xffffffff))  
End Sub  
  
Sub UpdateItemColor (Index As Int, Color As Int)  
   Dim cd As CardData = CLV1.GetValue(Index)  
   cd.Color = Color  
   Dim p As B4XView = CLV1.GetPanel(Index)  
   If p.NumberOfViews > 0 Then  
       'get the content label view (it is inside an additional panel)  
       Dim ContentLabel As B4XView = p.GetView(0).GetView(1)  
       ContentLabel.TextColor = Color  
   End If  
End Sub
```

  
  
When an item becomes visible we also call UpdateItemColor:  

```B4X
Sub CLV1_VisibleRangeChanged (FirstIndex As Int, LastIndex As Int)  
   Dim ExtraSize As Int = 20  
   For i = 0 To CLV1.Size - 1  
       Dim p As B4XView = CLV1.GetPanel(i)  
       If i > FirstIndex - ExtraSize And i < LastIndex + ExtraSize Then  
           'visible+  
           If p.NumberOfViews = 0 Then  
               Dim cd As CardData = CLV1.GetValue(i)  
               p.LoadLayout("Card1")  
               lblTitle.Text = cd.Title  
               lblContent.Text = cd.Content  
               SetColorStateList(lblAction1, xui.Color_LightGray, lblAction1.TextColor)  
               SetColorStateList(lblAction2, xui.Color_LightGray, lblAction2.TextColor)  
               ImageView1.SetBitmap(xui.LoadBitmapResize(File.DirAssets, cd.BitmapFile, ImageView1.Width, ImageView1.Height, True))  
               UpdateItemColor(i, cd.Color) '<————-  
           End If  
       Else  
           'not visible  
           If p.NumberOfViews > 0 Then  
               p.RemoveAllViews  
           End If  
       End If  
   Next  
End Sub
```

  
  
![](https://www.b4x.com/basic4android/images/SS-2018-01-04_12.58.56.png)