### [class] RecordSet: A class that extends the functionality of lists of same length arrays by William Lancee
### 08/25/2021
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/133744/)

A recordset is a data structure that consists of a collection of database records.   
For example, in StringUtils the result of su.LoadCSV(Dir, FileName, Separator) is a recordset, a list of same length arrays.  
But so is:  
  
 Dim galaxies As List  
 galaxies.Initialize  
 galaxies.Add(Array("Tadpole", 400))  
 galaxies.Add(Array("Pinwheel", 25))  
 galaxies.Add(Array("Milky Way", 0))  
 galaxies.Add(Array("Andromeda", 3))  
  
The RecordSet Class (Standard) adds the following functions to standard recordsets, without the use of a database such as MySQL or SQLite:  
1. Named fields or alternatively loading external .csv/.txt files with field headers  
2. Auto-detection of field type (numeric, categorical, or date)  
3. Full indexing - all values in all fields are indexed (surprisingly, this works for recordsets up to 50000 records or more, depending on number of fields)  
4. Sorting (Up/Down, Numeric/Categorical/ Date) (The indexing function uses B4XOrderedMaps, which are sorted during initialization, and after changes)  
5. Searching  
6. Filtering to subsets  
7. Inserting, Deleting, Replacing records  
8. Cloning  
9. Data Summaries (descriptive statistics of any field (whether numeric, categorical, or date)  
  
The class was designed as a generic tool, therefore it doesn't require any user interface by itself and it is cross-platform.  
Dependencies: DateUtils, StringUtils, and B4XCollections  
Lines of source code = 684 (the majority of these are related to statistical summaries).  
  
In order to show its power in simplifying complex tasks, I have included two other classes in the demo: RecordSetBrowser (535 lines)and RecordSetReport(107 lines).  
I could package RecordSet as a B4XLib, but at this point I want to make it easy for others to see how it works. As a Library I would rename it.  
  
The demo starts with small lists that show its functionality for small tables that normally wouldn't be thought of as recordsets.  
When you try RecordSetBrowser, clicking on a header selects that column and a set of field oriented tools appear.  
When you click on a cell nothing appears to happen but the calling context is notified and actions can be taken there.  
When you try RecordSetReport, clicking on a report notifies the calling context. The reports are catered automatically to the field data type.  
In the demo after the RecordSetBrowser page is closed, B4XMainPage is notified and moves onto the reports.  
  
I have included copious comments. Feedback is always welcome.  
  
![](https://www.b4x.com/android/forum/attachments/118265)  
  
![](https://www.b4x.com/android/forum/attachments/118266)