###  Supabase - Database Joins by Alexander Stolte
### 12/20/2023
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/157039/)

<https://www.b4x.com/android/forum/threads/b4x-supabase-the-open-source-firebase-alternative.149855/>  
  
In the following example I make a join into the "public.users" table and need the column "username" from it.  

```B4X
    Dim Query As Supabase_DatabaseSelect = xSupabase.Database.SelectData  
    Query.Columns("message,created_by,id, users(username)")  
    Query.From("dt_Chat")  
    Query.Filter_Equal(CreateMap("room_id":3))  
  
    Wait For (Query.Execute) Complete (DatabaseResult As SupabaseDatabaseResult)  
    
    For Each Row As Map In  DatabaseResult.Rows  
        
        AddItem(Row.Get("message"), Row.Get("created_by") = User.Id,Row.Get("users.username"))  
        
    Next
```

  
  
Join Public.users ON users.username:  

```B4X
Query.Columns("message,created_by,id, users(username)") 'Join Public.users ON users.username
```

  
  
Get the joined column:  

```B4X
Row.Get("users.username")
```

  
  
Join the Auth.Users Table:  
<https://www.b4x.com/android/forum/threads/supabase-table-joins-with-auth-users.158102/#post-970771>