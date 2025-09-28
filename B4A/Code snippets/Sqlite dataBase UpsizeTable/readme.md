### Sqlite dataBase UpsizeTable by Lello1964
### 09/26/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/168798/)

```B4X
#Region  Project Attributes  
    #ApplicationLabel: B4A Example  
    #VersionCode: 1  
    #VersionName:  
    'SupportedOrientations possible values: unspecified, landscape or portrait.  
    #SupportedOrientations: unspecified  
    #CanInstallToExternalStorage: False  
#End Region  
  
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: True  
#End Region  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
    Private xui As XUI  
    Dim RP1 As RuntimePermissions  
   
    Dim Sql1         As SQL  
    Dim SqlMaster    As SQL  
    Dim DBFileDir As String  
End Sub  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    Dim DBFileName As String = "database.db"  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("Layout")  
  
    DBFileDir = RP1.GetSafeDirDefaultExternal("")  
   
    If File.Exists(DBFileDir, DBFileName) = False Then  
        File.Copy(File.DirAssets,DBFileName, DBFileDir, DBFileName )  
    End If  
   
End Sub  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub  
  
Sub Button1_Click  
    Dim DB_Master As String ="_Master_" & DBFileName  
   
    If File.Exists(DBFileDir,DB_Master) = True Then  
        File.Delete(DBFileDir,DB_Master)  
    End If  
   
    File.Copy(File.DirAssets,DBFileName, DBFileDir,DB_Master)  
   
    Sql1.Initialize(DBFileDir,DBFileName,False)  
    SqlMaster.Initialize(DBFileDir, DB_Master,False)  
      
    Sql1.ExecNonQuery("PRAGMA foreign_keys = 0;")  
    UpsizeTable("myTable","myTable")  
   
    Sql1.ExecNonQuery("PRAGMA foreign_keys = 1;")  
   
    MsgboxAsync("Update Terminated","Ok")  
End Sub  
  
Sub UpsizeTable(MasterTable As String, OriginalTable As String)  
    Dim tableExists As Boolean = False  
    Dim s As String  
    s = Sql1.ExecQuerySingleResult("SELECT name FROM sqlite_master WHERE type='table' AND name='" & OriginalTable & "';")  
    If s <> Null Then tableExists = True  
   
    Sql1.BeginTransaction  
   
    Try  
       If tableExists Then  
            ' — Find ONLY the columns that are common between old and new table —  
            Dim oldCols As List, newCols As List  
            oldCols.Initialize  
            newCols.Initialize  
  
            Dim c1 As ResultSet = Sql1.ExecQuery("PRAGMA table_info(temp_" & OriginalTable & ");")  
            Do While c1.NextRow  
                oldCols.Add(c1.GetString("name"))  
            Loop  
            c1.Close  
  
            Dim c2 As ResultSet = Sql1.ExecQuery("PRAGMA table_info('" & OriginalTable & "');")  
            Do While c2.NextRow  
                Dim nm As String = c2.GetString("name")  
                If oldCols.IndexOf(nm) <> -1 Then newCols.Add(nm)  
            Loop  
            c2.Close  
  
            Dim colNames As String = JoinList(newCols, ", ")  
  
            ' Copy only the common fields: new fields will use their default values  
            Dim insertSQL As String = "INSERT INTO " & OriginalTable & " (" & colNames & ") " & _  
                                      "SELECT " & colNames & " FROM temp_" & OriginalTable & ";"  
            Sql1.ExecNonQuery(insertSQL)  
            Log("[UPSZ] Data migrated (common fields): " & colNames)  
  
            ' Remove the temporary table  
            Sql1.ExecNonQuery("DROP TABLE IF EXISTS temp_" & OriginalTable & ";")  
        End If  
          
        createSQL = createSQL.Replace(MasterTable, OriginalTable)  
        Sql1.ExecNonQuery(createSQL)  
        Log("[UPSZ] CREATE TABLE executed: " & createSQL)  
      
        If tableExists Then  
            ' — Transfer data from the temporary table —–  
            Dim cur As ResultSet = SqlMaster.ExecQuery("PRAGMA table_info('" & OriginalTable & "');")  
            Dim colNames As String = ""  
            Do While cur.NextRow  
                If colNames <> "" Then colNames = colNames & ", "  
                colNames = colNames & cur.GetString("name")  
            Loop  
            cur.Close  
          
            Dim insertSQL As String  
            insertSQL = "INSERT INTO " & OriginalTable & " (" & colNames & ") " & _  
                        "SELECT " & colNames & " FROM temp_" & OriginalTable & ";"  
            Sql1.ExecNonQuery(insertSQL)  
          
            ' — Delete temporary table —————–  
            Sql1.ExecNonQuery("DROP TABLE temp_" & OriginalTable & ";")  
        End If  
      
        ' — Automatically recreate indexes ———-  
        Dim idxCur As ResultSet = SqlMaster.ExecQuery( _  
            "SELECT name, sql FROM sqlite_master WHERE type='index' AND tbl_name='" & MasterTable & "' AND sql NOT NULL;")  
        Do While idxCur.NextRow  
            Dim idxName As String = idxCur.GetString("name")  
            Dim idxSQL As String = idxCur.GetString("sql")  
          
            idxSQL = idxSQL.Replace(MasterTable, OriginalTable)  
          
            If idxName = "" Or idxName = Null Then  
                idxName = """" ' OriginalTable & "idx" & DateTime.Now  
                ' Ricostruisce correttamente la query senza "" vuote  
                Dim pos As Int = idxSQL.IndexOf("CREATE INDEX")  
                If pos >= 0 Then  
                    idxSQL = "CREATE INDEX  " & """" & " " & idxName & idxSQL.SubString(idxSQL.IndexOf(" ON "))  
                End If  
              
            End If  
            Sql1.ExecNonQuery(idxSQL)  
          
            Log("[UPSZ] Index recreated: " & idxSQL)  
        Loop  
        idxCur.Close  
      
        ' Delete the Backup Table  
      
        ' — Drop original table ——————–  
        Sql1.ExecNonQuery("DROP TABLE IF EXISTS " & OriginalTable & "_BACKUP;")  
      
        Sql1.TransactionSuccessful  
            
        Log("[UPSZ] Table " & OriginalTable & " successfully recreated.")  
      
    Catch  
        Log("[UPSZ][ERROR] Upsize failed! Check physical backup and " & OriginalTable & "_BACKUP.")  
    End Try  
   
    Sql1.EndTransaction  
End Sub  
  
Private Sub JoinList(lst As List, sep As String) As String  
    Dim sb As StringBuilder  
    sb.Initialize  
    For i = 0 To lst.Size - 1  
        If i > 0 Then sb.Append(sep)  
        sb.Append(lst.Get(i))  
    Next  
    Return sb.ToString  
End Sub
```

  
  
  
The UpsizeTable subroutine allows you to **rebuild (upsize) a SQLite table** from a “master” schema (MasterTable), **preserving all existing data** while ensuring that **constraints and indexes are not only retained but can also be added or updated** according to the new schema.  
  
  
This routine is ideal for production environments where you need to **evolve the table structure**—for example, adding columns, new constraints, or indexes—without losing data or writing complex SQL by hand.  
  
  

