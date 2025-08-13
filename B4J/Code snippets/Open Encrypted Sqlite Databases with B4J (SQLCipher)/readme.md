### Open Encrypted Sqlite Databases with B4J (SQLCipher) by mcqueccu
### 08/09/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/162466/)

Download the JDBC from this [**GitHub**](https://github.com/willena/sqlite-jdbc-crypt/releases), and place it in your Additional folder  
  
In your Main Module, use **#AdditionalJar** to add your jdbc.  
  
**Add JSQL library**  
  
The following JDBC has been tested and works fine. You can use any of them  
'#AdditionalJar: sqlite-jdbc-3.30.0  
'#AdditionalJar: sqlite-jdbc-3.31.1  
'#AdditionalJar: sqlite-jdbc-3.35.5.1  
  
'Using the latest Version, you need to download and Add the slf4j API, otherwise you will get Class not found Error  
#AdditionalJar: sqlite-jdbc-3.46.0.0  
#AdditionalJar: slf4j-api-1.7.36  
  
Find Example Attached