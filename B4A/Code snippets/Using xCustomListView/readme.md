### Using xCustomListView by Cadenzo
### 02/09/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/163859/)

This is a part of [my Code Snippets collection](https://www.b4x.com/android/forum/threads/create-and-navigate-to-b4xpage.163854/), needed in many projects. There are many cases, where [xCustomListView](https://www.b4x.com/android/forum/threads/b4x-xui-xcustomlistview-cross-platform-customlistview.84501/#content) is the best way to show a list of data.  
  
The data I like to load into a list of a self defined type as first step from a file, a database or a server/cloud. Only from there as second step data will be shown in the CustomListView. Here the user can see, edit, delete or add data and in the end, the new data will be saved to file/database or uploaded to server/cloud. See also [Using SQLite](https://www.b4x.com/android/forum/threads/using-sqlite.163877/).  
  

```B4X
Sub Class_Globals  
    Type PersonType(ID As Int, Name As String, age as Short)  
End Sub  
  
'This example returns a persons list from database with an age filter  
Private Sub GetPersons() As List  
    Dim rs As ResultSet  
    rs = SQL1.ExecQuery("SELECT * FROM Person WHERE [age] BETWEEN 18 AND 35")  
   
    Dim li As List : li.Initialize  
    Do While rs.NextRow  
        li.Add(CreatePersonType(rs.GetInt("ID"), rs.GetString("Name"), rs.GetInt("age")))  
    Loop  
    rs.Close  
    Return li  
End Sub  
  
'you can create this Sub moving the mouse cursor over Type definition  
Private Sub CreatePersonType(ID As Int, Name As String, age as Short)  
    Dim t As PersonType : t.Initialize  
    t.ID = ID  
    t.Name = Name  
    t.age = age  
    return t  
End Sub
```

  
  

```B4X
Private Sub ShowPersons()  
    dim li as List = GetPersons()  
    clvPersons.Clear  
    dim iWidth as int = clvPersons.AsView.Width, iHeight as int = 60dip 'look in the created layout for .Top and .Height values of the views, to calculate the Item-Height that is needed!  
    For Each t As PersonType In li  
       clvPersons.Add(CreatePersonItem(t, iWidth, iHeight), t)  
    Next  
End Sub  
  
Private Sub CreatePersonItem(t as PersonType, width As Int, height As Int) As B4XView  
    Dim p As B4XView = xui.CreatePanel("")  
    p.SetLayoutAnimated(0, 0, 0, width, height)  
    p.LoadLayout("viewItmPerson") 'Create a layout "viewItmPerson" in designer with Labels "lblItmName" and "lblItmAge"  
    lblItmName.Text = t.name  
    lblItmAge.Text = t.age  
    Return p  
End Sub  
  
Private Sub clvPersons_ItemClick (Index As Int, Value As Object) 'handle an item click event  
     dim t as PersonType = Value  
     'do something with the user choice …  
End Sub  
  
Private Sub lblRemove_Click 'handle click events, if you have views (as labels or buttons) on an item  
    Dim iIndex As Int = clvPersons.GetItemFromView(Sender)  
    Dim t As PersonType = clvPersons.GetValue(iIndex)  
     'do something with the user choice …  
End Sub
```

  
  
If there are hundreds or thousands of items, [Lazy Loading](https://www.b4x.com/android/forum/threads/part-1-basics-creating-long-lists-using-xcustomlistview-with-lazy-loading-newer-developers.114096/#post-712656) is a better way. We create empty items and only the area on the display is loaded.  

```B4X
Sub BuildListItems(li As List)  
    Dim iWidth As Int = clvPersons.AsView.Width, iHeight As Int = 60dip  
    clvPersons.Clear  
    For Each t As PersonType In li  
  
     Dim Pnl As B4XView = xui.CreatePanel(Null) 'Create a new B4X View  
     Pnl.Color = xui.Color_White 'Set the background color to white  
     Pnl.SetLayoutAnimated(0dip, 0dip, 0dip, iWidth, iHeight) 'Set the list position and dimensions  
       
     clvPersons.Add(Pnl, t)  
  
    Next  
End Sub  
  
  
'POPULATE THE XCUSTOMLISTVIEW WITH THE BUILT ITEMS CREATED IN THE SUB ABOVE  
Sub clvPersons_VisibleRangeChanged (FirstIndex As Int, LastIndex As Int) 'LL, Lazy Loading  
    If FirstIndex > 0 And FirstIndex = LastIndex Then Return  
    Dim ExtraSize As Int = 25 'Add 25 items at a time, this can be changed to suite your requirements  
    For i = Max(0, FirstIndex - ExtraSize) To Min(LastIndex + ExtraSize, clvItems.Size - 1) 'Loop for adding/removing your items layout to or from the list  
        Dim Pnl As B4XView = clvPersons.GetPanel(i) 'Declare a new B4XView  
        If i > FirstIndex - ExtraSize And i < LastIndex + ExtraSize Then 'Add a new item to the list  
            If Pnl.NumberOfViews = 0 Then 'Add items to the list  
                Dim t As PersonType  = clvPersons.GetValue(i) 'Get your custom Type  
            End If  
        Else 'Remove items from the list  
            If Pnl.NumberOfViews > 0 Then  
                Pnl.RemoveAllViews 'Remove none visible item from the main xCLV layout  
            End If  
        End If  
    Next  
End Sub
```