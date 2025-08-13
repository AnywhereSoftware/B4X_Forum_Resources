###  Create List Item (with checkbox, imageview and 2 labels) by aeric
### 11/20/2024
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/164218/)

Extract the zip files into B4X additional folder. It contains Snippets and Views folders.  
Make sure XUI Views library is selected. chkItem is a Switch in B4i.  
  
Tutorial: <https://www.b4x.com/android/forum/threads/b4x-code-snippets.152450/>  
  
First, add the layout file.   
Right click the Files Manager and Add Files (browse to Views folder) then choose the platform specific layout.  
 ![](https://www.b4x.com/android/forum/attachments/158795)  
  
Type Code and use arrow key to select the snippet.  
Press Enter to confirm.  
![](https://www.b4x.com/android/forum/attachments/158793)  
Output code:  

```B4X
Private Sub CreateListItem (FirstLine As String, SecondLine As String, Width As Int, Height As Int) As B4XView  
    Dim p As B4XView = xui.CreatePanel("")  
    p.LoadLayout("ListItem")  
    p.SetLayoutAnimated(0, 0, 0, Width, Height)  
    imgItem.Bitmap = xui.LoadBitmapResize(File.DirAssets, "icon.png", 40dip, 40dip, True)  
    lblFirstLine.Text = FirstLine  
    lblSecondLine.Text = SecondLine  
    Return p  
End Sub
```

  
*Note: icon.png is not attached.*  
  
Usage:  

```B4X
CustomListView1.Add(CreateListItem("First Line", "Second Line", CustomListView1.AsView.Width, 120dip), 1)
```