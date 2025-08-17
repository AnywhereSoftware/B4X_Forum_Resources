###  [XUI] SD FlexGrid (Table) by Star-Dust
### 10/25/2023
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/100897/)

I created a new library to show a table (or grid) similar to the one in EXCEL.  
  
 There are already excellent classes that allow many to accomplish things, such as [**xCustomListView**](https://www.b4x.com/android/forum/threads/b4x-xui-xcustomlistview-cross-platform-customlistview.84501/) by [USER=1]@Erel[/USER] (B4X) and with the [**FlexibleTable**](https://www.b4x.com/android/forum/threads/class-flexible-table.30649/) by [USER=904]@klaus[/USER] (B4A). I wanted to make something slightly different suited to my needs.  
  
**WARNING**  
*The use of libraries for personal and / or commercial use is permitted. It is not allowed to modify the sources or change the name of the library. Reverse engineering is not authorized to access the sources for any reason, not even for study or learning reasons.*  
  
**Explanations**:  

1. To get the calculation of the cells that contain a formula I have added Erel's **[B4XEval](https://www.b4x.com/android/forum/threads/b4x-eval-expressions-evaluator.54629/#content)** to my Library, but as soon as possible I will make it external so that everyone can modify it according to their needs.
2. To select multiple cells, position yourself on the first cell of those to be selected (the one at the top left) click a shot and then click again and drag your finger to cover all the cells (or area) that you want to select
3. It is still in beta version, presents problems in large grids.
4. *Now only for* *B4A and B4i* **Now for B4A,B4i,B4j**
5. In the example to select a group of cells just **long click** on a cell (not checkbox). In the case of B4J click with the **right mouse** button

  
**SD\_FlexGrid  
  
Author:** Star-Dust  
**Version:** 0.45  

- **Eval**
*version 2.00  
Eval Method By Erel: <https://www.b4x.com/android/forum/threads/b4x-eval-expressions-evaluator.54629/>*

- **Fields:**

- **Error** As Boolean

- **Functions:**

- **Calculate** (Expression As String) As Double
- **Class\_Globals** As String
- **Initialize** (FG As FlexGrid) As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*
- **FlexGrid**

- **Events:**

- **CellClick** (Row As Int, Col As Int)
- **CellLongClick** (Row As Int, Col As Int)
- **FeetClick** (Index As Int)
- **HeadClick** (Index As Int)
- **Modified** (Row As Int, Col As Int)
- **ScrollX** (Position As Double)
- **ScrollY** (Position As Double)

- **Fields:**

- **EditBackgroundColor** As Int
- **EditTextColor** As Int
- **TypeButton** As Int
- **TypeCheck** As Int
- **TypeDouble** As Int
- **TypeFloat** As Int
- **TypeImage** As Int
- **TypeInt** As Int
- **TypeList** As Int
- **TypeString** As Int

- **Functions:**

- **AddRow** (Cell As Object(), Refresh As Boolean) As String
 *eg. Flexgrid.AddRow(Array As Object(i,B,"User ","Description " ,100.00), True)*- **AddRow2** (Cell As Object(), HeightRow As Int, Refresh As Boolean) As String
 *eg. Flexgrid.AddRow(Array As Object(i,B,"User ","Description " ,100.00),40dip,True)*- **AddRowAt** (index As Int, Cell As Object(), Refresh As Boolean) As String
 *eg. Flexgrid.AddRow(2,Array As Object(i,B,"User ","Description " ,100.00), True)*- **AddRowCustomize** (Cell As Object(), Text\_Color As Int, Background\_Color As Int, TextFont As B4XFont, Refresh As Boolean) As String
- **AddToParent** (Parent As B4XView, Left As Int, Top As Int, Width As Int, Height As Int, ColsNumber As Int) As String
 *Parent is Panel to Add Grid  
 eg. Flexgrid.AddToParent(Activity,0,0,100%x,100%y,5)*- **Class\_Globals** As String
- **ClearRows** As String
 *erase all rows contents*- **ClearSelection** As String
 *cell no longer be selected.*- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **EditCell** (Row As Int, Col As Int) As String
 *eg. Flexgrid.EditCell(1,1)*- **EditCellOnSite** (Row As Int, Col As Int) As String
 *eg. Flexgrid.EditCell(1,1)*- **GetCellBackgroundColor** (Row As Int, Col As Int) As Int
- **GetCellCol** (Col As Int) As Object()
*eg. Dim S() as String = Flexgrid.GetCellCol(1)  
 eg. Dim B() as Boolean = Flexgrid.GetCellCol(2)*- **GetCellRow** (Row As Int) As Object()
 *eg Dim Row() as Object = Flexgrid.GetCellRow(1)*- **GetCellTextColor** (Row As Int, Col As Int) As Int
- **GetCellTextFont** (Row As Int, Col As Int) As B4XFont
- **GetCellValue** (Row As Int, Col As Int) As Object
 *eg. Dim I as int = Flexgrid.GetCellValue(1,1)  
 eg. Dim S as String = FlexGrid.GetCellValue(2,2)*- **GetTypeCol** (Col As Int) As Int
 *eg. If Flexgrid.GetTypeCol(1)=Flexgrid.TypeInt Then …..*- **Initialize** (Callback As Object, EventName As String) As String
- **Invalidate** As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **RemoveRow** (Row As Int) As String
 *Row (0…n-1)  
 eg. Flexgrid.RemoveRow(1)*- **ResetCustomizeCell** (Col As Int, Row As Int) As String
 *eg. Flexgrid.ResetCustomizeCell(1,1)*- **SearchInColumn** (Text As String, Col As Int, FromRow As Int, exactly As Boolean, IgnoreCap As Boolean) As Int
*Search for text in the indicated column starting from the start row.  
 If the start row is 0 it will check the entire column.  
 It will return the position of the line containing the text  
 <code>Dim Col As Int = 5  
 Dim Row As Int = FlexGied1.SearchInColumn("My text",Col,0, False, True)  
 if Row>-1 then Log("Find in row " & Row) Else log("Don't find")  
 </code>*- **SearchInColumn2** (Text As String, Col As Int, FromRow As Int, exactly As Boolean, IgnoreCap As Boolean) As List
*Search for text in the indicated column starting from the start row.  
 If the start row is 0 it will check the entire column.  
 It will return the list of position of the line containing the text  
 <code>Dim Col As Int = 5  
 Dim IndexFinded As List = FlexGied1.SearchInColumn2("My text",Col,0, False, True)  
 if IndexFinded.Size>0 then Log("Find in row " & Row) Else log("Don't find")  
 </code>*- **SelectCell** (Row As Int, Col As Int, Mobile As Boolean) As String
 *eg. Flexgrid.SelectCell(1,1,True)  
 If Mobile is True, the selectable area can be enlarged by touching and dragging it to the desired box.*- **SelectCells** (FromRow As Int, FromCol As Int, ToRow As Int, ToCol As Int, Mobile As Boolean) As String
 *eg. Flexgrid.SelectCell(1,1,5,4,True)  
 If Mobile is True, the selectable area can be enlarged by touching and dragging it to the desired box.*- **SelectCol** (Col As Int) As String
 *eg. Flexgrid.SelectCol(1)*- **SelectRow** (Row As Int) As String
 *eg. Flexgrid.SelectRow(1)*- **SetCellCustomize** (Row As Int, Col As Int, Text\_Color As Int, Background\_Color As Int, TextFont As B4XFont) As String
 *eg. Flexgrid.SetCellCustomize(1,1,XUI.Color\_Black,XUI.Color\_White,XUi.CreateDefaultFont(12))*- **SetCellListIndex** (Row As Int, Col As Int, Index As Int) As String
- **SetCellValue** (Row As Int, Col As Int, Value As Object) As String
 *eg. Flexgrid.SetCellValue(1,1,True)  
 eg. Flexgrid.SetCellValue(2,2,"OK")  
 eg. Flexgrid.SetCellValue(3,3,3)  
 eg. Flexgrid.SetCellValue(Row,Col,"A,B,C,D,E") for TypeList*- **SetColAlignment** (ColumnIndex As Int, Alignment As String) As String
 *Index (0..n-1)  
 eg. SetColAlignment(0,"CENTER")*- **SetColCustomize** (Col As Int, Text\_Color As Int, Background\_Color As Int, TextFont As B4XFont) As String
 *eg. Flexgrid.SetColCistomize(1,XUI.Color\_Black,XUI.Color\_White,XUi.CreateDefaultFont(12))*- **SetColName** (ColumnIndex As Int, Name As String) As String
 *Index (0..n-1)  
 eg. Flexgrid.SetColName(1,"Help")*- **SetColsNumber** (ColumnNumber As Int) As String
 *Reset Grid and Change Cols Number*- **SetColType** (ColumnIndex As Int, Typ As Int) As String
 *Index (0..n-1)  
 eg. SetColType(0,FlexGrid.TypeInt)*- **SetColWidth** (ColumnIndex As Int, Width As Int) As String
 *Index (0..n-1)  
 eg. SetColWidth(0,100dip)*- **SetDataRow** (Row As Int, Cell As Object()) As String
 *eg. Flexgrid.SetRow(Row,Array As Object(i,B,"User ","Description " ,100.00))*- **SetDataRow2** (Row As Int, Cell As Object(), HeightRow As Int) As String
 *eg. Flexgrid.SetRow2(Row,Array As Object(i,B,"User ","Description " ,100.00),40dip)*- **SetFeetHeight** (Height As Int) As String
 *Set Header Height*- **setFootColValue** (col As Int, Fv As String) As String
 *eg. Flexgrid.FeetValue=array As String ("First","Second")*- **setHeaderAlignment** (Col As Int, Alignment As String) As String
 *eg. Flexgrid.HeaderAlignment="CENTER"*- **SetHeadHeight** (Height As Int) As String
 *Set Header Height*- **SetPadding** (Left As Int, Top As Int, Right As Int, Bottom As Int) As String
 *eg. FlexGrid1.SetPadding(10dip,0,10dip,0)*- **SetRowCustomize** (Row As Int, Text\_Color As Int, Background\_Color As Int, TextFont As B4XFont) As String
 *eg. Flexgrid.SetRowCustomize(1,XUI.Color\_Black,XUI.Color\_White,XUi.CreateDefaultFont(12))*- **SetRowHeight** (IndexRow As Int, Height As Int) As String
 *IndexRow (0..Size-1)  
 eg. setRowHeight(0,60dip)*- **SetRowsHeight** (Height As Int) As String
 *Set all Rows Height*- **SetSingleLine** (SLine As Boolean) As String
 *To set the cells to single or multiple lines*- **SortForCol** (Column As Int) As String

- **Properties:**

- **Base** As B4XView [read only]
- **ColCount** As Int [read only]
- **ColorSelectedArea**
*Set the color of the selected area*- **ColorSelectingArea**
 *Set the color of the area during the selection phase*- **ColsAlignment**
 *eg. setColsAlignment(Array As String ("LEFT","CENTER","CENTER","RIGHT"))*- **ColsName** As String()
 *eg. Flexgrid.ColName=array As String ("First","Second")*- **ColsType**
 *eg. ColsType=Array As Int(FlexGrid1.TypeInt,FlexGrid1.TypeCheck,FlexGrid1.TypeString,FlexGrid1.TypeString,FlexGrid1.TypeFloat)*- **ColsWidth**
 *eg. SetColsWìdth(Array As Int (100dip,50dip,100dip,100dip))*- **Font**
 *eg. Flexgrid.Font=xui.CreateDefaultFont(12)*- **FootFont**
 *eg. Flexgrid.FeetFont=xui.CreateDefaultFont(12)*- **FootValue** As String()
 *eg. Flexgrid.FeetValue=array As String ("First","Second")*- **FootVisible**
 *eg. FG.FeetVisible=True*- **HeaderFont**
 *eg. Flexgrid.HeaderFont=xui.CreateDefaultFont(12)*- **HeaderVisible**
 *eg. FG.HeadVisible=True*- **Height** As Int
- **RowCount** As Int [read only]
 *Dim Size as int = Flexgrid.RowCount*- **ScrollToCol**
 *eg. Flexgrid.ScroolToCol=50 (Col= 0..Size-1)*- **ScrollToRow**
 *eg. Flexgrid.ScroolToRow=50 (Row= 0..Size-1)*- **ScrollX** As Double
- **ScrollY** As Double
- **SelectedColumnEnd** As Int [read only]
 *return -1 if not selected*- **SelectedColumnStart** As Int [read only]
 *return -1 if not selected*- **SelectedRowEnd** As Int [read only]
 *return -1 if not selected*- **SelectedRowStart** As Int [read only]
 *return -1 if not selected*- **Width** As Int

  
  
![](https://www.b4x.com/android/forum/attachments/75757) ![](https://www.b4x.com/android/forum/attachments/75758) ![](https://www.b4x.com/android/forum/attachments/75760)  
![](https://www.b4x.com/android/forum/attachments/75761) ![](https://www.b4x.com/android/forum/attachments/75762) ![](https://www.b4x.com/android/forum/attachments/75759)  
  
List/Spinner  
![](https://www.b4x.com/android/forum/attachments/video7-gif.118379/)  
  
For more details: <https://www.b4x.com/android/forum/threads/xui-flexgrid.98686/>  
  
**Significative release logs:**  

- **0.12**

- Add method **SelectCells** (FromRow As Int, FromCol As Int, ToRow As Int, ToCol As Int, Mobile As Boolean)
- Modify method **SelectCell** (Row As Int, Col As Int, Mobile As Boolean)

- **0.15:** Added **HeaderFont**
- **0.16:** Added **SetColsNumber** method.
- **0.19** ([Sample](https://www.b4x.com/android/forum/threads/b4x-xui-sd-flexgrid-table.100897/post-835017))

- Add method **AddRowCustomize** (Cell As Object()
- Add method ***SearchInColumn** (Text As String, Col As Int, FromRow As Int, exactly As Boolean, IgnoreCap As Boolean) As Int*

- **0.21**

- Add **TypeList.** Allows you to add a ComboBox type box (Spinner in B4A and Picker in B4i) and select to a list
- Added other examples to [POST n. 2](https://www.b4x.com/android/forum/threads/b4x-xui-sd-flexgrid-table.100897/post-636136) To populate the grid from the database, search for a string in a column and to use TypeList in the grid
- added **SetCellListIndex** method to change the position of the selected index

- **0.25**

- Added **SetHeadHeight** method
*sets the height of the header*- Added **SetRowsHeight** method
*sets the height of all lines*
- **0.27**

- added properties **ScrollX** and **ScrollY**
- Added events **ScrollX()** and **ScrollY()**

- **0.29**: Fixed bugs in vertical scrolling
- **0.31**

- Added **SortForCol**(Column As Int)
- Added **SetDataRow**(Row As Int, Cell() As Object) and **SetDataRow2**(Row As Int, Cell() As Object, HeightRow As Int)
- Added field **ColorSelectedArea** and **ColorSelectingArea**
- Fix bug

- **0.32**

- Added **SearchInColumn2**. Returns the list of search result lines

- **0.33**

- Added **setHeaderAlignment**

- **0.34**

- Added the ability to freeze the last row (foot row) as well as the header so you can enter column totals that always remain visible
- Fix minor bugs

- **0.35**

- Added the ability to select from Design that text cells are single or multiline

- **0.36**

- Fix bugs: SortForCol; SetColsNumber

- **0.37**

- Added: **EditTextColor** and **EditBackgroundColor** fields to be able to select colors for the on-site editable cell. By default it is black background and white text

- **0.38**

- Fixed bug on CheckBox alignment

- **0.39**

- Singleline and multiline option of the design now also affects the column header and column foot

- **0.40**

- Added **ScrollToCol** (together with ScrollToRow it is possible to position in a specific cell)

- **0.41**

- Fix bug

- **0.42**

- Added **Width** and **Height** to change the size of the grid from code during execution

- **0.43**

- Fixed bug on **SearchInColumn2**

- **0.44**

- Added SetSingleLine - To set the cells to single or multiple lines

- **0.45**

- Added SetPadding