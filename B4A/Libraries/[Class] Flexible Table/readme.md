### [Class] Flexible Table by klaus
### 05/22/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/30649/)

This thread will be used by Erel, Melamoud and myself to discuss / post new releases of the Table class.  
  
The table class is a flexible UI component that enable scrollable table like UI, with sortable columns, multiselect rows etc  
  
the table is very efficient, maintaining labels only for visible rows  
  
old thread with details : <http://www.b4x.com/forum/additional-libraries-classes-official-updates/19254-class-tableview-supports-tables-any-size.html#post110901>  
  
The class depend on following libraries:  
- StringUtils (standard)  
- SQL (standard)  
- JavaObject (standard)  
- B4XCollections (standard)  
- [ScrollView2D](https://www.b4x.com/android/forum/threads/lib-scrollview2d.19268/#content) (additional)  
  
List of major features.  
1. scrollable table UI  
2. sortable columns  
3. select a row, cell or multi select rows  
4. callback for selection / click a cell / row  
5. callback for long click action  
6. read / write to CSV file  
  
Current version –> **3.36** Custom View  
Current version –> 1.44 Class  
  
**Other complementary routines:  
  
Load data with the Remote Database Connector.**  
  
EDIT: LucaMs has written a routine to fill a table with a Remote Database Connector query result see [post 182](http://www.b4x.com/android/forum/threads/class-flexible-table.30649/page-10#post-238972).  
The routine hasn't been added into the Class for the reasons explained in [post 183](http://www.b4x.com/android/forum/threads/class-flexible-table.30649/page-10#post-239001).  
A sample program can be found [HERE](http://www.b4x.com/android/forum/threads/come-fate-a-popolare-una-grid.39994/#post-238996).  
  
Code:  

```B4X
'load data from a RDC Request  
'Result = DBResult object got from a RDC request  
'AutomaticWidths  True > set the column widths automaticaly  
'Written by LucasMs  
Public Sub LoadRDCResult(Result As DBResult, AutomaticWidths As Boolean)  
    cAutomaticWidths = AutomaticWidths  
    NumberOfColumns = Result.Columns.Size  
    innerClearAll(NumberOfColumns)  
  
    Dim Headers(NumberOfColumns) As String  
    Dim ColumnWidths(NumberOfColumns) As Int  
    Dim HeaderWidths(NumberOfColumns) As Int  
    Dim DataWidths(NumberOfColumns) As Int  
    Dim col, row As Int  
    Dim str As String  
    For col = 0 To NumberOfColumns - 1  
        Headers(col) = Result.Columns.GetKeyAt(col)  
        If AutomaticWidths = False Then  
            ColumnWidths(col) = 130dip  
            HeaderWidths(col) = 130dip  
            DataWidths(col) = 130dip  
        Else  
            HeaderWidths(col) = cvs.MeasureStringWidth(Headers(col), Typeface.DEFAULT, cTextSize) + 8dip + cLineWidth  
            DataWidths(col) = 0  
  
            Dim FieldValue As Object  
            For row = 0 To Result.Rows.Size - 1  
                Dim Record() As Object = Result.Rows.Get(row)  
                FieldValue = Record(col)  
                If GetType(FieldValue) = "java.lang.String" Then  
                    DataWidths(col) = Max(DataWidths(col), cvs.MeasureStringWidth(str, Typeface.DEFAULT, cTextSize) + 8dip + cLineWidth)  
                End If  
            Next  
            ColumnWidths(col) = Max(HeaderWidths(col), DataWidths(col))  
        End If  
    Next  
    SetHeader(Headers)  
    SetColumnsWidths(ColumnWidths)  
  
    For Each Record() As Object In Result.Rows  
        Dim R(NumberOfColumns) As String  
        Dim FieldV As String  
        For col = 0 To NumberOfColumns - 1  
            FieldV = Record(col)  
            R(col) = FieldV  
        Next  
        AddRow(R)  
    Next  
End Sub
```

  
  
This is another routine updated by [cimperia](https://www.b4x.com/android/forum/members/cimperia.73319/) in [post #392](https://www.b4x.com/android/forum/threads/class-flexible-table.30649/page-20#post-331198) using a Map for the columns and a List for the rows.  

```B4X
'load data from a RDC Request  
'A RDC request returns a DBResult object, therefore this method  
'could be called as is:  
'LoadRDCResult(DBResult.Columns, DBResult.Rows, True)  
'AutomaticWidths  True > set the column widths automaticaly  
'Written by LucasMs  
Public Sub LoadRDCResult(Columns As Map, Rows As List, AutomaticWidths As Boolean)  
  cAutomaticWidths = AutomaticWidths  
  NumberOfColumns = Columns.Size  
  innerClearAll(NumberOfColumns)  
  
  Dim Headers(NumberOfColumns) As String  
  Dim ColumnWidths(NumberOfColumns) As Int  
  Dim HeaderWidths(NumberOfColumns) As Int  
  Dim DataWidths(NumberOfColumns) As Int  
  Dim col, row As Int  
  Dim str As String  
  For col = 0 To NumberOfColumns - 1  
    Headers(col) = Columns.GetKeyAt(col)  
    If AutomaticWidths = False Then  
      ColumnWidths(col) = 130dip  
      HeaderWidths(col) = 130dip  
      DataWidths(col) = 130dip  
    Else  
      HeaderWidths(col) = cvs.MeasureStringWidth(Headers(col), Typeface.DEFAULT, cTextSize) + 8dip + cLineWidth  
      DataWidths(col) = 0  
  
      Dim FieldValue As Object  
      For row = 0 To Rows.Size - 1  
        Dim Record() As Object = Rows.Get(row)  
        FieldValue = Record(col)  
       If GetType(FieldValue) = "java.lang.String" Then  
         DataWidths(col) = Max(DataWidths(col), cvs.MeasureStringWidth(str, Typeface.DEFAULT, cTextSize) + 8dip + cLineWidth)  
       End If  
      Next  
      ColumnWidths(col) = Max(HeaderWidths(col), DataWidths(col))  
    End If  
  Next  
  SetHeader(Headers)  
  SetColumnsWidths(ColumnWidths)  
  
  For Each Record() As Object In Rows  
    Dim R(NumberOfColumns) As String  
    Dim FieldV As String  
    For col = 0 To NumberOfColumns - 1  
      FieldV = Record(col)  
      R(col) = FieldV  
    Next  
    AddRow(R)  
  Next  
End Sub
```

  
  
  
**Load data from a MSMariaDB database.**  
  
Another routine for loading data from a MSMariaDB database can be found in [post#727](https://www.b4x.com/android/forum/threads/class-flexible-table.30649/page-37#post-516791).  
Thanks to [USER=45973]@Magma[/USER].  
  
**Updates:**  
EDIT: 2025.05.22 Version 3.36  
Removed unnecessary execution of SVF\_ScrollChanged when no columns are blocked  
  
EDIT: 2024.04.21 Version 3.35  
Replaced the original sorting functions by new ones kindly provided by forum member RB Smissaert.  
Amended first scroll scrolling back to 0  
Amended Header with transparent color  
  
EDIT: 2024.01.13 Version 3.33  
Changed possible values for DataType  
TEXT and NUMBER become T, R and I  
Amended problem with column colors  
Amended problems with SetHeaderColors and SetHeaderTextColors  
  
Version 3.32  
Amended Header and HeaderFirst problem in SaveCSVFromTable  
Moved If (lblStatusline… from AddRow to ShowRow  
  
Version 3.31  
Added SingleLine property for the Designer  
Added StatusLineHeight as a property  
Added FastScrollLabelMaxChars as a property  
  
EDIT: 2021.06.28 Version 3.30  
Added a check for none numeric values for numeric sorting.  
  
EDIT: 2021.06.28 Version 3.29  
Amended problem with column colors  
Version 3.28  
Added NumberOfColumns in the code  
Added TopRowIndex method  
Version 3.27  
Amended MultiSelect EDIT: 2020.09.02 Version 3.26  
Amended problem with sort with remove accents  
Amended problem with SetRowColorN  
Added SetCellAlignmentColN method  
Added SetHeaderAlignmentColN method  
  
EDIT: 2020.08.05 Version 3.24  
Amended problem with JumpToRowAndSelect not being selected.  
Amended error when setting RowHeight before the table initialized  
  
EDIT: 2020.06.19 Version 3.22  
Amended error in the insertRowAt routine.  
  
EDIT: 2020.05.25 Version 3.21  
Amended bug with TextSize in fixed columns  
  
EDIT: 2020.05.16 Version 3.20  
Added fast scroll feature  
Version 3.19  
Improved automatic width calculation and hidden columns  
Version 3.18  
Added a check in RemoveRowColorN to ensure that Row is not out of bounds  
Added ShowRow event  
Amended automatic width calculations  
Amended hidden column width problem  
  
EDIT: 2020.04.21 Version 3.17  
Amended HeaderHight problem with fixed columns  
  
EDIT: 2020.04.21 Version 3.16  
Amended two errors.  
  
EDIT: 2020.04.14 Version 3.14  
Added the methods below  
- LoadSQLiteDB4(SQLite As SQL, Query As String, AutomaticWidths As Boolean)  
loads SQLite data with data type checking  
- LoadSQLiteDB5(SQLite As SQL, Query As String, Values() As String, AutomaticWidths As Boolean).  
loads SQLite data with data type checking , similar to LoadSQLiteDB4 but for parametrized queries.  
- GetColumnDataTypes As String(), returns an Array with the data type for each column.  
- GetColumnDataType(Column As Int) As String, returns the data type of the fiven column.  
Added the InnerTotalWidth property, read only.  
Added multiple first fiexed columns  
Added line colors  
  
EDIT: 2020.03.10 Version 3.10  
Amended bug reported [HERE](https://www.b4x.com/android/forum/threads/class-flexible-table.30649/post-717102)  
  
EDIT: 2020.03.06 Version 3.09  
Amended bug reported [HERE](https://www.b4x.com/android/forum/threads/class-flexible-table.30649/post-716212).  
  
EDIT: 2020.02.29 Version 3.08  
Amended SetHeaderTypefaces method problem reprted [HERE](https://www.b4x.com/android/forum/threads/table-class-invalid-number-of-columns.114450/).  
Added HeaderTypeface property.  
  
EDIT: 2020.01.08 Version 3.07  
Amended bug [ShowStatisLine = False property bug](https://www.b4x.com/android/forum/threads/flexible-table-showstatusline-problem.112835/).  
Added MultiSelect property to Designer properties.  
**You need to open and close the Designer when you use the new version the first time to make the MultiSelect property active.**  
  
EDIT: 2019.12.28 Version 3.06  
Amened some bugs  
  
EDIT: 2019.12.25 Version 3.05  
Added FirstColumnFixed property which allows to fix the first column.  
*Attention*: You need to open and close the Designer to make the new property active.  
  
EDIT: 2019.11.15 Version 3.04  
- Added SelectedRowTextColor and SlectedCellTextColor properties  
- Added ZeroSelections property, True > when a selected row is pressed it will be unselected False > it remains selected.  
  
EDIT: 2019.11.12 Version 3.03  
- Changed JumpToRowAndSelect(Row As Int, Col As Int) to JumpToRowAndSelect(Col As Int, Row As Int)  
- Changed LoadSQLiteDB2 signature. Replaced the possible values from "T", "I", "R" to "TEXT", "NUMBER" for coherence with SetColumnDataTypes.  
- Added internal sorting bitmaps, avoids loading the image files into the Files folder.  
- Added two new properties: SortBitmapWidth and SortBitmapColor.  
- Added SetCustomSortingBitmaps method, which allows to use custom bitmaps instead of the internal ones.  
*Attention*: You need to open and close the Designer to make the new properties active.  
*Attention*: You need to invert the parameters in JumpToRowAndSelect.  
  
EDIT: 2019.07.04 Version 3.02  
Amended error reported in post #887  
  
EDIT: 2019.06.26 Version 3.01  
Amended SingleLine property setting in the code  
  
EDIT: 2019.04.05 Version 3.00  
Amended SetColumnColors and SetTextColors  
Removed Reflection library dependency  
  
EDIT: 2018.04.11 Version 2.29  
Version 2.27  
set the two variables sortedCol and sortingDir to Public instaed of Private  
added RemoveAccent routine for sorting with accented characters  
Version 2.28  
Added SetHeaderTypeFaces  
Added SortRemoveAccents property  
Version 2.29  
Added SaveTableToCSV2 with a user defined separator character  
  
EDIT: 2018.04.11 Version 2.26  
added LoadSQLiteDB3 method using SQLExec2 instead of SQLExec  
The query can include question marks which will be replaced with the values in the array.  
  
EDIT: 2018.03.27 Version 2.25  
amended minor errors  
added UpdateCell method  
  
EDIT: 2017.11.19 Version 2.22  
improved JumpToRowAndSelect scrolls horizontally to the selected column  
improved setHeaderHeight  
added padding for status bar Label  
  
EDIT: 2017.06.27 Version 2.19  
Replaced DoEvents by Sleep(0)  
Asked [HERE](https://www.b4x.com/android/forum/threads/class-flexible-table.30649/page-37#post-513561)  
  
EDIT: 2017.06.27 Version 2.19  
Replaced DoEvents by Sleep(0)  
Asked [HERE](https://www.b4x.com/android/forum/threads/class-flexible-table.30649/page-37#post-513561)  
  
EDIT: 2017.05.16 Version 2.18  
Amended error reported [HERE](https://www.b4x.com/android/forum/threads/tableview-error-due-to-dynamic-column-count-and-setcellalignments.77430/#post-490641).  
  
EDIT: 2017.03.09 Version 2.17  
Amended error reported [HERE](https://www.b4x.com/android/forum/threads/tableview-error-due-to-dynamic-column-count-and-setcellalignments.77430/#post-490641).  
  
EDIT: 2017.03.09 Version 2.15  
Amended error reported [here](https://www.b4x.com/android/forum/threads/class-flexible-table.30649/page-36#post-488129), Event signatures  
#Event: CellClick(col As Int, row As Int)  
#Event: CellLongClick(col As Int, row As Int)  
  
EDIT: 2016.12.05 Version 2.14  
Added NumberOfColumns and NumberOfRows as Public variables.  
Amended error reported [here](https://www.b4x.com/android/forum/threads/flexi-table-error.75880/).  
  
EDIT: 2016.12.05 Version 2.13  
Amended error reported here.  
Added NumberOfColumns as a property for the Designer.  
  
EDIT: 2016.07.30 Version 2.10  
Amended error with TextAlignment and HeaderTextAlignment reported in post #606  
  
EDIT: 2016.03.15 Version 2.00  
Added CustomView support.  
This version can be compiled into a library.  
Changes between the previous versions and version 2.00  
For a Table added in the Designer, this is new  
No need to initialize nor add it onto a parent view  
'For a Table added in the Designer, this is new  
'No need to initialize nor add it onto a parent view  
  
For a Table added in the code:  
The Initialize routine has been splittend into two routines.  
New:  
[FONT=Courier New]Initialize (CallBack As Object, EventName As String)  
InitializeTable (vNumberOfColumns As Int, cellAlignement As Int, showStatusL As Boolean)[/FONT]  
'Example:  
[FONT=Courier New]Table1.Initialize(Me, "Table1")  
Table1.InitializeTable(5, Gravity.CENTER\_HORIZONTAL, True)[/FONT]  
  
Old:  
[FONT=Courier New]Initialize(CallBack As Object, EventName As String, vNumberOfColumns As Int, cellAlignement As Int, showStatusL As Boolean)[/FONT]  
Example:  
[FONT=Courier New]Table1.Initialize(Me, "Table1", 5, Gravity.CENTER\_HORIZONTAL, True)[/FONT]  
  
EDIT: 2015.04.29 Version 1.43  
As the modifications in LoadSQLiteDB don't work in all cases I went back.  
LoadSQLiteDB as in version 1.40  
Added LoadSQLiteDB2 where the column data types must be given.  
  
EDIT: 2015.04.26 Version 1.42  
Changed he LoadSQLiteDB routine, version 1.41 didn't work as expected.  
The final solution was suggested by cimperia [HERE](https://www.b4x.com/android/forum/threads/sqlite-cursor-getstring-versus-getdouble.52903/#post-333303).  
  
EDIT: 2015.04.16 Version 1.41  
Changed the LoadSQLiteDB routine according to the error reported in the [SQL issue](https://www.b4x.com/android/forum/threads/sql-issue.52806/#post-331200) thread  
and the [SQLite Cursor GetString versus GetDouble](https://www.b4x.com/android/forum/threads/sqlite-cursor-getstring-versus-getdouble.52903/#post-331420) thread.  
The problem appears with numbers bigger than 999999.  
I left version 1.40 in case of problems.  
I tested it with a few databases, but I am not sure if it works in all cases.  
  
EDIT: 2015.03.05  
Amended bugs reported in posts #383 and #386  
Added SetAutomaticWidths routine  
  
EDIT: 2015.02.19  
Amended the problem alignment reported in post # 378  
  
EDIT: 2015.02.13  
Amended the problem of rows not shown reported in post # 371  
  
EDIT: 2015.01.09  
Added header aligments  
  
EDIT: 2014.08.14  
Added HeaderHeight property  
Amended RowColor problem reported in [post #260](http://www.b4x.com/android/forum/threads/class-flexible-table.30649/page-13#post-264727)  
  
EDIT: 2014.08.10  
Added SortColumn property asked in post #266  
Added UseColumnColors ColumnColors and HeaderColors propeties  
  
EDIT: 2014.05.10 Added RowHeight as a property  
  
**Screenshot:**  
  
![](https://www.b4x.com/android/forum/attachments/94167)