---

  
  
[HEADING=3]**Step-by-Step Process**[/HEADING]  
  

1. **Check and Backup the Original Table**

- Verifies whether OriginalTable exists.
- If it does, creates a full copy (<OriginalTable>\_BACKUP) and a **temporary table** (temp\_<OriginalTable>) containing all data.
- Drops the original table to prepare for reconstruction.

2. **Create the New Structure with Updated Constraints**

- Retrieves the full CREATE TABLE statement from the MasterTable.
- Replaces the master table name with the target table name (OriginalTable).
- Executes the new CREATE TABLE statement, which can include:

- **All existing constraints**, such as:

- UNIQUE ON CONFLICT ABORT
- NOT NULL
- CHECK, DEFAULT, primary keys, and foreign keys.

- **New constraints added in the MasterTable**, which are automatically applied to the upgraded table.

- ✅ **This means you can add new constraints (UNIQUE, NOT NULL, CHECK, etc.) simply by updating the MasterTable definition—no changes to the subroutine itself are needed.**

3. **Repopulate Data**

- Reads the column names from the new table.
- Reinserts all data from the temporary table, enforcing the updated constraints (any violation of new constraints—such as a new UNIQUE or NOT NULL—will trigger an error and roll back the transaction).

4. **Recreate Indexes**

- Retrieves and recreates all indexes defined in the MasterTable.
- Adjusts the CREATE INDEX statements to reference the new table name, handling unnamed indexes correctly.

5. **Cleanup**

- Drops both the temporary table and the backup table after completion.
- All operations are wrapped in a single **atomic transaction**, ensuring that if an error occurs, no partial changes remain and the database stays consistent.

  

---

  
  
[HEADING=3]**Key Features**[/HEADING]  
  

- **Preserves existing constraints**: Maintains all original rules such as UNIQUE ON CONFLICT ABORT, NOT NULL, primary keys, foreign keys, and any other SQL constraints.
- **Adds new constraints**: Any new constraints defined in the MasterTable—for example additional columns with NOT NULL, new UNIQUE or CHECK clauses—are automatically applied to the upgraded table.
- **Automatically rebuilds indexes**: All indexes from the master schema are recreated in the new table.
- **Safe and automatic**: Runs inside a single transaction with internal backups to protect against data loss.

  

---

  
  
[HEADING=3]**Typical Use Cases**[/HEADING]  
  

- Complex schema upgrades (adding/modifying columns, constraints, or data types).
- Production migrations where you need to **evolve a table’s structure without losing data**.
- Situations where you want to **introduce new integrity constraints** (e.g., UNIQUE, NOT NULL, CHECK) by simply updating the master schema.

  
  
[HEADING=3]Fixed[/HEADING]  
  
 **Find ONLY the columns that are common between old and new table**