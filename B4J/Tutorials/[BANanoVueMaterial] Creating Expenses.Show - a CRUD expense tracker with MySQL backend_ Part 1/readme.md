### [BANanoVueMaterial] Creating Expenses.Show - a CRUD expense tracker with MySQL backend: Part 1 by Mashiane
### 10/07/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/114028/)

Ola  
  
**DEPRECATED: This project is based on a very old version of BANanoVueMaterial and is NO LONGER MAINTAINED!!!  
  
HOWEVER, YOU CAN FOLLOW THIS THREAD ON CREATING AN EXPENSE TRACKER USING THE NEW VERSION,   
  
<https://www.b4x.com/android/forum/threads/bananovuematerial-bvmdesigner-mock-compile-publish.116934/post-736839>**  
  
**PS: A lot has happened eversince this tutorial was written and a lot of changes to libraries took place. Please just start a new thread should you have any questions about it.  
  
UPDATE 2020-05-19: [Please use this library instead](https://www.b4x.com/android/forum/threads/bananoconnect-bananosql-sqlite-mysql-mssql-library.117956/) for connectivity**  
  
[Download](https://github.com/Mashiane/BANanoVueMaterial/tree/master/4.%20Examples/5.%20Expenses.Show)  
  
![](https://www.b4x.com/android/forum/attachments/88809)  
  
The purpose of this tutorial is showing how easy it is to create a CRUD app using BANanoVueMaterial. In more detail, we will look at the following:  
  
1. Creating Modal forms for data entry.  
2. Data validation.  
3. Inserting data to a table  
4. Reading data from a table for edits  
5. Deleting data from a table (with a confirm dialog box)  
  

1. Part 1 of this tutorial will deal specifically with data entry.
2. [Part 2](https://www.b4x.com/android/forum/threads/bananovuematerial-creating-expenses-show-a-crud-expense-tracker-with-mysql-backend-part-2.114047/) will deal with reporting, e.g. charts, exporting to excel etx.

  
**Preparations**  
  
1. From the attachments here, create a mysql database named **expensesshow** and execute the scripts in the expensesshow.zip (sql) file.  
2. Update the config.php file in the Files tab with **your own MySQL** db connection settings  
  

```B4X
<?php  
const DB_HOST = '127.0.0.1';  
const DB_NAME = 'expensesshow';  
const DB_USER = 'root';  
const DB_PASS = '';  
?>
```

  
  
3. Also in Main.AppStart, update the ServerIP with your own IP address.  
  

```B4X
ServerIP = "127.0.0.1"
```

  
  
Some silly assumptions: You have downloaded the [BANanoVueMaterial](https://github.com/Mashiane/BANanoVueMaterial) library from Github and copied it to your external libraries folder.  
You have done some reading about BANanoVueMaterial from [these posts.](https://www.b4x.com/android/forum/threads/bananovuematerial-the-first-vuejs-ux-based-framework-for-banano.113789/#content)  
  
**1. Creating Records.**  
  
The most important screen for our Expense Tracker is the modExpenses module where one is able to capture expenses. This module however is dependent on 2 other modules, i.e. the expense type and the expense category.  
  
![](https://www.b4x.com/android/forum/attachments/88753)  
  
The expense types screen works exactly like the expense category screens. One defines the two records that they will use in capturing expensed.  
  
When adding a new record, a dialog box with the expense type details is provided. One captures the expense type/category and then saves. Each id of the record here is auto-incremented. The app though does not check for duplicated expense types but one can add that when needed.  
  
The code to execute the adding of records is sitting in pgIndex.  
  

```B4X
Sub btnAddExpenseType_click(e As BANanoEvent)  
    modExpenseTypes.Add  
End Sub
```

  
  
This calls the .Add method in modExpenseTypes  
  

```B4X
'a button to add a new record is clicked  
Sub Add  
    Mode = "A"  
    mdlExpenseType.Container.SetDefaults  
    mdlExpenseType.SetTitle("New Expense Type")  
    vm.ShowDialog("mdlExpenseType")  
End Sub
```

  
  
This sets the mode for the record, sets the default values for the container input elements,update the title of the dialog and then shows the dialog.  
  
You will recall, that when the .Code method was called for modExpenseTypes, the code to built what is needed was executed.  
  
1. A dialog for the input controls was created so that we can capture the expense types.  
  

```B4X
'create a modal to add an expense type  
    mdlExpenseType = vm.CreateDialog("mdlExpenseType",Me)  
    mdlExpenseType.settitle("New Expense Type")  
    mdlExpenseType.AddCancel("btnCancelExpenseType", "Cancel")  
    mdlExpenseType.AddOK("btnSaveExpenseType", "Save")  
    '  
    Dim etID As VMInputControl = mdlExpenseType.Container.NewText("id","#","",False,"",0,"","",0)  
    etID.SetVisible(False).SetInt  
    Dim etText As VMInputControl = mdlExpenseType.Container.NewText("text","Name","",True,"",20,"","The expense type is required!",0)  
    Dim etDescription As VMInputControl = mdlExpenseType.Container.NewTextArea("description","Description","",False,False,"",100,"","",0)  
  
  
    mdlExpenseType.Container.AddControlS(etID, 1, 1, 12, 12, 12, 12)  
    mdlExpenseType.Container.AddControlS(etText, 2, 1, 12, 12, 12, 12)  
    mdlExpenseType.Container.AddControlS(etDescription, 3, 1, 12, 12, 12, 12)  
    '  
    mdlExpenseType.SetClickOutsideToClose(False)  
    mdlExpenseType.SetCloseOnEsc(False)  
    mdlExpenseType.SetWidth("500px")  
    vm.AddDialog(mdlExpenseType)
```

  
  
and just before that, we added a table to list all our expense types.  
  
2.  

```B4X
'create a container to hold all contents  
    Dim cont As VMContainer = vm.CreateContainer(name,Me)  
    'hide this container  
    cont.Hide  
    'create 1 columns each spanning 12 columns  
    cont.AddRows(1).AddColumns12  
    '  
    expenseType = vm.CreateGijgoTable("expensetype", "id", Me)  
    expenseType.SetTitle("Expense Types")  
    expenseType.AddColumn("text","Name")   ' 20  
    expenseType.AddColumn("description","Description")   '100  
    expenseType.AddEditTrash  
    expenseType.autoLoad = True  
    expenseType.SetDataSource(Array())  
    cont.AddComponent(1,1, expenseType.tostring)  
    'add container to the page content  
    vm.AddContainer(cont)
```

  
  
As the table configuration is new, we define a new gijgo table and then add columns to it. We only add the columns we want to show on the grid. We also add action buttons for Add and Delete.  
  
Each time we want to show the contents of the database table expensetypes, we call the .Refresh method.  
  

```B4X
'load all existing expense types  
Sub Refresh  
    vm.pagepause  
    Dim dbsql As BANanoMySQL  
    dbsql.Initialize(Main.dbase, "expensetypes", "id")  
    dbsql.SelectAll(Array("*"), Array("text"))  
    dbsql.json = BANano.CallInlinePHPWait(dbsql.methodname, dbsql.Build)  
    dbsql.FromJSON  
    If dbsql.OK Then  
        expenseType.SetDataSource(dbsql.result)  
        expenseType.refresh  
    Else  
        Log("modExpenseTypes.Refresh: Error - " & dbsql.error)  
    End If  
    vm.pageresume  
End Sub
```

  
  
We open the MySQL database, select all records and sort them by id and then load the records to the grid. This also happens when we edit and update a record. The grid is refreshed.