### PocketBase - RawInsert (A route/handler to execute INSERT SQL Commands) by Mashiane
### 08/19/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/168292/)

Hi Fam..  
  
[Background](https://www.b4x.com/android/forum/threads/pocketbase-rawselect-a-route-handler-to-execute-select-sql-commands.168257/)  
  
With this route / handler, you are able to execute inserts in your database using parameterized sql command. You can also specify which fields should be returned from the record that was added. Copy the attached file to your **pb\_hooks** directory and restart the app.  
  
Example SQL Statement generated internally.  
  

```B4X
INSERT INTO bma_course (name,startdate,enddate,manager,active,id,created,updated) VALUES ({:name},{:startdate},{:enddate},{:manager},{:active},{:id},{:created},{:updated})
```

  
  
![](https://www.b4x.com/android/forum/attachments/166142)  
  
  
**Usage**  
  
The path should contain the collection and the id you want to add. Predefined id are required to meet my use case  
  

```B4X
 http://127.0.0.1:1001/api/rawinsert/bma_course/n1234567898
```

  
  
Give it the body to add and the fields (optional) to return.  
  

```B4X
{  
    "record": {  
        "name": "Anele Testing Insert",  
        "startdate": "2025-01-01",  
        "enddate": "2025-12-31",  
        "manager": "123456",  
        "active": "true"  
    },  
    "fields": "id,name,manager"  
}
```

  
  
**Output**  
  

```B4X
{  
    "id": "n1234567898",  
    "manager": "123456",  
    "name": "Anele Testing Insert",  
    "success": true  
}
```