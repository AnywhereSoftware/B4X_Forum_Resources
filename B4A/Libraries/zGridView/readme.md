### zGridView by KZero
### 04/12/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/116225/)

Just another Grid view  
  
main features  
- Support custom layouts  
- Can handle any number of items  
- Support Right to left  
- Adjustable items count per row  
- Divider size  
  
  
![](https://www.b4x.com/android/forum/attachments/91630)  
  
  
  
**zGridView  
Author:** Karim Ezzat  
**Version:** 0.1  

- **zGridview**
Events:

- **ItemClick** (Index As Int, Value As Object)
- **ItemLongClick** (Index As Int, Value As Object)
- **PanelRequested** (Index As Int)

**Fields:**

- **\_rowcount As int**
- **\_offscreenrows As int**
- **\_divider As int**
- **\_righttoleft As boolean**
- **\_itemsize As int**

**Methods:**

- **IsInitialized As boolean**
*Tests whether the object has been initialized.*- **\_asview As anywheresoftware.b4a.objects.ConcreteViewWrapper**
*Returns a view object that holds the list.*- **\_class\_globals As String**
- **\_clear As String**
*Clear the list*- **\_designercreateview** (base As anywheresoftware.b4a.objects.PanelWrapper, lbl As anywheresoftware.b4a.objects.LabelWrapper, props As anywheresoftware.b4a.objects.collections.Map) **As String**
- **\_getloadedpanel** (Index As int) **As anywheresoftware.b4a.objects.PanelWrapper**
*Get Panel by index , returns null if panel not loaded*- **\_getvalue** (Index As int) **As Object**
- **\_hidescrollbar** (Hide As boolean) **As String**
*Show or hide scrollbar*- **\_initialize** (ba As anywheresoftware.b4a.BA, vCallback As Object, vEventName As String) **As String**
- **\_ispanelloaded** (Index As int) **As boolean**
- **\_loadpanel** (Pnl As anywheresoftware.b4a.objects.PanelWrapper, Index As int) **As String**
*Load panel into visible item.*- **\_newitem** (Value As Object) **As String**
*Add empty item then load panel into it.*- **\_refreshlist As String**
- **\_reload As void**
- **\_removeat** (Index As int) **As String**
- **\_setscrollbarcolor** (Color As int) **As String**
- **\_setvalue** (Index As int, Value As Object) **As String**
- **\_size As int**
*Get List items count*