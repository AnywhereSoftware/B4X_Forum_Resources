### Alpha/Beta testing if jRDC2 with returning auto-generated key values after INSERT by OliverA
### 01/11/2021
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/126407/)

I've had this mod sitting on the sidelines since last fall. Looks like there is a need for this as shown in this post: <https://www.b4x.com/android/forum/threads/rdc2-select-last_insert_id.126310/>  
  
In order to retrieve the auto generated key values for an INSERT statement, I've added the ExecuteInsert method to the DBRequestManager shared module. Going with the sample code posted by [USER=74499]@aeric[/USER] in the above mentioned thread  

```B4X
Sub AddBook (Name As String)  
    Dim cmd As DBCommand = CreateCommand("insert_book", Array(Name))  
    Dim j As HttpJob = CreateRequest.ExecuteBatch(Array(cmd), Null)  
    Wait For(j) JobDone(j As HttpJob)  
    If j.Success Then  
        Log("Inserted successfully!")  
    End If  
    j.Release  
End Sub
```

  
to retrieve the auto-generated key values, the new method can be used  

```B4X
Sub AddBook (Name As String)  
    Dim cmd As DBCommand = CreateCommand("insert_book", Array(Name))  
    Dim j As HttpJob = CreateRequest.ExecuteInsert(Array(cmd), Null)  
    Wait For(j) JobDone(j As HttpJob)  
    If j.Success Then  
        Log("Inserted successfully!")  
        req.HandleJobAsync(j, "req")  
        Wait For (req) req_Result(res As DBResult)  
        'Let's print out the returned auto-generated key(s)  
        req.PrintTable(res)  
    End If  
    j.Release  
End Sub
```

  
  
Notes:  
1) By default, the JDBC returned value is a BIGINT. The jRDC2 code uses getLong to retrieve the value. So for very large DB's with auto-increment values that are greater than Java's Long value, this will fail. If that is an issue, the code could be modified to return a BIGINT value. Note that your code on the client file will fail unless you also provide BIGINT support in your client. See post#2 for changes  
2) Most DB's (at least the ones I have access to) only return one auto-generated key value. The default column name for this value seems to be GENERATED\_KEY  
3) The above code just prints the complete DBResults out in order to show what is returned. You can use that information to actually create the retrieval code of the values  
4) Don't forget that this requires an update (attached) to your DBRequestManager.bas