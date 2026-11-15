###  [XUI] AS LiquidGlassTabBar - Liquid Glass Bottom Navigation by Alexander Stolte
### 11/11/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/172533/)

This view makes it easy to add a Liquid Glass bottom navigation to your app. Add your tabs, load your layouts and the view takes care of the navigation.  
  
On B4i it uses the native UITabBarController. B4A and B4J use a custom implementation with a glass background, animated selection and long press / drag handling.  
  
Captured on Android Emulator  
  
![](https://www.b4x.com/android/forum/attachments/174786)![](https://www.b4x.com/android/forum/attachments/174787)  
  
![](https://www.b4x.com/android/forum/attachments/174788)![](https://www.b4x.com/android/forum/attachments/174789)  
  
**You need:**  
[AS\_LiquidGlass](https://www.b4x.com/android/forum/threads/b4x-xui-as-liquidglass-cross-platform-liquid-glass-panel.172530/) for B4A and B4J  
  
**Features**  

- B4X API for B4A, B4i and B4J
- Automatic content panels and tab switching
- Native tab bar on B4i
- Live glass background on B4A and B4J
- Long press and drag to select a tab
- Badges, custom icons and disabled tabs
- Separate search tab or your own custom action button
- Minimize the bar while scrolling
- Custom accessory views, for example a mini-player
- Light and dark themes
- Adjustable blur and coverage on B4A and B4J

  
**Example**  

```B4X
Private Tabs As AS_LiquidGlassTabBar  
  
Private Sub B4XPage_Created(Root1 As B4XView)  
    Tabs.Initialize(Me, "Tabs")  
    Tabs.CreateNavigation(Root1)  
    Tabs.AddTab("Home", "house.fill")  
    Tabs.AddTab("Favorites", "heart.fill")  
    Tabs.AddTab("Settings", "gearshape.fill")  
    Tabs.AddSearchTab("Search")  
    Tabs.SetBadge(1, "3")  
    Tabs.GetContentPanel(0).LoadLayout("Home")  
End Sub  
  
Private Sub Tabs_TabChanged(Index As Int)  
    Log(Index)  
End Sub
```

  
  
Load your layouts into GetContentPanel(Index). The view switches the panels automatically. Tab indices start at 0, with a maximum of 5 tabs including search. The search tab provides a content panel for your own search UI.  
  
**Blur strength (B4A / B4J)**  

```B4X
Tabs.BlurStrength = 25 '0 = clear, 100 = completely opaque
```

  
BlurStrength is also available in the designer. BlurRadius and GlassTint can be adjusted separately. B4i uses the system material.  
  
**Scroll behavior**  

```B4X
Tabs.MinimizeBehavior = "OnScrollDown"  
Tabs.BindScrollView(YourScrollView) 'B4A: ScrollView / B4J: ScrollPane
```

  
On B4i, put your native scroll view inside the tab's content panel and UIKit handles the scroll behavior.  
  
**Custom button**  

```B4X
Tabs.SetCustomButton(YourCustomView, 64dip)  
  
Private Sub Tabs_CustomButtonClick  
    Log("Add")  
End Sub
```

  
The custom button replaces the search tab and does not change the selected tab. On B4A/B4J it sits beside the bar. On B4i it uses the native bottom accessory slot in navigation mode.  
  
**Note**  
The native appearance on B4i depends on the iOS version and the SDK used to build the app. Older versions show the available system design. B4i device testing and a full B4J IDE build are still outstanding.  
  
[SPOILER="Properties, Functions, Events, etc."]  
**AS\_LiquidGlassTabBar  
  
Author:** Alexander Stolte  
**Version:** 1.00  

- **AS\_LiquidGlassTabBar**

- **Events:**

- **CustomButtonClick**
- **MinimizedChanged** (Minimized As Boolean)
- **TabChanged** (Index As Int)
- **TabClick** (Index As Int)
- **TabLongClick** (Index As Int)

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **AddSearchTab** (Text As String) As Int
*Adds a system search tab on iOS; detached search button on B4A/B4J.*- **AddTab** (Text As String, SymbolName As String) As Int
*Built-in names match SF Symbols on iOS. Other platforms use bundled fallback artwork.  
 Use SetIcon for the same custom bitmap on every platform.*- **BindScrollView** (Scroll As B4XView) As String
*Bind a native ScrollView (B4A) or ScrollPane (B4J). Native iOS scroll views must be inside GetContentPanel.  
 Does not replace the scroll control's existing event handlers.*- **CancelGesture** As String
- **Clear** As String
- **ClearAccessory** As String
- **ClearBadge** (Index As Int) As String
- **ClearCustomButton** As String
- **CreateBottomBar** (Parent As B4XView) As String
*Attach once. Parent size changes are handled by the view.*- **CreateNavigation** (Parent As B4XView) As String
*Full navigation host. Use GetContentPanel(Index) for each tab's layout.  
 B4i embeds a real UITabBarController. CreateBottomBar remains an overlay.*- **CreateViewPerCode** (Parent As B4XView, Left As Float, Top As Float, Width As Float, Height As Float) As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
- **Dispose** As String
- **GetContentPanel** (Index As Int) As B4XView
- **GetTab** (Index As Int) As AS\_LiquidGlassTabBar\_Tab
- **Initialize** (Callback As Object, EventName As String) As String
- **NotifyScroll** (Offset As Double) As String
*Optional custom scroll controls can forward their offset here instead of BindScrollView.  
 Increasing Offset means scrolling down. Direction changes use a 16dip threshold.*- **Refresh** As String
*Only needed after directly editing fields returned by GetTab or changing backdrop pixels.*- **RemoveTab** (Index As Int) As String
- **Resize** (Width As Float, Height As Float) As String
- **SetAccessory** (Content As B4XView, Height As Float) As String
*Use any custom view as a mini-player/accessory. Call ClearAccessory to remove it.*- **SetBackdropView** (Source As B4XView) As String
*Optional scene panel, otherwise the parent is captured with this bar temporarily hidden.*- **SetBadge** (Index As Int, Value As String) As String
*Empty Value shows a dot. ClearBadge removes it.*- **SetCustomButton** (Content As B4XView, Width As Float) As String
*B4A/B4J place it beside the bar. B4i uses UIKit's accessory slot in navigation mode.*- **SetEnabled** (Index As Int, Value As Boolean) As String
- **SetIcon** (Index As Int, Bitmap As B4XBitmap) As String
- **UnbindScrollView** As String

- **Properties:**

- **BackdropRefreshInterval** As Int
- **BlurRadius** As Float
- **BlurStrength** As Float
*Replica material settings. UIKit controls its native material on B4i.  
 One control for blur and coverage: 0 = clear, 100 = completely opaque.  
 BlurRadius and GlassTint can still be changed separately afterwards.*- **ContentBottomInset** As Float [read only]
- **DisplayMode** As String
*Automatic, TabBar or TabSidebar. UIKit adapts to iPad size classes in navigation mode.*- **GlassTint** As Int
- **Index** As Int
- **LiveBackdrop** As Boolean
*Frame-synchronized while scrolling; low-rate polling when the scene is idle.  
 The animation/gesture engine is not reconfigured by a backdrop update.*- **MinimizeBehavior** As String
*Never, OnScrollDown or OnScrollUp. UIKit performs native minimizing in navigation mode.*- **Minimized** As Boolean
*Explicit replica collapse state. On iOS, UIKit minimizes from native scroll gestures.*- **NativeController** As NativeObject [read only]
- **ReduceMotion** As Boolean
- **SelectedColor** As Int
- **SelectedIndex** As Int
- **TabCount** As Int [read only]
- **Theme** As String

- **AS\_LiquidGlassTabBar\_Tab**

- **Fields:**

- **BadgeValue** As String
- **BadgeVisible** As Boolean
- **Enabled** As Boolean
- **Icon** As B4XBitmap
- **SymbolName** As String
- **Tag** As Object
- **Text** As String

[/SPOILER]  
  
**Changelog**  

- **1.00**

- Release

  
Have fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)