### PocketBase: Speeding up your App with Views / Own SQL Commands even at Run-Time. by Mashiane
### 07/29/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/167987/)

Hi Fam  
  
The nice thing about views in PocketBase is that they allow one to feed their own sql statements and create views which are read only representation of your underlying sqlite data. They are fast. You can also create them in run-time.  
  
I have some dashboards that are based on the same repetetive data on my db. So i thought why not create views for them. Thing is, the information from the views should return the same content i.e. fields etc but need to receive different parameters.  
  
As collections are secure, one needs admin auth priviledges to create, update, delete them. So to do this, first fire up admin authorisation, store your token, each time you create your view, check if the token is valid, if not refresh it to get a new token and pass that as an bearer authorization in the header of your call.  
  
I am using BANanoFetch via the javascript sdk of pocketbase, v22.34 in my case. So this is my code to create a view.  
  
**CREATING A VIEW**  
  

```B4X
'<code>  
'pbComponents.CREATE_VIEW("viewname", "select id, name from…")  
'pbComponents.SELECT_VIEW("viewname")  
'Do While pbComponents.NextRow  
'Dim rec As Map = pbComponents.Record  
'Dim sid As String = pbComponents.GetString("id")  
'Loop  
'</code>  
Sub CREATE_VIEW(nameOf As String, qry As String)  
    If ShowLog Then  
        Log($"SDUIPocketBase.CREATE_VIEW(${nameOf})"$)  
    End If  
    Try  
        SetAuthorizationBearerToken(UserToken)  
        Dim col As Map = CreateMap()  
        col.Put("name", nameOf)  
        col.Put("type", "view")  
        col.Put("system", False)  
        col.Put("listRule", "")  
        col.Put("viewRule", "")  
        col.Put("createRule", Null)  
        col.Put("updateRule", Null)  
        col.Put("deleteRule", Null)  
        PutRecursive(col, "options.query", qry)  
        '  
        Dim opt As Map = CreateMap()  
        opt.Put("cache", "no-store")  
        If headers.Size > 0 Then opt.Put("headers", headers)  
        '  
        BANano.Await(client.GetField("collections").RunMethod("create", Array(col,opt)))  
    Catch  
        Log($"CREATE_VIEW: ${LastException.message}"$)  
    End Try  
End Sub
```

  
  
Creating a view like this will return an error if the view exists, so you can either delete it first / update it.  
  
Let's branch off a little.  
  
**DELETING A VIEW/COLLECTION**  
  
Views are considered as collections in PocketBase so one can use the same code to delete a view / collection. Also due to security measures, you need to give this an auth token to work.  
  

```B4X
'Removes the key and value mapped to this key.  
'<code>  
'Dim b As Boolean = BANano.Await(pb.DELETE_COLLECTION("a"))  
'</code>  
Sub DELETE_COLLECTION(colName As String) As Boolean  
    If ShowLog Then  
        Log($"SDUIPocketBase.DELETE_COLLECTION(${colName})"$)  
    End If  
    If Schema.Size = 0 Then  
        BANano.Throw($"SDUIPocketBase.DELETE_COLLECTION: ${colName} - please execute SchemaAdd?? first to define your table schema!"$)  
        Return False  
    End If  
    Try  
        SetAuthorizationBearerToken(UserToken)  
        Dim opt As Map = CreateMap()  
        opt.Put("cache", "no-store")  
        If headers.Size <> 0 Then  
            opt.Put("headers", headers)  
        End If  
        Dim r As Boolean = BANano.Await(client.GetField("collections").RunMethod("delete", Array(colName,opt)))  
        Return r  
    Catch  
        Log($"DELETE_COLLECTION: ${LastException.message}"$)  
        Return False  
    End Try  
End Sub
```

  
  
**CONTINUE….**  
  
In our view creation code, we need to pass it a valid view name i.e. collection name and then a valid SQL command. Always consider SQL injection here, and because only authorized users can manipulate views, that adds some level of comfort, but things can always go wrong.  
  
**TYPICAL USAGE**  
  
So this is what I do…  
  
1. I read all the names of collections in my db and store this on a variable called vnames. This is a list.  
2. When I need to call a view so that I can feed its content to a dashboard widget.  
3. I find out if my token is valid, if not I refresh it. I have previously ran an admin auth script before somewhere.  
4. I structure my collection name and SQL query to run. Remember always group your OR clauses. Phew.  
5. If the view name does not exist in my current collections list, I create it with CREATE\_VIEW  
6. Then I call SELECT\_VIEW to get the view records. This is exactly like other SELECT\_ALL/SELECT\_WHERE clauses in the PocketBase class for normal tables.  
  

```B4X
app.ShowSwalInfoToast("Counting signed contracts…", 3000)  
        Dim pbValid As Boolean = db.USER_ISVALID  
        If pbValid = False Then banano.Await(db.ADMIN_AUTH_REFRESH)  
        Dim qry As String = $"select id, provinceid, programmeid, count(*) as records from bma_beneficiary where ((signature <> '') or (signaturefile <> '')) and provinceid = '${provID}' and programmeid = '${progID}' group by provinceid, programmeid"$  
        Dim vname As String = $"signed_contracts_${provID}_${progID}"$  
        If vnames.IndexOf(vname) = -1 Then banano.Await(db.CREATE_VIEW(vname, qry))  
        banano.Await(db.SELECT_VIEW(vname))  
        Dim records As Int = db.GetRecordsCount  
        signedContractsCard.Value = records  
        signedContractsCard.Refresh
```

  
  
**ADVANTAGES**  
  
1. You don't have to execute a REST API call to filter the records you need each time, everything is done inside the read-only view.  
2. The view will be created once and then executed each time you call it to show your records  
3. A faster UI response especially when fields you use in views are indexed. Also compound indexes help a great deal.