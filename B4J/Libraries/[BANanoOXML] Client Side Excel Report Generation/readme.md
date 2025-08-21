### [BANanoOXML] Client Side Excel Report Generation by Mashiane
### 11/03/2019
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/110582/)

Yippie!!  
  
  
In case you need something like this one day, so here is my BANano implementation of it for y'all. With this one is able to CREATE Excel workbooks with multiple sheets. One is able to also set styles e.g. bold, italic, forecolor, add borders. Once generated, the workbook is automatically downloaded. So happy to have found [this lib](https://github.com/jiteshkumawat/oxml.js) on the net.  
  
![](https://www.b4x.com/android/forum/attachments/84723)  
  
  
Usage:  
  
In AppStart  
  

```B4X
BANano.Header.AddJavascriptFile("fileSaver.min.js")  
    BANano.Header.AddJavascriptFile("jszip.min.js")  
    BANano.Header.AddJavascriptFile("oxml.min.js")
```

  
  
In your module  
  

```B4X
Private oxml As BANanoOXML  
    oxml.Excel("themash.xlsx")  
    Dim wkSheet As BANanoObject = oxml.WorkSheet("TheMash")  
    oxml.SetNumber(wkSheet, 1, 1 , 10)  
    oxml.SetNumber(wkSheet, 1, 2, 20)  
    oxml.SetNumber(wkSheet, 1, 3, 30)  
    '  
    oxml.SetText(wkSheet, 3,1, "Hello There!")  
    '  
    oxml.SetSharedText(wkSheet, 4, 1, "Total")  
    '  
    oxml.SetFormula(wkSheet,1,4, "SUM(A1:C1)")
```

  
  
You can set styles on cells like this…  
  

```B4X
Dim cellx As BANanoObject = oxml.GetCell(wkSheet, 3, 1)  
    Dim style As OXMLStyle = oxml.CreateStyle  
    style.bold = True  
    style.fontColor = "ff0000"  
    style.italic = True  
    style.underline = True  
    style.fontName = "Calibri Light"  
    style.borderColor = "ff0000"  
    style.borderThickness = oxml.BorderThick  
    oxml.SetStyle(cellx, style)  
   
    'get cell  
    Dim cell As BANanoObject = oxml.GetCell(wkSheet, 1, 4)  
    oxml.SetCellText(cell, "Anele Mbanga Enjoying This!")
```

  
  
Then download the workbook.  
  

```B4X
oxml.download(Me, "onDownload")
```

  
  
We have added a callback on the download..  
  

```B4X
Sub onDownload  
    BANano.Window.Alert("Done Excel Report!")  
End Sub
```

  
  
Have Fun!