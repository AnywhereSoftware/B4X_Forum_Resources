### TreeTableView Helper Class by Mashiane
### 09/24/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/153212/)

Hi  
  
Thanks to [USER=9800]@stevel05[/USER] , Ive managed to implement this class..  
  
![](https://www.b4x.com/android/forum/attachments/146286)  
  
Put a TreeTableView in a form..  
  

```B4X
Private tv As SithasoB4JTreeTableView
```

  
  
Initialize and define the context menu  
  

```B4X
tv.Initialize(Me, Root, SDTreeTable, "tv")  
    tv.Editable = True  
    tv.TableMenuButtonVisible = True  
    tv.AddMenuItem("Add", Chr(0xF067))  
    tv.AddMenuItem("Edit", Chr(0xF040))  
    tv.AddMenuItem("Delete", Chr(0xF014))  
    tv.AddMenuItem("Up", Chr(0xF062))  
    tv.AddMenuItem("Down", Chr(0xF063))  
    tv.AddMenuItem("Left", Chr(0xF060))  
    tv.AddMenuItem("Right", Chr(0xF061))  
    tv.RefreshMenu
```

  
  
The add some parent children..  
  

```B4X
'Details, Add, Edit, Delete, Up, Down  
    tv.AddItem("", "prj1", "Anele Mbanga (Mashy)", Array("A","B","C","D","E"))  
    tv.AddItem("prj1", "page1", "Page 1", Array("A","B","C","D","E"))  
    tv.AddItem("prj1", "page2", "Page 2", Array("A","B","C","D","E"))  
    tv.AddItem("prj1", "page3", "Page 3", Array("A","B","C","D","E"))  
    tv.AddItem("page1", "page4", "Page 4", Array("A","B","C","D","E"))  
    tv.AddItem("page1", "page5", "Page 5", Array("A","B","C","D","E"))  
    tv.AddItem("page1", "page6", "Page 6", Array("A","B","C","D","E"))  
    tv.AddItem("page6", "page7", "Page 7", Array("A","B","C","D","E"))  
    tv.AddItem("page4", "page8", "Page 8", Array("A","B","C","D","E"))  
    'search
```

  
  
Perform some functions via code  
  

```B4X
Dim f As TreeTableItem = tv.SearchItemByID("page6")  
    Log(f)  
    tv.ExpandItemByID("prj1")  
    tv.ExpandItemByID("page1")  
    tv.ExpandItemByID("page6")  
    tv.selectItemByID("page7")  
    Log(tv.getIndexOfItemByID("page5"))  
    Log(tv.getLevelOfItemByID("page7"))  
    Log(tv.getItemIDByName("Page 3"))  
    tv.DeleteItemByID("page8")
```

  
  
Perform some functions via the context menu..  
  

```B4X
Private Sub tv_MenuClick(menuID As String)  
    Select Case menuID  
    Case "Add"  
    Case "Edit"  
    Case "Delete"  
        tv.DeleteItem(tv.SelectedItem)  
    Case "Up"  
        tv.MoveItemUp(tv.SelectedItem)  
    Case "Down"  
        tv.MoveItemDown(tv.SelectedItem)  
    Case "Left"  
        tv.MoveItemLeft(tv.SelectedItem)  
    Case "Right"          
        tv.MoveItemRight(tv.SelectedItem)  
    End Select  
End Sub
```

  
  
Trap Events fired by some processes  
  

```B4X
'fire when a node is deleted  
Sub tv_deleted(node As TreeNode)  
    Log("tv_deleted")  
    Log(node)  
End Sub  
  
Sub tv_movedleft(node As TreeNode)  
    Log("tv_movedleft")  
    Log(node)  
End Sub  
  
Sub tv_movedup(node As TreeNode)  
    Log("tv_movedup")  
    Log(node)  
End Sub  
  
Sub tv_moveddown(node As TreeNode)  
    Log("tv_moveddown")  
    Log(node)  
End Sub  
  
  
Sub tv_movedright(node As TreeNode)  
    Log("tv_movedright")  
    Log(node)  
End Sub
```

  
  
Enjoy!