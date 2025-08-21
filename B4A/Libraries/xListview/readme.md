### xListview by KZero
### 03/23/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/115073/)

**xCLV now supports adding huge numbers of items smoothly using Preoptimized class , you should use it instead :** <https://www.b4x.com/android/forum/threads/preoptimizedclv-lazy-loading-extension-for-xcustomlistview.115289/>  
  
I'd like to share my first B4A library,  
  
Using xListview you can add tens of thousands of items instantly with an extremely low memory footprint.  
  
**How it works**  
instead of creating an empty panel for each item to load the layout inside it when needed, which takes time to create the panels and consumes more memory if used for a large number of items  
xListview on the other hand uses only 1 panel for each visible item and automatically destroys it when it goes offscreen.  
So if we have a list that contains 100,000 items it will actually have around 15 panels only.  
  
  
**Requirements**  
Reflection library  

[MEDIA=youtube]Z9EmwHhZ670[/MEDIA]  
  
  
  
test on a very old android device  
  
[MEDIA=youtube]5VD\_q-JpO-Q[/MEDIA]

  
  
  
**Usage**  
  

```B4X
Sub Globals  
    Private xLV As xListView  
    Private lblTitle As Label  
    Private lblTime As Label  
End Sub  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("L1")  
    xLV.selectionColor = Colors.Cyan  
    xLV.OffscreenItems=5 'Default = 5, change it before adding items  
    xLV.SetScrollbarColor(Colors.Blue)  
    xLV.HideScrollBar(False) ' Set True to hide Scrollbar  
End Sub  
Sub xLV_PanelRequested(Index As Int)  
    'Load the panel here , the panel will be automatically removed when it's not visible (don't remove it manually)  
    Dim P As Panel  
    P.Initialize("")  
    P.SetLayout(0,0,xLV.AsView.Width,180dip)  
    P.LoadLayout("ItemLayout") 'Disable animation from the Visual Designer for more smooth scrolling  
    lblTitle.Text= "Item Number : " & Index  
    xLV.LoadPanel(P,Index)  
End Sub  
Sub Button1_Click  
    Dim B As Button=Sender  
    B.Text="Clicked"  
End Sub  
Sub xLV_ItemClick (Index As Int, Value As Object)  
    ToastMessageShow("Item " & Index & " Clicked",False)  
End Sub  
Sub xLV_ItemLongClick (Index As Int, Value As Object)  
    ToastMessageShow("Item " & Index & " Long Clicked",False)  
End Sub  
Sub btnAddItems_Click  
    Dim ms As Long = DateTime.Now  
    For i = 1 To 10000  
        xLV.NewItem(180dip,i)  
    Next  
    xLV.Reload ' you must call reload after adding new items  
    lblTime.Text = "Load Time : " & (DateTime.Now - ms) & " ms    -   Total Items : " & xLV.Size  
End Sub
```

  
  
  
v0.9  
+ Resize item  
+ DisableSelectionColor  
  
v0.95  
+ Scrolling performance improved