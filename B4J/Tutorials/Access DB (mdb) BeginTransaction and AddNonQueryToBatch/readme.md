### Access DB (mdb) BeginTransaction and AddNonQueryToBatch by LucaMs
### 03/01/2024
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/159612/)

I spent quite a bit of time tracking down an error that… wasn't in my project. To prevent you from doing it too…  
  
I had to insert many records into an Access table.  
  
I used a transaction (BeginTransaction).  
The project produced no errors, but the table was empty.  
  
I also tried AddNonQueryToBatch; even with this no errors but also no data in the table.  
  
Apparently these two types of operations do not work with ucanaccess and mdb files.  
  
Running the insert queries in a "normal" manner, everything worked.