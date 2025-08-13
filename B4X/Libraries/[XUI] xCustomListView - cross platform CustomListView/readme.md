###  [XUI] xCustomListView - cross platform CustomListView by Erel
### 12/24/2023
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/84501/)

Update: As several other libraries depend on xCustomListView library, it is no longer recommended to use the code module. Use the library instead. There are several extension classes that add more features to xCLV. They are listed at the end of this post.  
  
Video tutorial:  
  
[MEDIA=vimeo]256437236[/MEDIA]  
  
xCustomListView is an implementation of CustomListView based on XUI library. It provides all the features of the original CustomListView and it is compatible with B4A, B4J and B4i.  
  
![](https://www.b4x.com/basic4android/images/SS-2017-09-27_11.15.59.png) ![](https://www.b4x.com/basic4android/images/SS-2017-09-27_11.16.26.png) ![](https://www.b4x.com/basic4android/images/SS-2017-09-27_11.16.50.png)  
  
![](https://www.b4x.com/basic4android/images/SS-2017-12-27_16.20.44.png)  
  
This class replaces the platform specific CustomListView classes. It is recommended to use this one for new projects.  
  
Change log:  
  
- V1.74 - Fixes a bug with JumpToItem (B4i).  
- V1.72 (B4A only) - Fixes an issue where the designer typeface is not set when calling AddTextItem.  
- V1.71 (B4i only) - Fixes an issue related to iOS 9- devices.  
- V1.70 - ItemLongClick event (right click in B4J).  
- V1.68 - Fixes a bug with ResizeItem / ReplaceAt and lists with single item.  
- PressedColor is now a public field.  
- Setting the PressedColor to a transparent color disables the item click color animation. This is useful if you want to replace it with your own implementation.  
- V1.66 - Improves the text measurement of text items in B4J.  
- V1.65 - Fixes an issue in B4i only where the CSBuilder colors were ignored.  
- V1.64 - Fixes an issue with ScrollToItem / JumpToItem in B4i.  
- V1.63 - Bug fixes, Refresh method to force VisibleRangeChanged to be raised, several private subs are now public, designer property to hide the scroll bar.  
- V1.54 - Allows using CSBuilder with AddTextItem in B4i (it is also supported in B4A).  
- V1.53 - Fixes an issue with VisibleRangeChanged event and CLV.Clear  
- V1.52 - Fixes an issue with CLV.RemoveAt  
- V1.51 - Fixes an issue which caused the LastVisibleIndex and FirstVisibleIndex properties to be hidden.  
  
- V1.50 - Large update.  

- VisibleRangeChanged event. With this event it is possible to show longer lists with complex items: <https://www.b4x.com/android/forum/threads/b4x-xui-customlistview-lazy-loading-virtualization.87930/>
- FindIndexFromOffset - quickly finds the index of the item in the specified index.
- ScrollChanged event.
- Support for CSBuilder in AddTextItem (B4A only).
- Performance improvements.

- V1.20 - Adds support for horizontal orientation.  
Set it in the designer.  
Add items like this:  

```B4X
clv2.Add(CreateListItem($"Item #${i}"$, 160dip, clv2.AsView.Height), $"Item #${i}"$)  
'Instead of  
'clv2.Add(CreateListItem($"Item #${i}"$, clv2.AsView.Width, 160dip), $"Item #${i}"$)
```

  
  
**Don't use the source code. Use the preinstalled xCustomListView library instead.**   
Libraries such as XUI Views depend on the library and will not work properly with the module.  
  
Extension classes:  
  
CLVExpandable (B4X) - Allows expanding and collapsing items: <https://www.b4x.com/android/forum/threads/b4x-clvexpandable-allows-expanding-or-collapsing-xcustomlistview-items.106148/>  
CLVSwipe (B4A and B4i) - Adds swipe actions and swipe to refresh feature: <https://www.b4x.com/android/forum/threads/98252/#content>  
CLVHeader - (B4X) - Adds a nice animated header to the list: <https://www.b4x.com/android/forum/threads/b4x-clvheader-add-a-nice-animated-header-to-xcustomlistview.105343/#content>  
CLVSelections (B4X) - Adds more selection modes: <https://www.b4x.com/android/forum/threads/b4x-clvselections-extended-selection-modes-for-xcustomlistview.114364/>  
CLVNested (B4A) - Allows nesting a CLV inside a CLV item: <https://www.b4x.com/android/forum/threads/clvnested-allows-nesting-clvs.107742/#content>  
PreoptimizedCLV (B4X) - Lazy loading + fast scroll extension: <https://www.b4x.com/android/forum/threads/preoptimizedclv-lazy-loading-extension-for-xcustomlistview.115289/>  
  
[MEDIA=vimeo]400288986[/MEDIA]