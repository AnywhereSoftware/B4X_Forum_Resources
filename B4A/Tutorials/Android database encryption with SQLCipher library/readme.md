### Android database encryption with SQLCipher library by Erel
### 07/20/2025
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/14965/)

**Edit: this library isn't compatible with the 16KB page size requirement. Don't use it.**  
  
[SQLCipher](http://sqlcipher.net/) is an open source project that extends SQLite and adds full database encryption.  
License: <https://www.zetetic.net/sqlcipher/open-source/>  
  
B4A SQLCipher is a special subtype of SQL object. There is almost no need to change any code in order to switch from regular SQL to SQLCipher.  
  
The only difference between SQL API and SQLCipher API is the Initialize method.  
SQLCipher.Initialize expects two additional values: Password and a second parameter that is not used (it was used in the past).  
  
Password is the database password. You can pass an empty string if there is no password. Note that it is not possible to change the password (or set a new password) to an existing database.  
  
**Code changes required to convert from SQL to SQLCipher**  
- Declare the SQL object as SQLCipher.  
- Change the initialize code to:  

```B4X
SQL1.Initialize(File.DirRootExternal, "1.db", True, DB_PASSWORD, "")
```

  
  
V1.70  

- Based on SQLCipher v4.5.4: <https://www.zetetic.net/blog/2023/04/27/sqlcipher-4.5.4-release/>

V1.60  

- Based on SQLCipher v4.00: <https://www.zetetic.net/blog/2018/11/30/sqlcipher-400-release/>
- Includes 64 bit binaries and emulator binaries.
- Requires B4A v8+.
- Library is attached.
- **Not compatible by default with databases created with older versions.** See this link: <https://www.zetetic.net/blog/2018/11/30/sqlcipher-400-release/#compatibility>

V1.50  

- Based on SQLCipher v3.59
- Supports targetSdkVersion 26.
- The icu.zip file is no longer required. You can delete it from the Files folder.
- It is no longer required to disable the debugger virtual assets feature.
Remove this line: #DebuggerForceStandardAssets: True- Old version: [www.b4x.com/android/files/SQLCipher150.zip](https://www.b4x.com/android/files/SQLCipher150.zip)

  
Depends on: <https://repo1.maven.org/maven2/net/zetetic/android-database-sqlcipher/4.5.4/android-database-sqlcipher-4.5.4.aar>  
You should download and copy it to the additional libraries folder.