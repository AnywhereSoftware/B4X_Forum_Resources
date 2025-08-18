### [XLUtils] Creating Tables by Erel
### 05/09/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/130567/)

![](https://www.b4x.com/android/forum/attachments/113076)  
  
Tabular data can be converted to a Table object. Excel provides all kinds of nice features related to tables: <https://www.bluepecantraining.com/portfolio/convert-data-to-an-excel-table/>  
Tables are supported in XLSX (2007+) workbooks.  
  
Creating a table is a matter of calling XLSheetWriter.CreateTable with the defined range, name and style.  
  
You can see the various styles in Excel:  
  
![](https://www.b4x.com/android/forum/attachments/113079)  
  
= "TableStyleMedium3"  
  
It is also possible to load templates with tables and get the tables with Sheet.GetTables. You can create a template with a table, fill data and update the table area with Table.CellReferences.  
  
Notes:  
  
- Apache POI support for tables is quite basic.  
- Tables ranges are not really dynamic. You cannot use tables as an alternative to [dynamic named ranges](https://www.b4x.com/android/forum/threads/xlutils-templates-and-charts.130373/#content). You can use both features together.  
- Requires XLUtils v1.11+