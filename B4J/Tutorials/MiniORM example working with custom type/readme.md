### MiniORM example working with custom type by aeric
### 11/06/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/169236/)

This example is created from [**MiniORM** project template](https://www.b4x.com/android/forum/threads/b4x-project-template-miniorm.165499/) but product table is removed.  
Category table changed to Cassa, id column (Int) changed to idCassa (String). Autoincrement is disabled.  
Support CRUD using SQLite.  
  
Cassa is a custom type  

```B4X
Type Cassa (IdCassa As String, Name As String)
```

  
  

```B4X
Private Sub clvRecord_ItemClick (Index As Int, Value As Object)  
    Dim selectedCassa As Cassa = Value  
    Log($"Casa Id: ${selectedCassa.IdCassa}${CRLF}Casa Name: ${selectedCassa.Name}"$)  
End Sub
```

  
  
This is my answer to question [here](https://www.b4x.com/android/forum/threads/semplice-crud-con-reflection.169216/)