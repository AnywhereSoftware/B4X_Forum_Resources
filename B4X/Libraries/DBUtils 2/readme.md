###  DBUtils 2 by Erel
### 12/16/2021
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/81280/)

DBUtils is a b4xlib with useful utilities related to the SQL library. It is designed to work with SQLite databases.  
There have been three versions of DBUtils, one for each platform (except of B4R).  
  
DBUtils v2.0 merges the three modules to a single module that is compatible with B4A, B4i and B4J.  
  
The module behavior is mostly identical to previous versions.  
Differences are:  
- ExecuteMap in B4A version returned Null in some cases. It now returns an uninitialized Map if there are no results.  
- B4J ExecuteList, which filled a given list is now named ExecuteList2.  
- B4J ExecuteHtml includes the clickable parameter.  
  
Instructions: put the library in the additional libraries folder.  
  
It depends on: SQL or jSQL or iSQL  
B4A also depends on RuntimePermissions.  
  
Updates:  
  
V2.11 - Fixed issue with logs output from UpdateRecord even when DBUTILS\_NOLOGS is set.  
V2.10 - InsertMaps returns True if the maps were inserted successfully.  
You can disable logs by adding DBUTILS\_NOLOGS as a conditional symbol (Ctrl + B).  
  
V2.09 - HtmlCSS is now public.  
V2.08 - Fixes issue with B4J non-ui apps.  
V2.07 (by Luca): New GetFieldsInfo and GetTables methods.  
V2.06 - Fixes an issue with TableExists in B4A.  
V2.05 - New TableExists method to check whether a table exists (the table name is case insensitive).