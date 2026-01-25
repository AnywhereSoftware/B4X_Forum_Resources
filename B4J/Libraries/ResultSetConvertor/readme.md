### ResultSetConvertor by tchart
### 01/22/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/170096/)

Since B4J came out over 10 years ago, I have amassed a load of B4J helper functions to convert SQL query ResultSets into Maps, Lists, JSON for various scenarios - e.g. return results as JSON via jServer. I decided to standardise and put them into a Java library.  
  
Features:  

1. Converts a ResultSet to a B4X List or Map
2. Value types are correctly identified
3. ResultSet automatically closed
4. Helper methods to get field names and field types

Code Example  
  

```B4X
Dim rsconv As ResultSetConverter  
  
'Get list of ids  
Dim ids_rs As ResultSet  
ids_rs = Main.DB_RW.ExecQuery("select id from People")     
Dim ids As List = rsconv.ToList(ids_rs)  
  
'ids will be a list of ids eg (1,2,3,4,5)  
  
'Get list of maps  
Dim people_rs As ResultSet  
people_rs = Main.DB_RW.ExecQuery("select * from People")     
Dim people As List = rsconv.ToListOfMaps(people_rs)  
  
'people will be a list of maps eg (Map,Map,Map)
```

  
  
The code and library is available on GitHub. It would pay to read the comments as it shows examples.  
  
<https://github.com/ope-nz/ResultSetConverter>  
  
**NOTE ABOUT RESULTSET:  
When a ResultSet is converted, it will be closed after reading. I implemented this as the ResultSet can usually only be read once, so there is no point in keeping it open after reading. I looked into being able to rewind the ResultSet but this didn't seem possible with the default SQL library.  
  
NOTE ABOUT EXAMPLE BELOW:  
The examples below show JSON for readability, but the return types are always B4J Map or List. These can easily be converted to JSON by using ".As(JSON)"**  
  
[HEADING=2]ResultSetConverter (B4J / JDBC Utility) \* this is an AI Summary with some touch ups[/HEADING]  
  
**ResultSetConverter** is a small Java utility library for **B4J** that converts JDBC ResultSet objects into **B4X-friendly List and Map structures**.  
  
It removes repetitive JDBC iteration and type-handling code and is particularly useful for APIs, UI data binding, exports, and reporting.  
  
[HEADING=1]Supported Conversions & Output Examples[/HEADING]  
  
Assume the SQL query:  
  
SELECT Name, Age FROM People;  
  
with data:  
  
[TABLE]  
[TR]  
[TH]Name[/TH]  
[TH]Age[/TH]  
[/TR]  
[TR]  
[TD]John[/TD]  
[TD]30[/TD]  
[/TR]  
[TR]  
[TD]Jane[/TD]  
[TD]25[/TD]  
[/TR]  
[/TABLE]  
  

---

  
  
[HEADING=2]Metadata Helpers[/HEADING]  
  
**GetFieldTypes(ResultSet) returns Map**  
Returns column names mapped to JDBC types. This does not affect the ResultSet.  
  

```B4X
{  
  "Name": "VARCHAR",  
  "Age": "INTEGER"  
}
```

  
  
**GetFieldList(ResultSet) returns List**  
Returns column names in order. This does not affect the ResultSet.  
  

```B4X
["Name", "Age"]
```

  
[HEADING=2]Row-Based Conversions[/HEADING]  
**ToListOfMaps(ResultSet) returns List**  
Each row becomes a Map keyed by column name.  
  

```B4X
[  
  { "Name": "John", "Age": 30 },  
  { "Name": "Jane", "Age": 25 }  
]
```

  
  
**ToListOfLists(ResultSet, includeHeader) returns List**  
  
With includeHeader = true:  
  

```B4X
[  
  ["Name", "Age"],  
  ["John", 30],  
  ["Jane", 25]  
]
```

  
  
With includeHeader = false:  
  

```B4X
[  
  ["John", 30],  
  ["Jane", 25]  
]
```

  
[HEADING=2]Column-Based Conversions[/HEADING]  
  
**ToList(ResultSet) returns List**  
Returns first column only as a list.  
  

```B4X
["John", "Jane"]
```

  
  
[HEADING=2]Map-Based Conversions[/HEADING]  
  
**ToMap(ResultSet) returns Map**  
First column as key, full row as value.  
  

```B4X
{  
  "John": { "Name": "John", "Age": 30 },  
  "Jane": { "Name": "Jane", "Age": 25 }  
}
```

  
  
**ToMap\_KVP(ResultSet) returns Map**  
Two-column key/value mapping.  
  

```B4X
{  
  "John": 30,  
  "Jane": 25  
}
```

  
  
**ToMap\_IVP(ResultSet) returns Map**  
Row number (1-based) as key, first column as value.  
  

```B4X
{  
  1: "John",  
  2: "Jane"  
}
```

  
  
[HEADING=2]Chart / Series Conversion[/HEADING]  
  
**ToDataSeries(ResultSet) returns Map**  
Two-column result split into series and data arrays. This aligns with many JavaScript charting libraries.  
  

```B4X
{  
  "series": ["John", "Jane"],  
  "data": [30, 25]  
}
```

  
  
[HEADING=1]Type Handling[/HEADING]  
The library inspects ResultSetMetaData and converts values appropriately:  

- INTEGER, SMALLINT → int
- BIGINT → long
- FLOAT / DOUBLE → numeric
- DECIMAL / NUMERIC → BigDecimal
- BOOLEAN / BIT → boolean
- DATE → "yyyy-MM-dd"
- TIME → "HH:mm:ss"
- TIMESTAMP → ISO-8601 UTC string
(yyyy-MM-dd'T'HH:mm:ss.SSSZ)- Unknown types → String

[HEADING=1]Resource Management & Design Notes[/HEADING]  

- All conversion methods **consume and close the ResultSet**
- Errors are logged via Common.Log (no exceptions thrown)
- No external dependencies beyond JDBC and B4X runtime
- Designed for **read-only**, single-pass ResultSets

[HEADING=1]Typical Use Cases[/HEADING]  

- REST / API responses
- UI data binding
- CSV / Excel exports
- Charting and analytics
- Rapid JDBC prototyping in B4J