###  Supabase - Database OrderBy by Alexander Stolte
### 11/08/2023
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/157292/)

<https://www.b4x.com/android/forum/threads/b4x-supabase-the-open-source-firebase-alternative.149855/>  
  
You can order by just one column, or with multiple columns.  
  
Available sorting commands:  

- desc

- To sort the records in descending order

- asc

- To sort the records in ascending order

- nullsfirst
- nullslast

Example of order by with one column:  

```B4X
"Tasks_Id.desc"
```

  

```B4X
    Dim Query As Supabase_DatabaseSelect = xSupabase.Database.SelectData  
    Query.Columns("*").From("dt_Tasks")  
    Query.OrderBy("Tasks_Id.desc")  
    Wait For (Query.Execute) Complete (DatabaseResult As SupabaseDatabaseResult)  
    xSupabase.Database.PrintTable(DatabaseResult)
```

  
Example of order by with multiple columns:  

```B4X
"Tasks_Id.desc,Tasks_Name.asc"
```

  

```B4X
    Dim Query As Supabase_DatabaseSelect = xSupabase.Database.SelectData  
    Query.Columns("*").From("dt_Tasks")  
    Query.OrderBy("Tasks_Id.desc,Tasks_Name.asc")  
    Query.Limit(1)  
    Wait For (Query.Execute) Complete (DatabaseResult As SupabaseDatabaseResult)  
    xSupabase.Database.PrintTable(DatabaseResult)
```