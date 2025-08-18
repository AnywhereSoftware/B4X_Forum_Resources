### Null in relation to assigning database values to variables by j_o_h_n
### 04/28/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/130217/)

I don't know if this counts as a tutorial but it might help someone. Please advise of any errors or omissions and I'll fix them.  
  
Sometimes the value in a field in a resultset will be null.  
This can even be the case for database columns that are are defined NOT NULL by design, if the the resultset  
is from a join operation.  
  
Consider this example where the database field Company in the resultset RS is null :  
  

```B4X
Dim ob As Object = RS.getstring("Company")  
Log(ob=Null)  'this logs True  
Dim Company As String  = ob  
Log(Company) 'this logs the string "null", you probably don't want this.  
Log(Company.Length ) 'this logs 4  
          
Company = RS.getstring("Company")  
Log(Company=Null) 'this logs False  
Log(Company)'this again logs the string "null"  
Log(Company.Length )'this throws: (Exception) java.lang.Exception:  java.lang.NullPointerException
```

  
  
So in order to be able to test if null, first assign to an object.  
Test that for null and then do whatever you need to do, afterwards :  

```B4X
Dim ob As Object = RS.getstring("Company")  
if ob = null then  
    Company = ""  
else  
    Company = ob  
end if
```

  
  
For more information see <https://www.b4x.com/android/forum/threads/b4x-b4xtable-load-data-from-sql-database.102520/#content>  
  
**Update based on Erel's comment below.**  
If your sql query was
> "Select Company from dbname"

and you want the empty string returned for rows where the column is null  
then rewrite the query as
> "Select IFNULL(Company, "") from dbname"

Then in code below Company will be assigned the empty string if the database field is null  

```B4X
Company = RS.getstring("Company")
```

  
  
IFNull is the SQLite function, Postgres has COALESCE, etc.