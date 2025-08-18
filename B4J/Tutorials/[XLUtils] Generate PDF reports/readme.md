### [XLUtils] Generate PDF reports by Erel
### 05/27/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/131119/)

![](https://www.b4x.com/android/forum/attachments/114085)  
  
XLUtils v1.13 adds support for converting workbooks to PDF. This is a Windows only feature and it relies on Excel being installed on the computer.  
  
Exporting to PDF is a matter of calling:  

```B4X
    Wait For (xl.PowerShellConvertToPdf(WorkbookFile, OutputPDF, SheetIndex, True)) Complete (Success As Boolean)
```

  
You can also set the print area with Sheet.PrintArea and the print scaling with Sheet.SetFitToPage.  
  
The attached example is based on the template + chart example: <https://www.b4x.com/android/forum/threads/xlutils-templates-and-charts.130373/#content>  
It creates a workbook and then converts it to a PDF document.