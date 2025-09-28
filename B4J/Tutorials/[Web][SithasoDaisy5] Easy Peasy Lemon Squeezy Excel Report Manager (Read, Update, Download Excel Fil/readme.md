### [Web][SithasoDaisy5] Easy Peasy Lemon Squeezy Excel Report Manager (Read, Update, Download Excel Files) by Mashiane
### 09/25/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/168785/)

Hi Fam  
  
***Some web apps need to be completed with reporting functionality. This can be in PDF, Excel, Word format etc. Today we look at Excel Reporting. You can create your Excel Template to your hearts desire and then read it and feed it content.***  
  
Problem Statement:  
  
We want to easily generate excel reports from existing Excel Templates.  
  
Imagine This:  
  

```B4X
Dim report As SDUI5ExcelReport  
    report.Initialize  
    report.SheetName = "Sheet1"  
    report.TemplateFile = "./assets/FieldsReport.xlsx"  
    report.SetColumn("D3", $"Table: ${Main.tablename}"$)  
    report.ReportFileName = Main.ProjectName & "_" & Main.TableName & " Fields"  
    report.StartRow = 7  
    report.SetRows(dbFields.result)  
    report.AddColumn("a", "proppos")  
    report.AddColumn("b", "propname")  
    report.AddColumn("c", "proptitle")  
    report.AddColumn("d", "propdatatype")  
    report.AddColumn("e", "proptype")  
    report.AddColumn("f", "propcolumntype")  
    report.AddColumn("g", "propfaketype")  
    report.AddColumn("h", "propvalue")  
    report.AddColumn("i", "proprow")  
    report.AddColumn("j", "propcol")  
    report.AddColumn("k", "proprequired")  
    report.AddColumn("l", "propactive")  
    report.AddColumn("m", "propvisible")  
    report.AddColumn("n", "propenabled")  
    report.AddColumn("o", "propsort")  
    report.AddColumn("p", "propfocus")  
    report.AddColumn("q", "proptotal")  
    report.AddColumn("r", "propforeigntable")  
    report.AddColumn("s", "propforeignfield")  
    report.AddColumn("t", "propforeigndisplayfield")  
    report.AddColumn("u", "propforeignrecord")  
    report.AddColumn("v", "propallowadd")  
    report.AddColumn("w", "propcomputevalue")  
    BANano.Await(report.execute)
```

  
  
You give it your Excel Template file name, the sheet to process, write some content on some position eg. DE, then starting from row 7, process each of the specified key in the data on each of the specified columns as you specify the data to report on with .SetData(?)  
  
Resulting Output based on your template…  
  
![](https://www.b4x.com/android/forum/attachments/167261)  
  
So we easily generated our database documentation here for the named table.  
  
Have fun!  
  
  
[MEDIA=youtube]ehJpIg592Qo[/MEDIA]