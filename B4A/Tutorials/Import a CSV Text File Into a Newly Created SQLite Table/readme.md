### Import a CSV Text File Into a Newly Created SQLite Table by Mahares
### 09/06/2023
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/150342/)

1. I use StringUtils library to import the CSV text file into the SQLite table. There are other ways to import like, such as CSVParser class module, RegEx.Split and TextReader, although TextReader is no longer recommended by the community.  
2. The text file in this project has a semi colon as delimiter. With StringUtils, you can use whatever delimiter came with the file.  
3. The column names of the table created are generated from the first row of the text file which is the header,  
4. The project is enhanced by checking if there are any records before the import takes place, in order not to waste time importing every time.  
5. The attached B4XPages project is tested in B4A and B4J.  
The most relevant code snippets are:  

```B4X
Dim su As StringUtils  'stringutils lib checked  
MyList =  su.LoadCSV2(File.dirassets, filename, ";", Header)  'header and MyList are lists  
strQuery=$"CREATE TABLE IF NOT EXISTS  data ( ${Header.Get(0)} INTEGER PRIMARY KEY, ${Header.Get(1)} TEXT, ${Header.Get(2)} TEXT, ${Header.Get(3)} REAL, ${Header.Get(4)} REAL) "$  
SQL.ExecNonQuery(strQuery)
```

  

```B4X
strQuery="INSERT OR IGNORE INTO data VALUES(?, ?, ?, ?, ?)"  
 For Each s() As String In MyList  
        SQL.ExecNonQuery2(strQuery, s)  
 Next
```