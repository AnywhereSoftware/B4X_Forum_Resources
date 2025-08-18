### RTFeditor Version 2021 by Guenter Becker
### 04/28/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/129581/)

Due to the much reactions I got for Version 1 and to respect the proposals and comments of the community I desired to overhaul and redesign the custom view. Thank you for all replies.  
Again **this [SIZE=6]custom view is a small rich text word processor[/SIZE]** to be used as a view/control in your project  
  
![](https://www.b4x.com/android/forum/attachments/112416)  
  
**Version: 3 ( 2021/04/27)**  
- fixed scroll up/down  
- changed manual  
- redesign toolbar, horizontal scrolling  
- editor auto. scroll top/bottom added  
- added new custom properties  
- added new format buttons  
  
Tested on Huawei p20pro, Android 8.  
  
**Format overview *(New)*:**  

- Bold, Italic, Strikethrough, Underline
- Superscript, Subscript
- 6 Predefined Header Text size
- Align left, center, right
- Set Text(part) color with Color Dialog
- Set Text(part) Background color (highlight) with Color Dialog
- Build ordered (numbers), unordered (bulletts) List
- indent, outdent, ***blockquote***
- Insert checkbox
- Insert Image (from Device) for example from Gallery by dialog.
- ***u**n**do/redo last format***
- ***editor text zoom in/out***

**Code function overview:**  

- Use *RTFEditor* view in the Designer.
- Predefine Height of scrollable Editor Area (activate vertical scroll).
- ***Editor auto scroll to top and bottom position .***
- Enable/Disable Editor (enabled=false to use it as viewer)
- Show/Hide Toolbar
- ***Horizonal scrolling toolbar if view width is to small.***
- ***Format buttons spreaded over 5 Sub-Toolbars with list like scrolling.***
- Insert formatted/unformatted Text (HTML) as default value.
- Get formatted (HTML) text from Editor for example to store it into a database
- Set formatted (HTML) text into the Editor for example retriven from database.
- ***Get raw text from editor without format codes.***
- ***Big collection of custom properties*** to set or get the value. See description in the Manual.
- ***Collection of custom properties in the designer.***

**[SIZE=6]To get information about installation and usage for developer and user please look into the Manual. Please download it from this location [Google Drive, RTFeditorManualV3.zip](https://drive.google.com/file/d/1VwhhdumyjVljLKpqx8x__7PIgFLwUCLw/view?usp=sharing).[/SIZE]**  
  
To have a look into the code please use the demo project it includes RTFeditor as a class.  
  
**Updates** are published by editing this post. If you use it I recommend to bookmark this post in your profile.  
  
**[SIZE=6]Please respect that since Version 2 of this view it is not free for commercial use! Find further copyright information in the manual.[/SIZE]**