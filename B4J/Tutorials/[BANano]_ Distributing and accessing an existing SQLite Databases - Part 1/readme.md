### [BANano]: Distributing and accessing an existing SQLite Databases - Part 1 by Mashiane
### 05/23/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/102110/)

Ola  
  
[Part 2](https://www.b4x.com/android/forum/threads/bananosqliter-distributing-and-accessing-an-existing-sqlite-databases-part-2.118131/)  
  
**[UPDATE: BANanoSQLite now available for actual sqlite db CRUD](https://www.b4x.com/android/forum/threads/bananosqlite-sqlitedb-php-crud-class-for-banano.107461/#post-671858) using PHP**  
  
I've been wondering if I could be able to do this as I want to distribute my app with an already existing SQLite.DB database for READONLY access. No, this is not WebSQL but a pure SQLite database.  
  
At first I thought perhaps if I could convert the db to json and then read it like that I would have a nice solution, well that is for another day.  
  
For this to work, your SQLite.db should be:  
  
1. Copied to your Files tab. This will be copied to your assets folder of your BANano App.  
2. The app SHOULD RUN from a WEBSERVER. Accessing local files is blocked by CORS, perhaps if one can figure out how to access './assets/sqlite.db' it could be better. I would love that.  
3. I want to do this with the built in BANano.CallAJax method though. Still learning the ropes. Would be nice. Perhaps one of the gurus here can provide some green lights.  
4. The built in alaSQL for BANanoSQL has a way to attach sqlite databases, I have not been able to figure it out yet. A topic for another day.  
  
Here is the output of my very own database selecting 1 table..  
  
![](https://www.b4x.com/android/forum/attachments/76929)  
  
Reproduction:  
  
You need Ajax..  
  

```B4X
#if javascript  
var db;  
var SQL = window.SQL;  
function OpenDB(that){  
    var xhr = new XMLHttpRequest();  
    xhr.open('GET', that, true);  
    xhr.responseType = 'arraybuffer';  
    xhr.onload = function(e) {  
          var uInt8Array = new Uint8Array(this.response);  
          db = new SQL.Database(uInt8Array);  
          var contents = db.exec("SELECT * FROM Analysis");  
        console.log(contents);  
    };  
    xhr.send();  
}  
#End If
```

  
  
Then I call it…  
  

```B4X
BANano.RunJavascriptMethod("OpenDB",Array As String("./assets/bibleshow.db"))
```

  
  
By the way, you will need this [github](https://github.com/kripken/sql.js) project.  
  
Ta!  
  
PS: Use at own risk. :D