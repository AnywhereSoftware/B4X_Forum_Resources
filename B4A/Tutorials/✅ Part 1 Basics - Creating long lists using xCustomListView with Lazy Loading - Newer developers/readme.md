### ✅ Part 1 Basics - Creating long lists using xCustomListView with Lazy Loading - Newer developers by Peter Simpson
### 05/01/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/114096/)

Hello All  
After thinking about it yesterday and having a quick chat with Erel, I decided that my previous long list examples were not basic enough for newer B4X developers, so I put together a minimal xCLV with LL code example together with comments in the code module. There are no themes, databases or external APIs to worry about in this example, just a simple 'For i = 0 to 999' loop to populate the list. I also decided to add both item click and button click events to help users get to grip with how simple it can be to read and write data back and forth using xCLV. I'm fully aware that you can loop through the views to get the information, but I decided that this way is easier for newer B4X developers to follow.  
  
I'm hoping that both new and lesser experienced users to the B4X suite of RAD tools will read this post and then move onto **>>>** [? **Part 2 Examples**](https://www.b4x.com/android/forum/threads/%F0%9F%92%A1-part-2-examples-creating-long-lists-using-xclv-xcustomlistview-with-lazy-loading-new-developers.113843/) **<<<** which has some more comprehensive examples that they can download, assemble and learn from.  
  
**>>>** [**CLICK HERE**](https://www.dropbox.com/s/i1fa4oc5c61vdjn/xclv%20ll%20basic.zip?dl=0) **<<<** to download the Basics example source code.  
  
[B4i example can be found here](https://www.b4x.com/android/forum/threads/%F0%9F%92%A1-creating-long-lists-using-xcustomlistview-with-lazy-loading.116143/)  
  
**Libraries needed.**  
![](https://www.b4x.com/android/forum/attachments/91540)  
  
**Bare bone example screenshot with click events**  
![](https://www.b4x.com/android/forum/attachments/88836)  
  
**The code in this example**  

```B4X
Sub Process_Globals  
End Sub  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    'These variables can only be accessed from this module.  
  
    Type TestData (LabelNum As Int, LabelText As String) 'Create your own custom type  
  
    Private XUI As XUI  
     
    Private CLVList As CustomListView     'Layout View  
    Private LblNum, LblText As B4XView    'Layout View  
    Private BtnPress As B4XView            'Layout View  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("MainCLV") 'Load the base/main layout file  
    Activity.Title = "Basic xCLV with LL layout" 'Activity title  
  
    BuildListItems 'Build and populate the xCLV (the list)  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
End Sub  
  
'LETS BUILD AND POPULATE THE XCUSTOMLISTVIEW ITEMS  
Sub BuildListItems  
    For i = 0 To 999  
        Dim TD As TestData 'Declare your new custom type (Line 23 above)  
            TD.Initialize 'Initialize your custom type  
            TD.LabelNum = i 'Set the value of i into the LabelNun custom type field  
            TD.LabelText = $"Line ${i} this is a test "$ 'Set the value of this entire line into the LabelText custom type field  
  
        Dim Pnl As B4XView = XUI.CreatePanel(Null) 'Create a new B4X View  
            Pnl.Color = XUI.Color_White 'Set the background color to white  
            Pnl.SetLayoutAnimated(0dip, 0dip, 0dip, CLVList.AsView.Width, 50dip) 'Set the list positiion and dimensions  
  
        CLVList.Add(Pnl, TD)  
    Next  
End Sub  
  
'POPULATE THE XCUSTOMLISTVIEW WITH THE BUILT ITEMS CREATED IN THE SUB ABOVE  
Sub CLVList_VisibleRangeChanged (FirstIndex As Int, LastIndex As Int)  
    Dim ExtraSize As Int = 25 'Add 25 items at a time, this can be changed to suite your requirements  
    For i = Max(0, FirstIndex - ExtraSize) To Min(LastIndex + ExtraSize, CLVList.Size - 1) 'Loop for adding/removing your items layout to or from the list  
        Dim Pnl As B4XView = CLVList.GetPanel(i) 'Declare a new B4XView  
        If i > FirstIndex - ExtraSize And i < LastIndex + ExtraSize Then 'Add a new item to the list  
            If Pnl.NumberOfViews = 0 Then 'Add items to the list  
                Dim TD As TestData = CLVList.GetValue(i) 'Get your custom Type  
                Pnl.LoadLayout("ItemInfo") 'Load your  
                LblNum.Text = TD.LabelNum 'Self-explanatory  
                LblText.Text = TD.LabelText 'Self-explanatory  
            End If  
        Else 'Remove items from the list  
            If Pnl.NumberOfViews > 0 Then  
                Pnl.RemoveAllViews 'Remove none visible item from the main xCLV layout  
            End If  
        End If  
    Next  
End Sub  
  
'A LABEL ON THE LIST HAS BEEN CLICKED  
Sub CLVList_ItemClick (Index As Int, Value As Object)  
    Dim xCLVItem As B4XView = CLVList.GetPanel(Index).GetView(1) '2nd view in the layout index which is LblText  
    Log(xCLVItem.Text) 'Print the label text in the logs  
End Sub  
  
'A BUTTON ON THE LIST HAS BEEN CLICKED  
Sub BtnPress_Click  
    Dim xCLVIndex As Int = CLVList.GetItemFromView(Sender) 'Get the row index by using the sender filter  
    Dim xCLVItem As B4XView = CLVList.GetPanel(xCLVIndex) 'Get the Item layout for the selected Row  
    Dim LblNum As B4XView = xCLVItem.GetView(0) '1st view in the layout index which is LblNum  
    Dim LblText As B4XView = xCLVItem.GetView(1) '2nd view in the layout index which is LblText  
  
    LblNum.TextColor = XUI.Color_Blue 'Change the font color to blue  
    LblNum.Text = Chr(0xF118) 'Put an icon in the label (a smiley)  
    LblText.TextColor = XUI.Color_Red 'Change the font color to red  
    LblText.Text = "It worked" 'Put new text in the label  
End Sub
```

  
  
A special thanks goes out to Erel, Klaus, Manfred and all the developers that makes b4x.com the place to be when it comes to RAD tools, that means everybody ???  
  
  
**Enjoy…**