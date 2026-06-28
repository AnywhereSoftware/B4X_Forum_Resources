###  B4XDaisyPageScroll - Automate Your ScrollView Heights & Layout Boilerplate! by Mashiane
### 06/24/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/171373/)

Hello Fam!  
  
If you are tired of manually calculating the total height of your ScrollViews every time you add a new view or rotate the screen, I want to share a solution: **B4XDaisyPageScroll**.  
B4XDaisyPageScroll is a reusable custom view that acts as a page container. It encapsulates a standard ScrollView and a transparent host panel to completely centralize all the layout boilerplate code you normally write.  
  
**Key Features:**  

- **AutoFit Magic:** Automatically calculates content boundaries based on the components you add, and dynamically updates the scroll height.
- **Built-in Properties:** Easily set standard spacing with PagePadding and YGap directly from the designer or in code.
- **Helper Methods:** Includes built-in methods like AddSectionTitle and AddDivider to quickly generate standard UI elements while automatically tracking the Y-coordinate for your next view.
- **Easy Resizing:** Automatically handles layout stretching. Just pass the new Width and Height to Base\_Resize() during the B4XPage\_Resize event.

  
![](https://www.b4x.com/android/forum/attachments/172022) ![](https://www.b4x.com/android/forum/attachments/172021) ![](https://www.b4x.com/android/forum/attachments/172023)  
  
**Layout Example: The "Nav Scroll Dock"** The component makes complex responsive layouts a breeze. For example, you can create a layout with three zones:  

1. A Navbar pinned to the top (added to Root).
2. A Dock pinned to the bottom (added at Root.Height - DOCK\_H).
3. The B4XDaisyPageScroll component layered directly between them.

Because the ScrollView calculates its own height, all you do is inset the scroll container by the navbar height and dock height, giving you a perfect scrollable middle zone that respects screen rotation.  
  
  
[MEDIA=youtube]ravKWwmwSbI[/MEDIA]  
  
  
Let me know what you think or if you have any questions!