### jExcel library by Erel
### 01/01/2021
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/35004/)

**A more powerful library is now available: <https://www.b4x.com/android/forum/threads/jpoi-supports-microsoft-excel-xls-and-xlsx-workbooks.57392/>**  
  
This library allows you to read and write XLS files. It is similar to B4A Excel library: <http://www.b4x.com/android/forum/threads/read-write-excel-files-on-android.25632/#content>  
  
**You should follow the steps in the above link to download and copy the native library.**  
  
There are two new methods in this library:  
  
ReadableWorkbook.InitializeAsync - Asynchronously opens the file. The Ready event is raised when the workbook is ready.  
  
Sheet.GetAllAsync - Asynchronously gets all the cells from the sheet. The ValuesAvailable event is raised when the operation completee.  
  
![](http://www.b4x.com/basic4android/images/SS-2013-11-26_14.37.34.png)  
  
The attached example allows you to open a workbook file and browse its content.  
  
It depends on jxl.jar: [www.b4x.com/b4j/files/jxl.jar](https://www.b4x.com/b4j/files/jxl.jar)