### [XLUtils] Hyperlinks and Outlining / Grouping by Erel
### 05/05/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/130413/)

XLUtils v1.03 adds support for grouping rows and columns and for adding links.  
  
![](https://www.b4x.com/android/forum/attachments/112806)  
  
Grouping is done with XLSheetWriter.GroupRows / Columns.  
By default the expand button is positioned at the bottom.  
You can move it to the top using a template. Choose Data - Outline settings and uncheck "summary rows below detail":  
  
![](https://www.b4x.com/android/forum/attachments/112808)  
  
Adding links is done with XLSheetWriter.CreateHyperlink:  

```B4X
Dim LinkStyle As XLStyle = workbook.CreateStyle.FontLink(11).HorizontalAlignment("CENTER")  
Sheet.PutString(xl.AddressName("A1"), "Data source - https://ourworldindata.org")  
Sheet.CreateHyperlink(Sheet.LastAccessed, "URL", "https://ourworldindata.org/coronavirus-source-data")
```

  
  
There are four types of links:  
URL - web link  
DOCUMENT - location in the workbook - Country!A13  
EMAIL - mailto:[EMAIL]poi@apache.org[/EMAIL]?subject=Hyperlinks  
FILE - path to file  
  
Example project is attached. The data file is excluded due to its size. Download it: <https://covid.ourworldindata.org/data/owid-covid-data.csv> and put it in the Files folder.