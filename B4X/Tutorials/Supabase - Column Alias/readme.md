###  Supabase - Column Alias by Alexander Stolte
### 01/08/2024
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/158531/)

<https://www.b4x.com/android/forum/threads/b4x-supabase-the-open-source-firebase-alternative.149855/>  
  
You can use column aliases in Supabase. All you need to do is write the alias name, a colon and then the column name.  

```B4X
'AliasName:ColumnName  
Query.Columns("Name:Tasks_Name")
```

  
  

```B4X
Dim Query As Supabase_DatabaseSelect = xSupabase.Database.SelectData  
Query.Columns("*,Name:Tasks_Name").From("dt_Tasks")  
Query.Filter_Equal(CreateMap("Tasks_Name":"Task 02"))  
Wait For (Query.Execute) Complete (DatabaseResult As SupabaseDatabaseResult)
```