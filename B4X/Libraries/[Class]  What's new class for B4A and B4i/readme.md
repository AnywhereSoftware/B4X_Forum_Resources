### [Class]  What's new class for B4A and B4i by hatzisn
### 02/24/2020
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/108677/)

Hi everyone,  
  
this is a what's new class for B4A and B4i (b4xlib) that you can use to display information for new views or functions (related to views obviously) of your application.  
  
***(24/2/2020)***  
*I have added the new sub SetViewToExplainTextDimensions to the lib that sets new borders for the view to explain explanation text if needed. This is more useful for the B4i use of this b4xlib. Check the b4i example code for the use of the new sub.*  
  
***(2/1/2020)***  
*I have corrected a bug in the What's New lib which if for example there were initially two visible buttons and one button not visible and you added to the explaining sequence only the two visible, when the sequence was over it was showing all the buttons setting visible to True. Now it maintains the original visible state of each button (all the buttons are hidden and re-shown again - according to the initial state - because if they are not hidden they cover the corresponding drawing area of the b4x canvas during the explaining sequence).*  
  
***(23/8/2019)***  
*I have added the function CheckToShowWhatsNew which accepts the name of the Activity or page name (string) the version of the what's new we want to show (int) and an SQL. The function will check if the database has a table named "WhatsNew" and if there is not it will create it and insert the values of the name and the version and return True. If there is the table it will check if the name is in the inserted names and if it is not it will insert it as well as the version and return True. If the name there is in the table it will check the version and if the version we have sent is higher then the one in database it will update to the new version and return true else it will return false. If the result is true we show the what's new and if it is false we do not show it. OBVIOUSLY you will have to add to the dependencies the SQL (B4A) or the iSQL (b4i) as seen bellow.*  
  
The library takes advantage of the following libraries:  
  

- **Android**
XUI Views, StringUtils and SQL- **iOS**
XUI Views, iSQL
  
  
![](https://www.b4x.com/android/forum/attachments/83163)  
  
(The colors of the explain label and [Back] and [Next] labels can be changed to transparent or what ever color you wish - this is valid also for the drawn quarters around the view)  
  
B4A Example:  
  

```B4X
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    Activity.LoadLayout("1")  
    Dim wn As WhatsNew  
    wn.Initialize(Activity, 0xFFFFCC00, 0xFFFFE37A, 0xFFFFF3C8, _  
            0xFFFF0022, 0xFFFFB000, 19, _  
            0xFFFF0022, 0xFFFFB000, 19, 10)  
    wn.HighLigher = wn.HighlighterCircle  
  
    'Insert values instead of 0,0,0,0 to define the dimensions of your explanation manually  
    wn.AddViewToExplain(Button1, "This is button 1. This is button 1. This is button 1. This is button 1. This is button 1. This is button 1. This is button 1. This is button 1. ",0,0,0,0)  
    wn.AddViewToExplain(Button2, "This is button 2. This is button 2. This is button 2. This is button 2. This is button 2. This is button 2. This is button 2. This is button 2. ",0,0,0,0)  
    wn.AddViewToExplain(Button3, "This is button 3. This is button 3. This is button 3. This is button 3. This is button 3. This is button 3. This is button 3. This is button 3. ",0,0,0,0)  
    wn.StartExplainingWhatsNew  
  
End Sub
```

  
  
  
B4i Example:  
  

```B4X
Private Sub Application_Start (Nav As NavigationController)  
    'SetDebugAutoFlushLogs(True) 'Uncomment if program crashes before all logs are printed.  
    NavControl = Nav  
    Page1.Initialize("Page1")  
    Page1.Title = "Page 1"  
    Page1.RootPanel.LoadLayout("1")  
    Page1.RootPanel.Color = Colors.White  
    NavControl.NavigationBarVisible = False  
    NavControl.ShowPage(Page1)  
  
    'Remove this to see what will happen - lower labels disappear  
  
    wn.Initialize(Page1.RootPanel, 0xFFFFCC00, 0xFFFFE37A, 0xFFFFF3C8, _  
            0xFFFF0022, 0xFFFFB000, 19, _  
            0xFFFF0022, 0xFFFFB000, 19, 10)  
    wn.HighLigher = wn.HighlighterCircle  
    wn.AddViewToExplain(Button1, "This is button 1. This is button 1. This is button 1. This is button 1. This is button 1. This is button 1. This is button 1. This is button 1. ",0,0,0,0)  
    wn.AddViewToExplain(Button2, "This is button 2. This is button 2. This is button 2. This is button 2. This is button 2. This is button 2. This is button 2. This is button 2. ",0,0,0,0)  
    wn.AddViewToExplain(Button3, "This is button 3. This is button 3. This is button 3. This is button 3. This is button 3. This is button 3. This is button 3. This is button 3. ",0,0,0,0)  
  
End Sub  
  
Private Sub Page1_Resize(Width As Int, Height As Int)  
    wn.SetViewToExplainTextDimensions(Button1, 10%x, 10%y, 80%x, 80%y)  
    wn.SetDimensions(Width, Height)  
    wn.StartExplainingWhatsNew  
End Sub
```

  
  
Have fun  
<https://www.b4x.com/android/forum/threads/b4x-whats-new-class.108678/>