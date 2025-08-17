### SithasoDaisy: How to Create Beautiful Product Tour by Mashiane
### 07/04/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/148843/)

Hi there.  
  
[MEDIA=youtube]6nEcQFnfx8U[/MEDIA]  
  
  
We will demo this using a table and a property bag.  
  
We tell our SDUITable that it will have some toolbar buttons, these will be added to it.  
  
![](https://www.b4x.com/android/forum/attachments/143432)  
  
  
This is how the final SDUITable looks…  
  
![](https://www.b4x.com/android/forum/attachments/143433)  
  
We add tooltips to those buttons…  
  

```B4X
tblemployees.SetToolbarButtonToolTip("add", "Add a new Employee.", app.COLOR_PRIMARY, "left", True)  
    tblemployees.SetToolbarButtonToolTip("savesingle", "To save a single Employee, click this button.", app.COLOR_PRIMARY, "left", True)  
    tblemployees.SetToolbarButtonToolTip("deletesingle", "To delete a single Employee, click this button.", app.COLOR_PRIMARY, "left", True)  
    tblemployees.SetToolbarButtonToolTip("uploadtoolbar", "To upload Employees from Excel, click this button.", app.COLOR_PRIMARY, "left", True)  
    tblemployees.SetToolbarButtonToolTip("deleteall", "To delete all Employees on the current page, click this button.", app.COLOR_PRIMARY, "left", True)  
    tblemployees.SetToolbarButtonToolTip("exporttocsv", "To export Employees to CSV, click this button.", app.COLOR_PRIMARY, "left", True)  
    tblemployees.SetToolbarButtonToolTip("exporttopdf", "To export Employees to PDF, click this button.", app.COLOR_PRIMARY, "left", True)  
    tblemployees.SetToolbarButtonToolTip("exporttoxls", "To export Employees to Excel, click this button.", app.COLOR_PRIMARY, "left", True)  
    tblemployees.SetToolbarButtonToolTip("refresh", "Refresh list of Employees", app.COLOR_PRIMARY, "left", True)  
    tblemployees.SetToolbarButtonToolTip("back", "Close this page and go to the dashboard, click this button.", app.COLOR_PRIMARY, "left", True)  
    '      
    tblemployees.AddToolbarButtonIcon("help", "fa-solid fa-question", app.COLOR_INFO)  
    tblemployees.SetToolbarButtonToolTip("help", "Tour this page.", app.COLOR_PRIMARY, "left", True)
```

  
  
We have added an extra button called help, when clicked, this will activate the product tour.  
  
When the help button is clicked, the product tour starts to guide our end users on how to use the webapp.  
  

```B4X
Sub tblemployees_help (e As BANanoEvent)  
    e.PreventDefault  
    Dim help As SDUIEnjoyHint  
    help.Initialize  
    help.AddStep(tblemployees.getTitleID, "This is the title of this table.")  
    help.AddStep(tblemployees.getSearchID, "You can search for a customer by typing your criteria here.</br>Search is performed after 3 letters are entered at each key-press.")  
    help.AddStep(tblemployees.getToolBarPrevPageID, "To view the previous page, click here.")  
    help.AddStep(tblemployees.getToolBarNextPageID, "To view the next page, click here.")  
    help.AddStep(tblemployees.getToolBarButtonID("add"), "To add a new Employee, click this button.")  
      
    help.AddStep(tblemployees.getToolBarButtonID("savesingle"), "To save a single Employee, click this button.")  
    help.AddStep(tblemployees.getToolBarButtonID("deletesingle"), "To delete a single Employee, click this button.")  
    help.AddStep(tblemployees.getToolBarButtonID("uploadtoolbar"), "To upload Employees from Excel, click this button.")  
    help.AddStep(tblemployees.getToolBarButtonID("deleteall"), "To delete all Employees on the current page, click this button.")  
    help.AddStep(tblemployees.getToolBarButtonID("exporttocsv"), "To export Employees to CSV, click this button.")  
    help.AddStep(tblemployees.getToolBarButtonID("exporttopdf"), "To export Employees to PDF, click this button.")  
    help.AddStep(tblemployees.getToolBarButtonID("exporttoxls"), "To export Employees to Excel, click this button.")  
    '      
    help.AddStep(tblemployees.getToolBarButtonID("refresh"), "This option will refresh the Employee listing with all Employees in the database.")  
    help.AddStep(tblemployees.getToolBarButtonID("back"), "To go to the dashboard, select this option.")  
    '  
    'add buttons added to the toolbar  
    '  
    help.AddStep(tblemployees.getColumnChooserID, "This section enables one to toggle the visibility of the columns in the table.")  
    '  
    help.AddStep(tblemployees.getHeadingID , "One is also able to click a column header to sort the columns in ascending or descending order.")  
    help.AddStep(tblemployees.getSelectAllID, "One is able to select / unselect all Employees here in one go.")  
    '  
    'add columns added to the table  
    'help.AddStep(tblemployees.getColumnID("id"), "This column displays the ID")  
    help.AddStep(tblemployees.getColumnID("employeeid"), "This column displays the Employee ID")  
    'help.AddStep(tblemployees.getColumnID("name"), "This column displays the Full Name")  
    help.AddStep(tblemployees.getColumnID("picture"), "This column displays the Picture & Full Name")  
    'help.AddStep(tblemployees.getColumnID("uploadpicture"), "This column displays the Upload Picture")  
    help.AddStep(tblemployees.getColumnID("phone"), "This column displays the Phone")  
    help.AddStep(tblemployees.getColumnID("email"), "This column displays the Email")  
    'help.AddStep(tblemployees.getColumnID("address"), "This column displays the Address")  
    help.AddStep(tblemployees.getColumnID("city"), "This column displays the City")  
    help.AddStep(tblemployees.getColumnID("state"), "This column displays the State")  
    help.AddStep(tblemployees.getColumnID("zip"), "This column displays the Zip")  
    'help.AddStep(tblemployees.getColumnID("notes"), "This column displays the Notes")  
          
    help.AddStep(tblemployees.getColumnID("edit") , "To make changes to a Employee, click the 'Edit' column that corresponds to it.")  
    help.AddStep(tblemployees.getColumnID("delete") , "To delete a Employee, click the 'Delete' column that corresponds to it.")  
    help.AddStep(tblemployees.getColumnID("clone") , "To clone / copy a Employee, click the 'Clone' column that corresponds to it.")  
    help.AddStep(tblemployees.getFooterID , "On the footer, one is able to see the total number of Employees.")  
    help.EndsOn(tblemployees.getFooterID, "Got it")  
    help.Run(Me)  
End Sub
```

  
  
When we click the Add button to add employees, the property bag activates so that we can add the employees..  
  
![](https://www.b4x.com/android/forum/attachments/143435)  
  
Clicking the ? for the property bag activates the tour also for it, this is activated by…  
  

```B4X
Sub pbemployees_help (e As BANanoEvent)  
    e.PreventDefault  
    Dim help As SDUIEnjoyHint  
    help.Initialize  
    help.AddStep(pbemployees.GetPropertyHintID("employeeid"), $"Here you specify the employee id."$)  
    help.AddStep(pbemployees.GetPropertyHintID("name"), $"Here you specify the employee full name."$)  
    help.AddStep(pbemployees.GetPropertyHintID("picture"), $"Here you specify the employee picture."$)  
    help.AddStep(pbemployees.GetPropertyHintID("uploadpicture"), $"Here you upload employee picture."$)  
    help.AddStep(pbemployees.GetPropertyHintID("phone"), $"Here you specify the employee phone."$)  
    help.AddStep(pbemployees.GetPropertyHintID("email"), $"Here you specify the employee email."$)  
    help.AddStep(pbemployees.GetPropertyHintID("address"), $"Here you specify the employee address."$)  
    help.AddStep(pbemployees.GetPropertyHintID("city"), $"Here you specify the employee city."$)  
    help.AddStep(pbemployees.GetPropertyHintID("state"), $"Here you specify the employee state."$)  
    help.AddStep(pbemployees.GetPropertyHintID("zip"), $"Here you specify the employee zip."$)  
    help.AddStep(pbemployees.GetPropertyHintID("notes"), $"Here you specify the employee notes."$)  
          
    help.AddStep($"mdlemployeesyes"$, $"Click here to save the Employee to the database."$)  
    help.AddStep($"mdlemployeescancel"$, $"Click here to cancel saving the Employee."$)  
    help.EndsOn($"mdlemployeescancel"$, "Got it")  
    help.Run(Me)  
End Sub
```

  
  
  
Happy Coding!