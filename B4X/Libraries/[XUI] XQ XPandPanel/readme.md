###  [XUI] XQ XPandPanel by fat32
### 03/31/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/160211/)

An expandable panel with a titlebar (xq-titlebar), than can host any other view, inside the panel. It can have up to 5 icons in the right corner, one icon in the left corner and the title is auto-adjustable. The panel can also be animated while expanding/collapsing.  
  
**Features:**  

- Up to 5 icons on the right side
- Left/Burger icon (visible or not)
- Change background and text color
- Each element (panel, burger, title, icons) has each own click event
- Title label adjusts its width, depending the icons visible
- Can adjust icon spacing/padding
- All default sizes are compatible with the Material Design
- Can be animated while collapsing/expanding
- Collapse/Expand events

  

---

  
  
**View:** xq\_xpandpanel  
**Author:** xqtr  
**Version:** 1.00  
**Depends:** XUI  
  

- **Fields**

- **Background** As Int
- **ShowBurgerIcon** As Boolean
- **IconSpacing** As Int
- **IconPadding** As Int
- **IconSize** As Int
- **IconCount** As Int
- **Icons**(5) As B4XView\*
- **TitleLabel** As B4XView\*
- **BurgerIcon** As B4XView\*
- **ShowBurgerIcon** As Boolean
- **isCollapsed** As Boolean
- **TitleBarHeight** As Int
- **PanelHeight** As **Int**
- **Radius** As Int
- **Elevation** As Int
- **Animated** As Boolean
- **Duration** As Int 'Animation Duration in ms

- **Events**

- **IconClick**(Index As Int)
- **TitleClick**
- **BurgerClick**
- **Collapse**
- **Expand**
- **PanelClick**

- **Functions**

- **Refresh** 'Applies changes like color/size
- **Redraw** 'Complete redraw of view, used when changing icon count
- **Clear** 'Resets the view
- **AddIcon** 'Adds an icon in the right size
- **GetPanel** 'Returns the collapsible panel
- **Expand**
- **Collapse**

\*The B4XView is Label  
  

---

  
  
**Releases**  
  

- **v1.00**// 2024-03-31

- Initial Release

---

  
  
**Screenshots**  
  
![](https://www.b4x.com/android/forum/attachments/152350)![](https://www.b4x.com/android/forum/attachments/152351)  
[MEDIA=youtube]9AKGXvzGbnk[/MEDIA]  

---

  

[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-450x174-png.152294/)](https://www.paypal.com/paypalme/xqtr)