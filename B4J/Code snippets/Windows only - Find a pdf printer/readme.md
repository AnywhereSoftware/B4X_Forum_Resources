### Windows only - Find a pdf printer by Erel
### 10/02/2019
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/110121/)

```B4X
Sub FindPdfPrinter As ResumableSub  
   Dim shl As Shell  
   shl.Initialize("shl", "wmic", Array("printer", "get", "Name"))  
   shl.Run(-1)  
   Wait For shl_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)  
   If Success Then  
       For Each line As String In Regex.Split("[\r\n]+", StdOut)  
           If line.ToLowerCase.Contains("pdf") Then Return line.Trim  
       Next  
   End If  
   Return ""  
End Sub
```

  
  
Usage example:  

```B4X
Wait For (FindPdfPrinter) Complete (PdfPrinter As String)  
If PdfPrinter <> "" Then
```

  
  
Depends on jShell library.