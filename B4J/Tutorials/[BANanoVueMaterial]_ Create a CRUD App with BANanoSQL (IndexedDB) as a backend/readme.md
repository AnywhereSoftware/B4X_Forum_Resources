### [BANanoVueMaterial]: Create a CRUD App with BANanoSQL (IndexedDB) as a backend by Mashiane
### 06/29/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/114086/)

Ola  
  
NB: First set up [BANanoVueMaterial](https://github.com/Mashiane/BANanoVueMaterial) The code for this tutorial is under the folder **4. Examples\6. Form Utilities**  
  
[MEDIA=youtube]MIFm3jUuZxM[/MEDIA]  
  
This tutorial will take you through the process of creating a CRUD app with BANanoVueMaterial and using BANanoSQL (IndexedDB) as a backend.  
  
Previously we looked at how we can create a CRUD app using MySQL as a backend. For more details about that, go [here](https://www.b4x.com/android/forum/threads/bananovuematerial-creating-expenses-show-a-crud-expense-tracker-with-mysql-backend-part-1.114028/).  
  
If you have been following my posts, I started talking about [BANanoSQLUtilities](https://www.b4x.com/android/forum/threads/banano-bananosql-crud-ing-around-with-bananosqlutils.101880/) in January 2019. Those utilities were helper functions that enable one to build [SQL](https://www.b4x.com/glossary/sql/) commands for BANanoSQL. We later updated these and called the helper class BANanoAlaSQL. Some articles were also written using it.  
  
![](https://www.b4x.com/android/forum/attachments/88823)  
  
So here wer are using the same class to speak to BANanoSQL. We will:  
  
1. Create Records  
2. Read Records  
3. Update existing records  
4. Delete records.  
  
For that we are creating a simple table and just saving records to it using BANanoSQL. The code here is similar to our code in creating a CRUD app using MySQL however we are using BANanoSQL.