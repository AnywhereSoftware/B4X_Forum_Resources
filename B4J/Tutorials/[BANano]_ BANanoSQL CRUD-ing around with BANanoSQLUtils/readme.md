### [BANano]: BANanoSQL CRUD-ing around with BANanoSQLUtils by Mashiane
### 05/19/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/101880/)

Hi  
  
**UPDATE 2020-05-19:** [**Please use this library instead**](https://www.b4x.com/android/forum/threads/bananoconnect-bananosql-sqlite-mysql-mssql-library.117956/)  
  
[Source Code](https://www.b4x.com/android/forum/threads/banano-bananosql-crud-ing-around-with-bananosqlutils.101880/#post-639535)  
  
Honestly I am not qualified enough to write this tutorial, but anyway, its a shot. I want to use this for one of my backends and will share some things I have learned so far. I could be wrong in some things and stand to be corrected and advised. There is something I havent figured out yet and Im sure help will be provided.  
  
Anyway let me towards the point. I have written some subs here that are familiar with most experiences with DBUtils to Create,Read,Update and Delete records. The approach followed here is the one without the Wait(), I'm sure as soon as I figure that out. Well I need to figure how to use this in a real-world app.  
  
To understand the sequence, let me put my Firefox log herein…  
  
![](https://www.b4x.com/android/forum/attachments/76689)  
Steps and sequence of followed  
  
1. A database is created  
2. After its opened, a CreateTable method is called using a map. The map has field-names and field-types. You will remember this with dbUtils. The returned tag for the table creation is DB\_CREATE  
3. Sub SQL\_SQLExecuteResult(Tag As String, Result As List) is tracing and executing sub calls  
4. The table has a primary key, I tried to create indexes on other fields, dololo. Later perhaps.  
5. As I need to add a record to the table, it has a primary key, I need to first find if such a record exists, this is done with CheckFlight, this returns a DB\_EXISTS tag. This is just a select where clause. If the record does not exist the result will be Zero and if not 1. If the record exists, update it if not insert it. Inserts return DB\_INSERT tag whilst update returns DB\_UPDATE  
6. Just to demo, after the record is inserted, we update it. After it is updated, all the records are updated from East London to Israel with DB\_UPDATEALL tag  
7. Then a query to select an existing record is executed, this is done to return a map of the record. Its like ExecuteMap(s) in DBUtils. This is returned as an object{}, with DB\_SELECT  
8. Then we call a delete sub to delete the record.  
  
As noted above, the sequencing of events here is rather important.  
  
So there is it.  
  
1. Open DB  
2. Create Table  
3. **C**reate Record (DB\_INSERT)  
4. **R**ead Record (DB\_SELECT)  
5. **U**pdate Record (DB\_UPDATE)  
6. **D**elete Record (DB\_DELETE)  
  
Ta!