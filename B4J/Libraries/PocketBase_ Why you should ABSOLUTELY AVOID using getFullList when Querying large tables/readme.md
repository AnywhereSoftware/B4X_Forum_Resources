### PocketBase: Why you should ABSOLUTELY AVOID using getFullList when Querying large tables by Mashiane
### 07/29/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/167988/)

Hi Fam  
  
There are a variety of ways to get data from Pocketbase, one of them being **getFullList.** Remember, you can specify the fields you want to show in your end result and even filter your resultset. This is like a where clause where you use a **filter** property in your options  
  
**THE PROBLEM WITH getFullList**  
  
The issue with getFullList is that **all the records** in your table that meet your query parameters are fetched, in a paginated fashion off course and **stored in RAM** until the next garbage collection internal to pocketbase.  
  
**SOLUTION - Garbage Collect after each page fetch and store results in an array / list.**  
  
This solution works best if you are dealing with large collections.  
  
Get the number of pages that will be affected by your query and then get the records affected per page and store these in a variable. This helps the garbage collector after each execution to clear whatever RAM was used by your query. This results in faster execution and better performance of your apps.  
  
We have updated the latest PocketBase class to use getList going forward and no more getFullList. This has increased our response times and also resulted in less RAM usage of our pocketbase deployment. Let's see an example of selecting all records in a table.  
  

```B4X
Sub SELECT_ALL As List  
    If ShowLog Then  
        Log($"SDUIPocketBase.${sTableName}.SELECT_ALL"$)  
    End If  
    If Schema.Size = 0 Then  
        BANano.Throw($"SDUIPocketBase.SELECT_ALL: ${sTableName} - please execute SchemaAdd?? first to define your table schema!"$)  
        Return Null  
    End If  
    '  
    For Each fld As String In Schema.keys  
        Dim fldType As String = Schema.Get(fld)  
        If fldType = DB_FILE Then  
            FILE_FIELD(fld, $"${fld}url"$)  
        End If  
    Next  
  
    result.Initialize  
    Dim qsort As String = Join(",", orderByL)  
    Dim qflds As String = Join(",", flds)  
    Dim qexpand As String = Join(",", expand)  
  
    'Dim allRecords As List  
    'allRecords.Initialize  
  
    Try  
        Dim page As Int = 1  
        Dim totalPages As Int = 1  
  
        Do While page <= totalPages  
            Dim opt As Map = CreateMap()  
            opt.Put("page", page)  
            opt.Put("perPage", batchSize)  
            If qsort <> "" Then opt.Put("sort", qsort)  
            If qflds <> "" Then opt.Put("fields", qflds)  
            If qexpand <> "" Then opt.Put("expand", qexpand)  
            opt.Put("cache", "no-store")  
            'If skipTotal <> "" Then opt.Put("skipTotal", skipTotal)  
            If headers.Size > 0 Then opt.Put("headers", headers)  
  
            If ShowLog Then  
                Log($"SDUIPocketBase.SELECT_ALL page ${page} => ${BANano.ToJson(opt)}"$)  
            End If  
  
            Dim res As Map = BANano.Await(client.RunMethod("collection", sTableName).RunMethod("getList", Array(page, batchSize, opt)))  
            Dim items As List = res.Get("items")  
            If page = 1 Then totalPages = res.Get("totalPages")  
             
            ' Process file fields if needed  
            If fileFields.Size > 0 Then  
                For rCnt = 0 To items.Size - 1  
                    Dim r As Map = items.Get(rCnt)  
                    For Each fk As String In fileFields.Keys  
                        Dim fv As String = fileFields.Get(fk)  
                        Dim fk1 As String = r.Get(fk)  
                        Dim pk1 As String = r.Get(PrimaryKey)  
                        fk1 = CStr(fk1).trim  
                        If fk1 <> "" Then  
                            Dim fk2 As String = $"${baseURL}/api/files/${sTableName}/${pk1}/${fk1}"$  
                            r.Put(fv, fk2)  
                            If GetFiles Then  
                                Dim fdata As String = BANano.Await(BANano.GetFileAsDataURL(fk2, Null))  
                                Dim bisBase64Image As Boolean = BANano.Await(isBase64Image(fdata))  
                                If bisBase64Image Then  
                                    r.Put(fk, fdata)  
                                Else  
                                    r.Put(fk, "")     
                                End If  
                            End If  
                        End If  
                    Next  
                    items.Set(rCnt, r)  
                Next  
            End If  
  
            result.AddAll(items)  
            page = page + 1  
        Loop  
  
    Catch  
        Log($"SELECT_ALL: ${LastException.message}"$)  
    End Try  
  
    RowCount = result.Size  
    lastPosition = -1  
    Return result  
End Sub
```

  
  
**USAGE**  
  

```B4X
Dim db As SDUIPocketBase  
…..  
banano.await(db.SELECT_ALL)  
Do While db.NextRow  
     Dim srecords As String = db.GetString("records")  
     Dim sprovinceid As String = db.GetString("provinceid")  
     Dim sprogrammeid As String = db.GetString("programmeid")  
     …..  
Loop
```

  
  
**COMPARISON**  
  
getFullList - 5000 records are all fetched at once and stored in RAM until garbage collection  
getList - 5000 records are fetched per batch, you can set the batch size for example 50-500 and garge collection executes after each batch fetch is done.  
  
Enjoy!