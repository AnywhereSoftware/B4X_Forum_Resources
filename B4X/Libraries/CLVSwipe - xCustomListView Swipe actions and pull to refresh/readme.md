###  CLVSwipe - xCustomListView Swipe actions and pull to refresh by Erel
### 03/02/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/98252/)

CLVSwipe is a class that adds "swipe actions" and pull to refresh features to the standard xCustomListView library.  
  
It is compatible with B4A and B4i (currently not with B4J).  
Both features are optional.  
  
[MEDIA=vimeo]295327727[/MEDIA]  
  
Using it is simple:  
  
1. Add the class to your project. It depends on XUI, xCustomListView and ViewsEx [v1.30](https://www.b4x.com/android/forum/threads/updates-to-internal-libraries.59340/#post-616520)+.  
2. Initialize Swipe and pass the CustomListView.  
3. In B4i, call Swipe.Resize when the page is resized.  
  
Adding action commands:  
  
- Set the action colors:  

```B4X
Swipe.ActionColors = CreateMap("Delete": xui.Color_Red, "Do Something Else": xui.Color_Green, _  
       "Action 1": xui.Color_Red, "Action 2": xui.Color_Blue, "Action 3": xui.Color_Yellow)
```

  
- Create the items values with Swipe.CreateItemValue:  

```B4X
CustomListView1.AddTextItem($"Important item ${i} …"$, Swipe.CreateItemValue("", Array("Delete", "Do Something Else")))
```

  
- Handle the ActionClicked event:  

```B4X
Sub Swipe_ActionClicked (Index As Int, ActionText As String)
```

  
  
Pull to refresh:  
  
- Create the PullToRefreshPanel panel. This is the panel that appears when the user pulls the list.  
- Set it with Swipe.PullToRefreshPanel.  
- Handle the RefreshRequested event. Make sure to call Swipe.RefreshCompleted when done.  
- In B4i you need to call Swipe.ScrollChanged from the ScrollChanged event.  
  
B4A and B4i projects are attached. Note that the class module is identical in both projects.  
  
**Updates**  
  
V1.14 - Fixes an issue with crashes on low resolution devices.  
V1.13 - New ScrollingEnabled property - enables or disables scrolling.  
V1.12 - Fixes an issue with the Resize method.  
V1.11 - Fixes an issue with horizontal swipes when the list is empty.  
v1.10 - Adds pull to refresh feature.  
  
The class is included inside the project.