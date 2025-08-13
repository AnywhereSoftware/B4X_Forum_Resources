### [Supabase] Findings by yiankos1
### 12/31/2023
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/158332/)

Hello,  
  
I am doing my baby steps with Supabase and i will post here my findings in case someone needs them.  
  
1) If you JOIN tables and filtering, then you will get results even it is equal with filter even it is not. So, in order to INNER JOIN tables and get only results that corresponds with filters you have to do this:  

```B4X
    Dim Query As Supabase_DatabaseSelect = xSupabase.Database.SelectData  
    Query.Columns("*,workoutcalendar!inner(wctime),users!inner(name)").From("appointments").Filter_Equal(CreateMap("workoutcalendar.wcdate":DateTime.Date(FirstDate))).OrderBy("workoutcalendar(wctime).asc")  
    Wait For (Query.Execute) Complete (DatabaseResult As SupabaseDatabaseResult)  
    xSupabase.Database.PrintTable(DatabaseResult)
```

  
  
So here, we will get every column (\*) from appointments table, wctime from workoutcalendar table and name from users table that corresponds to a specific date ordered by wctime of workoutcalendar table.  
  
You have to put: **!inner** before column name. More info [here](https://supabase.com/blog/postgrest-9#resource-embedding-with-inner-joins).