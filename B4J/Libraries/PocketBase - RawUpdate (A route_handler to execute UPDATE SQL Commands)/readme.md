### PocketBase - RawUpdate (A route/handler to execute UPDATE SQL Commands) by Mashiane
### 08/19/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/168295/)

Hi Fam  
  
[Background](https://www.b4x.com/android/forum/threads/pocketbase-rawselect-a-route-handler-to-execute-select-sql-commands.168257/#content)  
  
RawUpdate is a new addition to the pocketbase routes. Its purpose is to help anyone execute UPDATE SQL Commands directly to their pocketbase back-end.  
  
![](https://www.b4x.com/android/forum/attachments/166144)  
  
You need to drop the file to your pb\_hooks directly and you are able to execute the update commands  
  
Here you pass the collection you want..  
  

```B4X
 http://127.0.0.1:1001/api/rawupdate/bma_course
```

  
  
Then pass the body of the record to update. The filter works like your where clause.  
  

```B4X
{  
    "record": {  
        "name": "Anele Testing Insert4",  
        "manager": "123456fxxx",  
        "active": "false"  
    },  
    "filter": "id='n1234567898'",  
    "fields": "id,name,active"  
}
```

  
  
Output  
  

```B4X
{  
    "record": {  
        "id": "n1234567898",  
        "name": "Anele Testing Insert4",  
        "active": "false"  
    },  
    "success": true  
}
```