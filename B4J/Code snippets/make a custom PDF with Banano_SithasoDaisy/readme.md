### make a custom PDF with Banano/SithasoDaisy by Gianni M
### 05/11/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/161059/)

lib:  
BANano  
SithasoDaisy  
SithasoDaisyPDF  
[HEADING=2][/HEADING]  
thanks to [USER=44364]@Mashiane[/USER]   
  

```B4X
Sub makepdf  
    Log("make pdf")  
    Dim jspdf As SDUIJSPDF  
    jspdf.Initialize(Me, "pdfEvent", "test.pdf")  
    jspdf.Start  
    jspdf.SetText1("Hello World", "20", "20")  
    jspdf.SetText("20", "30", "Example with Banano/SithasoDaisy and jsPDF")  
    jspdf.addPage 'new page  
    jspdf.SetText("40", "55", "Page number two!")  
    jspdf.close  
    jspdf.Save  
End Sub
```