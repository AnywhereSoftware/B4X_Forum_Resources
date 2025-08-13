### Font Resizer: Responsive label and Popup Menu or xCustomListView Menu called from ACToolBar icon by GeoT
### 03/11/2023
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/146717/)

Examples to change the font size of a text inside a label, adapting it and the ScrollView.  
With my correction to StringUtils.MeasureMultilineTextHeight(…) because it didn't quite calculate correctly.  
Rotating the device maintains the values and measurements.  
   
It gets the value of the primary color declared in the Manifest Editor to color the system StatusBar afterwards.  
  
![](https://www.b4x.com/android/forum/attachments/140153)  
  
TextSize example. Popup Menu version.  

- Clicking on the PopUp Menu item closes it
- The Popup Menu hangs from a Label on the ACToolBar indicating the current font size
- It could also hang from a hidden view created with the Designer

  
![](https://www.b4x.com/android/forum/attachments/140154)  
  
TextSize\_xCustomListView. xCustomListView version.  

- xCustomListView with elevation
- When clicking on the xCustomListView Menu item, it is not hidden
- It is hidden when clicking on the transparent panel that captures the event in the rest of the Activity or on the icon of the ACToolBar that called it

  
   
Dependencies: AppCompat, JavaObject, Phone, StringUtils, (xCustomListView), XmlLayoutBuilder, XUI. Optional: Drawer B4X  
   
I accept corrections and suggestions.  
  
Regards.