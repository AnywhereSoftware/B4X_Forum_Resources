### StdActionBar - Another ActionBar library by Erel
### 01/03/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/36786/)

StdActionBar (Standard ActionBar) library is based on the native ActionBar API, therefore **it is only supported by Android 4+.**  
  
StdActionBar / StdViewPager tutorial: [ActionBar / Sliding Pages tutorial](http://www.b4x.com/android/forum/threads/36865/#content)  
  
The [share](http://developer.android.com/about/dashboards/index.html) of Android 2.x devices is dropping and currently (January 2014) it is only 24%.  
  
This library allows you to add tabs and dropdown list to the action bar:  
  
![](https://www.b4x.com/android/forum/attachments/22024) ![](https://www.b4x.com/android/forum/attachments/22025)  
  
The attached example demonstrates both modes. You should change the navigation mode to see the two modes.  
  
**List mode**  
  
Adding a list is very simple. You set the NavigationMode:  

```B4X
bar.NavigationMode = bar.NAVIGATION_MODE_LIST
```

  
Add the items:  

```B4X
bar.SetListItems(Array As String("Dropdown 1", "Dropdown 2", "Dropdown 3"))
```

  
  
And handle the event:  

```B4X
Sub bar_ListItemSelected (Index As Int, Value As String)  
   Log("Selected value: " & Value)  
End Sub
```

  
  
**Tabs mode**  
  
Unlike TabHost, the tabs do not hold any views. You are responsible for switching the layout based on the selected tab.  
  
The first step is to set the navigation mode:  

```B4X
bar.NavigationMode = bar.NAVIGATION_MODE_TABS
```

  
  
Then we add the tabs:  

```B4X
bar.AddTab("Tab 1")
```

  
bar.AddTab returns a StdTab object. We can use it to modify the tabs:  

```B4X
bar.AddTab("Tab 1").Tag = panel1  
bar.AddTab("Tab 2").Tag = panel2  
'Add icon to tab 3  
Dim tb As StdTab = bar.AddTab("Tab 3")  
tb.Tag = panel3  
Dim bd As BitmapDrawable  
bd.Initialize(LoadBitmap(File.DirAssets, "ic_small.png"))  
tb.Icon = bd
```

  
In the above code we add three tabs and use the tabs tag property to store a panel in each tab. Later we will use these panels to switch the layout.  
  
When the TabChanged event is raised we clear the current layout and show the new layout.  

```B4X
Sub bar_TabChanged(Index As Int, STab As StdTab)  
   Activity.RemoveAllViews  
   Dim pnl As Panel = STab.Tag  
   Dim height As Int  
   If 100%y > 100%x Then  
     height = 100%y - 48dip 'fix for the additional tabs height  
   Else  
     height = 100%y  
   End If  
   Activity.AddView(pnl, 0, 0, 100%x, height)  
   If pnl.NumberOfViews = 0 Then  
     pnl.LoadLayout(Index)  
   End If  
End Sub
```

  
  
Note that the attached example uses the Holo.Light theme. This is done with this manifest editor line:  

```B4X
SetApplicationAttribute(android:theme, "@android:style/Theme.Holo.Light")
```

  
  
V1.52 is released. Fixes an incompatibility with Android 5.0. Note that the ButtonClicked event will not work on these devices.  
  
You should use Activity\_ActionBarHomeClick event instead.