### SQLite 2 JavaScript / JSON by Mashiane
### 09/29/2019
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/110014/)

Ola  
  
I needed to embed a sqlite db as part of a web app i'm working on, but as JavaScript / JSON.  
  
This app helps with converting your sqlite db to javascript. This is useful when one wants to use the data for READ ONLY purposes, my case in point.  
  
1. Add the database that you want to be converted to the Files tab of the project  
2. Pass the name of the database on "sqlite.db"  
3. You have an option to include a. scheme, b. indexes. c. data and also generate individual js files for each table.  
4. The output is saved under /Objects folder. This can then be moved to your relevant project, in my case my BANano based WebApp.  
  
Usage:  
  

```B4X
Sub AppStart (Form1 As Form, Args() As String)  
    'RedirectOutput(File.DirApp, "sqlite2json.txt")  
    '  
    SQLite2JSON("sqlite.db",False,False,True,True)  
    '  
    'ViewFile(File.DirApp, "sqlite2json.txt")  
    ExitApplication  
End Sub
```

  
  
  

```B4X
'open the database file  
Sub SQLite2JSON(dbName As String, bIndexes As Boolean, bSchema As Boolean, bData As Boolean, bSeparate As Boolean)
```

  
   
Example output…  
  

```B4X
function GetBooksData(){  
return Books.data;  
}  
  
var Books = {  
    "data": [  
        {  
            "chapters": "50",  
            "bookname": "Book 1",  
            "bookid": "1"  
        },  
        {
```

  
  
4. Next I will include the js files (which will be minified) to my app and query with BANanoJSONJquery  
  
Ta!