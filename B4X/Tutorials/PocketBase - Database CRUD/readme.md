###  PocketBase - Database CRUD by Alexander Stolte
### 01/26/2025
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/165269/)

<https://www.b4x.com/android/forum/threads/b4x-pocketbase-open-source-backend-in-1-file.165213/#content>  
  
This is a very simple tutorial on how to use the CRUD options. A more detailed tutorial is coming soon.  
  
**CREATE**  

```B4X
    Dim Insert As Pocketbase_DatabaseInsert = xPocketbase.Database.InsertData.Collection("dt_Task")  
    Insert.Parameter_Fields("Task_Name,Task_CompletedAt")  
    Dim InsertMap As Map = CreateMap("Task_UserId":xPocketbase.Auth.TokenInformations.Id,"Task_Name":"Task 06","Task_CompletedAt":Pocketbase_Functions.GetISO8601UTC(DateTime.Now))  
    Wait For (Insert.Insert(InsertMap).Execute) Complete (DatabaseResult As PocketbaseDatabaseResult)  
    xPocketbase.Database.PrintTable(DatabaseResult)
```

  
  
You can also upload files directly if you have a file column:  

```B4X
    Dim Insert As Pocketbase_DatabaseInsert = xPocketbase.Database.InsertData.Collection("dt_Task")  
    Insert.Parameter_Files(Array(Pocketbase_Functions.CreateMultipartFileData(File.DirAssets,"test.jpg","Task_Image","")))  
    Dim InsertMap As Map = CreateMap("Task_UserId":xPocketbase.Auth.TokenInformations.Id,"Task_Name":"Task 98","Task_CompletedAt":Pocketbase_Functions.GetISO8601UTC(DateTime.Now))  
    Wait For (Insert.Insert(InsertMap).Execute) Complete (DatabaseResult As PocketbaseDatabaseResult)  
    xPocketbase.Database.PrintTable(DatabaseResult)
```

  
 **READ**  
Various functions are available for retrieving data.  
  
Returns paginated items list  

```B4X
    Wait For (xPocketbase.Database.SelectData.Collection("dt_Task").GetList(0,2,"")) Complete (DatabaseResult As PocketbaseDatabaseResult)  
    xPocketbase.Database.PrintTable(DatabaseResult)
```

  
Returns single item by its ID  

```B4X
    Wait For (xPocketbase.Database.SelectData.Collection("dt_Task").GetOne("77avq8zn44ck37m")) Complete (DatabaseResult As PocketbaseDatabaseResult)  
    xPocketbase.Database.PrintTable(DatabaseResult)
```

  
Returns the first found list item by the specified filter  

```B4X
    Wait For (xPocketbase.Database.SelectData.Collection("dt_Task").GetFirstListItem("","")) Complete (DatabaseResult As PocketbaseDatabaseResult)  
    xPocketbase.Database.PrintTable(DatabaseResult)
```

  
Returns a list with all items batch fetched at once  

```B4X
    Wait For (xPocketbase.Database.SelectData.Collection("dt_Task").GetFullList("-Task_Name")) Complete (DatabaseResult As PocketbaseDatabaseResult)  
    xPocketbase.Database.PrintTable(DatabaseResult)
```

  
Create your own query with all available filters.  
Use the "Parameter\_" properties  

```B4X
    Dim CustomQuery As Pocketbase_DatabaseSelect = xPocketbase.Database.SelectData.Collection("dt_Task")  
    CustomQuery.Parameter_Page(0)  
    CustomQuery.Parameter_PerPage(2)  
    CustomQuery.Parameter_Fields("Task_Name,Task_CompletedAt")  
    CustomQuery.Parameter_Sort("-Task_Name") 'DESC  
    Wait For (CustomQuery.GetCustom) Complete (DatabaseResult As PocketbaseDatabaseResult)  
    xPocketbase.Database.PrintTable(DatabaseResult)
```

  
 **UPDATE**  

```B4X
    Dim UpdateRecord As Pocketbase_DatabaseUpdate = xPocketbase.Database.UpdateData.Collection("dt_Task")  
    UpdateRecord.Parameter_Fields("Task_Name,Task_CompletedAt")  
    UpdateRecord.Update(CreateMap("Task_Name":"Task 02"))  
    Wait For (UpdateRecord.Execute("77avq8zn44ck37m")) Complete (DatabaseResult As PocketbaseDatabaseResult)  
    xPocketbase.Database.PrintTable(DatabaseResult)
```

  
  
You can also upload files directly if you have a file column:  

```B4X
    Dim UpdateRecord As Pocketbase_DatabaseUpdate = xPocketbase.Database.UpdateData.Collection("dt_Task")  
    UpdateRecord.Parameter_Fields("Task_Name,Task_CompletedAt")  
    UpdateRecord.Parameter_Files(Array(Pocketbase_Functions.CreateMultipartFileData(File.DirAssets,"test.jpg","Task_Image","")))  
    UpdateRecord.Update(CreateMap("Task_Name":"Task 02"))  
    Wait For (UpdateRecord.Execute("77avq8zn44ck37m")) Complete (DatabaseResult As PocketbaseDatabaseResult)  
    xPocketbase.Database.PrintTable(DatabaseResult)
```

  
 **DELETE**  

```B4X
Wait For (xPocketbase.Database.DeleteData.Collection("dt_Task").Execute("43r7071wtp30l5h")) Complete (Result As PocketbaseError)
```