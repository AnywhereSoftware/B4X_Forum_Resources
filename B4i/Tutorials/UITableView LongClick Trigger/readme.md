### UITableView LongClick Trigger by ilan
### 05/04/2020
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/117315/)

UITableView is a very powerful Listview. It loads items very fast and scrolling is very smooth. thanx to b4i it is also very customizable.  
  
B4i support 5 Events for the UITableView:  
  

```B4X
Sub tv_AccessoryButtonClicked (SectionIndex As Int, Cell As TableCell)  
   
End Sub  
  
Sub tv_ActionButtonClicked (SectionIndex As Int, Cell As TableCell, Text As String)  
   
End Sub  
  
Sub tv_Click  
   
End Sub  
  
Sub tv_LongClick  
   
End Sub  
  
Sub tv_SelectedChanged (SectionIndex As Int, Cell As TableCell)  
   
End Sub
```

  
  
As you can see the AccessoryButtonClicked, ActionButtonClicked, and SelectedChanged will return the SectionIndex and the Cell. This is very important for us to be able to know which row was pressed.  
  
The Click and LongClick event does not return anything. So the use of them is very limited. As I needed to trigger a LongClick like Apple does it in a lot of their Apps (Files, Email, …) i looked for a way to do that. B4i does give me an opportunity to do that by adding a CustomView.  
  

```B4X
tc.CustomView
```

  
  
using this feature will allow me to add a Panel with any views I like and almost use my TableView as the so familiar View we all know and love the CustomListView.  
  
So now I can trigger a LongPress and know where I have pressed. What we were looking for right? Well, almost.  
if I use the Tableview without a Customview and add 1000 items it takes me 297ms (tested on a real iPhone 11).  
This is super fast and you don't even notice that. BUT using a customview with 1000 items will take 8158 ms (tested on a real iPhone 11) :oops:  
  
So 8 seconds vs 0.3 seconds is a huge difference, right?  
So how can we get the LongClick Event and know what row was pressed but still have a good performance?  
  
After some research in the net and lot of tries, I found a way.  
  
Add the items as usual BUT use in the customview ONLY an empty transparent panel. This will allow you to trigger the LongClick and performance is awesome.  
  

```B4X
    Dim starttime As Long = DateTime.Now  
   
    itemList.Clear  
    For i = 0 To 1000  
        itemList.Add("Item " & i & "|this is the second line of item " & i)  
    Next  
   
    For i = 0 To itemList.Size - 1  
        Dim str() As String = Regex.Split("\|", itemList.Get(i))  
       
        Dim actString1, actString2 As AttributedString  
        actString1.Initialize(str(0),Font.CreateNew(16),Colors.Black)  
        actString2.Initialize(str(1),Font.CreateNew(10),Colors.ARGB(150,0,0,0))  
       
        Dim tc As TableCell = mainTableView.AddTwoLines("","")  
        tc.AccessoryType = tc.ACCESSORY_INDICATOR  
        tc.Text = actString1  
        tc.DetailText = actString2  
        tc.Tag = i  
        tc.ShowSelection = False  
        tc.Bitmap = LoadBitmap(File.DirAssets,"Folder-icon.png")  
        tc.AddActionButton("Delete",Colors.Red)  
        tc.CustomView = CreateItem(i,maintableviewpnl.Width,mainTableView.RowHeight)  
    Next  
  
    mainTableView.ReloadAll  
    Msgbox((DateTime.Now - starttime) & " ms","Time")  
  
….  
  
Private Sub CreateItem(index As Int, width As Float, height As Float) As Panel  
    Dim p As Panel  
    p.Initialize("inlinePnlRow")  
    p.Width = width  
    p.Height = height  
    p.Color = Colors.Transparent  
    p.Tag = index  
     
    Return p  
End Sub
```

  
  
In Debug Mode it took 427ms (vs 297 ms without customview and 8158 ms using only a cutomview with 1 imageview and 3 labels in it)  
  
and in release mode it took 86 ms !!:  
  
![](https://www.b4x.com/android/forum/attachments/93277)  
  
So if someone needs a Solution on how to get a LongClick on a Tableview but still keep the good performance this is the best solution i found.  
  
Regards, ilan  
  
BTW the ActionButton option work as usual with this solution.