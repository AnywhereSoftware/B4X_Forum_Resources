###  B4XTable - Cross platform, sortable, searchable, customizable table by Erel
### 02/08/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/102322/)

B4XTable is a paged based table. The UI is made of a horizontal xCLV. The data is stored in an in-memory SQLite database.  
  
![](https://www.b4x.com/basic4android/images/SS-2019-02-07_15.33.03.png)  
  
**How to use?**  
  
1. Add a B4XTable with the designer.  
2. Add the columns:  

```B4X
B4XTable1.AddColumn("US County", B4XTable1.COLUMN_TYPE_NUMBERS)  
B4XTable1.AddColumn("Name", B4XTable1.COLUMN_TYPE_TEXT)
```

  
There are currently three types: TEXT, NUMBERS and DATES.  
3. Set the data:  

```B4X
Dim data As List = su.LoadCSV2(File.DirAssets, "us_counties.csv", ",", headers)  
B4XTable1.SetData(data)
```

  
Data is a list. Each item in the list is an array of objects that represents a row.  
Example  

```B4X
Dim data As List  
data.Initialize  
data.Add(Array(1, 2, 3))  
data.Add(Array(4, 5, 6))  
B4XTable1.SetData(data)
```

  
  
When you call SetData the an in-memory db is created with the data.  
  
**CellClick event**  
  

```B4X
Sub B4XTable1_CellClicked (ColumnId As String, RowId As Long)  
   Dim RowData As Map = B4XTable1.GetRow(RowId)  
   Dim cell As String = RowData.Get(ColumnId)  
   Log(cell)  
End Sub
```

  
B4XTable.GetRow returns a Map with the row data. The row values are mapped to the columns ids.  
Tip: You can access the visible row ids with B4XTable.VisibleRowIds.  
  
**Customization**  
  
Many things can be customized. Will start with a few simple things.  
B4XTable.AddColumn returns a B4XTableColumn type instance. You can modify this type to change the column behavior:  

```B4X
Dim StateColumn As B4XTableColumn = B4XTable1.AddColumn("State", B4XTable1.COLUMN_TYPE_TEXT)  
StateColumn.Width = 80dip  
StateColumn.Sortable = False
```

  
By default all columns are sortable and text columns are searchable.  
  
Other fields that you can change are: Id, Searchable, Formatter, LabelIndex and DisableAutoResizeLayout. Not all of them will be covered in this tutorial.  
  
You can also call GetColumn with the column id to get a column type. The id equals to the title by default (can be changed).  
  
Attached examples show how to set a custom [B4XFormatter](https://www.b4x.com/android/forum/threads/102055/#content).  
  
B4XTable.VisibleColumns holds the list of displayed columns. By default all columns are displayed. You can remove columns from the list or change their order as needed. Call B4XTable.Refresh after you modify the list.  
  
Most of the table colors are set in the designer properties. The arrows colors are set with ArrowsEnabledColor / ArrowsDisabledColor.  
The fonts are set with HeaderFont and LabelsFont fields.  
  
**Custom Data Filters**  
  
You can call B4XTable.CreateDataView to create a custom filter.  
  
For example:  

```B4X
B4XTable1.CreateDataView($"${NumberColumn.SQLID} > 10"$)
```

  
The parameter passed is the SQL WHERE clause. NumberColumn is a B4XTableColumn and the SQLID returns the SQL column name.  
Another example:  

```B4X
B4XTable1.CreateDataView($"${NumberColumn.SQLID} > 10 AND ${NumberColumn.SQLID} < 15"$)
```

  
  
**Updates**  
  
V1.24 - "From To" text is removed when there are 0 rows.  
V1.22 - Fixes an issue with the 'go to last' feature. Thanks [USER=51832]@LucaMs[/USER]  
V1.21 - New HighlightSearchResults field. Allows disabling the search highlighting feature.  
V1.20 - Many changes under the hood. New RefreshNow method that refreshes the table synchronously. SetData returns a ResumableSub object and can be used with Wait For to (asynchronously) wait for the data to be ready.  
New SearchVisible field and designer property. Use it to hide the search field. Hiding the search field directly will no longer work.  
New COLUMN\_TYPE\_VOID column type. This type is useful for columns that don't hold any data. For example columns with editing buttons. Instead of adding empty values to the Data collection you ignore these columns.  
  
V1.18 - lblSort (sort arrow) is now public.  
V1.17 - Navigation state is set correctly when the table is cleared.  
V1.16 - Fixes an issue with frozen columns when the table is reused with new columns.  
V1.15 - New BuildQuery method. This method can be used to get the SQL query that was used to set the table data with the current state and filter. Usage example:  

```B4X
Dim o() As Object = B4XTable1.BuildQuery(False) 'True to include the page LIMIT in the query.  
Dim rs As ResultSet = B4XTable1.sql1.ExecQuery2(o(0), o(1))  
Do While rs.NextRow  
   Log(rs.GetString(B4XTable1.GetColumn("State").SQLID))  
Loop  
rs.Close
```

  
  
V1.10 - Fixes a bug with cell clicks on empty tables.  
V1.09 - The navigation buttons layout was fine tuned to be able to show three digits.  
V1.08 - New events: CellLongClicked and HeaderLongClicked. In B4J they fire when a cell is right clicked.  
V1.07 - NumberOfFreezedColumns field renamed to NumberOfFrozenColumns.  
V1.06 - NumberOfFreezedColumns field - allows freezing the first x columns. Set it immediately after you add the columns.  
V1.05 - HeaderClick event. Usage example: <https://www.b4x.com/android/forum/threads/b4x-table.102551/#post-643333>  
V1.04 - HeadersHeight field. Allows setting the headers height independently of RowHeight value.  
- AllowSmallRowHeightModifications field. By default the actual row height can be slightly different than the set RowHeight value. This is done to let the rows fill all of of the available space (except of the scroll bar in B4J).  
You can set this field to False to prevent this. This is mainly useful if you are using custom cells and want the heights to be static.  
V1.03 - Search term highlighting. Color is configurable with the designer.  
- PrefixSearch field - limits searches to prefix matches.  
- Better support for table resizing. See the updated B4A and B4i examples. The table is resized when the keyboard becomes visible.  
  
V1.02 - Setting the selection color to transparent color disables the cell click animation. This is useful when you want to create a custom selection logic.  
  
![](https://www.b4x.com/basic4android/images/SS-2019-02-06_15.44.21.png)  
<https://www.b4x.com/android/forum/threads/b4x-b4xtable-multiple-rows-selection.102364/>  
  
V1.01 - New DataUpdated event, MaximumRowsPerPage and other changes to make it simpler to create tables with custom layouts:  
  
![](https://www.b4x.com/basic4android/images/SS-2019-02-06_11.52.16.png)  
  
B4XTable examples and code snippets: [https://www.b4x.com/android/forum/pages/results/?query=b4xtable&prefix=19,23,20,30,8,9,18,21,27](https://www.b4x.com/android/forum/pages/results/?query=b4xtable&prefix=19%2C23%2C20%2C30%2C8%2C9%2C18%2C21%2C27)  
  
**Extensions:**  
  
- B4XTableSelections: <https://www.b4x.com/android/forum/threads/b4x-b4xtableselections-extended-selection-modes-for-b4xtable.114294/>  
Adds more selection models.  
- InlineEditing: <https://www.b4x.com/android/forum/threads/b4x-b4xtable-with-inline-editing.112686/>  
Helps with adding inline editing features.  
  
**B4XTable is an internal library.** 