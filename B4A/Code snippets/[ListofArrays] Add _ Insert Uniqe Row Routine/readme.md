### [ListofArrays] Add / Insert Uniqe Row Routine by Eng. Nizar
### 06/07/2026
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/171194/)

For added flexibility, it's good to add these two features (The creator Erel):  
Like:  
AddUniqeRow(NewRow() As Object,UniqColIndx As Object) As Boolean  
InsertUniqeRow(NewRow() As Object,UniqColIndx As Object, RowIndx as int) As Boolean  
if Success return True  
  
I wrote down the routines AddUniqeRow/Insert UniqeRow routine and tested it.  
  

```B4X
Sub AddUniqeRow(table1 As ListOfArrays,NewRow_Array() As Object,UniqColIndx As Object) As Boolean  
    Return AddInsUniqeRow(table1,NewRow_Array,UniqColIndx, -1)  
End Sub  
  
Sub InsertUniqeRow(table1 As ListOfArrays,NewRow_Array() As Object,UniqColIndx As Object, InsertRowIndx As Int)  As Boolean  
    Return AddInsUniqeRow(table1,NewRow_Array,UniqColIndx, InsertRowIndx)  
End Sub  
  
Sub AddInsUniqeRow(table1 As ListOfArrays,NewRow_Array() As Object,UniqColIndx As Object, InsertRowIndx As Object) As Boolean  
    If IsNumber(InsertRowIndx) Then  
        If InsertRowIndx > table1.Size Then InsertRowIndx=-1  
    Else  
        InsertRowIndx=-1  
    End If  
    Dim ColValue As Object =-1  
    If UniqColIndx Is String And table1.Header.Length>0 Then  
        For i=0 To table1.Header.As(List).Size-1  
            If table1.Header(i).As(String).ToUpperCase=UniqColIndx.As(String).ToUpperCase Then  
                UniqColIndx=i  
                Exit  
            End If  
        Next  
    Else If IsNumber(UniqColIndx)=False Then  
        Log("ColIndx is Wrong")  
        Return False  
    End If  
    ColValue=NewRow_Array(UniqColIndx)  
    If table1.GetRowsByValue(UniqColIndx,ColValue).Size=0 Then  
        If InsertRowIndx>=0 Then  
            table1.InsertRow(InsertRowIndx,NewRow_Array)  
        Else  
            table1.AddRow(NewRow_Array)  
        End If  
        Return True  
    Else  
        Dim res As String'="[" & IIf(table1.Header.Length>0, table1.Header(UniqColIndx),"ColNo (" &UniqColIndx) & ") = " & ColValue &  "]  is Found"  
        If table1.Header.Length>0 Then  
            res = table1.Header(UniqColIndx)  
        Else  
            res="ColNo (" & UniqColIndx & ")"  
        End If  
        res=  res & "[" & ColValue &  "] is Found" & Chr(13)& Chr(10) & "Row Was Not " & IIf (InsertRowIndx>=0,"Inserted! at Index " & InsertRowIndx,"Added!")  
        Log(res)  
        ToastMessageShow(res,True)  
        Return False  
    End If  
End Sub
```