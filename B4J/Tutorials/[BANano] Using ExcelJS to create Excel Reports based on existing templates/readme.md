### [BANano] Using ExcelJS to create Excel Reports based on existing templates by Mashiane
### 08/13/2024
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/162522/)

Hi Fam  
  
I wanted to generate an excel report based on an existing template. The template should have some existing structure in it, so I need to read it and then update the portions I need and then write it back by saving it.  
  
I have talked about reading and creating Excel reports here.  
  
1. <https://www.b4x.com/android/forum/threads/bananooxml-client-side-excel-report-generation.110582/#content>  
  
This unfortunately does not support reading existing files and updating them, though you can create and style your new report in whatever way you want.  
  
2. <https://www.b4x.com/android/forum/threads/bananoexcelreader-read-excel-file-and-return-json-array.117529/#content>  
  
This was to read the contents of an existing excel sheets. Usually when you want to read the csv contents and then process them further.  
  
For this part, whilst you can create a new workbook & sheet, I wanted to explore reading an existing excel template. For this I found this github.  
  
<https://github.com/exceljs/exceljs>