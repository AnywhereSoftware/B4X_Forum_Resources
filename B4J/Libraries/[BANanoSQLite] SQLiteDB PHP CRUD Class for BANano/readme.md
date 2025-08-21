### [BANanoSQLite] SQLiteDB PHP CRUD Class for BANano by Mashiane
### 05/19/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/107461/)

Ola  
  
**UPDATE 2020-05-19:** [**Please use this library instead**](https://www.b4x.com/android/forum/threads/bananoconnect-bananosql-sqlite-mysql-mssql-library.117956/)  
  
Update: [BANanoSQLite1 Example](https://github.com/Mashiane/BANanoWebix/tree/master/4.%20BANanoSQLite1%20Example)  
  
[**If you are opting for MySQL connectivity, BANanoMySQL is available here.**](https://www.b4x.com/android/forum/threads/bananomysql-an-inline-php-class-for-your-mysqli-crud-functionality.106858/#content)  
  
My journey finally has led me to complete a basic wrapper that one can use for PHP SQLite access.  
  
![](https://www.b4x.com/android/forum/attachments/81987)  
  
![](https://www.b4x.com/android/forum/attachments/81985)  
  
Initially, we tried…  
  
[Distributing and Accessing SQLite Databases](https://www.b4x.com/android/forum/threads/banano-distributing-and-accessing-an-existing-sqlite-databases-part-1.102110/#content)  
  
However, the parent of this class here is [Exploring and Using PHP and SQLite for your BANano WebApp](https://www.b4x.com/android/forum/threads/banano-exploring-using-php-sqlite-for-your-webapp.103571/#content) as this continues on this note.  
  
For reference, one can also look at [BANanoMySQL](https://www.b4x.com/android/forum/threads/bananomysql-an-inline-php-class-for-your-mysqli-crud-functionality.106858/#content), a class and PHP script for MySQL PHP CRUD functionality.  
  
So in the same light, we explore, INSERT, SELECT, UPDATE and DELETE for SQLite dbs located in the server via PHP. This works just like BANanoMySQL as one needs to indicate the field types that they are processing when running queries.  
  
I am using XAMPP for testing my developments, so first things first.  
  
Open PHP.INI and edit the line to activate sqlite3 functionality…  
  

```B4X
extension=sqlite3
```

  
  
You will also need BANanoSQLite attached in this demo. Let's look at the CRUD statements to complete this task…  
  
Again, we look at parameter based statements to work with our database. We will create a database, create a table, insert some records, select them and delete some.  
  
**PHP Prepared Statements**  
  

```B4X
function prepareStatement($db, $sql, $types, $values) {  
        /* Bind parameters. Types: s = string, i = integer, d = double,  b = blob */  
        $stmt = $db->prepare($sql);  
        $n = count($types);  
        for($i = 0; $i < $n; $i++) {  
            $param_type = $types[$i];  
            $param_value = $values[$i];  
            $loc = $i + 1;  
            switch($param_type){  
                case "s":  
                    $stmt->bindValue($loc, '$param_value', SQLITE3_TEXT);  
                    break;  
                case "i":  
                    $stmt->bindValue($loc, $param_value, SQLITE3_INTEGER);  
                    break;  
                case "d":  
                    $stmt->bindValue($loc, $param_value, SQLITE3_FLOAT);  
                    break;  
                case "b":  
                    $stmt->bindValue($loc, $param_value, SQLITE3_BLOB);  
                    break;  
            }  
        }  
        return $stmt;  
}
```

  
  
This is the function that builds up our prepared statement for SQLite…  
  
The Engine that does everything…  
  

```B4X
function BANanoSQLite($dbname,$data) {  
       $db;  
    //set the header  
    header('content-type: application/json; charset=utf-8');  
       $db = new SQLite3($dbname);  
    if(!$db) {  
          $response = $db->lastErrorMsg();  
          $output = json_encode(Array("response" => $response));  
          die($output);  
    }  
    //data Is json, set it As a php variable  
    $data = json_decode($data, True);  
    //get the command To execute  
    $command = $data["command"];  
    $sql = $data["sql"];  
    $values = $data["args"];  
    $types = $data["types"];  
    $fields = $data["fields"];  
    switch($command){  
        Case "select":  
            $res = $db->query($sql);  
            $rows = Array();  
            while($row = $res->fetchArray()) {  
                $rows[] = $row;  
            }  
            $output = json_encode(array("response" => "OK", "data" => $rows));  
              echo $output;  
            break;  
        case "deletewhere":  
            //build the prepared statement  
            $stmt = prepareStatement($db, $sql, $types, $values);  
            $res = $stmt->execute();  
            $affRows = $db->changes();  
            $output = json_encode(array("response" => "OK", "data" => $affRows));  
              echo $output;  
            break;  
…..  
…..  
…..
```

  
  
As noted above, when we call BANanoSQLite, the db, if it does not exist is created, if it does, it gets opened…  
  
Let's look at the usage…  
  
We define a few parameters..  
  

```B4X
Dim sqlite As BANanoSQLite  
    sqlite.Initialize  
    dbName = $"${AppName}.db"$
```

  
  
Let's look at some other things…  
  
**How to use this class?**  
  
In *Process Globals* I have defined a variable..  
  

```B4X
Public AppName As String = "BANanoSQLiteDemo"
```

  
  
In *AppStart* of your BANanoApp, define your php paramaters for your SQLite database connection..  
  

```B4X
'set php settings  
    BANano.PHP_NAME = "bananosqlite.php"  
    BANano.PHPHost = $"http://localhost/${AppName}/"$  
    BANano.PHPAddHeader("Access-Control-Allow-Origin: *")
```

  
  
In *BANano\_Ready*, let's created the needed tables for our SQLite db, the database will be created on the root of your server for the app.  
  

```B4X
Dim sqlite As BANanoSQLite  
    sqlite.Initialize  
    dbName = $"${AppName}.db"$
```

  
  
  
  
**NB: The lib will be loaded soon for us to enjoy…**