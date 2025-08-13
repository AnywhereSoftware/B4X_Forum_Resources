### [SQL] DButils v.2.5 for SQLite and MySQL by peacemaker
### 10/11/2023
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/155152/)

One my project has to be using not only SQLite database (actually, two different ones, as separate classes), but MySQL also, due to big size that now is more convenient to see via web-browser remotely (without downloading big SQLite db file).  
  
So, i have combined 2 DBUtils modules:  

- latest DButils2 from Erel: <https://www.b4x.com/android/forum/threads/b4x-dbutils-2.81280>
- module with MySQL additions: <https://www.b4x.com/android/forum/threads/module-universal-dbutils.80569/>

  
It's not so good to switch the db type (SQLite or MySQL) during usage:  

```B4X
'MySQL additions:  
'Added to give EscapeField more flexibility  
Public Sub SetEscapeChars(MySQL As Boolean)  
    If MySQL Then  
        escapeCharStart = "`"  
        escapeCharEnd = "`"  
        isMySQL = True  
    Else  
        escapeCharStart = "["  
        escapeCharEnd = "]"  
        isMySQL = False  
    End If  
End Sub  
  
'usage:  
  
DBUtils2.SetEscapeChars(True)  
DBUtils2.InsertMaps(db.SQL, "sorting", L)[/CODE]  
  
, but it works in such complex project OK, tested.  
  
Please, post your suggestions how to modify for more easy and correct usage with both db kinds.
```