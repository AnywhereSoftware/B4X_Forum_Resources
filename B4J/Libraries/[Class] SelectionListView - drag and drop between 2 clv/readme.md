### [Class] SelectionListView - drag and drop between 2 clv by zed
### 12/18/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/169784/)

This class allows you to manage two lists (available and selected) with a display based on CustomListView and advanced features such as multiple selection and drag and drop of elements.  
  
**Internal Structure  
  
Main Variables:**  
[INDENT][/INDENT]  
[INDENT]AviableList and SelectedList: *the source lists.*[/INDENT]  
[INDENT][/INDENT]  
[INDENT]clvAvailable and clvSelected: t*he two CustomListViews displaying the items.*[/INDENT]  
[INDENT][/INDENT]  
[INDENT]Aviable\_SelectedValue and Selected\_SelectedValue: *the currently selected values.*[/INDENT]  
[INDENT][/INDENT]  
[INDENT]CSelections\_a and CSelections\_s: *selection handlers (CLVSelections class).*[/INDENT]  
[INDENT][/INDENT]  
[INDENT]Drag & Drop Management: *DragGhost, DragValue, DragSource, etc.*[/INDENT]  
[INDENT][/INDENT]  
**Initialization :**  
  
[INDENT]Initialize(Callback As Object, EventName As String) : *Standard signature for a B4X class.*[/INDENT]  
[INDENT][/INDENT]  
[INDENT]Setup(Container As B4XView, RootPane As B4XView) : *class configuration with container and window root.*[/INDENT]  
  
**Main features**   
  
**List management:**  
  
[INDENT]SetAvailableList(lst As List): *loads a list into the "available" section.*[/INDENT]  
[INDENT][/INDENT]  
[INDENT]MoveItem(…): *moves an item from one list to another.*[/INDENT]  
  
**Multiple selection:**  
  
[INDENT]ToggleSelection(values As List, selections As CLVSelections, index As Int, value As String): *adds or removes an element from the selection.*[/INDENT]  
  
**Drag and drop:**  
  
[INDENT]dragitem\_MousePressed, dragitem\_MouseDragged, dragitem\_MouseReleased: *manage the creation of a visual "ghost" and the movement of items between lists.*[/INDENT]  
  
**Action buttons:**  
  
[INDENT]btn\_AviableToSelected\_Click and btn\_SelectedToAviable\_Click: transfer the selected items from one list to the other.[/INDENT]  
[INDENT][/INDENT]  
[INDENT]btAccept\_MouseClicked: returns the final list of selected items to the main page via CallSubDelayed2.[/INDENT]  
[INDENT][/INDENT]  
**Example of use:**  
  
[INDENT]In your main code, you initialize and configure the class as follows:[/INDENT]  
[INDENT][/INDENT]  

```B4X
slv.Initialize(Me, "NewList")  
slv.Setup(Pane1, B4XPages.MainPage.Root)  
slv.SetAvailableList(AviableList)  
…  
  
Sub NewList(mList As List)  
    Log("List received : " & mList)  
End Sub
```

  
  
![](https://www.b4x.com/android/forum/attachments/168937)  
  
[INDENT=2][/INDENT]