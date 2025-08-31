###  PreoptimizedCLV - Lazy loading extension for xCustomListView by Erel
### 08/28/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/115289/)

This is a cross platform class that extends xCustomListView and makes it "lazier".  
Lazy loading is explained here: <https://www.b4x.com/android/forum/threads/b4x-xui-customlistview-lazy-loading-virtualization.87930/#content> and here: [https://www.b4x.com/android/forum/threads/?-part-1-basics-creating-long-lists-using-xcustomlistview-with-lazy-loading-newer-developers.114096/#content](https://www.b4x.com/android/forum/threads/%F0%9F%92%A1-part-1-basics-creating-long-lists-using-xcustomlistview-with-lazy-loading-newer-developers.114096/#content)  
This is a performance optimization. Instead of creating all items with all the views when the app starts, we create the views as the items become visible.  
  
There are all kinds of lazy loading methods.  
An incomplete list:  

- Level 0: No lazy loading at all. Most applications should choose this one. It is simplest to implement and the easiest one to customize. This method is good for up to several hundred items, depending of course on the items content.
- Level 1: Creating all layout except of the "heavy parts", usually bitmaps.
- Level 2: Only creating layouts for the visible items.

There are several variants for level 2, you can load a new layout each time and discard old layouts or you can cache the layouts and reuse them (example: <https://www.b4x.com/android/forum/threads/xcustomlistview-with-four-columns-of-imageviews-and-many-rows.101431/#post-636920>).  
  
When you add items to xCLV, each item is made of two panels. The first panel is an internal panel and the second one is the panel passed in the CLV.Add call.  
This is true even with lazy loading. If you are creating lists with thousands of items or more than these panels become an issue. PreoptimizedCLV solves this issue.  
PreoptimizedCLV implements the level 2 method without the need to create the two panels. The internal panel is reused and the second panel is created for visible items only.  
  
**Edit:** When I first developed this library I was a bit skeptic about its usefulness, as users will never scroll more than a few hundred items at most. However Klaus suggested to add fast scrolling feature **and it was a great idea!** With fast scrolling this library becomes useful.  
  
It looks like this:  
  
[MEDIA=vimeo]400288986[/MEDIA]  
  
Full example:  

```B4X
Sub Globals  
    Private CustomListView1 As CustomListView  
    Private PCLV As PreoptimizedCLV  
    Private xui As XUI  
    Private Label1 As B4XView  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("1")  
    PCLV.Initialize(Me, "PCLV", CustomListView1)  
    Dim words As List = File.ReadList(File.DirAssets, "english.txt")  
    For Each word As String In words  
        PCLV.AddItem(100dip, xui.Color_White, word)  
    Next  
    PCLV.Commit  
End Sub  
  
Sub PCLV_HintRequested (Index As Int) As Object  
    Dim word As String = CustomListView1.GetValue(Index)  
    Return word  
End Sub  
  
Sub CustomListView1_VisibleRangeChanged (FirstIndex As Int, LastIndex As Int)  
    For Each i As Int In PCLV.VisibleRangeChanged(FirstIndex, LastIndex)  
        Dim item As CLVItem = CustomListView1.GetRawListItem(i)  
        Dim pnl As B4XView = xui.CreatePanel("")  
        item.Panel.AddView(pnl, 0, 0, item.Panel.Width, item.Panel.Height)  
        'Create the item layout  
        pnl.LoadLayout("Item")  
        Label1.Text = item.Value  
    Next  
End Sub
```

  
  
Step #1:  
Add the items with PCLV.AddItem. You need to pass the item size (height for vertical lists and width for horizontal lists), background color and value. Value can be any object you like including complex custom types that hold all the data needed to later build the layout.  
  
Step #2:  
Call PCLV.Commit.  
  
Step #3:  
Implement the VisibleRangeChanged event. The code should look like:  

```B4X
For Each i As Int In PCLV.VisibleRangeChanged(FirstIndex, LastIndex)  
  Dim item As CLVItem = CustomListView1.GetRawListItem(i)  
  'Create the layout for item i and add it to item.Panel.  
Next
```

  
  
Step #4:  
Implement the HintRequested event and return the string or CSBuilder that will be displayed when the user scrolls the list.  
  
That's it.  
  
Once the items are committed you can add or remove items by modifying CLV directly and calling PCLV.  

```B4X
CustomListView1.InsertAtTextItem(Index, "New Item", "")  
PCLV.ListChangedExternally
```

  
PCLV ignores these items.  
  
**Notes**  
  

- The item layout should have a transparent background.
- Better to remove AutoScaleAll and set the animation duration to 0 in the item layout.
- The list should scroll very smoothly in release mode.
- Make sure that "Show Scrollbar" option is unchecked in CLV custom properties.
- PCLV.pnlOvarlay is the panel that hides the list when it fast scrolls. PCLV.lblHint is the label that appears. Both can be customized.
- You can change the seek bar interval by setting PCLV.NumberOfSteps, before calling PCLV.Commit. The default value is 20. Don't set it to be too high as it will be difficult for the user to select a specific point.
- ScrollView height in Android is limited to 16,777,215 pixels. The exact limit depends on the device scale and the items height. As a rule of thumb you can show up to 50,000 100dip tall items. Such lists are not practical anyway: <https://www.b4x.com/android/forum/threads/preoptimizedclv-lazy-loading-extension-for-xcustomlistview.115289/post-721157>

  
Example #1 shows the 10,000 most frequent English words. Source: <https://github.com/first20hours/google-10000-english>  
Example #2 is a port of the "Corona cases" cross platform example based on B4XTable + xChart. It depends on [xChart library](https://www.b4x.com/android/forum/threads/91830/#content).  
Data source: <https://ourworldindata.org/coronavirus-source-data>  
  
**This is an internal library.**  
  
Updates:  
  
PCLV\_Example1 is based on B4XPages and is cross platform.  
v1.21 - Fixes an issue with horizontal orientation in B4i.