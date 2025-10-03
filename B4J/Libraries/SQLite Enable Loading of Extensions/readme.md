### SQLite Enable Loading of Extensions by tchart
### 10/01/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/168873/)

**NOTE this is for B4J only** (Erel has stated that you can't enable extension loading on Android/iOS - [link](https://www.b4x.com/android/forum/threads/how-to-use-sqlite3_load_extension.160820/post-987073))  
  
Small Java library with two methods that enable or disable loading of extensions for SQLite.  
  

- EnableLoading(SQL) - enable loading of SQLite extensions
- DisableLoading(SQL) - disable loading of SQLite extensions

  
You can get some precompiled extensions here.  
  
<https://github.com/nalgeon/sqlean>  
  
Extensions must be in the same folder as your JAR (or Objects folder during debug) - alternatively (not tested) you can use the full path when calling load\_extension. You must load the correct library for your OS (eg DLL for Windows and SO for Linux)  
  
How to use;  
  

```B4X
Dim SQL As SQL  
SQL.InitializeSQLite(File.DirApp,"Test.sqlite",True)  
  
Log(SQL.IsInitialized)  
  
Dim e As EnableSQLiteExtensions  
  
e.EnableLoading(SQL) ' Enable loading  
SQL.ExecNonQuery("SELECT load_extension('crypto.dll')") ' Extension should be in the same folder as your JAR or Objects folder  
e.DisableLoading(SQL) ' You can disable loading once you have loaded your extension  
  
Log(SQL.ExecQuerySingleResult("select hex(crypto_md5('abc'));"))
```