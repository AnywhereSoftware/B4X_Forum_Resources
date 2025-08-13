###  [XUI] XQ TitleBar by fat32
### 03/28/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/160159/)

A simple view, that is used as a Title/Action Bar, with icons and adjustable title.  
  
**Features:**  

- Up to 5 icons on the right side
- Left/Burger icon (visible or not)
- Change background and text color
- Each element (burger, title, icons) has each own click event
- Title label adjusts its width, depending the icons visible
- Can adjust icon spacing/padding
- All default sizes are compatible with the Material Design

  

---

  
  
**View:** xq\_titlebar  
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

- **Events**

- **IconClick**(Index As Int)
- **TitleClick**
- **BurgerClick**

- **Functions**

- **Refresh** 'Applies changes like color/size
- **Redraw** 'Complete redraw of view, used when changing icon count
- **Clear** 'Resets the view
- **AddIcon** 'Adds an icon in the right size

\*The B4XView is Label  

---

  
  
**Releases**  

- **v1.00**// 2024-03-28

- Initial Release

---

  
  
**Screenshots**  
  
![](https://www.b4x.com/android/forum/attachments/152288)![](https://www.b4x.com/android/forum/attachments/152289)![](https://www.b4x.com/android/forum/attachments/152290)  
  

---

  
  

[![](https://www.b4x.com/android/forum/attachments/152294)](https://www.paypal.com/paypalme/xqtr)