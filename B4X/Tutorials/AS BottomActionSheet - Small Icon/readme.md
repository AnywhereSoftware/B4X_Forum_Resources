###  AS BottomActionSheet - Small Icon by Alexander Stolte
### 11/04/2024
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/163932/)

<https://www.b4x.com/android/forum/threads/b4x-xui-as-bottomactionsheet.159328/>  
  
In this example I will show you how you can add a small icon to an item and customize it to your needs.  
  
A small icon is an icon that can be placed before or after the text, e.g. it symbolizes that this item is only available in the premium version.  
  
![](https://www.b4x.com/android/forum/attachments/158300)  
  
**Add Item with a small icon**  
You can use the new [ICODE]AddItem2[/ICODE] function to add an item with a small icon.  

```B4X
BottomActionSheet.AddItem2("Item #4",Null,BottomActionSheet.FontToBitmap(Chr(0xE897),True,25dip,xui.Color_White),4)
```

  
  
**Customize**  
You can specify the position, size and a gap of the small icon.  
You can only customize it before the item is added.  

```B4X
    BottomActionSheet.ItemSmallIconProperties.HorizontalAlignment = BottomActionSheet.HorizontalAlignment_AfterText  
    BottomActionSheet.ItemSmallIconProperties.VerticalAlignment = BottomActionSheet.VerticalAlignment_Top  
    BottomActionSheet.ItemSmallIconProperties.LeftGap = 5dip  
    BottomActionSheet.ItemSmallIconProperties.WidthHeight = 15dip
```