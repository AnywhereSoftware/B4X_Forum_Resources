### Clean SQLite database, if it grows much by peacemaker
### 12/01/2019
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/111510/)

Long working apps have DB that grows and grows. It must be controlled, when records qty is very big, and most old data should be deleted:  
  

```B4X
Sub Clean_SQL(tables() As String) As Boolean  
    'Starter.SQL is already open  
    Dim TotalRecordsLimit As Int = 20000    'set yourself according to the project scale, speed of DB grow and needed time period for data storage. i guess, it should be > 10…100K  
    Dim MinQty As Int = 1000  
    Dim IndexFieldName As String = "id"    'each table must have the primary index with this name  
    If tables = Null Then  
        Dim cur As Cursor = Starter.SQL.ExecQuery("SELECT name FROM sqlite_master WHERE Type='table' ORDER BY name")  
        If cur.RowCount = 0 Then  
            cur.Close  
            Return False  
        End If  
        Dim TotalRecords As Int  
        For i = 0 To cur.RowCount - 1  
            cur.Position = i  
            Dim tablename As String = cur.GetString2(0)  
            Dim count As Int = Starter.SQL.ExecQuerySingleResult("SELECT count(*) FROM '" & tablename & "'")  
            TotalRecords = TotalRecords + count    'total records in the db  
        Next  
        If TotalRecords < TotalRecordsLimit Then  
            cur.Close  
            Return False    'small DB yet, no need to clean  
        End If  
        For i = 0 To cur.RowCount - 1  
            cur.Position = i  
            Dim tablename As String = cur.GetString2(0)  
            Dim count As Int = Starter.SQL.ExecQuerySingleResult("SELECT count(*) FROM '" & tablename & "'")  
            Dim TableLimit As Int = count - (TotalRecordsLimit / TotalRecords * count)    'qty to be deleted from this table  
            If TableLimit < MinQty Then Continue    'do not clean table fully  
            Starter.SQL.BeginTransaction  
            Try  
                Dim q As String = "DELETE FROM " & tablename & " WHERE " & IndexFieldName & " in (SELECT id FROM " & tablename & " ORDER BY " & IndexFieldName & " ASC LIMIT " & TableLimit & ")"  
                'Log(q)  
                Starter.SQL.ExecNonQuery(q)  
                Starter.SQL.TransactionSuccessful  
            Catch  
                Log("Clean_SQL." & tablename & ".error = " & LastException.Message)  
            End Try  
            Starter.SQL.EndTransaction  
        Next  
        cur.Close  
    Else  
        Dim TotalRecordsLimit As Int = 2000    'set yourself according to the project scale, speed of DB grow and needed time period for data storage. i guess, it should be > 10…100K  
        Dim TotalRecords As Int  
        For i = 0 To tables.Length - 1  
            Dim tablename As String = tables(i)  
            Dim count As Int = Starter.SQL.ExecQuerySingleResult("SELECT count(*) FROM '" & tablename & "'")  
            TotalRecords = TotalRecords + count    'total records in the db  
        Next  
        TotalRecords = TotalRecords + count    'total records in the db  
        If TotalRecords < TotalRecordsLimit Then  
            Return False    'small DB yet, no need to clean  
        End If  
        For i = 0 To tables.Length - 1  
            Dim tablename As String = tables(i)  
            Dim count As Int = Starter.SQL.ExecQuerySingleResult("SELECT count(*) FROM '" & tablename & "'")  
            Dim TableLimit As Int = count - (TotalRecordsLimit / TotalRecords * count)    'qty to be deleted from this table  
            If TableLimit < MinQty Then Continue    'do not clean table fully  
            Starter.SQL.BeginTransaction  
            Try  
                Dim q As String = "DELETE FROM " & tablename & " WHERE " & IndexFieldName & " in (SELECT id FROM " & tablename & " ORDER BY " & IndexFieldName & " ASC LIMIT " & TableLimit & ")"  
                'Log(q)  
                Starter.SQL.ExecNonQuery(q)  
                Starter.SQL.TransactionSuccessful  
            Catch  
                Log("Clean_SQL." & tablename & ".error = " & LastException.Message)  
            End Try  
            Starter.SQL.EndTransaction  
        Next  
    End If  
    Return True  
End Sub
```