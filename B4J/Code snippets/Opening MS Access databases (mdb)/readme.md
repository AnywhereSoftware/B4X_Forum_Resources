### Opening MS Access databases (mdb) by Erel
### 11/24/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/107963/)

1. Download UCanAccess: <https://www.b4x.com/b4j/files/ucanaccess.zip>  
(Sources: <https://jackcessencrypt.sourceforge.io/> and <http://ucanaccess.sourceforge.net/site.html>)  
The libraries are licensed with Apache 2.0 license: <http://www.apache.org/licenses/LICENSE-2.0>  
  
2. Copy the jars to the additional libs folder.  
3. Add:  

```B4X
#AdditionalJar: ucanaccess-5.0.0  
#AdditionalJar: commons-lang3-3.8.1  
#AdditionalJar: commons-logging-1.2  
#AdditionalJar: hsqldb-2.6.1  
#AdditionalJar: jackcess-3.0.1-B4J  
#IgnoreWarnings: 15
```

  
4. There are four text files inside the zip file. Add them to the project Files folder.  
5. Open the database:  

```B4X
'SQL object from jSQL library  
sql.Initialize("net.ucanaccess.jdbc.UcanaccessDriver", "jdbc:ucanaccess://C:/Users/H/Downloads/1.accdb") 'change path as needed
```