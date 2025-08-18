### POC: ORM by EnriqueGonzalez
### 11/29/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/136428/)

Having a background on Ruby On Rails there are 2 things i miss everytime i come back to B4x: ActiveRecord and Testings, so today i decided to tackle both them.  
  
so far i have achived 20% of what i want to do, but i am very happy with the results.  
My current approach consists of using the Type system of B4x to map them into the database. lets see the example:  
  

```B4X
Type supplier(id As String, nombre As String, nombre_corto As String, invoices As List)
```

  
the type supplier matches to the table suppliers in the database (singular -plural), each field also match to a column. EXCEPT of course for the list, this one matches to the table invoices (hence the plural)  
  

```B4X
Type invoice(id As String, folio As String, supplier_id As String)
```

  
the type invoice has a supplier\_id, this way i am creating a One to Many relation ship.  
  
The next step is simply to connect to a database and let the magic begin!  
  

```B4X
    DB_ORM.Initialize(MP)  
     
    TakeTime  
    Dim p As supplier = Createsupplier("testorm","tm")  
     
    For i = 0 To 10  
        Dim f As invoice = Createinvoice(i,DB_ORM.uuid_null)  
        p.invoices.Add(f)  
    Next  
     
    DB_ORM.save(p,Null)  
    CallSub(Me, "StopTakeTime")  
    Log(p.id) 'Elapsed time: 00:01:896  
    StartMessageLoop
```

  
this code will create the following information in to the database.  
![](https://www.b4x.com/android/forum/attachments/122397)  
The code will not hit the database until i call the save method, it will automatically detect the child tables (based on the type of the fields classes) each one of the invoice objects will be saved into the database too without having to do anything extra. it can also detect wheter it has to update or insert.  
  
i was a bit hesitant on the performance, but inserting 11 records to a remote database (in a vps in another country) takes 2 seconds on avarage. If there is a performance hit it seems to be neglible.  
  
Thats it for now! there is a bunch to do so far, the next steps will be to do some query SELECTORS  
Okey then, sorry for the teasing as it is not ready to be released i want to know if this is something that could interest to the community and if so, what functionality would you like to appear?  
  
P.D. of course, with this technique creating TESTS would be almost the same!