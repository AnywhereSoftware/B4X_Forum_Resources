### [BANanoWebix] Lesson 8.3 Datatable Pagination & Exporting to XLSX, PNG, PDF and CSV by Mashiane
### 06/29/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/107291/)

Ola  
  
[Lesson 8.1](https://www.b4x.com/android/forum/threads/bananowebix-lesson-8-1-the-datatable-datagrid.107035/)  
[Lesson 8.2](https://www.b4x.com/android/forum/threads/bananowebix-lesson-8-2-the-datatable-datagrid.107036/)  
[Lesson 8.3](https://www.b4x.com/android/forum/threads/bananowebix-lesson-8-3-datatable-pagination-exporting-to-xlsx-png-pdf-and-csv.107291/#content)  
[Lesson 8.4](https://www.b4x.com/android/forum/threads/bananowebix-lesson-8-4-enhanced-data-table.107351/#content)  
  
As per subject matter this lesson is about a data-table with a pager and also functionality to export its contents to PNG, PDF, [CSV](https://www.b4x.com/glossary/csv/) and XLSX.  
  
It's so amazing that with just a few object (map) settings and then a few simple calls webix does everything for you. This surely speeds up development as one does not have to worry much about html and css.  
  
Anyway. We are adding a toolbar to our page, then the grid and then a pager to enable paginating of our data-table.  
  
![](https://www.b4x.com/android/forum/attachments/81833)  
  
This is simple as defining our objects…  
  

```B4X
Sub Init(pgContainer As String)  
    'initialize the page and set the container to hold the widgets  
    'add a header and set its label  
    pg.Initialize("", pgContainer).SetHeader("Lesson 8.3 Datatable Pager")  
    '  
    'create the data-table  
    Dim dt As WixDataTable  
    dt.Initialize("grida")  
    'ensure its a row selection  
    dt.SetSelect(dt.DT_SELECT_ROW)  
    'number of columns  
    dt.SetYCount(10)  
    'dont scroll  
    dt.SetScroll(False)  
    'can use keyboard keys  
    dt.SetNavigation(True)  
    'set the pager to use  
    dt.SetPager("pager")  
    '  
    'get the records from JSON array  
    Dim films As List = BANano.RunJavascriptMethod("getFilms", Null)  
    'set data to the grid  
    dt.SetData(films).SetEditable(True)  
    dt.SetAutoConfig(True)  
    Dim grida As Map = dt.Item  
    '  
    'create the pager  
    Dim pgr As WixPager  
    'set number of records per page to 10, 5 groups of pages  
    'show the first button, show prev button, show pages, show next button, show last page button  
    pgr.Initialize("pager").SetSize(10).SetGroup(5).SetShowFirst(True).SetShowPrev(True).SetShowPages(True).SetShowNext(True).SetShowLast(True)  
    pgr.SetAnimate(True)  
    Dim pager As Map = pgr.Item  
    '  
    'create a container  
    Dim cont As WixElement  
    cont.Initialize("cont").SetPadding(10)  
    '  
    Dim r1 As WixRow  
    r1.Initialize("r1").SetTemplate("<b>Static paging</b><br><br>Use the page selector below to choose the desired page.")  
    r1.SetHeight(70)  
    '  
    'add row to page  
    pg.AddRow(r1)  
    '  
    Dim tbl As WixToolBar  
    tbl.Initialize("tbl")  
    Dim e As BANanoEvent  
    tbl.CreateButton("excel").SetLabel("XLSX").SetWidth(100).SetClick(BANano.CallBack(Me,"export_excel",Array(e))).Pop  
    tbl.CreateButton("pdf").SetLabel("PDF").SetWidth(100).SetClick(BANano.CallBack(Me,"export_pdf",Array(e))).Pop  
    tbl.CreateButton("csv").SetLabel("CSV").SetWidth(100).SetClick(BANano.CallBack(Me,"export_csv",Array(e))).Pop  
    tbl.CreateButton("png").SetLabel("PNG").SetWidth(100).SetClick(BANano.CallBack(Me,"export_png",Array(e))).Pop  
  
    '  
    pg.AddRows(tbl.Item)  
  
    'add grid to page  
    pg.AddRows(grida)  
    'add pager to page  
    pg.AddRows(pager)  
    '  
    'build the user interface  
    pg.ui  
End Sub
```

  
  
As we are creating a separate pager element here, we link it to the data-table by calling .SetPager('pager') of our datatable.  
  
We then create a pager that shows the following:  
  
1. First Page button  
2. Previous Page button  
3. Pages (buttons)  
4. Next Page button and  
5. Last Page button  
  
This is depicted by these calls on the pager…  
  

```B4X
.SetShowFirst(True).SetShowPrev(True).SetShowPages(True).SetShowNext(True).SetShowLast(True)
```

  
  
We have created a javascript method call to return our films variable. These records are inside the *data.js* file in our Files tab of our project. One could also read these directly from a db.  
  
We didn't want to create columns for this grid so we used .SetAutoConfig(True) so that webix does its magic of header configurations.  
  
The toolbar we have added has some buttons that when clicked they execute calls to export our data-table records to various formats using the **BANano.CallBack** method.