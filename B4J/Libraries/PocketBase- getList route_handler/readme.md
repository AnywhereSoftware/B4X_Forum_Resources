### PocketBase- getList route/handler by Mashiane
### 08/23/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/168351/)

Hi Fam  
  
In **PocketBase**, getList is a client method used to **retrieve a paginated list of records** from a collection.  
[HEADING=2][SIZE=4]How it works[/SIZE][/HEADING]  

- You specify the collection name (or ID).
- You provide pagination parameters (page, perPage).
- You can optionally add a filter, sort order, and expand relations

**It returns an object containing**  

- page → current page number
- perPage → number of items per page
- totalItems → total number of records in the collection (that match your filter)
- totalPages → total number of pages
- items → array of record objects (the actual data)

```B4X
const pb = new PocketBase('http://127.0.0.1:8090');   
// fetch a paginated records list   
const resultList = await pb.collection('posts').getList(1, 50, {    filter: 'created >= "2022-01-01 00:00:00" && someField1 != someField2', });
```

  
  
Whilst on this customized getList you cannot use expand, however it is created based on the same methodology. The reason we had to built our own is because with pocketBase, all cases of record selection execute a SELECT \* and then return the columns you need if the fields parameter is specified.   
  
With this getList, the fields you specify in fields parameter are the ones that will be used in your select sql command.   
  
Also this getList will execute some extra code. If you have file fields in your collection, e.g. a field called **document**, it will return an extra field named **documenturl**, with the full url of the file and the "document" will contain a base64 string of the file. After a file is saved in a collection, your file field stores text made of the file name and not the actual file content. The file content is stored in the pb\_data/storage folder, using the collection id, record id and the newly generated file name. To get the file contents when you have files in your collection, set *getFiles to true, so that your call returns the base64 string of your file.*  
  
With fullList true, the getList works like getFullList where all the records of your collection are got using the parameters you have specified. IffullList is false, only the page you specified in page parameter is read and returned, based on the parameters you specify.  
  
![](https://www.b4x.com/android/forum/attachments/166258)