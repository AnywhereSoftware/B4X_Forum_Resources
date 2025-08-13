### [Web][SithasoDaisy] Mastering the SDUIDragTabs Component i.e. Draggable Tabs by Mashiane
### 05/03/2024
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/160910/)

Hi Fam  
  
This component helps with scrolling tabs which are clickable, more like the YouTube draggable tabs.  
  
![](https://www.b4x.com/android/forum/attachments/153375)  
  
When the page is shown, we build up the page  
  

```B4X
'sub to show the page  
Sub Show(duiapp As SDUIApp)            'ignore  
    'get the reference to the app  
    app = duiapp  
    page.Initialize(Me, name, name)  
    banano.Await(page.ClearPageView)  
    page.PageName = name  
    page.ParentID = "pageview"  
    page.FullPage = False  
    page.Title = title  
    page.ResizePageView = True  
    page.Container = False  
    page.MxAuto = False  
    page.flex = False  
    page.FlexWrap = False  
    page.Grid = True  
    page.GridCols("1")  
    page.Visible = True  
    page.PaddingAXYTBLR = "a=5; x=?; y=?; t=?; b=?; l=?; r=?"  
    banano.Await(page.AddToParent(app.PageViewer, page.CustProps))  
    'build the page, via code or loadlayouts  
    drgTab.Initialize(Me, "drgTab", "drgTab")  
    drgTab.ParentID = name  
    banano.Await(drgTab.AddToParent(name, drgTab.CustProps))  
    BuildPage  
End Sub
```

  
  
Then we clear and add items to the draggable component.  
  

```B4X
'start building the page  
private Sub BuildPage  
    drgTab.Clear  
    drgTab.AddItem("programming", "Programming")  
    drgTab.AddItem("robotics", "Robotics")  
    drgTab.AddItem("database", "Database")  
    drgTab.AddItem("webdev", "Web Development")  
    drgTab.AddItem("appdev", "App Development")  
    drgTab.AddItem("marketing", "Marketing")  
    drgTab.AddItem("freelancing", "Freelancing")  
    drgTab.AddItem("gaming", "Gaming")  
    drgTab.AddItem("gadgets", "Gadgets")  
    drgTab.AddItem("flutter", "Flutter")  
    drgTab.AddItem("videos", "Videos")  
    drgTab.AddItem("blogs", "Blogs")  
    drgTab.AddItem("podcast", "Podcasts")  
End Sub
```

  
  
We then trap the event when an item is clicked.  
  

```B4X
Private Sub drgTab_ItemClick (e As BANanoEvent, Item As String)  
    e.PreventDefault  
    drgTab.SetActiveItem(Item)  
    app.ShowToast(Item)  
End Sub
```

  
  
You can perform other tasks when tabs are clicked.  
  
#Available in next update.