###  [class] xWheel by mberthe
### 04/19/2020
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/107830/)

Xwheel is a "rotating wheel" based on xCustomListView.  
  
I tested this class in B4A, but not currently having a MAC, could you tell me if it is compatible with B4i ?  
  
**xWheel**  
Author: [USER=17859]@mberthe[/USER]  
Version: 1.2  
  
**Dependancies :**  
  
 B4A : XUI,JavaObjet,StringUtils,xCustomLisView,BipmapCreator  
  
  
**Usage:**  

1. Load in the designer the layout xWheelTemplate with the xCustomLIistView : CLV1
2. In the designer create a instance of the custom view : xWheel1 (layout 1) and set the custom properties :

- ItemHeight : set the items height (default value : 25dip)
- NbItem : set the number of visible items : (default value : 7)
- TextSize : set the item text size (default value : 14)
- TextColor : set the item text color (default value : Black)
- BorderWidth : set the border width (default value : 5dip)
- BorderColor : set the border color (default value : LightGray )

3. Initialtize the list of items : list1 (elements text & val)
4. draw the xwheel

```B4X
xWheel1.initwheel[(list1)
```

**Properties:**
[INDENT] ItemIndex : set the preselected item (default value : 1)[/INDENT]
**Methode :**
[INDENT] xwheel1.UpdateItems(nlist as List) : change the items list[/INDENT]
**Events:**
[INDENT] xwheel1\_scroll(index As Int,value As String) :[/INDENT]
[INDENT] get the index(base 1) and the value of the selected item[/INDENT]
**Update:**
[INDENT]version 1.1 : fixed issues of cross platform compatibility
version 1.2 : creation of the cusom view "xwheel"[/INDENT]