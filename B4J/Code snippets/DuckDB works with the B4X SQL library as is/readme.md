###  DuckDB works with the B4X SQL library as is by William Lancee
### 11/20/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/169385/)

Last September I started taking a course on Machine Learning.  
This field is moving so fast that the text book\* is already on the third edition which was published in 2023.  
So it's probably already out of date.  
\* "Hands-On Machine Learning with Scikit-Learn, Keras & TensorFlow" by Aurélien Géron  
  
As seen from the title of the book, it is based on Python Scikit-Learn library, as most Machine Learning systems are.  
I have a working knowledge of Python and B4X PyBridge makes it easy to interface with it. However, I was not familiar with  
the favorite database management system that is used in this field: 'DuckDB'. Why DuckDB?  
  
It has a column based structure as opposed to row-based used by MySQL, SQLLite and others.  
This makes it superfast in retrieval of column data for analytical purposes such as summary statistics.  
DuckDB provides a rich SQL dialect with advanced features such as arbitrary and nested correlated subqueries,  
window functions, collations, and support for complex types like arrays and map.  
It also has a good integration with Python Pandas DataFrames, which are critial data structures in Machine Learning.  
<https://duckdb.org/why_duckdb>  
  
Since DuckDB uses SQL syntax, I wondered if it would work with the B4X SQL library. And it does, out of the box.  
All you need is "#AdditionalJar: duckdb\_jdbc-1.4.2.0" in your Project Attributes and a copy of duckdb\_jdbc-1.4.2.0 in your AdditionalLibraries Folder.  
 You can download a copy from: <https://duckdb.org/install/?platform=windows&environment=java>  
  
Here are some usage examples, include standard libraries: DBUtils and jSQL  
These are B4J examples. I have not tested it with B4A. Since the Library is Java, it won't work as is on B4i (although there is an API for C and C++).  
Note that if you want to hide DBUtils logs from showing, add DBUTILS\_NOLOGS to your configuration 'Additional Symbols' field.  
  
The example project duckDB\_v5.zip is attached  
  
Finally, I searched DuckDB on the Forum and got no hits - except one reference in the 'ollama' Library. Please let me know if I missed an important reference.'  
Edit: [USER=74499]@aeric[/USER] provided this link to a previous post of DuckDB: <https://www.b4x.com/android/forum/threads/duckdb-anyone-tried.162155/>  
  

```B4X
Sub Example  
'In Gobals Sub:  
'    Private SQL As SQL  
'    Private dbPath As String = File.DirApp & "/my_analytics.duckdb" ' Path for persistent database file (I defined it as the Objects sub folder of the project)  
  
    Log("Starting Example")  
    Dim markTime As Long = DateTime.now  
    Try  
        ' "jdbc:duckdb:" for an in-memory database or "jdbc:duckdb:file.duckdb" for a file  
        SQL.Initialize("org.duckdb.DuckDBDriver", "jdbc:duckdb:" & dbPath)  
    Catch  
        Log(LastException.Message)  
    End Try  
    Log((DateTime.Now - markTime) & TAB & "Completed SQL.Initialize")  '232msecs  
  
    Dim markTime As Long = DateTime.now  
    Dim fldInfo As List = makeDB("CREATE OR REPLACE TABLE table1 (Random_Number INTEGER)")   'ignore  
    Log((DateTime.Now - markTime) & TAB & "Created Table")  '11 msec  
  
    Log(fldInfo)  
    '(ArrayList) [[IsInitialized=true, FieldName=Random_Number, DataType=INTEGER, CanBeNull=false, DefValue=null]]  
     
    Dim markTime As Long = DateTime.now  
     
    For i = 1 To 1000  
        SQL.AddNonQueryToBatch("INSERT INTO table1 VALUES (?)", Array(Rnd(0, 100000)))  
    Next  
    Dim SenderFilter As Object = SQL.ExecNonQueryBatch("SQL")  
    Wait For (SenderFilter) SQL_NonQueryComplete (Success As Boolean)  
    Log((DateTime.Now - markTime) & TAB & "Finished 1000 Batch Inserts")  '97 msecs to insert 1000 simple random values in table1  
    displayMap(getDBMap(fldInfo, "SELECT * FROM table1"))  
    '0    Random_Number    [98792, 67729, 99388, 44887, …, 91804, 99621]  
     
    'Make another table    'data' using some helper Subs (see duckDB_v5.zip) - all just SQL methods, but aimed at returning columns of data rather than rows.  
    Dim fldInfo As List = makeDB("CREATE OR REPLACE TABLE data (id INTEGER, value VARCHAR)")   'ignore  
    changeDB("INSERT INTO data VALUES (1, 'test'), (2, 'hello')")  
  
    displayMap(getDBMap("STRING", "SELECT list(id) FROM data"))  
    '0    list(id)    [[1, 2]]        'displayMap returns a vertical list of key value pairs, items in list are numbered 0,1,2, …  
     
    displayMap(getDBMap(fldInfo, "SELECT * FROM data"))  
    '0    id    [1, 2]  
    '1    value    [test, hello]  
     
    'Here are some Select statements without an explicitly named table!  
     
    displayMap(getDBMap("TEXT", "SELECT list[1] AS element FROM (Select ['first', 'second', 'third'] AS list)"))  
    '0    element    [first]  
     
     
    displayMap(getDBMap("TEXT", "Select 'I love you! I know'[:-3] AS nearly_soloed"))  
    '0    nearly_soloed      
     
    displayMap(getDBMap("TEXT", Array("SELECT ['A-Wing', 'B-Wing', 'X-Wing', 'Y-Wing'] AS starfighter_list, ", _  
            "{name: 'Star Destroyer', common_misconceptions: 'Can''t in fact destroy a star'} AS star_destroyer_facts")))  
    '0    starfighter_list    [[A-Wing, B-Wing, X-Wing, Y-Wing]]  
    '1    star_destroyer_facts    [{'name': Star Destroyer, 'common_misconceptions': 'Can\'t in fact destroy a star'}]  
  
    Dim exMap As Map = CreateMap("name": "Tatooine", "Amount of sand": "High")  
    displayMap(getDBMap("TEXT", $"SELECT ${mapToSQL(exMap)} AS planet"$))  
    '0    planet    [{'name': Tatooine, 'Amount of sand': High}]  
     
    SQL.Close  
End Sub
```