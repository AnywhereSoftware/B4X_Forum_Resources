###  [XUI] XQ BreadCrumbs by fat32
### 04/05/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/160336/)

A simple breadcrumb view, using a horizontal xcustomlistview.  
  
**Features:**  

- Scrollable, also by code (ScrollToEnd, ScrollToStart)
- The number of items, can be as many a xCustomListView can hold ;)
- It has a root and separator FontAwesome/MaterialFont character for style
- Easy to set background/pressed color, no need to customize the internal Listview
- Elevation/Shadow is also easy to set from properties
- Can set the component to remove (or not) the items, right of the one you clicked, so you can also use this component as a horizontal menu.
- Except from text items, you can also add other views (if you want to)
- Two ways to add TextItems, with either adjustable size of fixed.
- TextItems support CSBuilder strings
- Click and LongClick events
- Can get Index value of each item. The separator characters don't return an index or value
- Can add a Tag value/object to each item.
- You can enable the clicked item to change its style from normal to bold, or not.

  

---

  
  
**View:** xq\_breadcrumbs  
**Author:** xqtr  
**Version:** 1.00  
**Depends:** XUI, xCustomListView  
  

- **Fields**

- **Background** As Int 'Color
- **Pressed** As Int 'Color
- **Textcolor** As Int 'Color
- **Padding** As Int 'Left/Right gap between items
- **Elevation** As Int
- **Active** As Boolean 'Clicked item will be in bold
- **RemoveItem** As Boolean 'Remove items from right side of clicked item.
- **ActiveItemIndex** As Int 'Read only, return the selected/clicked item index
- **clv** As xCustomListView
- **RootChar** As Char
- **Seperator** As Char

- **Events**

- **ItemClick**(Index As Int, Value As Object)
- **LongItemClick**(Index As Int, Value As Object)

- **Functions**

- **ScrollToStart**
- **ScrollToEnd**
- **Clear**
- **AddTextItem**(txt As Object, iTag As Object)
- **AddItem**(v As B4XView, iTag As Object)
- **AddTextItemWidth**(txt As Object, iTag As Object, Width As Int)
- **RemoveItemsFromIndex**(index As Int)
- **GetValueAt**(Index As Int) As Object

  

---

  
  
**Releases**  

- **v1.00**// 2024-04-05

- Initial Release

---

  
  
**Screenshots**  
  
![](https://www.b4x.com/android/forum/attachments/152484)![](https://www.b4x.com/android/forum/attachments/152485)![](https://www.b4x.com/android/forum/attachments/152486)  
[media=youtube]hEOCsysQSIw[/media]  
  

---

  

[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-450x174-png.152294/)](https://www.paypal.com/paypalme/xqtr)