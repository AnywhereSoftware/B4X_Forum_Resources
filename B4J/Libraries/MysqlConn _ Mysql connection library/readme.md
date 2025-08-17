### MysqlConn : Mysql connection library by Justcooldev
### 05/12/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/147946/)

Hi !  
  
New library ! MysqlConn. It is fully written in B4X !  
  
This library is compatible with **B4J & B4A.** It depends on OkHttpUtils2 and a PHP Script.  
  
PHP Script :   

```B4X
<?php  
$host_name = $_GET['Hostname'];  
$database = $_GET['DbName'];  
$user_name = $_GET['username'];  
$password = $_GET['password'];  
  
$link = mysqli_connect($host_name, $user_name, $password, $database);  
  
if ($_GET['Type'] == 'Test') {  
  if ($link->connect_error) {  
    die(0);  
  } else {  
    echo 1;  
  }  
} elseif ($_GET['Type'] == 'QueryNoResults') {  
  $query = $link->query($_GET['Query']);  
  if ($query) {  
    echo '1';  
  } else {  
    echo '0';  
  }  
} elseif ($_GET['Type'] == 'QueryResults') {  
  $query = mysqli_query($link, $_GET['Query']);  
  $rows = array();  
  while($r = mysqli_fetch_assoc($query)) {  
    $rows[] = $r;  
  }  
  $res = json_encode($rows);  
   echo $res;  
   mysqli_free_result($query);  
}  
?>
```

  
  
**Functions :**  

1. Initialize
2. QueryNoResults
3. QueryResults
4. MysqlResultSet
5. GetString
6. GetDouble
7. GetInt

  
**Events :**  

1. EventName\_QueryResultsDone(Result As List)
2. EventName\_QueryNoResultsDone(Result As Boolean)

  
GetBlob is not supported for now… I'm currently working on it.  
  
I'm attaching the project for **B4J & B4A** And The source code too.  
  
I don't know if it is compatible with **B4I**.  
  
**IMPORTANT** : This library is **BETA,** it seems sometimes, you will find some bugs, if you find one, please report it and start a new thread for your question ! Thank you for your help.  
  
Hope you will enjoy it !