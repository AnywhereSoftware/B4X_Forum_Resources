### TD_Recordset the Resultset alternative by Guenter Becker
### 05/04/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/166867/)

Name: **TD\_recordset**  
Type: Custom B4A Class (b4xlib)  
Version: 1.0  
State: Testphase  
Licence: free for personell use, free for commercial use after donation.  
  
[Download here](https://drive.google.com/file/d/1E7gsb7_QEf584w8eMbeBWhFVKHzIF8vO/view?usp=sharing)  
  
*TD\_Recordset is a custom class that allows you to store* and manage selected data from an *SQLite* or *SQLCipher database.  
  
TD\_Recordset* is an alternative to using the *B4X SQL result set* and provides significantly more data management functionality. Like the *result set , the recordset* is a database-independent object. The database serves merely as a data provider.  
  
The *recordset* consists of *records* . Each *record* contains data columns. The data columns are identified by a column name and have the object data type; therefore, they can contain all database data types (text, numeric, blob).  
  
The position of a record ( *record pointer* ) is determined by its location in *the recordset* . When the *recordset is sorted or reordered,* the record receives a new position number. The position number is therefore not identical to the *RowID* of a database table.  
  
**Administrative functions:**  

- Load data from the database and save it in the *recordset* .
- Add, Update, Delete Data in *the recordset* without the need to reload it.
- Recover deleted data.
- Sort the *recordset* data based on a column value.
- Find a record based on a column value.
- Jump to a specific record position.
- Convert the *recordset* to a list, e.g. for loading a *B4XTable* .

  
**Information functions:**  

- Number of records in the *recordset* .
- Number of columns in a record.
- List of column names of a record.
- Value of a specific column
- Retrieve columns and values of the current record.
- Last used SELECT command and its arguments.
- Current *record pointer* position.
- List of deleted records.

  

---

  
I tested the Recordset with a manual load of 10.000 Records (one numeric Column) and the loading time was less a second. I please you to do some more testing as well and reporting any error or whishes to me as reply to the post.  
Please find a detailed manual in the Documents Folder of the Example project.