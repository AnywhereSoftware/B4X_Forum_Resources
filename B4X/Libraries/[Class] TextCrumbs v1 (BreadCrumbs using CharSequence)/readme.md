###  [Class] TextCrumbs v1 (BreadCrumbs using CharSequence) by epiCode
### 01/27/2023
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/145741/)

This class helps you create a simple Clickable Text Based Bread Crumbs Feature which supports CharSequence too.  
  
Usage is very simple.  
Create a list which has individual items to be shown as bread crumbs. This can be text / charSequence or mix of both.  
Initialize TextCrumbs and pass this list and a label where the crumbs are to be displayed.  
Everytime you change the list, call refresh method.  
  
Note: By default the label will be horizontally scrollable but somehow charsequence spans do not allow for dragging, so only way a person can scroll it is using separators. To make it easier for user, place your label in a HorizontalScrollView or any other way you like. Source Code is attached.  
   
  
  
[SPOILER="Description"]  
**TextCrumbs  
  
Author:** epiCode  
**Version:** 1  

- **TextCrumbs**

- **Events:**

- **\_Clicked** (Position As Int)

- **Fields:**

- **ClickColor** As Int
- **underline** As Boolean

- **Functions:**

- **Initialize** (Callback As Object, EventName As String, mList As List, mlabel As B4XView, separator As Object)
*mList: the list holding bread crumbs  
 mLabel: Label to show the bread crumbs in  
 Separator: any char /symbol to use as separator like ">" (charsequence accepted)*- **Refresh**
*Refresh after changes to list*
- **Properties:**

- **Width** As Int [read only]

[/SPOILER]  
  
![](https://www.b4x.com/android/forum/attachments/138572)