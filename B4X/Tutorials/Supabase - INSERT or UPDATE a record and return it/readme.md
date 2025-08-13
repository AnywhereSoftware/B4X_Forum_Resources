###  Supabase - INSERT or UPDATE a record and return it by Alexander Stolte
### 01/09/2024
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/158532/)

<https://www.b4x.com/android/forum/threads/b4x-supabase-the-open-source-firebase-alternative.149855/>  
  
It is possible to create a new data record and return it directly.  
Use the [ICODE]SelectData[/ICODE] property  

```B4X
    Dim Insert As Supabase_DatabaseInsert = xSupabase.Database.InsertData  
    Insert.From("users")  
    Insert.Upsert 'Works with upsert too  
    Insert.SelectData  
    Dim InsertMap As Map = CreateMap("id":"492422e5-4188-4b40-9324-fee7c46be527","username":"Alex")  
    Wait For (Insert.Insert(InsertMap).Execute) Complete (Result As SupabaseDatabaseResult)  
    xSupabase.Database.PrintTable(Result)
```

  
  
The same works if you update a record  

```B4X
    Dim Update As Supabase_DatabaseUpdate = xSupabase.Database.UpdateData  
    Update.From("users")  
    Update.Update(CreateMap("username":"Alex"))  
    Update.SelectData  
    Update.Eq(CreateMap("id":"492422e5-4188-4b40-9324-fee7c46be527"))  
    Wait For (Update.Execute) Complete (Result As SupabaseDatabaseResult)  
    xSupabase.Database.PrintTable(Result)
```