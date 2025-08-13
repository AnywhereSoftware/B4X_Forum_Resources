### Convert DateTime, Graphic, Boolean, Units by Guenter Becker
### 11/13/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/157358/)

Version: 1.1/2023  
  
The **Module** contains **functions to convert formats or units** to be needed in the daily life of software development as followes:  

- Convert Date or Time Values into B4x-Ticks or ISO8601 Format.
- Convert Boolean True/False into Integer 1/0 and reverse.
- Convert Decimal Point from Comma to Point and reverse
- Convert Image to Byte and reverse.
- Convert Length Units
- Convert Volumn Units
- Convert Weight Units
- Convert Speed Units
- Change Image color

The Module is developed in B4A Language.  
(C) Usage is free on your own risk for all registered Members on the Anywhere B4X Forum for private and commercial Use.  
The Module code is not obfuscated and clear to be read. The Code is well commented, easy to understand and needs no further explanations.  
Feel free to test the code and give comments if you find out errors or if you may have proposals for enhancement.  
  
It is recommended to copy the file 'TD\_Converter.bas' into the 'sharedBas' Folder of your Dev-Suite or copy it into your project.  
  

```B4X
Dim x as object  
x = TD_converter.TDconvertDateTime("01.05.2023","","date","iso8601")  
x = TD_converter.TDconvertDateTime("","13:30:00","time","ticks")  
x = TD_converter.TDconvertDateTime("01.05.2023","13:30:00","datetime","ticks")  
x= D_converter.TDconvertDecimal("1,000.5",",>.")
```

  
  
By the Way, the complete Framework *'TDFramework'* is planned to be published until end of january 2024 in this forum.  
If you like to get more information if it is published and to get it whatch out and search this forum for 'TDFramework'.  
  
The Framework includes this parts:  

- Part 1, Framework overview including Excourse 'SQLite/SQLCipher Database'
- Part 2, 'Proposals and Business Experiance of optimization of the Development of Software, Process or Organization'
(Extract from my Lectures as Guest Professor at the University)- Part 3, Collection of Custom Views
3.1 TD\_DBDetails, Dataform layout to automate datatransfer SQlite/SQLCipher Database <> databound (custom) Views
3.2 TD\_ActionBar, substitute standard Title/Action Bar
3.3 TD\_Statusbar, with Info, Database Management and Database Navigation Bars
3.4 TD\_Drawer, Sliding Menu with foldable Menu Items tree
3.5 TD\_DBUtils, Class with functions to Insert, Update, Delete, Select Data (SQLite or SQLiteCipher Database)
3.6 TD\_Convert, Module to convert Formats and Units