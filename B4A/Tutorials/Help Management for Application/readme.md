### Help Management for Application by Guenter Becker
### 07/13/2021
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/132513/)

Hello hope your'e well.  
Apps are getting more and more complicate and to work with the user needs a manual. This examples shows how you can add an help dialog to your B4XPages Project. The help information is taken from a pdf file. The help index is created from the app. If you do not like to show the help as a dialog it should be easy to modify the code to show it on a B4XPage or Activity.  
  
**Features:**  
- show individual pdf file (manual)  
- goto first, next, previous, last pdf page  
- goto entered page number  
- create and show Page Index  
- goto page number selected by index  
- move and zoom pdf page with gestures  
  
**Version 1.0  
Licence free for private and commercial use of Board Members  
Find Example B4A Project attached.**  
  

```B4X
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root1.LoadLayout("B4XMain")  
      
    'Initialize Help Dialog  
    DLGHelp.Initialize(Root)  
      
    ' setup helpindex key= page no, value= title  
    IndexValues.Put(1,"Index")  
    IndexValues.Put(2,"Chapter 1 …")  
    ' setup HelpFileName  
    HelpFileName="acr1255u.pdf"  
    ' set dialog properties  
    DLGHelp.Title = "Help AppName"  
    DLGHelp.TitleBarColor=Colors.Blue  
    DLGHelp.TitleBarTextColor=Colors.White  
    DLGHelp.BorderColor=Colors.Blue  
    DLGHelp.BorderWidth=2dip  
    DLGHelp.BorderCornersRadius=5dip  
    DLGHelp.ButtonsColor=Colors.Blue  
    DLGHelp.ButtonsTextColor=Colors.white  
    DLGHelp.BackgroundColor=Colors.white  
End Sub
```