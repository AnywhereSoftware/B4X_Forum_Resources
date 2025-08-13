### Emigrate Mysql to Sqlite DB by Situ LLC
### 01/02/2023
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/140161/)

Fellows.  
   
Here, this is a small app to migrate From DB MySQL to SQLite  
  
  
  
  
Work in B4A / B4J  
  
Its very simple, just checks the additional .jar  
  
Add: MySQL-connector-java-8.0.26.jar   
  
And this one is already included in the core of B4J SQLite-JDBC-3.7.2.jar  
  
  
  
Finally, put your data connection  
  
 Dim host As String = "LOCAL/IP"  
 Dim database As String = "Mysql\_DB"  
 Dim usuario As String = "My\_user"  
 Dim password As String = "My\_pasword"  
  
 And Wait a lithe while, and see the magic emigration  
 Enjoy