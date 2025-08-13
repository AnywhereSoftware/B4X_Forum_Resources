### List of Maps to a B4XTable by Brian Michael
### 06/08/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/161558/)

Hey there! Excited to share a handy code snippet with you!   
This code converts a List of Maps into a format that's perfect for loading into a B4XTable.   
  
It just works when you have a List of Maps like:  
  
> ("Name":"Brian","Last Name": "Michael", "Age":29),  
> ("Name":"Harold","Last Name": "Pimentel", "Age":27),  
> ("Name":"Kevin","Last Name": "Hunt", "Age":35)

  
  

```B4X
Public Sub ListOfMapToB4XTable(Data As List) As List  
    Dim ResultList As List : ResultList.Initialize  
    Dim Headers As List : Headers.Initialize  
    If Data.Size > 0 Then  
  
        For Each Row As Map In Data  
                For Each Key As String In Row.Keys  
                    If (Headers.IndexOf(Key) = - 1) Then Headers.Add(Key)  
                Next  
        Next  
  
        For Each Row As Map In Data  
            If Row <> Null And Row.Size = Headers.Size Then  
                Dim r(Headers.Size) As Object  
                For i = 0 To Headers.Size - 1  
                    If Not(Row.GetValueAt(i) = Null) Then  
                        r(i) = Row.GetValueAt(i)  
                    Else  
                        r(i) = Null 'You can set a default value  
                    End If  
                      
                Next  
                ResultList.Add(r)  
            End If  
        Next  
    End If  
    Return ResultList  
End Sub
```