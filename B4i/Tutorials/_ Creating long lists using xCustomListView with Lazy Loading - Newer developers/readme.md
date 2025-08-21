### ? Creating long lists using xCustomListView with Lazy Loading - Newer developers by Peter Simpson
### 05/01/2020
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/116143/)

Hello All  
This simple B4i tutorial code wise is a carbon copy of the B4A example code, I copied and pasted the layout files but for iOS I had to change the button font and background colors. This example uses a simple 'For i = 0 to 999' loop to populate the list. I also decided to add both item click and button click events to help users get to grip with how simple it can be to read and write data back and forth using xCLV. I'm fully aware that you can loop through the views to get the information, but I decided that this way is easier for newer B4X developers to follow.  
  
[B4A example can be found here](https://www.b4x.com/android/forum/threads/%F0%9F%92%A1-part-1-basics-creating-long-lists-using-xcustomlistview-with-lazy-loading-newer-developers.114096/)  
  
**Libraries needed.**  
![](https://www.b4x.com/android/forum/attachments/91541)  
  
**Bare bone example screenshot with click events**  
![](https://www.b4x.com/android/forum/attachments/91538)  
  
**The code in this example**  

```B4X
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
    Public App As Application  
    Public NavControl As NavigationController  
    Private Page1 As Page  
  
    Type TestData (LabelNum As Int, LabelText As String) 'Create your own custom type  
   
    Private XUI As XUI  
       
    Private CLVList As CustomListView     'Layout View  
    Private LblNum, LblText As B4XView    'Layout View  
    Private BtnPress As B4XView            'Layout View  
End Sub  
  
Private Sub Application_Start (Nav As NavigationController)  
    'SetDebugAutoFlushLogs(True) 'Uncomment if program crashes before all logs are printed.  
    NavControl = Nav  
    Page1.Initialize("Page1")   
    Page1.RootPanel.LoadLayout("MainCLV") 'Load the base/main layout file  
    Page1.Title = "Basic xCLV with LL layout" 'Page title  
    Page1.RootPanel.Color = Colors.White  
    NavControl.ShowPage(Page1)  
  
    BuildListItems 'Build and populate the xCLV (the list)  
End Sub  
  
Private Sub Page1_Resize(Width As Int, Height As Int)  
End Sub  
  
Private Sub Application_Background  
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