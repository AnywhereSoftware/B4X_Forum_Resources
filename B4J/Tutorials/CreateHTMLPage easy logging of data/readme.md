### CreateHTMLPage easy logging of data by stevel05
### 05/05/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/147801/)

For those like me, that are always looking for easy solutions for logging or dumping data, this library will create an html page and display it in your default browser from one or more lists or arrays or csv.  
  

![](https://www.b4x.com/android/forum/attachments/141740)

  
  
  
At it's simplest you can add a list of arrays or lists using:  
  

```B4X
Dim CP As HTMLPage  
CP.Initialize  
CP.AddTable.FromList(L)  
CP.ShowPage
```

  
  
And you will get something like the first image below.  
  
But you can also add css, tell it there is a header row, add column and row numbers add a title and create highlights for values or ranges in the table columns:  
  

```B4X
Dim CP As HTMLPage  
    CP.Initialize  
   
    Dim CSS As String = $"${Addl_CSS.FontSansSerif}  
${Addl_CSS.TableHeadersBold}  
${Addl_CSS.PositionCloseButton("","50px","","50px","150px","75px","1.25em")}  
    #tbl1 .row-num{background-color:lightgray;}  
    #tbl1 .col-num{background-color:lightgray;}  
"$  
    CP.CSS(CSS)  
   
    CP.AddTable.FromList(L).Id("tbl1").HasHeader.Highlight(3,HTMLPage_Static.HIGHLIGHT_BETWEEN,"yellow",0,2500) _  
    .ColumnNumbers(0).RowNumbers.Title("Dump of data table")  
    CP.FileName(File.DirTemp,"test1.html").ShowPage
```

  
  
And get something like the second image. In addition you can filter the selected values within the range to get the 3rd image. You can also specify where the file is stored before it is sent to your default browser.  
  
  

![](https://www.b4x.com/android/forum/attachments/141741)

  
![](https://www.b4x.com/android/forum/attachments/141747)![](https://www.b4x.com/android/forum/attachments/141753)  
  
  
You can pass a list of arrays, or a multidimension array, or a list of types or a delimited text file and it will display a table.  
  
The tables have default CSS which you can tell it to ignore and add your own, or just add extra. There is also some useful CSS in the Addl\_CSS module that you can plug in (see the code example above).  
  
There are a lot of options, so download it and give it a try.  
  
If you want to create more than one page at a time, use a separate instance of HTMLPage and give it a different filename, otherwise the file may be overwritten before it is displayed. The default file is saved to the File.DirTemp directory with the name CreateHTMLPage.html. If you want to save the page, you should be able to do that from the browser or you can call GetHTML on the HTMLPage and save the result to an .html file..  
  
**External Dependencies**  
[jReflection](https://www.b4x.com/android/forum/threads/jreflection-library.35448/)  
  
The project creates a small in memory SQLite database so you need one of the sqlite-jdbc jar versions in your library and change the #AdditionaJar directive in the Main module to match.  
  
**Notes**  
  
There are a couple of SQL utilities in the project to create a list from a ResultSet that are not added to the library as I didn't want to make SQLite a dependency for the library.  
  
You could also get the HTML from the HTMLPage class and display it in a Webview instead of calling the Show method.  
  
Running the project will create 3 web pages demonstrating different functions.  
  
**Updates**  
v0.2 - added data-cell class as appropriate.  
 added MakeScrollable to Addl\_Css  
 added DontShowClose to HTMLPage  
 Fixed some inaccurate comments  
 moved css required for filter hits and it is always added if filtering is requested.  
 added SyncScroll for tables. Works best when the tables have the same number of rows.  
 added Classes col-num-row and header-row for more flexibility.  
 fixed a bug in the hit highlighting relating to the first row on a table without column numbers.  
  
  
I hope you find it useful, let me know how you get on with it.