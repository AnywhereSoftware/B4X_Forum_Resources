### TDDButils Database Management for SQlite and SQLiteCipher by Guenter Becker
### 03/09/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/139030/)

**Name**: TDDBUtils  
**Type**: b4a, b4xlib  
**Version**: 1  
**(C)**: TechDoc G. Becker Royalty Free for Personally/Commercial use for B4X Board Members  
  
This additional B4A library makes the live of standard Database Management for SQLite (unencrypted) and SQLiteCipher (encrypted) Databases a little bit easier. You no longer have to learn the SQL Language. At this beginning the lib covers some of the most common actions to insert/update/select/delete rows from the database table.  
Table Joins are not included.  
  
**Nearby**:  

- Download the SQLCipher library from the Forum. [Download here.](https://www.b4x.com/android/forum/threads/android-database-encryption-with-sqlcipher-library.14965/)
- I recommend to create, modify or encryt a SQLCipher or SQLite Database on your PC download, install and use the free App 'DB Browser'. [Download here.](https://sqlitebrowser.org/)

  
**Features**:  

- Open/Close Database (SQlite 3 or SQLiteCipher 4)
- Insert/Update/Delete records
- Save records (automatic insert or update)
- Select records by condition
- Select distinct records by condition
- Select records by operand and date
- Select records between 2 dates
- Select records by date +/- nDays, nMonth, nYears
- Get all database table names
- Get column information of a database table
- Check if a record exists
- Check if column has a Null Value if yes return empty string or 0
- Set database compact/compress mode
- Activate database compacting/compressing

  
**Development Plan:**  

- Add Feature Export/Import Table Data to/from file
- Add Feature ….. whished by Forum Members

  
**Installation:**  

- Copy TDDButils.b4xlib to your additional libraries folder
- In your Project activate the libs SQL, SQLCipher, TDDButils

  
**Learn:**   

- Examin attached TDDButils.bas file
- Examin attached TDDButilsProject (B4A)

  
  
  

```B4X
'Notice!  
    ' This example uses an encrypted Database SQLiteCipher  
    ' Please install and activate SQL, SQLCipher libs (both!) and TDDButils  
    ' The Table Test is loaded with 4 rows with default values  
     
    ' Initialize variables, open database connection  
    ' if Cipher=True DB object=SQLite  
    ' if Cipher=False DB object=SQLCipher  
    ' get table info=TDButils.TableInfo(list)  
    ' get column info= TDButils.ColumnInfo (map), key=ColumnName, Value as type TColInfo  
    ' Parameter: DBName, TableName, is Cipher, Password / All case sensitive!  
    ' returns true if initialized  
    ' Notice! This is the 1st step to use TDDButils features!  
    If TDDButils.initialize("Test.db","Test",True,"Test") Then  
         
        ' ## TDDBUtils Variables:  
        ' ## You have access to this TDDBUtils Variables:  
        ' ## TDDButils.ColumnInfo (MAP) holding Column Info  
        ' ## TDDButils.ColumnValues (MAP) holding COlumn Values  
        ' ## TDDButils.DatabaseName the name of the active Database  
        ' ## TDDButils.SQLCipher the SQLipher Database object  
        ' ## TDDButils.SQLite the SQLite Database object  
        ' ## TDDButils.TableInfo (List) holding Tablenames  
  
        ' Function EXAMPLES:  
        ' set TestNo Value to perform the requested test  
        ' Notice! If you set the column name that contains a space in the WhereValue than  
        ' enclosuer it with [brackets].  
        Dim TestNo As Int = 1  
        Select TestNo  
            Case 1  
                ' ## show Table name of database  
                Log("Tables: " & TDDButils.TableInfo) ' (List)  
            Case 2  
                ' ## show column info of test table  
                ' ##  Column Info, Keys=ColName, Value as type TColInf  
                Log("Columns Test table: " & TDDButils.ColumnInfo)' (Map)  
            Case 3  
                ' ## show info of one column  
                Dim CInfo As TColInfo  
                 CInfo = TDDButils.ColumnInfo.get("ColText")  
                Log("CINFO: " & CInfo)  
            Case 4  
                ' ## get max/min/average/sum value of all columns 'ColInteger'  
                Log(TDDButils.maxValue("ColInteger",""))  
                Log(TDDButils.minValue("ColInteger",""))  
                Log(TDDButils.averageValue("ColInteger",""))  
                Log(TDDButils.sumValue("ColInteger",""))  
            Case 5  
                ' ## get row count  
                Log(TDDButils.countValue("ColInteger","ColText LIKE 'Text%'"))  
            Case 6        
                ' ## check if a column value is Null  
                ' assume we have a populate resultset 'resSet'  
                ' TDDButils.checkNull(resSet.getString("ColText")))  
            Case 7  
                ' ## set databasecompact mode  
                TDDButils.setDBcompactMode("FULL")  
            Case 8  
                ' ## compact/compress Database  
                ' ## setDBcompactMode befor call  
                Log(TDDButils.compactDB)  
            Case 9  
                ' ## select rows >= startDate and <= endDate  
                ' ## Parameter: Colname, startDate,endDate,nDays,nMonth,nYears  
                ' ## set Date Format = yyyy-MM-dd leave rest of Parameter = 0  
                DateTime.DateFormat="yyyy-MM-dd"  
                Dim rs As ResultSet = TDDButils.dateDifference( _  
                    "Date","2000-04-01",DateTime.date(DateTime.Now),0,0,0)  
                Log(rs.RowCount)  
            Case 10    
                ' ## select rows >= startdate and +- nDays, nMonth, nYears  
                ' ## Parameter: Colname, startDate,endDate,nDays,nMonth,nYears  
                ' ## leave endDate empty  
                DateTime.DateFormat="yyyy-MM-dd"  
                Dim rs As ResultSet = TDDButils.dateDifference("Date", _  
                    "2021-02-01","",0,0,-1)  
                Log(rs.RowCount)  
            Case 11  
                ' ## select rows by operand and startdate  
                ' ## Parameter: Colname, startDate, Operand like '<'  
                ' ## leave endDate empty  
                DateTime.DateFormat="yyyy-MM-dd"  
                Dim rs As ResultSet = TDDButils.dateFromTo("Date", _  
                    "2020-01-01","<")  
                Log(rs.RowCount)  
            Case 12        
                ' ## check if record exists  
                ' ## if yes count of rows is returned  
                ' ## if no count of rows = 0  
                Log(TDDButils.existsRecord("ColText='Text1'"))  
            Case 13  
                ' ## set column values  
                ' ## key=column name, Value as Value  
                TDDButils.ColumnValues.clear  
                TDDButils.ColumnValues.Put("ColText","Text5")  
                TDDButils.ColumnValues.Put("ColInteger",5000)  
            Case 14  
                ' ## insert a new record  
                ' ## set TDDButils.ColumnValues (map) before call  
                Log(TDDButils.insertRecord)  
            Case 15  
                ' ## update record by condition  
                ' ## set TDDButils.ColumnValues (map) befor call  
                Log(TDDButils.UpdateRecord("ColText='Text1'"))  
            Case 16  
                ' ## check if record exists if yes do update if no do insert  
                ' ## set TDDButils.ColumnValues (map) before call  
                Log(TDDButils.saveRecord("ColText='Text1'"))  
            Case 17  
                ' ## simple select rows by condition  
                ' ## returns result set or null if not found  
                Dim rs As ResultSet =TDDButils.selectRecord("*","ColText='Text1'")  
                Log(rs.rowCount)  
            Case 18  
                ' ## select distinct rows by condition  
                Dim rs As ResultSet =TDDButils.selectRecordDistinct("*","ColText LIKE 'Text%'")  
                Log(rs.rowCount)  
            Case 19  
                ' ## Delete a row (no confirmation request included!)  
                xui.Msgbox2Async("Delete Record?","Confirmation requested","OK","","Cancel",Null)  
                If xui.DialogResponse_Positive Then  
                     Log(TDDButils.deleteRecord("ColText='Text1'"))  
                End If  
            Case 20  
                ' ## close Database  
                Log(TDDButils.closeDatabase(True))  
        End Select
```