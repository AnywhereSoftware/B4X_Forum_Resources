### PocketBase - RawSelect (A route/handler to execute SELECT SQL Commands) by Mashiane
### 08/22/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/168257/)

Hi Fam  
  
*Compatibility: v22.35 and below*  
  
In b4j we have a way of adding routes and writing handler code, same with PocketBase. In PocketBase, one is able to create handlers via javascript and then publish these in the **pb\_hooks** directory and then restart the app to make them live.  
  
So, to execute a select sql command, one is able to create a POST like this  
  

```B4X
 http://127.0.0.1:1001/api/rawselect
```

  
  
And in the body enter the SELECT SQL Command like this  
  

```B4X
"query": "select id, provinceid, programmeid, count(*) as records, isyouth,created from bma_beneficiary where onmaster = 'true' group by isyouth, provinceid"
```

  
  
**NB: Boolean Casting - fields starting with is,has,can & those ending with active,enabled,disabled are treated as boolean.**  
  

```B4X
// Boolean-ish names  
if (  
  /^(is|has|can)[a-z0-9_]*$/.test(nl) ||  
  /(active|enabled|disabled)$/.test(nl)  
)  
  return false;
```

  
  
**The Result**  
  

```B4X
{  
    "items": [  
        {  
            "id": "iriincbo2dawhs4",  
            "isyouth": false,  
            "programmeid": "iboxnkim1dnftwa",  
            "provinceid": "i792vo4vxocwkyd",  
            "records": 28,  
            "created": "2024-07-19 12:44:59.459Z"  
        },  
        {  
            "id": "sy3x19wk0524dpc",  
            "isyouth": false,  
            "programmeid": "iboxnkim1dnftwa",  
            "provinceid": "iozxdk2lymyixsb",  
            "records": 1,  
            "created": "2025-03-24 19:37:59.174Z"  
        },  
        {  
            "id": "iookrqdfole9gqn",  
            "isyouth": false,  
            "programmeid": "iboxnkim1dnftwa",  
            "provinceid": "iql8k8yujpwkdrr",  
            "records": 80,  
            "created": "2024-09-02 07:44:52.772Z"  
        },  
        {  
            "id": "i83wfnpix48c77s",  
            "isyouth": false,  
            "programmeid": "iboxnkim1dnftwa",  
            "provinceid": "iqxojxo2fqtlrmq",  
            "records": 45,  
            "created": "2024-06-20 23:20:11.286Z"  
        },  
        {  
            "id": "ibgymsvogswykly",  
            "isyouth": true,  
            "programmeid": "iboxnkim1dnftwa",  
            "provinceid": "i792vo4vxocwkyd",  
            "records": 152,  
            "created": "2024-07-19 12:44:59.081Z"  
        },  
        {  
            "id": "ifes6vp1yscppqa",  
            "isyouth": true,  
            "programmeid": "iboxnkim1dnftwa",  
            "provinceid": "iql8k8yujpwkdrr",  
            "records": 676,  
            "created": "2024-06-20 23:20:14.417Z"  
        },  
        {  
            "id": "i8iytaaugyqbeap",  
            "isyouth": true,  
            "programmeid": "iboxnkim1dnftwa",  
            "provinceid": "iqxojxo2fqtlrmq",  
            "records": 274,  
            "created": "2024-06-20 23:20:10.075Z"  
        }  
    ],  
    "perPage": 50,  
    "totalItems": 7,  
    "totalPages": 1  
}
```

  
  
**Why such routes?**  
  
A careful study of what happens behind the scenes in pocketbase necessiated this for my use case. A lot happens with PocketBase due to the added back-end security features it has.  
A look at the SDK calls and thus the API calls, indicate that in most or almost all cases, a **SELECT \* will take place.**  
  
At times I just need the columns I need without the whole row contents.  
  
![](https://www.b4x.com/android/forum/attachments/166141)  
  
**Views**  
  
I had earlier discussed how one can do something similar by creating a "view", however this time around, we don't want any view created but just fire a SQL command directly. This could be useful where you just want to execute an sql command that could be dynamic. We have limited this route to SELECT statements only.  
  
Automatically it detects from your select which fields you need etc etc.  
  
<https://www.b4x.com/android/forum/threads/pocketbase-speeding-up-your-app-with-views-own-sql-commands-even-at-run-time.167987/#content>  
  
The nice thing about a view is that you just have to run getList / getFullList by passing it the view name to get its results, as it stays permanent on your database until you delete the view.  
  
**How to use:**  
  
Unzip the file to your pb\_hooks directory.  
  
Restart your pocketbase.  
  
Execute a POST request to your API path, example. "<http://127.0.0.1:1001/api/rawselect>", the body of your request should be your SQL command.  
  
Example…  
  

```B4X
{  
    "query": "select id, provinceid, programmeid, count(*) as records, isyouth,created from bma_beneficiary where onmaster = 'true' group by isyouth, provinceid"  
}
```

  
  
![](https://www.b4x.com/android/forum/attachments/166067)  
  
All in all, we are in an attempt to speed up our back-end and thus front end.  
  
Have fun!