###  Supabase - Database CRUD by Alexander Stolte
### 01/10/2024
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/149857/)

<https://www.b4x.com/android/forum/threads/b4x-supabase-firebase-alternative.149855/>  
  
This is a very simple tutorial on how to use the CRUD options. A more detailed tutorial is coming soon.  
  
**CREATE**  

```B4X
Dim Insert As Supabase_DatabaseInsert = xSupabase.Database.InsertData  
Insert.From("dt_Tasks")  
Dim InsertMap As Map = CreateMap("Tasks_Name":"Task 01","Tasks_Checked":False,"Tasks_CreatedAt":DateUtils.TicksToString(DateTime.Now),"Tasks_UpdatedAt":DateUtils.TicksToString(DateTime.Now))  
Wait For (Insert.Insert(InsertMap).Execute) Complete (Result As SupabaseDatabaseResult)
```

  

```B4X
Dim Insert As Supabase_DatabaseInsert = xSupabase.Database.InsertData  
Insert.From("dt_Tasks")  
Dim lst_BulkInsert As List  
lst_BulkInsert.Initialize  
lst_BulkInsert.Add(CreateMap("Tasks_Name":"Task 02","Tasks_Checked":True,"Tasks_CreatedAt":DateUtils.TicksToString(DateTime.Now),"Tasks_UpdatedAt":DateUtils.TicksToString(DateTime.Now)))  
lst_BulkInsert.Add(CreateMap("Tasks_Name":"Task 03","Tasks_Checked":True,"Tasks_CreatedAt":DateUtils.TicksToString(DateTime.Now),"Tasks_UpdatedAt":DateUtils.TicksToString(DateTime.Now)))  
Wait For (Insert.InsertBulk(lst_BulkInsert).Execute) Complete (Result As SupabaseDatabaseResult)
```

  
**READ**  

```B4X
    Dim Query As Supabase_DatabaseSelect = xSupabase.Database.SelectData  
    Query.Columns("*").From("dt_Tasks")  
    Query.Filter_Equal(CreateMap("Tasks_Name":"Task 02"))  
    Wait For (Query.Execute) Complete (DatabaseResult As SupabaseDatabaseResult)  
  
    xSupabase.Database.PrintTable(DatabaseResult)  
  
    For Each Row As Map In DatabaseResult.Rows  
        Log(Row.Get("Tasks_Name"))  
    Next
```

  
**UPDATE**  

```B4X
Dim Update As Supabase_DatabaseUpdate = xSupabase.Database.UpdateData  
Update.From("dt_Tasks")  
Update.Update(CreateMap("Tasks_Name":"Task 02"))  
Update.Eq(CreateMap("Tasks_Id":1))  
Wait For (Update.Execute) Complete (Result As SupabaseDatabaseResult)
```

  
**DELETE**  

```B4X
Dim Delete As Supabase_DatabaseDelete = xSupabase.Database.DeleteData  
Delete.From("dt_Tasks")  
Delete.Eq(CreateMap("Tasks_Id":1))  
Wait For (Delete.Execute) Complete (Result As SupabaseError)
```