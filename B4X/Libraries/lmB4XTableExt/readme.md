###  lmB4XTableExt by LucaMs
### 04/13/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/158817/)

B4XLib library that adds useful functionalities to B4XTable. Currently for B4A and B4J.  
  
**Note that this library is NOT my custom version of the official and original B4XTable View, it does not replace it. It can be used together with the B4XTable View to add functionalities to the B4XTable View.**  
  
![](https://i.imgur.com/q6auEFA.gif)  
  
The main feature of this library, although not the only one, is having a type of filtering similar to that of Excel, i.e. with the column headers that "transform" to allow you to easily insert filters (one or more filters together ).  
The programmer user will only have to set the Filtered property on True/False, all the graphics (and obviously the logic) are managed by the library.  
  
Other useful features:  
  
- Automatic creation of table columns. You pass an open SQLite DB and a table name to the library and everything will be automatic. It is also possible to list N fields of the table not to load or pass a WHERE clause.  
  
- Automatic adaptation of column widths based on cells contents. It is possible to deactivate it and choose whether to also evaluate the column titles (default setting).  
  
- GetCellValue. The way to obtain the value of a clicked cell in B4XTable is not very intuitive; this method makes it easier.  
  
- Hide/unhide columns.  
  
- Export to Excel, including cell type (numbers, texts, dates).  
  
- Export to CSV text format.  
  
All the Views contained in the library have been declared Public, so that the programmer can easily customize (especially for localization, text translation).  
  
The use is very easy. Obviously you select (import) the lmB4XTableExt library and create a variable:  
  
Private lmTableExt As lmB4XTableExt  
  
and initialize it by passing it a B4XTable (plus what was said previously). Easy, it's the same way used by Erel for its classes that extend the functionality of CustomListView.  
  
It is a B4XLib type library, for which **you will have the source code** (you can modify it but it is forbidden to publish anything that uses this code, even if modified).  
  
It works with B4A and B4J (for now I'm attaching an animated gif of this version only); for B4i you will have to make few changes, mainly create two layout files (just copy and paste). I don't have Apple stuff, otherwise I obviously would have done.  
  
Perhaps it is not immediately understandable but the development required time, patience and some headaches, which is why the minimum donation requested is €7.50 (please, use the Donate button in my signature).  
  
**Methods**   

- DataUpdated
- ExportTableToCSV
- ExportTableToExcel
- GetCellValue
- HideColumn
- Resize
- SetDBTableName
- ShowColumn

  
**Properties**  

- AutoColumnSizing
- Filtered
- FilterFont
- FilterPanelColor
- FilterSymbolOff
- FilterSymbolOn
- FilterTextColor
- DBTableName
- WrongDateMsg1
- WrongDateMsg2