### SithasoDaisy: Creating Dialog Forms with the Abstract Designer by Mashiane
### 06/29/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/148760/)

Good day  
  
In the SithasoDaisy download package, you get a MySQL Crud App for a simple expense tracking app. As a showcase, there is a b4j layout named **expenseCategory**  
  
![](https://www.b4x.com/android/forum/attachments/143318)  
  
  
This layout has been built to stand alone as it's injected inside a modal during the **BuildPage** page process.  
  

```B4X
'start building the page  
private Sub BuildPage  
    banano.LoadLayout(app.PageViewer, "expensecategorieslayout")  
    banano.LoadLayout(mdlExpense.FormHere, "expenseCategory")  
    'apply master data source settings  
    app.SetBackEnd(dsExpense)  
    '  
    BuildTable  
    '  
    mounted  
End Sub
```

  
  
  
We first load the expensecategorieslayout into the pageViewer, then, inside the form of the modal, we load this layout. This layout uses a grid approach as components are placed inside rows and columns. You can get a brief about this here.   
  
<https://www.w3schools.com/bootstrap/bootstrap_grid_system.asp>  
  
A column can span 12 spaces i.e **Size,** however you can indicate the size to take for each of the devices.  
  
  
![](https://www.b4x.com/android/forum/attachments/143319)  
  
In the case below, we are saying, the size across all devices, should be 6 i.e. half of the screen.  
  
  
![](https://www.b4x.com/android/forum/attachments/143320)  
  
The end result of this form is…  
  
![](https://www.b4x.com/android/forum/attachments/143321)  
  
When the app is being ran, you will explore and learn about creating this type of table. This has badged and color coded text (green & red)![](https://www.b4x.com/android/forum/attachments/143322)  
  
Also  
  
  
![](https://www.b4x.com/android/forum/attachments/143323)  
  
Adding Expenses & Loading combo boxes from Database records  
  
![](https://www.b4x.com/android/forum/attachments/143324)  
  
  
Etc  
  
Happy Coding.