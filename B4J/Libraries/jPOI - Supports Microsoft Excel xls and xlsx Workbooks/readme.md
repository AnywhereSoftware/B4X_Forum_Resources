### jPOI - Supports Microsoft Excel xls and xlsx Workbooks by Erel
### 05/25/2021
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/57392/)

Edit:  
**This is the old version. The new version which has some small non-backwards compatible changes is available here: <https://www.b4x.com/android/forum/threads/129969>**  
Copy jPOI.jar / xml to the internal libraries folder.  
  
jPOI is based on Apache POI project: <http://poi.apache.org/>  
Currently it only supports Microsoft Excel related APIs.  
  
It is an alternative library to jExcel: <https://www.b4x.com/android/forum/threads/jexcel-library.35004/>  
Advantages of jPOI:  

- Supports both xls and xlsx (Excel 2007+ format). jExcel only supports the old format.
- More powerful.
- Apache POI is an active project.
- Supports password protected workbooks.
- A bit simpler to use.

The disadvantage of jPOI is that the library is much larger (about 10mb).  
  
How to use  
  
The first step is to create a PoiWorkbook. You can either create a new workbook (InitializeNew) or read the data of an existing workbook (InitializeExisting).  
Now you can add sheets to the workbook, or access existing sheets.  
A sheet represented by PoiSheet holds a list of rows (PoiRow).  
Each row holds a list of cells (PoiCell).  
Note that if you call PoiSheet.GetRow with the index of an empty row it will return an uninitialized row.  
The same is true for PoiRow.GetCell.  
  
PoiSheet.Rows will return a list with all the non-empty rows.  
PoiRow.Cells will return a list with all the non-empty cells.  
  
These properties are useful for a iterating over the rows and cells with For Each blocks:  

```B4X
For Each row As PoiRow In Sheet.Rows  
For Each cell As PoiCell In row.Cells  
  Log(cell.Value)  
Next  
Next
```

  
  
Cells (and rows) can be styled with PoiCellStyle objects. These objects should be reused when possible. Meaning that if multiple cells should have the same style then they should all use the same object.  
  
The rows, sheets and cell indices all start from 0.  
  
Reading the cells values is done with the various PoiCell.Value properties. If the cell type is known then use the Value property that returns the correct type (for example ValueNumeric). Otherwise use the general Value property which checks the cell type and returns the value.  
  
Saving the workbook is done with Workbook.Save. When you are done with the workbook you should call Workbook.Close.  
  
Note that if the workbook is opened in Excel then the program will fail to open it.  
  
The attached program creates a simple table with some styling, formulas and formats. It also adds an image.  
  
![](https://www.b4x.com/basic4android/images/SS-2015-08-19_13.17.07.png)  
  
**The library depends on additional jar files. You should download them from this link:**  
[www.b4x.com/b4j/files/jPoi\_AdditionalJars.zip](https://www.b4x.com/b4j/files/jPoi_AdditionalJars.zip)  
Copy the jar files to the additional libraries folder.  
  
Don't forget to download the attached library.  
  
**Updates**  
  
V1.21 - Adds a missing dependency.  
V1.20 - based on Apache POI v4.0.0. Make sure to update the additional jars as well.  
Note that this is a major upgrade. Calls with JavaObject might need some updates. Start a new thread if you encounter any issue.  
  
V1.10 - based on Apache POI v3.16. Make sure to update the additional jars as well.