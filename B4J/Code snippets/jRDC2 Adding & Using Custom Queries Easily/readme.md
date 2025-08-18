### jRDC2 Adding & Using Custom Queries Easily by Mashiane
### 10/15/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/135157/)

Ola  
  
**Step 1:**  
  
Add this code to the RDCConnector  
  

```B4X
'add a command that does not exist  
public Sub AddCommand(scommand As String, qry As String)  
    scommand = scommand.tolowercase  
    Dim skey As String = $"sql.${scommand}"$  
    If commands.ContainsKey(skey) = False Then  
        commands.Put(skey, qry)  
        Log("AddCommand…")  
        Log(scommand)  
        Log(qry)  
    End If  
End Sub
```

  
  
**Step 2:**  
  
Before you fire the Query call / when app starts.  
  

```B4X
Main.rdcConnector.AddCommand("select_animal", "select * from animal where name = ?")
```

  
  
You are good to go!  
  
#SharingTheGoodness