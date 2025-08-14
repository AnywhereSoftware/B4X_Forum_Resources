### Get Month Short Names (according to Java SimpleDateFormat) by Chris2
### 07/31/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/168032/)

```B4X
Private Sub GetMonthShortNames As List  
    Dim l As List  
    l.Initialize  
    For i=1 To 12  
        DateTime.DateFormat="M"  
        Dim longDT As Long = DateTime.DateParse(i)  
        DateTime.DateFormat="MMM"  
        l.Add(DateTime.Date(longDT))  
    Next  
    Return l  
End Sub
```

  
Tip: They're not always what you might expect (at least in English) ;)