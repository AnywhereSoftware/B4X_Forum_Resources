### [B4XPages][XLUtils]A small class to view many-columned B4XTables - for example Excel sheets. by William Lancee
### 04/30/2021
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/130153/)

This is too small for a 'creation' and probably too large for a code snippet (about 100 lines of code).  
Edit, now more like 250 lines. However, I think it might be useful for some members.  
  
'tableSection' is a small B4XPages class. Each instance of this class is a section of a many-columned B4XTable.  
The sections behave as independent tables, but are synchronised by row. The arrows at the bottom move right and left from section to section.  
  
I have provided a zip file with an example that uses the Beta version of XLUtils (still in development) to read an Excel sheet.  
The example depends on the same things as XLUtils. As you will see the new XL initiative is a very useful tool.  
  
<https://www.b4x.com/android/forum/threads/xlutils-jpoi-5-read-and-write-ms-excel-workbooks.129969/>  
  
Since each section is just a B4XTable, you can easily implement editing and selection if needed.  
However, it will take some extra work to get the row selection to span multiple sections.  
  
Edit (Friday): fixed a bug in demo