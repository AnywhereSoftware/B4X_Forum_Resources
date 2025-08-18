### Parameterized SQL Update Example by 73Challenger
### 05/29/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/140854/)

There are many ways to write a parameterized update class/function of course….and here is 1 more :)  
  
Requirements:  
0. Reference to SQL and DBUtils Libraries  
1. A Type object that has the same structure as your data row (Type GameRow in the code snippet below).  
2. A SQL String builder (GetUpdateGameRecordString in the snippet below).  
3. A data array builder (GetUpdateGameRecordArray in the snippet below).  
\*\*\*\*Then call ExecNonQuery2 with the objects\*\*\*\*  
  

```B4X
' This example uses a Type object for row mapping and executing a SQL row update.  
Private SQLGame As SQL  
Private DBName as String = "game.db"  
Private TableName as String = "gameTable"  
  
'Type structure should match the data table row columns.  
Type GameRow(rowId As Int, playResult as String, playScore as Int)  
Private GameRowElementCount as Int = 3 'Simply the number of elements in the Type, easy to edit here when adding/removing rows. Used to dimension data array.  
  
'Entry Point - Receive new values, build type object and update the db  
Public Sub UpdateRow(rowId as Int, playResult as String, playScore as Int)  
  
     'Initializer should be called outside of this function. Adding here to make this a fully working example.  
    If SQLGame.IsInitialized = False Then  
        SQLGame.Initialize(xui.DefaultFolder, DBName, True)  
        If DBUtils.TableExists(SQLGame, TableName) = False Then  
             'SQLGame.ExecNonQuery($"CREATE TABLE ${TableName} (rowId INTEGER NOT NULL, playResult TEXT, playScore INTEGER)"$)  
             SQLGame.ExecNonQuery(GetCreateGameTableString(TableName))  
        End If  
    End If  
  
    Dim tempRow as GameRow  
    tempRow.Initialize  
    tempRow.rowId = rowId  
    tempRow.playResult = playResult  
    tempRow.playScore = playScore  
    UpdateGameRecord(tempRow, TableName)  
End Sub  
  
Private Sub UpdateGameRecord(gr As GameRow, tblName As String)  
    Dim sqlString As String = GetUpdateGameRecordString(tblName)  
    Dim dataArray() As String = GetUpdateGameRecordArray(gr)  
    SQLGame.BeginTransaction  
    Try  
        'Execute the update using parameterized string and array.  
        SQLGame.ExecNonQuery2(sqlString, dataArray)  
        SQLGame.TransactionSuccessful  
    Catch  
        Log(LastException.Message)  
    End Try  
   SQLGame.EndTransaction  
End Sub  
  
Private Sub GetUpdateGameRecordString(tblName As String) As String  
    Private sb As StringBuilder  
    sb.Initialize  
    sb.Append("UPDATE ")  
    sb.Append(tblName)  
    sb.Append(" Set ")  
    sb.Append("playResult = ?,")  
    sb.Append("playScore = ? ")  
    sb.Append("WHERE rowId = ?")  
    Return sb.ToString  
End Sub  
  
Private Sub GetUpdateGameRecordArray(gr As GameRow) As String()  
    Dim tempArray(GameRowElementCount) As String  
    tempArray(0) = gr.playResult  
    tempArray(1) = gr.playScore  
    tempArray(2) = gr.rowId  
    Return tempArray  
End Sub  
  
Private Sub GetCreateGameTableString(tblName As String) As String  
    Private sb As StringBuilder  
    sb.Initialize  
    sb.Append("CREATE TABLE ")  
    sb.Append(tblName)  
    sb.Append(" (")  
    sb.Append("rowId INTEGER NOT NULL, ")  
    sb.Append("playResult TEXT, ")  
    sb.Append("playScore INTEGER)")  
    Return sb.ToString  
End Sub
```

  
  
Corrections/comments are welcome. Thank you.